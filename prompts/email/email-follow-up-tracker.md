# Email Follow-up Tracker

## Description

Identifies sent emails that require follow-up by analyzing your sent items for questions, requests, or scheduling proposals that haven't received direct replies within a specified date range.

## AI Model

- Platform: Microsoft 365 Copilot
- Note: Requires Microsoft 365 Copilot license

## Prompt

``` text
Review my Sent Items from last month (first day to last day) and identify emails where I asked a question, requested information, proposed scheduling, or indicated I was expecting a response — and where NO direct reply was received according to the anchored‑reply rules below.

Exclusions:

- Newsletters, automated notifications, system emails, and any recipients with no-reply/DoNotReply addresses.

Reply check (must be anchored to the specific sent message):

- Consider an email 'replied' only if there is an Inbox message:
  1) in the same Conversation/Thread AND with DateTime > the sent email’s DateTime; AND
  2) from one of the original TO recipients (ignore CC/BCC); AND
  3) where In-Reply-To references the sent email’s Message-ID (when available).
- Do NOT treat earlier messages in the thread as replies to my later sent email.
- The replied email can also be sent later than the mentioned date range, as long as it meets the above criteria.

Output:
Create a table with columns:
Date Sent | Recipient (Organization) | Subject | Key Question/Request | Days Since Sent | Follow-up Priority (High/Medium/Low) | Received answered reply (Yes/No)

Sort by "Days Since Sent" (oldest first) and include ONLY rows where the criteria above find no direct reply.  Show a counter of how many emails you have found.
```

## Example Use Case

Use this prompt at the end of each month to review all sent emails and identify which ones need follow-up. Particularly useful for tracking pending requests, unanswered questions, or proposed meetings that haven't been confirmed. Helps maintain professional communication and ensures important conversations don't slip through the cracks.

## Tags

- email-management
- follow-up
- productivity
- communication-tracking
- inbox-management
- microsoft-365

## Credits

- Created by: @DevSecNinja

## Notes

Make sure to enable the `work` mode in Copilot and enable 'Think deeper'.

## 💬 Feedback

Have suggestions or issues with this prompt? [Click here to provide feedback](https://github.com/DevSecNinja/gpt-prompts/issues/new?labels=feedback,email,email-follow-up-tracker&title=Feedback%3A%20Email%20Follow-up%20Tracker&body=**Prompt%20Reference**%3A%20https%3A%2F%2Fgithub.com%2FDevSecNinja%2Fgpt-prompts%2Fblob%2Fmain%2Fprompts%2Femail%2Femail-follow-up-tracker.md%0A%0A**Your%20Feedback**%3A%0A%0A%3C%21---%20Please%20describe%20your%20suggestion%2C%20issue%2C%20or%20question%20below%20--%3E)
