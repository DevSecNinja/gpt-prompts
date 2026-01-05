#!/bin/bash

# Script to generate INDEX.md from all prompt files
# Scans prompts/ and .github/prompts/ directories

set -e

echo "📑 Generating prompt index..."

# Create the header
cat > INDEX.md << EOF
# 📑 Prompt Index

> Auto-generated index of all available prompts

Last updated: $(TZ=UTC date '+%Y-%m-%d %H:%M:%S %Z')

EOF

# Function to extract title from markdown
get_title() {
  grep -m 1 "^# " "$1" | sed 's/^# //'
}

# Function to extract description
get_description() {
  sed -n '/^## Description$/,/^##/p' "$1" | sed '1d;$d' | sed 's/^[[:space:]]*//' | head -n 1
}

# Process prompts directory
echo "" >> INDEX.md
echo "## 📂 Regular Prompts" >> INDEX.md
echo "" >> INDEX.md

for category_dir in prompts/*/; do
  if [ -d "$category_dir" ]; then
    category_name=$(basename "$category_dir")
    category_title=$(echo "$category_name" | sed 's/-/ /g' | awk '{ for (i = 1; i <= NF; i++) { $i = toupper(substr($i, 1, 1)) substr($i, 2) } print }')
    
    # Check if there are any .md files
    if ls "$category_dir"*.md 1> /dev/null 2>&1; then
      echo "### 📁 ${category_title}" >> INDEX.md
      echo "" >> INDEX.md
      
      # Process each prompt in the category
      for prompt_file in "$category_dir"*.md; do
        if [ -f "$prompt_file" ]; then
          title=$(get_title "$prompt_file")
          description=$(get_description "$prompt_file")
          relative_path="${prompt_file#./}"
          
          echo "- **[${title}](/${relative_path})** - ${description}" >> INDEX.md
        fi
      done
      echo "" >> INDEX.md
    fi
  fi
done

# Process .github/prompts directory
if [ -d ".github/prompts" ]; then
  echo "" >> INDEX.md
  echo "## 🤖 GitHub Copilot Prompts" >> INDEX.md
  echo "" >> INDEX.md
  echo "> Prompts optimized for use with GitHub Copilot" >> INDEX.md
  echo "" >> INDEX.md
  
  for prompt_file in .github/prompts/*.md; do
    if [ -f "$prompt_file" ]; then
      title=$(get_title "$prompt_file")
      description=$(get_description "$prompt_file")
      relative_path="${prompt_file#./}"
      
      echo "- **[${title}](/${relative_path})** - ${description}" >> INDEX.md
    fi
  done
  echo "" >> INDEX.md
fi

# Add footer
cat >> INDEX.md << 'EOF'

---

*This index is automatically generated from the prompts directory.*
EOF

echo "✅ Index generated successfully!"
