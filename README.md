# SaneSync

[![License: MIT](https://img.shields.io/github/license/stephanjoseph/SaneSync)](LICENSE)
[![macOS 15+](https://img.shields.io/badge/macOS-15%2B-blue)](https://github.com/stephanjoseph/SaneSync/releases)
[![Privacy: 100% On-Device](https://img.shields.io/badge/Privacy-100%25%20On--Device-success)](PRIVACY.md)

**AI-powered file organization for macOS.** Tell it what you want in natural language, it handles the rest.

---

## Features

### Natural Language Commands
- "Flatten all my photos into one folder"
- "Organize downloads by file type"
- "Move documents older than 2023 to archive"

### Multi-Cloud Support
- iCloud Drive
- Google Drive
- Dropbox
- Local folders

### Safety First
- Confirmation prompts before destructive operations
- Full undo/history for all operations
- Preview changes before applying

### Privacy
- **100% on-device processing**
- No files uploaded to cloud
- Claude API for intelligence (your API key, your control)

---

## Requirements

- macOS 15.0+ (Sequoia or later)
- Apple Silicon (M1/M2/M3/M4)
- Claude API key (for AI features)

---

## Installation

Coming soon! SaneSync is in active development.

---

## Development

See [CONTRIBUTING.md](CONTRIBUTING.md) for setup instructions.

```bash
# Clone and build
git clone https://github.com/stephanjoseph/SaneSync.git
cd SaneSync
bundle install
./Scripts/SaneMaster.rb verify
```

---

## Privacy

SaneSync processes all files locally on your Mac. The only external communication is with the Claude API when you execute natural language commands:

- Your files are never uploaded
- Only command text is sent to Claude
- No analytics or telemetry
- No account required

---

## License

MIT — see [LICENSE](LICENSE)

---

## Support

- [GitHub Issues](https://github.com/stephanjoseph/SaneSync/issues)
