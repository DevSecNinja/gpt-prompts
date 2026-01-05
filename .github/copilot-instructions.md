# Copilot Agent Instructions for GPT Prompts Collection

## Repository Overview

This is a **documentation repository** containing a curated collection of reusable GPT prompts. It's a small, lightweight project focused on Markdown content with bash automation scripts.

**Repository Type**: Documentation/Content repository  
**Primary Language**: Markdown  
**Automation**: Bash scripts  
**Size**: Small (~11 files)  
**No Dependencies**: No package.json, requirements.txt, or external dependencies required

## Project Structure

```
/workspaces/gpt-prompts/
├── prompts/                    # Main prompt collection (categorized)
│   ├── analysis/              # Data analysis prompts
│   ├── coding/                # Development prompts
│   └── writing/               # Writing/documentation prompts
├── .github/
│   ├── prompts/               # GitHub Copilot-specific prompts
│   └── workflows/             # CI/CD automation
├── scripts/
│   └── generate-index.sh      # Auto-generates INDEX.md and updates README.md
├── tests/
│   └── validate-prompts.sh    # Validates prompt file structure
├── README.md                  # Main documentation (contains auto-generated index)
├── INDEX.md                   # Standalone index (auto-generated)
├── PROMPT_TEMPLATE.md         # Template for new prompts
└── CONTRIBUTING.md            # Contribution guidelines
```

## Key Files

- **PROMPT_TEMPLATE.md**: Template that all new prompts must follow
- **README.md**: Main entry point; contains auto-generated index between `<!-- INDEX_START -->` and `<!-- INDEX_END -->` markers
- **INDEX.md**: Standalone version of the index, fully auto-generated
- **.markdownlint.json**: Markdown linting configuration
- **.markdown-link-check.json**: Link validation configuration

## Build & Validation Commands

### Generate Index (ALWAYS run after adding/modifying prompts)

```bash
bash scripts/generate-index.sh
```

**What it does**:

- Scans `prompts/` and `.github/prompts/` directories
- Extracts title (from `# heading`) and description (from `## Description` section)
- Generates INDEX.md
- Updates README.md by replacing content between `<!-- INDEX_START -->` and `<!-- INDEX_END -->` markers
- **Duration**: ~1 second
- **No prerequisites**: Works immediately

**CRITICAL**: Always run this command after adding or modifying any prompt file. The command is fast and reliable.

### Validate Prompt Structure

```bash
bash tests/validate-prompts.sh
```

**What it validates**:

- Every prompt file must have:
  1. A title as `# heading`
  2. A `## Description` section
  3. A `## Prompt` section
- **Note**: Category is NOT required in files (it's derived from folder location)
- **Duration**: ~1 second
- **Exit code**: Non-zero if validation fails

**Run this before committing** to ensure prompt structure is correct.

## CI/CD Workflows

Three GitHub Actions workflows run automatically:

### 1. Generate Prompt Index (`.github/workflows/generate-index.yml`)

- **Triggers**: Push to main, PRs that modify `prompts/**/*.md` or `.github/prompts/**/*.md`
- **Actions**: Runs `bash scripts/generate-index.sh` and auto-commits changes
- **Note**: Commits are marked with `[skip ci]` to prevent loops

### 2. Markdown Validation (`.github/workflows/markdown-validation.yml`)

- **Triggers**: Push to main, all PRs to main
- **Steps**:
  1. **Markdown Linting**: Uses markdownlint with `.markdownlint.json` config (continues on error)
  2. **Link Checking**: Validates all markdown links using `.markdown-link-check.json` (continues on error)
  3. **Structure Validation**: Runs `bash tests/validate-prompts.sh` (MUST pass)
- **Important**: Only structure validation is required to pass; linting and link checking are informational

### 3. Welcome (`.github/workflows/welcome.yml`)

- **Triggers**: First-time issue/PR from new contributors
- **Actions**: Posts welcome message with guidelines

## Adding New Prompts

### File Naming Convention

- **Format**: `lowercase-with-hyphens.md`
- ✅ Good: `code-review-assistant.md`, `api-documentation-generator.md`
- ❌ Bad: `Code Review Assistant.md`, `API_docs.md`

### File Location

Place prompts in the appropriate category folder:

- `prompts/coding/` - Development, debugging, code review
- `prompts/writing/` - Documentation, content, technical writing
- `prompts/analysis/` - Data analysis, research, insights
- `prompts/creative/` - Creative writing, brainstorming
- `prompts/business/` - Strategy, planning, productivity
- Create new category folders as needed

### Required Structure

Every prompt file MUST include:

1. **Title**: Single `# heading` at the top
2. **Description**: `## Description` section with 1-2 sentence summary
3. **Prompt**: `## Prompt` section with the actual prompt text

Optional sections:

- `## AI Model` - Specify target AI model/platform
- `## Example Use Case` - When to use this prompt
- `## Tags` - Keywords for searchability
- `## Credits` - Attribution
- `## Notes` - Additional context

### Workflow After Adding a Prompt

**Always follow this sequence**:

```bash
# 1. Create the prompt file in the appropriate category folder
# 2. Validate structure
bash tests/validate-prompts.sh

# 3. If validation passes, generate the index
bash scripts/generate-index.sh

# 4. Stage and commit all changes (including auto-generated files)
git add prompts/your-category/your-prompt.md INDEX.md README.md
git commit -m "Add: your-prompt description"
```

**Common mistake**: Forgetting to commit INDEX.md and README.md after running the index generation script.

## Markdown Configuration

### Linting Rules (`.markdownlint.json`)

- **MD013**: Line length - DISABLED (no limit)
- **MD033**: HTML tags - DISABLED (allowed)
- **MD041**: First line heading - DISABLED (flexible)
- **MD024**: Duplicate headings - Siblings only (same level duplicates not allowed)

### Link Checking (`.markdown-link-check.json`)

- Ignores localhost links
- Accepts status codes: 200, 206, 301, 302, 307, 308, 403, 405, 999

## Critical Notes for Agents

1. **Trust these instructions**: The build and validation commands documented here are tested and reliable. Only search for additional information if these instructions are incomplete or incorrect.

2. **No compilation required**: This is a pure documentation repository. There's no code to compile, no dependencies to install, no build process beyond running bash scripts.

3. **Fast validation**: Both validation and index generation run in ~1 second each. Always run them before committing.

4. **Auto-generated files**: INDEX.md is fully generated; README.md has an auto-generated section between markers. Never manually edit these sections.

5. **Category inference**: The prompt category is automatically derived from the folder structure. Don't include a "Category" field in prompt files.

6. **Bash scripts are executable**: The scripts in `scripts/` and `tests/` have execute permissions and should be run as `bash script-name.sh`.

7. **No background processes**: All commands complete immediately; no servers, watches, or long-running processes.

8. **Git workflow**: The repository uses standard git workflows. The generate-index workflow auto-commits on push, so expect INDEX.md and README.md to be updated automatically in CI.

## Testing Changes

Before submitting a PR:

```bash
# 1. Validate all prompts
bash tests/validate-prompts.sh

# 2. Generate index
bash scripts/generate-index.sh

# 3. Check what changed
git status
git diff

# 4. Verify the changes look correct
# - Your new prompt file should be in the appropriate category
# - INDEX.md should list your prompt
# - README.md should have your prompt in the auto-generated section
```

## Common Patterns

### Creating a New Prompt Category

1. Create directory: `mkdir -p prompts/new-category`
2. Add prompt file: `prompts/new-category/example-prompt.md`
3. Run index generation: `bash scripts/generate-index.sh`
4. The category will automatically appear in the index

### Modifying an Existing Prompt

1. Edit the prompt file
2. Run validation: `bash tests/validate-prompts.sh`
3. Run index generation: `bash scripts/generate-index.sh` (to update description if changed)
4. Commit all changes

## Coding Style Preferences

- **Avoid inline scripts**: Never use inline commands in pipelines or other configurations.
- **Use external scripts**: Always create separate script files (e.g., `.devcontainer/post-create.sh`) for better:
  - Readability and maintainability
  - Version control and diffs
  - Testing and debugging
  - Reusability across projects
- **Make scripts executable**: Run `chmod +x` on script files

## Environment

- **OS**: Ubuntu 24.04.3 LTS (in dev container)
- **Shell**: Bash (scripts use `/bin/bash`)
- **Git**: Available and configured
- **Standard tools**: grep, awk, sed, find (all used by scripts)
- **No additional tools required**: No npm, pip, bundle, make, etc.
