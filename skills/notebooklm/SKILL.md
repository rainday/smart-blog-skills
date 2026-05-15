---
name: notebooklm
description: >
  Query Google NotebookLM notebooks for source-grounded, citation-backed
  answers from user-uploaded documents. Manages notebook library, handles
  Google authentication, and supports smart discovery. Works standalone
  via /smart-blog-skills:notebooklm or internally from write and blog-researcher
  for Tier 1 research data. Falls back gracefully when not configured.
  Use when user says "notebooklm", "notebook", "query notebook",
  "ask notebook", "notebook research", "source grounded research",
  "document query", "notebook library".
user-invokable: true
argument-hint: "[ask|discover|library|setup|status|cleanup] [question-or-url]"
license: MIT
---

# Blog NotebookLM -- Source-Grounded Research from Your Documents

Query Google NotebookLM notebooks directly from Claude Code for citation-backed
answers from Gemini. Each question opens a headless browser session, retrieves
the answer exclusively from your uploaded documents, and closes. Responses are
Tier 1 quality (user's own primary sources) -- zero hallucination risk.
Answers satisfy the FLOW evidence triple: use the returned source title as the
inline citation and the notebook URL plus retrieval date as the bibliography entry.

## Quick Reference

| Command | What it does |
|---------|-------------|
| `/smart-blog-skills:notebooklm ask <question>` | Query a notebook for source-grounded answers |
| `/smart-blog-skills:notebooklm discover <url>` | Smart-discover notebook content before cataloging |
| `/smart-blog-skills:notebooklm library list` | List all notebooks in library |
| `/smart-blog-skills:notebooklm library add <url>` | Add a notebook to library |
| `/smart-blog-skills:notebooklm library search <query>` | Search notebooks by keyword |
| `/smart-blog-skills:notebooklm library remove <id>` | Remove a notebook from library |
| `/smart-blog-skills:notebooklm setup` | One-time Google authentication (browser visible) |
| `/smart-blog-skills:notebooklm status` | Check authentication status |
| `/smart-blog-skills:notebooklm cleanup` | Clean browser state (preserves library) |

## Prerequisites

- Google account with NotebookLM access
- Python 3.11+ (venv managed automatically by `run.py`)
- Google Chrome (installed automatically on first run via Patchright)
- One-time authentication setup (interactive Google login in visible browser)

## Always Use run.py Wrapper

**NEVER call scripts directly. ALWAYS use `python3 scripts/run.py [script]`:**

```bash
# CORRECT:
python3 scripts/run.py auth_manager.py status
python3 scripts/run.py ask_question.py --question "..."

# WRONG -- fails without venv:
python3 scripts/auth_manager.py status
```

## Auth Check (Gate Pattern)

Before any query operation, check authentication:

```bash
python3 scripts/run.py auth_manager.py status
```

- If authenticated: proceed with the query
- If not authenticated: inform user and guide to setup:
  "NotebookLM requires Google login. Run `/smart-blog-skills:notebooklm setup` to authenticate."
- **When called internally** (from write or blog-researcher): return silently
  with no error if not authenticated. Never block the writing workflow.

## Setup Workflow

For `/smart-blog-skills:notebooklm setup`:

```bash
# Opens a visible browser for manual Google login (one-time)
python3 scripts/run.py auth_manager.py setup
```

Tell the user: "A browser window will open. Please log in to your Google account."
Authentication persists via browser profile + cookie injection (hybrid approach).

Other auth commands:
```bash
python3 scripts/run.py auth_manager.py status   # Check auth
python3 scripts/run.py auth_manager.py reauth   # Re-authenticate
python3 scripts/run.py auth_manager.py clear     # Clear all auth data
```

## Query Workflow

For `/smart-blog-skills:notebooklm ask <question>`:

### Step 1: Check Auth
Run auth check (see gate pattern above). If not authenticated, guide to setup.

### Step 2: Resolve Notebook
Determine which notebook to query:
- If `--notebook-url` provided: use directly
- If `--notebook-id` provided: look up in library
- If neither: use active notebook from library
- If no active notebook: show library and ask user to select

### Step 3: Ask the Question
```bash
# Basic query (uses active notebook)
python3 scripts/run.py ask_question.py --question "Your question here"

# Query specific notebook by ID
python3 scripts/run.py ask_question.py --question "..." --notebook-id notebook-id

# Query by URL directly
python3 scripts/run.py ask_question.py --question "..." --notebook-url "https://..."

# JSON output (for internal/programmatic use)
python3 scripts/run.py ask_question.py --question "..." --json
```

### Step 4: Analyze and Follow Up
Every response ends with a follow-up prompt. **Required behavior:**
1. **STOP** -- do not immediately respond to the user
2. **ANALYZE** -- compare the answer to the user's original request
3. **IDENTIFY GAPS** -- determine if more information is needed
4. **ASK FOLLOW-UP** -- if gaps exist, immediately ask a follow-up question
5. **REPEAT** -- continue until information is complete
6. **SYNTHESIZE** -- combine all answers before responding to the user

## Smart Discovery Workflow

For `/smart-blog-skills:notebooklm discover <url>`:

When adding a notebook without knowing its content, query it first:

```bash
# Step 1: Discover content
python3 scripts/run.py ask_question.py \
  --question "What is the content of this notebook? What topics are covered? Provide a complete overview briefly and concisely" \
  --notebook-url "<URL>"

# Step 2: Add with discovered metadata
python3 scripts/run.py notebook_manager.py add \
  --url "<URL>" \
  --name "<Based on content>" \
  --description "<Based on content>" \
  --topics "<Extracted topics>"
```

**NEVER guess or use generic descriptions.** Always discover or ask the user.

## Library Management

```bash
# List all notebooks
python3 scripts/run.py notebook_manager.py list

# Add notebook (all params required -- discover or ask user!)
python3 scripts/run.py notebook_manager.py add \
  --url "https://notebooklm.google.com/notebook/..." \
  --name "Descriptive Name" \
  --description "What this notebook contains" \
  --topics "topic1,topic2,topic3"

# Search by keyword
python3 scripts/run.py notebook_manager.py search --query "keyword"

# Set active notebook
python3 scripts/run.py notebook_manager.py activate --id notebook-id
```

## Data Storage

All data stored inside the skill directory:
- `scripts/data/library.json` -- Notebook metadata and library
- `scripts/data/auth_info.json` -- Authentication status
- `scripts/data/browser_state/` -- Chrome profile with cookies

**Security:** All data directories are gitignored. Never commit auth or browser state.

## Error Handling

| Error | Resolution |
|-------|-----------|
| Not authenticated | Run `/smart-blog-skills:notebooklm setup` |
| ModuleNotFoundError | Always use `run.py` wrapper |
| Browser crash | `cleanup_manager.py --confirm --preserve-library`, then re-auth |
| Rate limit (50/day) | Wait until midnight PST or switch Google account |
| Notebook not found | Check with `notebook_manager.py list` |
| Query timeout (120s) | Retry with simpler question or `--show-browser` to debug |
| MCP unavailable (internal) | Return silently -- writing workflow uses WebSearch |

## Limitations

- No session persistence (each question = new browser session)
- Rate limits on free Google accounts (50 queries/day)
- Manual upload required (user must add docs to NotebookLM web UI)
- Browser overhead (few seconds per question for launch + teardown)
- Local Claude Code only (not available in web UI)
