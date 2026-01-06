# SaneSync - Real World Insights

**Source:** Actual file organization session - January 5, 2026
**Context:** Organized 20 years of accumulated files across Desktop, Documents, iCloud, and Google Drive

---

## The Core Problem

> "I've been meaning to clean up my computer for 20 years but never got around to it. Never trusted dumb auto match tools. I needed an intelligent person to do it."

Users don't want:
- Pattern matching that deletes wedding photos as "duplicates"
- Nested folder structures that hide files
- Tools that require manual categorization
- Anything that might destroy irreplaceable data

Users want:
- Natural language: "flatten it" / "put photos in photos"
- Intelligence that understands context
- Confidence that nothing important gets lost
- Files ACCESSIBLE, not archived in deep structures

---

## User Quotes That Define the Product

| Quote | Implication |
|-------|-------------|
| "Never trusted dumb auto match tools" | Intelligence is the differentiator |
| "You aren't a person but you're smart enough to not just auto delete things" | Safety + smarts = trust |
| "If it were just THERE in my photos and documents I'd be able to do something with it" | Accessibility > organization theory |
| "I don't want anything hidden in subfolders that are stupid" | Flat > nested, always |
| "I trust google and apple to catch duplicate photos and videos" | Leverage platform dedup, don't rebuild it |

---

## Technical Architecture (Validated)

### What Works

**iCloud Access:**
```
~/Library/Mobile Documents/com~apple~CloudDocs/
```
- Just a local folder. No API needed.
- Full read/write access
- Syncs automatically to cloud

**Google Drive Access:**
- rclone with OAuth: `rclone config create gdrive drive`
- Full CRUD operations
- 40+ cloud providers supported

**Bidirectional Sync:**
```bash
# CORRECT - only adds newer files, never deletes
rclone copy "$SOURCE" "$DEST" --update

# WRONG - deletes files not in source
rclone sync "$SOURCE" "$DEST"  # DANGEROUS for bidirectional
```

**Photos Import (macOS):**
```applescript
tell application "Photos"
    import POSIX file "/path/to/photo.jpg" skip check duplicates yes
end tell
```

**Apple Music Import:**
```
~/Music/Music/Media.localized/Automatically Add to Music.localized/
```
Just copy files there. Music.app handles the rest.

### Folder Structure That Worked

Underscore prefix for sort order:
```
_Documents/
_Faith/
_Financial/
_Housing/
_Kids/
_Legal/
_Misc/
_Photos/
_School/
_Videos/
_Work/
_Writing/
```

User loved this - everything sorts to top, clear categories.

---

## Technical Requirements (What We Actually Used)

### Minimum macOS Version
- **Used:** macOS 26.2 (Tahoe) on Apple Silicon
- **Minimum viable:** macOS 13+ (Ventura) - needs modern Swift concurrency, SwiftUI features
- **Recommended:** macOS 14+ (Sonoma) for best SwiftUI/Observable support

### System Tools Used (All Built-in)
```
osascript          # AppleScript execution (Photos import)
find               # File discovery
mv / cp / rm       # File operations
mkdir              # Directory creation
launchctl          # Scheduled task management
```

### External Tools Used
```
rclone             # Cloud provider sync (Google Drive, Dropbox, etc.)
                   # Install: brew install rclone
                   # Config: rclone config (OAuth flow)
```

### Claude API
```
Model: claude-opus-4-5-20251101 (or claude-sonnet for cheaper operations)
SDK: Anthropic Swift SDK or direct REST API
Auth: API key from console.anthropic.com
```

### File System Paths Used
```
# iCloud Drive (local folder - no API needed)
~/Library/Mobile Documents/com~apple~CloudDocs/

# Apple Music auto-import
~/Music/Music/Media.localized/Automatically Add to Music.localized/

# Photos.app - accessed via AppleScript, no direct path needed

# Trash (safe delete destination)
~/.Trash/

# rclone config
~/.config/rclone/rclone.conf

# launchd user agents
~/Library/LaunchAgents/
```

### Entitlements Needed
```xml
<!-- For file access outside sandbox -->
<key>com.apple.security.app-sandbox</key>
<false/>

<!-- Or if sandboxed, need these: -->
<key>com.apple.security.files.user-selected.read-write</key>
<true/>
<key>com.apple.security.files.bookmarks.app-scope</key>
<true/>

<!-- For Claude API calls -->
<key>com.apple.security.network.client</key>
<true/>
```

### Privacy Permissions (System Prompts)
- **Full Disk Access** - For accessing ~/Library/Mobile Documents/ and other protected paths
- **Photos Access** - If integrating with Photos.app directly
- **Automation** - For AppleScript control of Photos, Music, etc.

### What the App Must Bundle or Require
1. **rclone binary** - Either bundle it (~50MB) or require user install via Homebrew
2. **Claude API key** - User provides, or developer proxies through backend
3. **OAuth tokens** - Stored in Keychain for Google Drive, Dropbox, etc.

---

## Mistakes Made (Build Safeguards For These)

### 1. Deleted Before Confirming
**What happened:** Moved photos to Photos.app, deleted source, some imports failed silently.
**User response:** "It's ok but yea next time check for confirm before deletion"

**Safeguard needed:**
```
Before any delete:
1. Verify destination has the files
2. Show user what will be deleted
3. Require explicit confirmation
4. Move to trash first, not permanent delete
```

### 2. Wrong Location Assumption
**What happened:** Assumed FB Data was in `_Work`, it was in `_Misc`.
**Fix:** Always verify paths exist before operating.

### 3. Used Destructive Sync
**What happened:** Initially used `rclone sync` which deletes files not in source.
**Fix:** Use `rclone copy --update` for bidirectional sync.

---

## Session Statistics

| Metric | Value |
|--------|-------|
| Files organized | ~20,000+ |
| FB photos flattened | 11,012 |
| FB videos flattened | 4,922 |
| FB documents flattened | 3,357 |
| Data synced | ~8+ GiB |
| Time | ~2 hours |
| User interventions needed | ~5 (mostly clarifications) |

---

## Product Requirements (Derived)

### Must Have (P0)
- [ ] Natural language input for file operations
- [ ] Confirmation dialog before ANY delete
- [ ] Undo/history for all operations
- [ ] iCloud folder access
- [ ] Google Drive integration
- [ ] Flat structure option ("don't hide things in subfolders")
- [ ] Progress visibility (what's happening, what's done)

### Should Have (P1)
- [ ] Dropbox, OneDrive support
- [ ] Photos.app import integration
- [ ] Duplicate detection (with user confirmation)
- [ ] Scheduled sync (launchd integration)
- [ ] Dry-run mode ("show me what you'd do")

### Nice to Have (P2)
- [ ] Apple Music integration
- [ ] Kindle/Books sync
- [ ] iOS companion app
- [ ] Face/object recognition for photo sorting

---

## Business Philosophy

**Core principles:**
- **Buy once** - No subscriptions. People have subscription fatigue.
- **Privacy centric** - Files never leave the machine unless user explicitly syncs to cloud
- **Mac native** - Swift/SwiftUI, not Electron bloat
- **Simple to use** - Grandma-friendly eventually
- **Updates for 2 years** - Then it's done, or pay for v2

**API Cost Reality:**
- ~$0.15-0.75 per "organize my stuff" session at current Claude API rates
- Options: bundle X sessions with purchase, user brings own key, or hybrid
- Buy-once model could work: $29-49 with ~20 included sessions, then user adds own key or buys session packs

**Avoid:**
- Monthly subscriptions
- Cloud-based processing (privacy concern)
- Feature bloat
- Cross-platform complexity (Mac-first, Mac-only is fine)

---

## Competitive Advantage

No one else has this:
- **Hazel:** Rules-based, no intelligence
- **Default Folder X:** Finder enhancement, not organization
- **Cloud sync apps:** Move files, don't understand them
- **AI assistants:** Chat interface, not native Mac integration

SaneSync = **Native Mac app + AI intelligence + file system access**

Tagline candidates:
- "Tell it what you want. It actually listens."
- "Finally, sane file management."
- "20 years of mess. 2 hours to fix."

---

## Development Priority

1. **Core engine:** Claude API + file operations + safety checks
2. **iCloud + local files:** The 80% use case
3. **Google Drive:** rclone integration
4. **UI:** Simple chat + progress + history
5. **Polish:** Onboarding, edge cases, error handling

---

## Key Insight

The magic isn't the file operations - `mv`, `cp`, `rclone` are solved problems.

The magic is **understanding intent** and **being trustworthy**.

User said: "flatten it" → System understood: move all nested photos/videos/docs to top-level folders by type.

User said: "i dont want anything hidden in subfolder that are stupid" → System understood: accessibility over archival structure.

That's what 20 years of tools couldn't do. That's SaneSync.
