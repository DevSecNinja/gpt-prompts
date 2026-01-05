#!/bin/bash

# Script to validate prompt files have required sections
# Required sections: Title (# heading), Description, Prompt
# Category is derived from folder location, not required in file

set -e

# Enable globstar for ** pattern matching and nullglob to handle no matches
shopt -s globstar nullglob

EXIT_CODE=0

echo "🔍 Validating prompt structure..."
echo ""

# Function to check if file has YAML frontmatter
has_frontmatter() {
  head -n 1 "$1" | grep -q "^---$"
}

# Check prompts directory
for file in prompts/**/*.md .github/prompts/**/*.md; do
  # Skip if not a regular file (nullglob prevents literal pattern iteration)
  [ -f "$file" ] || continue
  
  echo "Checking $file..."
  
  FILE_VALID=1
  
  # Check if file is in .github/prompts directory
  if [[ "$file" == .github/prompts/* ]]; then
    # Files in .github/prompts should use YAML frontmatter format
    if has_frontmatter "$file"; then
      # Validate frontmatter format
      if ! grep -q "^description:" "$file"; then
        echo "❌ Missing 'description' field in frontmatter in $file"
        EXIT_CODE=1
        FILE_VALID=0
      fi
      
      # Frontmatter files don't require traditional markdown sections
      # The content after frontmatter is the prompt itself
    else
      echo "❌ File in .github/prompts must use YAML frontmatter format in $file"
      EXIT_CODE=1
      FILE_VALID=0
    fi
  else
    # Files in prompts/ directory should use traditional markdown format
    if has_frontmatter "$file"; then
      echo "❌ Files in prompts/ directory should not use YAML frontmatter in $file"
      EXIT_CODE=1
      FILE_VALID=0
    fi
    
    # Validate traditional markdown format
    # Check for required headers
    if ! grep -q "^# " "$file"; then
      echo "❌ Missing title (# heading) in $file"
      EXIT_CODE=1
      FILE_VALID=0
    fi
    
    if ! grep -q "^## Description" "$file"; then
      echo "❌ Missing Description section in $file"
      EXIT_CODE=1
      FILE_VALID=0
    fi
    
    if ! grep -q "^## Prompt" "$file"; then
      echo "❌ Missing Prompt section in $file"
      EXIT_CODE=1
      FILE_VALID=0
    fi
  fi
  
  if [ $FILE_VALID -eq 1 ]; then
    echo "✅ $file is valid"
  fi
  echo ""
done

if [ $EXIT_CODE -eq 0 ]; then
  echo "✅ All prompts are properly structured!"
else
  echo "❌ Some prompts are missing required sections"
fi

exit $EXIT_CODE
