#!/bin/bash

# Script to automatically generate and update feedback links in all prompt files
# Scans prompts/ directory and updates/adds feedback sections with proper GitHub issue URLs

# Note: set -e is intentionally not used to allow the script to continue even if individual operations fail

# Configuration
REPO_OWNER="DevSecNinja"
REPO_NAME="gpt-prompts"
BASE_URL="https://github.com/${REPO_OWNER}/${REPO_NAME}"

echo "🔗 Generating feedback links for all prompts..."
echo ""

# Function to check if file has YAML frontmatter
has_frontmatter() {
  head -n 1 "$1" | grep -q "^---$"
}

# Function to extract title from markdown
get_title() {
  if has_frontmatter "$1"; then
    # For frontmatter files, derive from filename
    local filename=$(basename "$1" .md)
    filename=$(basename "$filename" .prompt)
    echo "$filename" | sed 's/-/ /g' | awk '{ for (i = 1; i <= NF; i++) { $i = toupper(substr($i, 1, 1)) substr($i, 2) } print }'
  else
    # Extract from markdown heading
    grep -m 1 "^# " "$1" | sed 's/^# //'
  fi
}

# Function to URL encode a string using Python
urlencode() {
  python3 -c "import urllib.parse; print(urllib.parse.quote('''$1'''))"
}

# Function to generate feedback link for a prompt file
generate_feedback_link() {
  local file="$1"
  local category="$2"
  local prompt_name="$3"
  local title="$4"
  
  # URL encode the title
  local encoded_title=$(urlencode "Feedback: ${title}")
  
  # Create the body content
  local body_content="**Prompt%20Reference**%3A%20${BASE_URL}%2Fblob%2Fmain%2F${file}%0A%0A**Your%20Feedback**%3A%0A%0A%3C%21---%20Please%20describe%20your%20suggestion%2C%20issue%2C%20or%20question%20below%20--%3E"
  
  # Create the full URL
  echo "${BASE_URL}/issues/new?labels=feedback,${category},${prompt_name}&title=${encoded_title}&body=${body_content}"
}

# Function to check if file has feedback section
has_feedback_section() {
  grep -q "^## 💬 Feedback" "$1" 2>/dev/null
}

# Function to add or update feedback section
update_feedback_section() {
  local file="$1"
  local feedback_link="$2"
  local temp_file=$(mktemp)
  local final_file=$(mktemp)
  
  if has_feedback_section "$file"; then
    # Update existing feedback section
    # Find line number of feedback section
    local feedback_line=$(grep -n "^## 💬 Feedback" "$file" | cut -d: -f1 || echo "")
    
    if [ -n "$feedback_line" ]; then
      # Keep everything before the feedback section
      head -n $((feedback_line - 1)) "$file" > "$temp_file"
      
      # Add new feedback section
      echo "" >> "$temp_file"
      echo "## 💬 Feedback" >> "$temp_file"
      echo "" >> "$temp_file"
      echo "Have suggestions or issues with this prompt? [Click here to provide feedback](${feedback_link})" >> "$temp_file"
      
      # Check if there's content after feedback section (next ## heading)
      local next_section_line=$(tail -n +$((feedback_line + 1)) "$file" | grep -n "^## " | head -1 | cut -d: -f1 || echo "")
      
      if [ -n "$next_section_line" ]; then
        # There's another section after feedback, keep it
        tail -n +$((feedback_line + next_section_line)) "$file" >> "$temp_file"
      fi
    else
      cp "$file" "$temp_file"
    fi
  else
    # Add new feedback section at the end
    cp "$file" "$temp_file"
    echo "" >> "$temp_file"
    echo "## 💬 Feedback" >> "$temp_file"
    echo "" >> "$temp_file"
    echo "Have suggestions or issues with this prompt? [Click here to provide feedback](${feedback_link})" >> "$temp_file"
  fi
  
  mv "$temp_file" "$file"
}

# Counter for updated files
updated_count=0

# Process prompts directory
for category_dir in prompts/*/; do
  if [ -d "$category_dir" ]; then
    category_name=$(basename "$category_dir")
    
    # Process each prompt in the category
    for prompt_file in "$category_dir"*.md; do
      if [ -f "$prompt_file" ]; then
        # Extract prompt name (filename without extension)
        prompt_name=$(basename "$prompt_file" .md)
        
        # Get the title from the prompt file
        title=$(get_title "$prompt_file")
        
        # Get relative path from repo root
        relative_path="${prompt_file#./}"
        
        # Generate feedback link
        feedback_link=$(generate_feedback_link "$relative_path" "$category_name" "$prompt_name" "$title")
        
        # Update the feedback section
        update_feedback_section "$prompt_file" "$feedback_link"
        
        echo "✅ Updated: $relative_path"
        echo "   Category: $category_name"
        echo "   Prompt: $prompt_name"
        echo "   Title: $title"
        echo ""
        
        ((updated_count++))
      fi
    done
  fi
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Feedback links updated for ${updated_count} prompt(s)!"
echo ""
echo "📝 Note: The PROMPT_TEMPLATE.md still contains placeholder instructions"
echo "   for manual customization. Update it if needed for consistency."
