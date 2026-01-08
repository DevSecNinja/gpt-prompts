#!/bin/bash

# Script to add or update feedback sections in all prompt files
# This script is idempotent - it can be run multiple times safely

set -e

# Repository details
REPO_OWNER="DevSecNinja"
REPO_NAME="gpt-prompts"
GITHUB_BASE_URL="https://github.com/${REPO_OWNER}/${REPO_NAME}"

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔗 Adding/updating feedback links in all prompt files..."

# Function to URL encode a string using Python
urlencode() {
    python3 << EOF
import urllib.parse
import sys
print(urllib.parse.quote("""$1""", safe=''))
EOF
}

# Function to extract the title from a markdown file
get_title() {
    local file="$1"
    grep -m 1 "^# " "$file" | sed 's/^# //'
}

# Function to get the relative path from workspace root
get_relative_path() {
    local file="$1"
    echo "$file" | sed 's|^./||'
}

# Function to get the category from the file path
get_category() {
    local file="$1"
    local dir=$(dirname "$file")
    basename "$dir"
}

# Function to get the prompt name (filename without extension)
get_prompt_name() {
    local file="$1"
    local filename=$(basename "$file")
    echo "${filename%.md}"
}

# Function to generate the feedback section
generate_feedback_section() {
    local file="$1"
    local title=$(get_title "$file")
    local relative_path=$(get_relative_path "$file")
    local category=$(get_category "$file")
    local prompt_name=$(get_prompt_name "$file")
    
    # Create the GitHub issue URL with parameters
    # Include category in title for searchability
    local issue_title="Feedback: [${category}] ${title}"
    local issue_body="## Feedback for: ${title}

**Prompt location**: [${relative_path}](${GITHUB_BASE_URL}/blob/main/${relative_path})

**Category**: ${category}
**Prompt name**: ${prompt_name}

---

<!-- Please provide your feedback below -->

"
    
    # URL encode the parameters
    local encoded_title=$(urlencode "$issue_title")
    local encoded_body=$(urlencode "$issue_body")
    
    # Generate the feedback section
    echo "## Feedback"
    echo ""
    echo "Have suggestions or found an issue with this prompt? [Click here to provide feedback](${GITHUB_BASE_URL}/issues/new?title=${encoded_title}&body=${encoded_body}&labels=enhancement)."
}

# Function to check if a file has a feedback section
has_feedback_section() {
    local file="$1"
    grep -q "^## Feedback" "$file"
}

# Function to add or update the feedback section in a file
process_file() {
    local file="$1"
    local temp_file="${file}.tmp"
    
    if has_feedback_section "$file"; then
        # File has feedback section, update it
        echo -e "${YELLOW}  Updating feedback section in: $file${NC}"
        
        # Extract content before feedback section (preserve all content)
        awk '/^## Feedback/{exit} {print}' "$file" > "$temp_file"
        
        # Ensure proper spacing before feedback section
        # Add blank line if the last line of content isn't blank
        if [ -s "$temp_file" ]; then
            if ! tail -c1 "$temp_file" 2>/dev/null | grep -q "^$" 2>/dev/null; then
                echo "" >> "$temp_file"
            fi
            # Check if the last line is not already a blank line
            last_line=$(tail -1 "$temp_file" 2>/dev/null || echo "")
            if [ -n "$last_line" ]; then
                echo "" >> "$temp_file"
            fi
        fi
        
        # Add the new feedback section
        generate_feedback_section "$file" >> "$temp_file"
        
        # Replace the original file
        mv "$temp_file" "$file"
    else
        # File doesn't have feedback section, add it at the end
        echo -e "${GREEN}  Adding feedback section to: $file${NC}"
        
        # Add newline if file doesn't end with one
        last_char=$(tail -c 1 "$file" 2>/dev/null || echo "")
        if [ -n "$last_char" ]; then
            echo "" >> "$file"
        fi
        
        # Add the feedback section
        echo "" >> "$file"
        generate_feedback_section "$file" >> "$file"
    fi
}

# Find all markdown files in prompts/ directory only
# Exclude PROMPT_TEMPLATE.md since it's a template
# Exclude .github/prompts/ as those are GitHub-specific prompts
file_count=0
for dir in "prompts"; do
    if [ -d "$dir" ]; then
        # Use find to get all .md files, excluding PROMPT_TEMPLATE.md
        mapfile -t files < <(find "$dir" -type f -name "*.md" ! -name "PROMPT_TEMPLATE.md")
        for file in "${files[@]}"; do
            process_file "$file"
            file_count=$((file_count + 1))
        done
    fi
done

echo ""
echo -e "${GREEN}✅ Successfully processed ${file_count} prompt files!${NC}"
