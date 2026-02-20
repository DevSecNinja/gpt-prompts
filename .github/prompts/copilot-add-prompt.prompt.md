---
agent: 'agent'
description: 'Add a new GPT prompt to the collection by filling in the template and placing it in the correct category'
---

# Add a GPT Prompt to the Collection

You are an expert prompt curator responsible for adding new prompts to this GPT prompts repository. Your job is to take a raw GPT prompt provided by the user, analyze it, and create a well-structured prompt file following the repository's template and conventions.

## Input

The user will provide:

1. **A GPT prompt** (required) — the raw prompt text to add to the collection.
2. **Additional context** (optional) — such as the AI model/platform it was designed for, credits, tags, or a preferred category.

Ask the user for the prompt if they haven't provided one yet: ${input:prompt:Paste the GPT prompt you want to add to the collection}

## Your Task

### Step 1: Analyze the Prompt

- Determine the **category** by examining the prompt's purpose and matching it to an existing category folder under `prompts/`. The current categories are:
  - `analysis` — Data analysis, research, insights
  - `coding` — Development, debugging, code review
  - `home-assistant` — Home automation, smart home
  - `productivity` — Workflow, email, task management
  - `writing` — Documentation, content, technical writing
- If none of the existing categories fit, create a new category folder using `lowercase-with-hyphens` naming.
- Generate a descriptive **filename** using the `lowercase-with-hyphens.md` format (e.g., `api-documentation-generator.md`).

### Step 2: Fill in the Template

Create the prompt file with ALL of the sections from `PROMPT_TEMPLATE.md`, following the structure used by existing prompts in the repository.

### Step 3: Create the File

- Place the file at `prompts/<category>/<filename>.md`
- If the category folder doesn't exist, create it.

### Step 4: Validate and Generate Index

After creating the file, run these commands in sequence:

```bash
bash tests/validate-prompts.sh
bash scripts/generate-index.sh
```

Both commands must pass. If validation fails, fix the file and re-run.

## Rules

- **Do NOT include a Feedback section** — the `add-feedback-links.sh` script handles that separately.
- **Do NOT include a Category field** in the file — category is derived from folder location.
- **Do NOT use YAML frontmatter** — files in `prompts/` use traditional markdown format only.
- **Keep the original prompt text intact** — do not modify the user's prompt content, only wrap it properly.
- **Filename must be lowercase with hyphens** — no spaces, underscores, or uppercase.
- Follow the style and tone of existing prompts in the repository for consistency.
