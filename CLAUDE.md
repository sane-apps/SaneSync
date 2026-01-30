# SaneSync - AI-Powered File Organization

---

## Sane Philosophy

```
┌─────────────────────────────────────────────────────┐
│           BEFORE YOU SHIP, ASK:                     │
│                                                     │
│  1. Does this REDUCE fear or create it?             │
│  2. Power: Does user have control?                  │
│  3. Love: Does this help people?                    │
│  4. Sound Mind: Is this clear and calm?             │
│                                                     │
│  Grandma test: Would her life be better?            │
│                                                     │
│  "Not fear, but power, love, sound mind"            │
│  — 2 Timothy 1:7                                    │
└─────────────────────────────────────────────────────┘
```

→ Full philosophy: `~/SaneApps/meta/Brand/NORTH_STAR.md`

---

## Project Location

| Path | Description |
|------|-------------|
| **This project** | `~/SaneApps/apps/SaneSync/` |
| **Save outputs** | `~/SaneApps/apps/SaneSync/outputs/` |
| **Screenshots** | `~/Desktop/Screenshots/` (label with project prefix) |
| **Shared UI** | `~/SaneApps/infra/SaneUI/` |
| **Hooks/tooling** | `~/SaneApps/infra/SaneProcess/` |

**Sister apps:** SaneBar, SaneClip, SaneVideo, SaneHosts, SaneAI, SaneClick

---

## Where to Look First

| Need | Check |
|------|-------|
| Build/test commands | `./Scripts/SaneMaster.rb --help` |
| Project structure | `project.yml` (XcodeGen config) |
| Past bugs/learnings | `.claude/memory.json` or MCP memory |
| Code patterns | `.claude/rules/` directory |
| Swift services | `Core/Services/` directory |
| AI integration | `Core/AI/` directory |
| UI components | `UI/` directory |

---

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
- Always stay in /Users/sj/SaneApps/apps/SaneSync/

---

## MCP Tool Optimization (TOKEN SAVERS)

### XcodeBuildMCP Session Setup
At session start, set defaults ONCE to avoid repeating on every build:
```
mcp__XcodeBuildMCP__session-set-defaults:
  projectPath: /Users/sj/SaneApps/apps/SaneSync/SaneSync.xcodeproj
  scheme: SaneSync
  arch: arm64
```
Note: SaneSync is a **macOS app** - no simulator needed. Use `build_macos`, `test_macos`, `build_run_macos`.

### claude-mem 3-Layer Workflow (10x Token Savings)
```
1. search(query, project: "SaneSync") → Get index with IDs (~50-100 tokens/result)
2. timeline(anchor=ID)               → Get context around results
3. get_observations([IDs])           → Fetch ONLY filtered IDs
```
**Always add `project: "SaneSync"` to searches for isolation.**

### apple-docs Optimization
- `compact: true` works on `list_technologies`, `get_sample_code`, `wwdc` (NOT on `search_apple_docs`)
- `analyze_api analysis="all"` for comprehensive API analysis
- `apple_docs` as universal entry point (auto-routes queries)

### context7 for Library Docs
- `resolve-library-id` FIRST, then `query-docs`
- SwiftUI ID: `/websites/developer_apple_swiftui` (13,515 snippets!)

### macos-automator (493 Pre-Built Scripts)
- `get_scripting_tips search_term: "keyword"` to find scripts
- `get_scripting_tips list_categories: true` to browse
- 13 categories including `13_developer` (92 Xcode/dev scripts)

### github MCP
- `search_code` to find patterns in public repos
- `search_repositories` to find reference implementations

---

## Claude Code Features (USE THESE!)

### Key Commands

| Command | When to Use | Shortcut |
|---------|-------------|----------|
| `/rewind` | Rollback code AND conversation after errors | `Esc+Esc` |
| `/context` | Visualize context window token usage | - |
| `/compact [instructions]` | Optimize memory with focus | - |
| `/stats` | See usage patterns (press `r` for date range) | - |

### Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Esc+Esc` | Rewind to checkpoint |
| `Shift+Tab` | Cycle permission modes |
| `Option+T` | Toggle extended thinking |
| `Ctrl+B` | Background running task |

### Smart /compact Instructions

```
/compact keep SaneSync file operation patterns and cloud sync learnings, archive general Swift tips
```

### Project Skills (Auto-Discovered)

Skills in `.claude/skills/` activate automatically:

| Skill | Triggers When |
|-------|---------------|
| `session-context-manager` | Checking memory health, session state |
| `memory-compactor` | Memory full, tokens high |
| `codebase-explorer` | Searching code, finding implementations |
| `mlx-fine-tuning` | ML model fine-tuning questions |

### Use Explore Subagent for Searches

```
Task tool with subagent_type: Explore
```
