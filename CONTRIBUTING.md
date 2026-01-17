# Contributing to SaneSync

Thanks for your interest in contributing to SaneSync! This document explains how to get started.

---

## Quick Start

```bash
# Clone the repo
git clone https://github.com/stephanjoseph/SaneSync.git
cd SaneSync

# Install dependencies
bundle install

# Generate Xcode project and verify build
./Scripts/SaneMaster.rb verify
```

If everything passes, you're ready to contribute!

---

## Development Environment

### Requirements

- **macOS 15.0+** (Sequoia or later)
- **Xcode 16+**
- **Ruby 3.0+** (for build scripts)
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) - installed via `bundle install`

### Key Commands

| Command | Purpose |
|---------|---------|
| `./Scripts/SaneMaster.rb verify` | Build + run all tests |
| `./Scripts/SaneMaster.rb test_mode` | Kill → Build → Launch → Stream logs |
| `./Scripts/SaneMaster.rb logs` | Stream live app logs |
| `xcodegen generate` | Regenerate project after new files |

---

## Project Structure

```
SaneSync/
├── Core/                   # Business logic, AI integration
├── UI/                     # SwiftUI views
├── Tests/                  # Unit tests
├── Scripts/                # Build tools, hooks
└── project.yml             # XcodeGen configuration
```

---

## Coding Standards

- **Swift 6.0+**
- **@Observable** instead of @StateObject
- **Swift Testing** framework (`import Testing`, `@Test`, `#expect`)
- **Actors** for services with shared mutable state

---

## Making Changes

1. Check [GitHub Issues](https://github.com/stephanjoseph/SaneSync/issues) for existing discussions
2. **Fork** the repository
3. **Create a branch** from `main`
4. **Run tests**: `./Scripts/SaneMaster.rb verify`
5. **Submit a PR** with clear description

---

## Code of Conduct

This project follows the [Contributor Covenant](CODE_OF_CONDUCT.md). Please be respectful and constructive.

---

## Questions?

Open a [GitHub Issue](https://github.com/stephanjoseph/SaneSync/issues)

Thank you for contributing!
