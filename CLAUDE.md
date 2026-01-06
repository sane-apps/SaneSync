# SaneSync - AI-Powered File Organization

## Project Overview

SaneSync is a native macOS app that brings AI intelligence to file organization.
Users describe what they want in natural language, and the app executes it.

## Key Commands

```bash
./Scripts/SaneMaster.rb verify     # Build + test
./Scripts/SaneMaster.rb test_mode  # Kill → Build → Launch → Logs
./Scripts/SaneMaster.rb logs       # Stream live logs
xcodegen generate                  # Regenerate Xcode project after new files
```

## Architecture

- **Core/** - Business logic, services, AI integration
- **UI/** - SwiftUI views
- **Tests/** - Unit tests
- **Scripts/** - Build tools, hooks

## Core Features (Planned)

1. Natural language file commands
2. iCloud Drive integration (local folder access)
3. Google Drive / Dropbox integration (rclone or native SDKs)
4. Safety confirmations before destructive operations
5. Undo/history for all operations

## Rules

Same as SaneBar - see ~/.claude/CLAUDE.md for global rules.

Key ones:
- Rule #2: VERIFY BEFORE YOU TRY (check APIs exist)
- Rule #9: NEW FILE? GEN THAT PILE (run xcodegen after new files)
- Always stay in /Users/sj/SaneSync/
