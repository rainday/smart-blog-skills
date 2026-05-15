---
name: calendar
description: >
  Generate editorial calendars for blogs with topic clusters, publishing
  schedules, content decay detection, freshness update plans, seasonal
  opportunities, content mix formula, template integration, and distribution
  scheduling. Plans monthly or quarterly calendars optimized for SEO topic
  authority and AI citation freshness requirements (30-day update cycles).
  Use when user says "editorial calendar", "content calendar", "blog calendar",
  "publishing schedule", "blog plan", "content plan", "what should I write",
  "內容行事曆", "編輯計畫".
user-invokable: true
argument-hint: "[<niche>]"
license: MIT
---

# Blog Calendar -- Editorial Planning

Generates editorial calendars with topic clusters, publishing cadence,
freshness update schedules, content decay detection, template recommendations,
distribution planning, and seasonal hooks. Optimized for building topical
authority (Google) and maintaining citation freshness (AI platforms).

## Workflow

### Step 1: Understand the Blog

Gather context:
1. **Niche/industry** -- What is the blog about?
2. **Existing content** -- Scan for existing blog posts (Glob for *.md, *.mdx, *.html)
3. **Publishing cadence** -- How often can they publish? (default: 2x/week)
4. **Timeframe** -- Monthly or quarterly calendar?
5. **Business goals** -- What should the blog drive? (traffic, leads, authority)

### Step 2: Topic Cluster Design

Design 3-5 topic clusters (pillar + supporting content):

```
Cluster: [Pillar Topic]
├── Pillar Page: [Comprehensive guide - 3,000+ words]
├── Supporting: [Subtopic 1 - 2,000 words]
├── Supporting: [Subtopic 2 - 2,000 words]
├── Supporting: [Subtopic 3 - 1,500 words]
├── Comparison: [X vs Y - 1,500 words]
└── FAQ: [Common questions - 1,500 words]
```

### Step 2.5: Content Decay Detection

Scan existing blog posts for `lastUpdated` or `date` fields in frontmatter.
Classify each post by staleness:

| Traffic Level | Stale Threshold | At-Risk Threshold |
|---------------|----------------|-------------------|
| High-traffic posts | >30 days since update | >90 days |
| Medium-traffic posts | >90 days since update | >180 days |
| Low-traffic posts | >180 days since update | >365 days |

Reference: 76% of top AI citations are from content updated within 30 days.

### Step 3: Freshness Update Schedule

Plan update cycles:
- **High-priority posts** (traffic drivers): Update every 30 days
- **Medium-priority posts**: Update every 90 days
- **Low-priority posts**: Update annually

### Step 4: Seasonal & Trending Hooks

Research seasonal opportunities:
1. **Industry events** -- Conferences, product launches, algorithm updates
2. **Seasonal trends** -- Use WebSearch to check Google Trends for the niche
3. **Annual reports** -- When do major studies release new data?

### Step 5: Generate the Calendar

#### Content Mix Formula

Apply: **60% new content / 30% freshness updates / 10% repurposed content**

| Cadence | Monthly Posts | New | Refreshes | Repurposed |
|---------|-------------|-----|-----------|------------|
| 2 posts/week | 8 | 5 | 2 | 1 |
| 3 posts/week | 12 | 7 | 4 | 1 |
| 1 post/week | 4 | 2-3 | 1 | 0-1 |

#### Monthly Calendar Format

```
# Editorial Calendar: [Month Year]

## Publishing Cadence: [N] posts/week
## Content Mix: [N] new / [N] refreshes / [N] repurposed

### Week 1: [Date Range]
| Day | Type | Title | Template | Cluster | Target Keyword | Status |
|-----|------|-------|----------|---------|---------------|--------|
| Mon | New | [Title] | how-to-guide | [Cluster] | [keyword] | Draft |
| Thu | Update | [Existing post] | -- | [Cluster] | [keyword] | Refresh |

[... repeat for weeks 2-4 ...]

## Freshness Update Queue
| Post | Last Updated | Priority | Scheduled |
|------|-------------|----------|-----------|

## Seasonal Hooks
- [Event/trend and how to leverage it]
```

### Step 5.5: Topic Cluster Progress Tracking

```
## Topic Cluster Progress
| Cluster | Pillar | Spokes Published | Spokes Planned | Coverage |
|---------|--------|-----------------|----------------|----------|
| [Topic] | Published | 5/10 | 5 this quarter | 50% |
```

Rules:
- Clusters at 50%+ coverage: highest priority to complete
- Never have more than 3 clusters in active build-out simultaneously

### Step 5.6: Distribution Scheduling

| Post | Publish Date | LinkedIn | Reddit | Email | YouTube |
|------|-------------|----------|--------|-------|---------|
| [Title] | [Date] | Same day | +2-3 days | Next batch | If pillar |

### Step 6: Save & Next Steps

Save the calendar and suggest:
1. Start with `/smart-blog-skills:brief <first-topic>` to create the first content brief
2. Use `/smart-blog-skills:write` to generate articles from briefs
3. Use `/smart-blog-skills:rewrite` for freshness updates on existing content
4. Re-run `/smart-blog-skills:calendar` next month/quarter for the next plan
