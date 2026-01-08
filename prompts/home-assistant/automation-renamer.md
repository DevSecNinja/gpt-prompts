# Home Assistant Automation Renamer

## Description

This prompt helps rewrite Home Assistant automation aliases and descriptions into clear, non-technical language that anyone in your household can understand, without changing any automation logic.

## AI Model

- Platform: GitHub Copilot in VS Code
- Model: Claude Sonnet 4.5

## Prompt

``` text
You are reviewing a Home Assistant automations.yaml file.

For each automation, rewrite:

1. alias (title)
• Max 10 words
• Clear, simple, no technical jargon
• Understandable by someone with no Home Assistant knowledge

2. description
• Max 4 short lines
• Plain, everyday language
• Explain what happens, when, and why, from a user’s perspective
• Avoid technical terms like trigger, entity, service, state, automation

Rules
• Do not change any logic, triggers, conditions, or actions
• Only update alias and description fields
• If a description is missing, add one
• Keep tone friendly and human, as if explaining it to a partner at home
• If the automation could be confusing or surprising, explicitly mention that behavior

Here's my automation YAML:

[Paste your automation YAML here]
```

## Example Use Case

Use this prompt when you have a Home Assistant automations.yaml file with technical names like "Trigger: motion_sensor_1 state to 'on'" and want to make them readable for non-technical household members. Simply paste your YAML configuration, and the AI will rewrite the aliases and descriptions in plain English while preserving all functionality.

## Tags

- home-assistant
- automation
- documentation
- smart-home
- yaml
- refactoring

## Credits

- Created by: DevSecNinja

## Notes

- Always backup your automations.yaml before making changes
- The prompt is designed to maintain technical accuracy while improving readability
- Works best with complete automation blocks rather than partial configurations
- Consider running this on all automations at once for consistent naming conventions
- Consider checking in the automations.yaml file with git before you run this prompt so that you can easily see what changed

## 💬 Feedback

Have suggestions or issues with this prompt? [Click here to provide feedback](https://github.com/DevSecNinja/gpt-prompts/issues/new?labels=feedback,home-assistant,automation-renamer&title=Feedback%3A%20Home%20Assistant%20Automation%20Renamer&body=**Prompt%20Reference**%3A%20https%3A%2F%2Fgithub.com%2FDevSecNinja%2Fgpt-prompts%2Fblob%2Fmain%2Fprompts%2Fhome-assistant%2Fautomation-renamer.md%0A%0A**Your%20Feedback**%3A%0A%0A%3C%21---%20Please%20describe%20your%20suggestion%2C%20issue%2C%20or%20question%20below%20--%3E)
