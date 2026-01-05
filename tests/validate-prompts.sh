#!/bin/bash

# Script to validate prompt files have required sections
# Required sections: Title (# heading), Description, Prompt
# Category is derived from folder location, not required in file

set -e

EXIT_CODE=0

echo "🔍 Validating prompt structure..."
echo ""

# Check prompts directory
for file in prompts/**/*.md .github/prompts/**/*.md; do
  if [ -f "$file" ]; then
    echo "Checking $file..."
    
    # Check for required headers
    if ! grep -q "^# " "$file"; then
      echo "❌ Missing title (# heading) in $file"
      EXIT_CODE=1
    fi
    
    if ! grep -q "^## Description" "$file"; then
      echo "❌ Missing Description section in $file"
      EXIT_CODE=1
    fi
    
    if ! grep -q "^## Prompt" "$file"; then
      echo "❌ Missing Prompt section in $file"
      EXIT_CODE=1
    fi
    
    if [ $EXIT_CODE -eq 0 ]; then
      echo "✅ $file is valid"
    fi
    echo ""
  fi
done

if [ $EXIT_CODE -eq 0 ]; then
  echo "✅ All prompts are properly structured!"
else
  echo "❌ Some prompts are missing required sections"
fi

exit $EXIT_CODE
