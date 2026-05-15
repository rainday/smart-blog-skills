---
name: cannibalization
description: >
  Detect keyword cannibalization across blog posts by extracting primary keywords
  from titles and headings, clustering semantically similar targets, and flagging
  posts competing for the same search intent. Outputs severity-scored report with
  merge or differentiate recommendations. Use when user says "cannibalization",
  "keyword overlap", "competing pages", "duplicate keywords", "cannibalize",
  "關鍵字重疊", "關鍵字蠶食".
user-invokable: true
argument-hint: "[directory] [--api]"
license: MIT
---

# Blog Cannibalization - Keyword Overlap Detection

Detect when multiple blog posts compete for the same search keywords. Two modes:
local-only analysis (default) and DataForSEO API mode for SERP-level data.

## Two Modes

| Mode | Flag | Cost | Data Source |
|------|------|------|-------------|
| Local | (default) | Free | File content analysis via Grep/Read |
| API | `--api` | ~$0.01/call | DataForSEO Page Intersection + Ranked Keywords |

Local mode works without any API keys. API mode requires DataForSEO credentials
set as environment variables: `DATAFORSEO_LOGIN` and `DATAFORSEO_PASSWORD`.

## Local Mode Workflow

### Step 1: Scan Blog Files

Use Glob to find all content files in the target directory:
- Patterns: `**/*.md`, `**/*.mdx`, `**/*.html`
- Skip files in `node_modules/`, `.git/`, `drafts/`

### Step 2: Extract Primary Keywords

For each file, read and extract keyword signals from:
- **Title tag** or H1 heading (highest weight)
- **H2 headings** (medium weight)
- **First paragraph** (supporting signal)
- **Meta description** if present in frontmatter

### Step 3: Cluster by Similarity

Group posts into clusters using these matching rules (in priority order):

1. **Exact match** - identical primary keyword across 2+ posts
2. **Stem match** - same root word (e.g., "optimize" vs "optimization")
3. **Semantic overlap** - Claude determines that two keywords target the same search intent
4. **Subset match** - one keyword contains another

### Step 4: Score and Flag

For each cluster with 2+ posts, assess severity and generate a recommendation.

## Severity Scoring

| Level | Criteria | Action Urgency |
|-------|----------|----------------|
| Critical | Same exact keyword, both pages in top 20 | Immediate |
| High | Same keyword cluster, one page outranks the other | This week |
| Medium | Related keywords with partial SERP overlap | This month |
| Low | Semantic similarity but different confirmed intents | Monitor |

## Output Format

### Summary Table

```
| Post A | Post B | Shared Keywords | Severity | Recommendation |
|--------|--------|-----------------|----------|----------------|
| /best-crm-tools | /top-crm-software | best crm, crm tools | Critical | MERGE |
| /email-tips | /email-marketing-guide | email marketing | High | DIFFERENTIATE |
```

### Per-Cluster Detail

For each flagged cluster, provide:
- Both post titles and URLs
- Full list of overlapping keywords
- Which post is stronger
- Specific recommendation with rationale

## Recommendations

### MERGE
When both pages are thin or cover the same intent with similar depth.
- Combine the best content from both into one comprehensive post
- 301 redirect the weaker URL to the merged post

### DIFFERENTIATE
When pages serve different intents but keyword targeting overlaps.
- Shift the primary keyword of the weaker post to a related long-tail
- Update the title, H1, and meta description

### CANONICAL
When one post is clearly the authority and the other is a lesser duplicate.
- Add `rel="canonical"` on the weaker page pointing to the authority

### NO ACTION
When intent is genuinely different despite surface-level keyword similarity.
- Document the reasoning for future audits
- Monitor rankings quarterly

## Error Handling

- **No blog files found**: Report "No blog files found in [directory]" and suggest checking the path
- **Single-post directory**: Report "Cannibalization analysis requires at least 2 posts" and exit gracefully
- **DataForSEO credentials missing**: Fall back to local mode automatically and notify the user
