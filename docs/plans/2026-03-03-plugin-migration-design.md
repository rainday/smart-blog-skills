# Smart Blog Plugin Migration — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Migrate smart-blog-skills from a loose skills architecture to a Claude Code plugin with namespaced commands, hooks, settings, and marketplace distribution.

**Architecture:** Restructure directories to match plugin conventions, merge brief into outline, add hooks.json/settings.json/plugin.json. Keep install scripts for non-Claude Code platforms.

**Tech Stack:** Claude Code Plugin System (plugin.json, marketplace.json), SKILL.md frontmatter, AGENT.md format

---

## Task 1: Restructure directories — move blog/ into skills/blog/

**Files:**
- Move: `blog/` → `skills/blog/` (SKILL.md + references/ + templates/)

**Step 1: Create skills/blog/ and move contents**

```bash
# From repo root: d:\行銷\pumpfly\smart-blog-skills
mkdir -p skills/blog
cp -r blog/SKILL.md skills/blog/SKILL.md
cp -r blog/references skills/blog/references
cp -r blog/templates skills/blog/templates
```

**Step 2: Verify the copy**

```bash
ls skills/blog/
ls skills/blog/references/
ls skills/blog/templates/
```

Expected: SKILL.md, references/ (8 .md files), templates/ (5 .md files)

**Step 3: Remove old blog/ directory**

```bash
rm -rf blog/
```

**Step 4: Commit**

```bash
git add skills/blog/ && git add -u
git commit -m "refactor: move blog/ into skills/blog/ for plugin structure"
```

---

## Task 2: Rename sub-skill directories — remove smart-blog-skills- prefix

**Files:**
- Move: `skills/smart-blog-skills-write/` → `skills/write/`
- Move: `skills/smart-blog-skills-analyze/` → `skills/analyze/`
- Move: `skills/smart-blog-skills-rewrite/` → `skills/rewrite/`
- Move: `skills/smart-blog-skills-outline/` → `skills/outline/`

**Step 1: Rename all four directories**

```bash
mv skills/smart-blog-skills-write skills/write
mv skills/smart-blog-skills-analyze skills/analyze
mv skills/smart-blog-skills-rewrite skills/rewrite
mv skills/smart-blog-skills-outline skills/outline
```

**Step 2: Verify**

```bash
ls skills/
```

Expected: `blog/  write/  analyze/  rewrite/  outline/`

No `smart-blog-skills-*` directories should remain.

**Step 3: Commit**

```bash
git add skills/ && git add -u
git commit -m "refactor: rename sub-skill dirs, drop smart-blog-skills- prefix (plugin provides namespace)"
```

---

## Task 3: Create plugin manifest files

**Files:**
- Create: `.claude-plugin/plugin.json`
- Create: `.claude-plugin/marketplace.json`

**Step 1: Create .claude-plugin directory and plugin.json**

Write `.claude-plugin/plugin.json`:
```json
{
  "name": "smart-blog-skills",
  "version": "1.1.0",
  "description": "Anti-hallucination blog engine. 4 commands: write, analyze, rewrite, outline. Triple-layer verification, 100-point scoring, E-E-A-T + AI citation optimization. Traditional Chinese first.",
  "author": {
    "name": "rainday",
    "url": "https://github.com/rainday"
  },
  "repository": "https://github.com/rainday/smart-blog-skills",
  "license": "MIT",
  "keywords": ["blog", "seo", "writing", "anti-hallucination", "eeat", "traditional-chinese"]
}
```

**Step 2: Create marketplace.json**

Write `.claude-plugin/marketplace.json`:
```json
{
  "plugins": [
    {
      "name": "smart-blog-skills",
      "description": "Anti-hallucination blog engine with triple-layer verification",
      "source": "./"
    }
  ]
}
```

**Step 3: Commit**

```bash
git add .claude-plugin/
git commit -m "feat: add plugin.json and marketplace.json for Claude Code plugin distribution"
```

---

## Task 4: Create hooks.json and settings.json

**Files:**
- Create: `hooks/hooks.json`
- Create: `settings.json` (repo root)

**Step 1: Create hooks/hooks.json**

Write `hooks/hooks.json`:
```json
{
  "PostToolUse": [
    {
      "matcher": "Write",
      "hooks": [
        {
          "type": "prompt",
          "prompt": "If the file just written is a blog article (.md/.mdx with frontmatter), remind the user to run /smart-blog-skills:analyze for quality scoring. Otherwise, do nothing."
        }
      ]
    }
  ]
}
```

**Step 2: Create settings.json**

Write `settings.json`:
```json
{
  "permissions": {
    "allow": [
      "WebFetch(domain:pixabay.com)",
      "WebFetch(domain:unsplash.com)",
      "WebFetch(domain:pexels.com)"
    ]
  }
}
```

**Step 3: Commit**

```bash
git add hooks/ settings.json
git commit -m "feat: add hooks (post-write quality reminder) and default WebFetch permissions"
```

---

## Task 5: Update skills/blog/SKILL.md — router updates

**Files:**
- Modify: `skills/blog/SKILL.md`

**Step 1: Update the SKILL.md**

Changes needed:
1. Update `name` from `blog` to `blog` (no change needed — plugin provides `smart-blog-skills:` prefix)
2. Remove `brief` from the command table and routing section
3. Update routing targets from `smart-blog-skills-write` → `write`, `smart-blog-skills-analyze` → `analyze`, etc.
4. Update reference file paths from `blog/references/` → `references/` (now relative to skill dir) or keep as `skills/blog/references/` depending on plugin path resolution
5. Remove `brief` / `簡報` / `策略` from routing rules

Replace the command table with:
```markdown
| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:blog write <主題>` | 從零寫一篇新文章 |
| `/smart-blog-skills:blog analyze <檔案>` | 品質審計 + 100 分評分 |
| `/smart-blog-skills:blog rewrite <檔案>` | 優化改寫現有文章 |
| `/smart-blog-skills:blog outline <主題>` | 生成 SERP 導向大綱 + 關鍵字研究 + 競品分析 |
```

Replace the routing section with:
```markdown
## 指令路由

1. 解析使用者指令，辨識子指令
2. 如果沒有子指令，問使用者要做什麼
3. 路由到對應子技能：
   - `write` / `寫` → `write`
   - `analyze` / `分析` / `audit` → `analyze`
   - `rewrite` / `改寫` / `優化` / `update` → `rewrite`
   - `outline` / `大綱` / `簡報` / `brief` → `outline`
```

Update the description field to remove brief references:
```yaml
description: >
  AI 防幻覺部落格引擎。4 個指令涵蓋完整寫作流程：寫、分析、改寫、大綱。
  雙重優化 Google 排名（E-E-A-T、2025 年 12 月核心更新）和 AI 引用平台（ChatGPT、
  Perplexity、AI Overview）。內建反幻覺三層驗證、100 分品質評分、5 個內容模板。
  支援多平台自動偵測（Next.js、Hugo、Jekyll、Astro、WordPress、靜態 HTML）。
  繁體中文優先。Use when user says "blog", "write blog", "寫文章", "部落格",
  "blog post", "分析文章", "改寫", "大綱", "內容簡報", "blog outline",
  "analyze blog", "rewrite blog", "blog strategy", "content brief", "blog brief".
```

Update reference paths from `blog/references/` → `references/` and `blog/templates/` → `templates/` (relative to this SKILL.md's directory).

**Step 2: Commit**

```bash
git add skills/blog/SKILL.md
git commit -m "refactor: update router — remove brief, update skill references and paths"
```

---

## Task 6: Update sub-skill SKILL.md files — name fields and paths

**Files:**
- Modify: `skills/write/SKILL.md`
- Modify: `skills/analyze/SKILL.md`
- Modify: `skills/rewrite/SKILL.md`

**Step 1: Update skills/write/SKILL.md**

Changes:
1. `name: smart-blog-skills-write` → `name: write`
2. Path references: `blog/references/content-templates.md` → `skills/blog/references/content-templates.md`
3. Path references: `blog/templates/<type>.md` → `skills/blog/templates/<type>.md`
4. Path references: `blog/references/content-rules.md` → `skills/blog/references/content-rules.md`
5. Agent references: `blog-researcher` and `blog-writer` stay unchanged (agents/ dir is at plugin root)

**Step 2: Update skills/analyze/SKILL.md**

Changes:
1. `name: smart-blog-skills-analyze` → `name: analyze`
2. Path references: `blog/references/content-rules.md` → `skills/blog/references/content-rules.md`

**Step 3: Update skills/rewrite/SKILL.md**

Changes:
1. `name: smart-blog-skills-rewrite` → `name: rewrite`
2. Path references: `blog/references/content-rules.md` → `skills/blog/references/content-rules.md`
3. Agent reference: `smart-blog-skills-analyze` → `analyze` (Phase 1 uses analyze logic)

**Step 4: Commit**

```bash
git add skills/write/SKILL.md skills/analyze/SKILL.md skills/rewrite/SKILL.md
git commit -m "refactor: update sub-skill names and path references for plugin structure"
```

---

## Task 7: Merge brief functionality into outline

**Files:**
- Modify: `skills/outline/SKILL.md`

**Step 1: Update skills/outline/SKILL.md**

Changes:
1. `name: smart-blog-skills-outline` → `name: outline`
2. Update description to include brief capabilities
3. Add `--full` mode flag handling
4. Add new steps for keyword research, competitor analysis, visual planning, internal linking
5. Add `WebSearch` and `WebFetch` to allowed-tools (already present)
6. Update path references: `blog/references/` → `skills/blog/references/`

New description:
```yaml
name: outline
description: >
  生成 SERP 導向的文章大綱。分析搜尋結果前 5 名的結構，
  找出內容缺口，產出包含字數建議的完整骨架。
  使用 --full 可產出完整內容簡報（含關鍵字研究、競品分析、視覺元素規劃）。
```

Add after Step 1 (before SERP analysis), a new section for `--full` mode:

```markdown
### 模式判斷

- 預設模式：快速大綱（Step 1-6）
- `--full` 模式：完整內容簡報（加入 Step 2b、Step 4b、Step 7）

如果使用者說「簡報」「brief」「完整」或加了 `--full`，進入完整模式。
```

Add Step 2b (after SERP analysis, only in --full mode):

```markdown
### Step 2b：關鍵字研究（--full 模式）

1. 用 WebSearch 搜尋關鍵字變體和長尾關鍵字
2. 分析搜尋意圖（資訊型 / 交易型 / 導航型）
3. 輸出：

| 類型 | 關鍵字 | 搜尋意圖 |
|------|--------|---------|
| 主要 | [關鍵字] | [意圖] |
| 長尾 | [關鍵字 1] | [意圖] |
| 長尾 | [關鍵字 2] | [意圖] |
| 長尾 | [關鍵字 3] | [意圖] |
```

Add Step 4b (after outline generation, only in --full mode):

```markdown
### Step 4b：競品分析表（--full 模式）

分析 SERP 前 3-5 名：

| 排名 | 標題 | 字數 | H2 數 | 有 FAQ | 有圖表 | 差異化機會 |
|------|------|------|-------|--------|--------|-----------|
| 1 | [標題] | [N] | [N] | [Y/N] | [Y/N] | [描述] |
| 2 | [標題] | [N] | [N] | [Y/N] | [Y/N] | [描述] |
| ... | ... | ... | ... | ... | ... | ... |
```

Add Step 7 (only in --full mode):

```markdown
### Step 7：視覺與連結規劃（--full 模式）

#### 視覺元素
- 封面圖方向：[建議主題和風格]
- 內文圖：每 200-400 字一張，共 [N] 張
- 圖表規劃：[N] 個，類型建議

#### 統計數據搜尋方向
列出 8-12 個需要搜尋的統計方向：
1. [方向 + 建議搜尋查詢]
2. [方向 + 建議搜尋查詢]
...

#### 內部連結規劃
- 建議連結密度：[N] 個（依目標字數）
- 連結放置位置：引言、H2 段落、FAQ、結論
```

**Step 2: Commit**

```bash
git add skills/outline/SKILL.md
git commit -m "feat: merge brief functionality into outline with --full mode"
```

---

## Task 8: Update agent path references

**Files:**
- Modify: `agents/blog-researcher.md`
- Modify: `agents/blog-writer.md`

**Step 1: Update agents/blog-researcher.md**

Change path references:
- `blog/references/seo-landscape.md` → `skills/blog/references/seo-landscape.md`

**Step 2: Update agents/blog-writer.md**

Change path references:
- `blog/templates/[selected-template].md` → `skills/blog/templates/[selected-template].md`
- `blog/references/content-rules.md` → `skills/blog/references/content-rules.md`
- `blog/references/eeat-signals.md` → `skills/blog/references/eeat-signals.md`
- `blog/references/schema-stack.md` → `skills/blog/references/schema-stack.md`
- `blog/references/visual-media.md` → `skills/blog/references/visual-media.md`
- `blog/references/internal-linking.md` → `skills/blog/references/internal-linking.md`

**Step 3: Commit**

```bash
git add agents/
git commit -m "refactor: update agent path references for plugin directory structure"
```

---

## Task 9: Update README.md

**Files:**
- Modify: `README.md`

**Step 1: Update README.md**

Major changes:
1. Add plugin installation as the primary method (above manual install)
2. Update command examples from `/blog write` → `/smart-blog-skills:write` (or `/smart-blog-skills:blog write`)
3. Update project structure diagram
4. Remove brief from command table
5. Update workflow recommendation (remove brief step)
6. Keep install.sh/install.ps1 section for non-Claude Code platforms

New installation section:
```markdown
## 安裝

### Claude Code（推薦）

```bash
/plugin marketplace add rainday/smart-blog-skills
/plugin install smart-blog-skills
```

安裝完成後直接使用，不需要重啟。

### 其他平台（手動安裝）

[keep existing install.sh/install.ps1 section]
```

Update command table:
```markdown
## 4 個指令

| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:write <主題>` | 從零寫一篇新文章 |
| `/smart-blog-skills:analyze <檔案>` | 品質審計 + 100 分評分 |
| `/smart-blog-skills:rewrite <檔案>` | 優化改寫現有文章 |
| `/smart-blog-skills:outline <主題>` | 生成 SERP 導向大綱 |

> `/smart-blog-skills:outline <主題> --full` 可產出完整內容簡報（含關鍵字研究 + 競品分析）
```

Update workflow:
```markdown
### 建議工作流程

1. /smart-blog-skills:outline "主題" --full  ← 先產大綱 + 簡報
2. /smart-blog-skills:write "主題"            ← 開始寫文章
3. /smart-blog-skills:analyze ./file.md       ← 品質檢查 100 分評分
4. /smart-blog-skills:rewrite ./file.md       ← 分數不夠就改寫
```

Update project structure to match new layout.

**Step 2: Commit**

```bash
git add README.md
git commit -m "docs: update README for plugin architecture and new command format"
```

---

## Task 10: Update install scripts for non-Claude Code platforms

**Files:**
- Modify: `install.sh`
- Modify: `install.ps1`

**Step 1: Update install.sh**

Changes:
1. For Claude Code (option 1): Update source paths from `blog/` → `skills/blog/`, `skills/smart-blog-skills-*` → `skills/write`, `skills/analyze`, etc.
2. For Antigravity/Codex (options 2-3): Same path updates
3. For Cursor/Cline/Kilo (options 4-6): Update reference paths from `blog/references/` → `skills/blog/references/`, `blog/templates/` → `skills/blog/templates/`
4. Add note recommending plugin install for Claude Code users

**Step 2: Update install.ps1**

Same changes as install.sh but in PowerShell syntax.

**Step 3: Commit**

```bash
git add install.sh install.ps1
git commit -m "refactor: update install scripts for new directory structure"
```

---

## Task 11: Clean up and verify

**Step 1: Verify no old directories remain**

```bash
ls -la
ls skills/
ls .claude-plugin/
```

Expected final structure:
```
.claude-plugin/    (plugin.json, marketplace.json)
skills/            (blog/, write/, analyze/, rewrite/, outline/)
agents/            (blog-researcher.md, blog-writer.md)
hooks/             (hooks.json)
settings.json
STRATEGY.md
README.md
install.sh
install.ps1
uninstall.sh
uninstall.ps1
docs/plans/
```

No `blog/` at root. No `skills/smart-blog-skills-*` directories.

**Step 2: Test locally**

```bash
claude --plugin-dir .
```

Then try:
- `/smart-blog-skills:blog` — should show router
- `/smart-blog-skills:write` — should show write skill

**Step 3: Final commit if any cleanup needed**

```bash
git add -A
git commit -m "chore: final cleanup after plugin migration"
```

---

## Summary

| Task | Description | Commit |
|------|-------------|--------|
| 1 | Move blog/ → skills/blog/ | `refactor: move blog/ into skills/blog/` |
| 2 | Rename smart-blog-skills-* → short names | `refactor: rename sub-skill dirs` |
| 3 | Create plugin.json + marketplace.json | `feat: add plugin manifest` |
| 4 | Create hooks.json + settings.json | `feat: add hooks and settings` |
| 5 | Update router SKILL.md | `refactor: update router` |
| 6 | Update sub-skill SKILL.md files | `refactor: update sub-skill names/paths` |
| 7 | Merge brief into outline | `feat: merge brief into outline` |
| 8 | Update agent path references | `refactor: update agent paths` |
| 9 | Update README.md | `docs: update README` |
| 10 | Update install scripts | `refactor: update install scripts` |
| 11 | Clean up and verify | `chore: final cleanup` |
