# Scripts

This directory contains automation scripts for maintaining the GPT Prompts repository.

## Available Scripts

### `generate-index.sh`

Automatically generates and updates the prompt index in `INDEX.md` and `README.md`.

**Usage:**
```bash
bash scripts/generate-index.sh
```

**What it does:**
- Scans all prompt files in `prompts/` and `.github/prompts/` directories
- Extracts title and description from each prompt
- Generates a categorized index
- Updates `INDEX.md` with the full index
- Injects the index into `README.md` between `<!-- INDEX_START -->` and `<!-- INDEX_END -->` markers

**When it runs:**
- Automatically on push to `main` branch when prompts are modified
- Automatically on pull requests that modify prompts
- Manually via GitHub Actions workflow dispatch

### `generate-feedback-links.sh`

Automatically generates and updates feedback links in all prompt files.

**Usage:**
```bash
bash scripts/generate-feedback-links.sh
```

**What it does:**
- Scans all prompt files in `prompts/` directory
- Extracts the category (folder name), prompt name (filename), and title
- Generates a GitHub issue URL with pre-filled parameters:
  - Labels: `feedback`, category tag, prompt name tag
  - Title: "Feedback: [Prompt Title]"
  - Body: Prompt reference link and feedback template
- Adds or updates the `## 💬 Feedback` section in each prompt

**When it runs:**
- Automatically on push to `main` branch when prompts are modified
- Automatically on pull requests that modify prompts
- Manually via GitHub Actions workflow dispatch

**Configuration:**
To change the repository or add new label categories, edit these variables at the top of the script:
```bash
REPO_OWNER="DevSecNinja"
REPO_NAME="gpt-prompts"
```

The script automatically derives categories from folder names and prompt names from filenames, so new categories and prompts require no script changes.

## CI/CD Integration

Both scripts are integrated into GitHub Actions workflows:
- `.github/workflows/generate-index.yml` - Runs `generate-index.sh`
- `.github/workflows/generate-feedback-links.yml` - Runs `generate-feedback-links.sh`

These workflows automatically commit and push changes with `[skip ci]` to avoid trigger loops.

## Adding New Categories

When you add a new category folder (e.g., `prompts/new-category/`):
1. Create the folder: `mkdir prompts/new-category`
2. Add your prompt files
3. Run both scripts locally or let CI handle it:
   ```bash
   bash scripts/generate-feedback-links.sh
   bash scripts/generate-index.sh
   ```

No script modifications needed! 🎉
