# OOO Task Handoff Planner

## Description

Scans your recent emails to identify tasks requiring action before, during, or after an out-of-office period, then groups them into prioritized handoff buckets with delegates and deadlines.

## AI Model

- Platform: Microsoft 365 Copilot
- Note: Requires Microsoft 365 Copilot license with WorkIQ access

## Prompt

``` text
I'll be out of office from 20/02/2026 to 27/02/2026.

Scope / recency rules (must follow):
Only use items from Emails
Include items RECEIVED/CREATED between (past 15 days) and 27/02/2026
Ignore older items unless there is new activity (reply, mention, forward, comment, or meeting follow-up referencing it)

Task extraction rules:
Identify emails that assign me a task (reply, review, approve, fix, ship, follow up, provide input)
Capture unresolved issues, risks, blockers, or escalations needing handoff.
Work I initiated that needs closure or a status update before my OOO
Prioritize: deadlines before or during my OOF window
items from my manager/leadership
items blocking others or marked urgent/important

Use my Automatic Reply text (pasted above) for context on topics and named delegates/owners.

Output format (compact, grouped bullets):
Group 1: Must do before 20/02/2026
Group 2: Must be delegated during OOF (handoff)
Group 3: Can wait until after 27/02/2026
For every bullet:
Task Title:
What it is: 1‑sentence description of the email‑based task
Why it matters: 1‑sentence explanation of the impact statement
Deadline: use explicit date if stated; if none, use email arrival date
Delegate: (use delegate from my automatic reply if available; else add my manager)

Important accuracy rule:
Do not invent tasks or deadlines.

Guidelines:
Prioritize items requiring immediate action or decisions
De‑dupe related threads into one synthesized task.
Focus on actions, not raw email activity
Clearly separate tasks I must finish vs. those to hand off.
Assume I want to wrap up completely with minimal loose ends
Keep all explanations 1 sentence for fast scanning.
```

## Example Use Case

Use this prompt a few days before going on vacation or extended leave. Paste your automatic reply text before the prompt so Copilot can extract delegate names and topic context. It will scan your recent emails and produce a compact, prioritized task list split into "do now", "delegate", and "defer" buckets — helping you leave with zero loose ends.

## Tags

- out-of-office
- task-handoff
- delegation
- productivity
- email-management
- microsoft-365

## Credits

- Created by: Microsoft

## Notes

- Requires the `work` mode in M365 Copilot with access to WorkIQ (email data).
- Paste your automatic reply / OOO message above the prompt so Copilot can identify your delegates and key topics.
- Adjust the OOO dates and the 15-day lookback window to match your situation.

## Feedback

Have suggestions or found an issue with this prompt? [Click here to provide feedback](https://github.com/DevSecNinja/gpt-prompts/issues/new?title=Feedback%3A%20%5Bproductivity%5D%20OOO%20Task%20Handoff%20Planner&body=%23%23%20Feedback%20for%3A%20OOO%20Task%20Handoff%20Planner%0A%0A%2A%2APrompt%20location%2A%2A%3A%20%5Bprompts%2Fproductivity%2Fooo-task-handoff-planner.md%5D%28https%3A%2F%2Fgithub.com%2FDevSecNinja%2Fgpt-prompts%2Fblob%2Fmain%2Fprompts%2Fproductivity%2Fooo-task-handoff-planner.md%29%0A%0A%2A%2ACategory%2A%2A%3A%20productivity%0A%2A%2APrompt%20name%2A%2A%3A%20ooo-task-handoff-planner%0A%0A---%0A%0A%3C%21--%20Please%20provide%20your%20feedback%20below%20--%3E%0A%0A&labels=enhancement).
