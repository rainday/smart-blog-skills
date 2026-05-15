---
name: factcheck
description: >
  Verify statistics and claims in blog posts by fetching cited source URLs and
  checking if the claimed data actually appears on the page. Extracts all
  statistical claims (numbers, percentages, named sources), fetches each cited
  URL via WebFetch, and scores match confidence (exact match 1.0, paraphrase
  0.7-0.9, not found 0.0). Flags uncited claims as UNVERIFIED. Use when user
  says "fact check", "verify statistics", "check sources", "validate claims",
  "factcheck", "source verification", "核查", "驗證數據".
user-invokable: true
argument-hint: "[file]"
license: MIT
---

# Blog Fact-Check

Verify statistics, claims, and source attributions in blog posts.

## Workflow

### Step 1: Read the Blog Post

Read the target file and identify all sections containing data claims.

### Step 2: Extract Statistical Claims

Scan the full text for every claim that includes a number, percentage, dollar
amount, or named source. Build a claims list with these fields:

| Field | Description |
|-------|-------------|
| claim_text | The exact sentence or phrase containing the statistic |
| value | The numeric value (e.g., "42%", "$1.2M", "3x") |
| attribution | Named source if present (e.g., "HubSpot", "Gartner 2025") |
| url | Cited URL if present |
| location | Heading or line number where the claim appears |

### Step 3: Verify Cited Claims

For each claim that includes a URL:

1. Fetch the source page via WebFetch
2. Search the returned content for the specific numeric value
3. If exact value found, check surrounding context matches the claim topic
4. Assign a confidence score

Process claims sequentially to avoid rate-limiting source sites.

### Step 4: Flag Uncited Claims

For claims without a URL:

- Mark status as UNVERIFIED
- Suggest a search query the user can run to find a source

### Step 5: Generate Verification Report

## Verification Scoring

| Score | Status | Criteria |
|-------|--------|----------|
| 1.0 | VERIFIED | Exact number found on cited page in matching context |
| 0.7-0.9 | PARAPHRASE | Similar data found but with different wording, rounding, or timeframe |
| 0.3-0.6 | WEAK | Source page exists and covers the topic but the specific statistic is not visible |
| 0.0 | NOT FOUND | Cited page does not contain the claimed data anywhere |
| N/A | UNVERIFIED | No source URL provided for the claim |

## Output Format

### Verification Report: [Post Title]

**File**: [path]
**Claims found**: [total]
**Verified**: [count] | **Paraphrase**: [count] | **Weak**: [count] | **Not Found**: [count] | **Unverified**: [count]

| # | Claim | Source URL | Score | Status | Notes |
|---|-------|-----------|-------|--------|-------|
| 1 | "73% of marketers..." | https://example.com/report | 1.0 | VERIFIED | Exact match found |
| 2 | "5x ROI improvement" | https://example.com/study | 0.8 | PARAPHRASE | Source says "nearly 5x" |
| 3 | "60% prefer video" | (none) | N/A | UNVERIFIED | Try: "video preference statistics 2025" |

### Recommended Actions
- [List claims that need source URLs]
- [List claims with weak or not-found scores that need replacement sources]

## Limitations

- **Paywalled content**: WebFetch cannot access content behind login walls. Score as WEAK (0.5) with a note.
- **Dynamic pages**: JavaScript-rendered content may not be available via WebFetch.
- **PDF sources**: WebFetch may not extract PDF text reliably. Flag for manual verification.
- **Archived pages**: If a URL returns 404, suggest checking web.archive.org.
- **Rate limits**: Process no more than 10 URLs per run. If a post has more than 10 cited URLs, verify the first 10 and list the remainder as SKIPPED.
