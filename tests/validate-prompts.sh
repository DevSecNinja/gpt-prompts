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

# Check prompts directory
for file in prompts/**/*.md .github/prompts/**/*.md; do
  # Skip if no files match (nullglob handles this, but keeping check for clarity)
  [ -f "$file" ] || continue
  
  echo "Checking $file..."
  
  FILE_VALID=1
  
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
