# Security Policy

## Reporting a Vulnerability

**Please do NOT report security vulnerabilities through public GitHub issues.**

Instead, please report them via email to: **stephanjoseph2007@gmail.com**

Include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact

You should receive a response within 48 hours.

---

## Security Model

SaneSync is a **file organization application** that:

1. **Requires file system access** to organize files
2. **Communicates with Claude API** for AI-powered commands
3. **Stores settings locally** on your Mac
4. **Uses OAuth** for cloud service integration (Google Drive, Dropbox)

### Data Handling

- Files are processed locally — never uploaded
- Only command text is sent to Claude API
- OAuth tokens stored in system Keychain
- No analytics or telemetry

### Permissions Required

- File system access (to organize files)
- Network access (Claude API, cloud services)
- Keychain access (OAuth tokens)

---

## Privacy

- No files are uploaded to any server
- Claude API receives only your natural language commands
- No analytics, telemetry, or tracking
