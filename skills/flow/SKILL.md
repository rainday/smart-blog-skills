---
name: flow
description: >
  FLOW framework integration for bloggers. Evidence-led content workflow using
  the Find, Optimize, Win loop with stage-specific AI prompts from the FLOW
  knowledge base (30 blog-applicable prompts, CC BY 4.0). Use when user says
  "FLOW", "FLOW framework", "blog flow", "evidence-led blogging", "find optimize
  win", or wants stage-specific blog prompts, "FLOW 框架".
user-invokable: true
argument-hint: "[stage] [url|topic]"
license: MIT
---

# FLOW Framework for Bloggers (Find, Optimize, Win)

> Framework and prompts (c) Daniel Agrici, CC BY 4.0. Source: github.com/AgriciDaniel/flow

FLOW is an evidence-led operating model built for the AI-search era. Smart Blog
integrates the FLOW prompt library so writers can drive their workflow with
structured, source-backed AI prompts instead of improvised queries.

**Attribution notice**: Every `/smart-blog-skills:flow` activation outputs:
```
Framework and prompts (c) Daniel Agrici, CC BY 4.0. Source: github.com/AgriciDaniel/flow
```

## Commands

| Command | What it does |
|---------|-------------|
| `/smart-blog-skills:flow` | Show FLOW overview and stage menu |
| `/smart-blog-skills:flow find [topic\|url]` | Find-stage: keyword discovery, intent mapping, gap analysis |
| `/smart-blog-skills:flow optimize [url]` | Optimize-stage: select 2-3 most relevant prompts based on context |
| `/smart-blog-skills:flow win [url]` | Win-stage: BOFU, conversion, dual-surface scorecard |
| `/smart-blog-skills:flow prompts` | Full index of all 30 blog-applicable prompts |

## Orchestration Logic

### On `/smart-blog-skills:flow` (no sub-command)
1. Show the FLOW stage overview with a one-line description of each stage.
2. Ask the user which stage matches their current situation.

### On `/smart-blog-skills:flow find [topic|url]`
1. Apply Find-stage prompts to the topic or URL.
2. Cross-reference: "For deeper briefs and outlines, see `/smart-blog-skills:brief <topic>`,
   `/smart-blog-skills:outline <topic>`, and `/smart-blog-skills:cannibalization`."

### On `/smart-blog-skills:flow optimize [url]`
1. Read prior context (target URL, niche, any prior skill output in this conversation).
2. Select 2-3 most relevant Optimize prompts.
3. Apply the selected prompts.
4. Cross-reference: "For deeper rewrites, see `/smart-blog-skills:rewrite <file>`,
   `/smart-blog-skills:seo-check <file>`, `/smart-blog-skills:geo <file>`."

### On `/smart-blog-skills:flow win [url]`
1. Apply Win-stage prompts to the URL's conversion and BOFU context.
2. Cross-reference: "For repurposing and full-site health, see `/smart-blog-skills:repurpose <file>`,
   `/smart-blog-skills:audit`."

### On `/smart-blog-skills:flow prompts`
1. Display the full index: 30 prompts grouped by stage (Find, Leverage, Optimize, Win).

## Context Matching (Optimize stage)

The optimize stage has 21 prompts. Select by priority:

1. **Niche** (SaaS or B2B blog leans on-page plus technical; lifestyle leans freshness plus E-E-A-T)
2. **Prior skill output** (`/analyze` E-E-A-T gap routes to authority prompts; `/seo-check` failures route to on-page prompts)
3. **URL signals** (commercial pages need conversion prompts; informational posts need freshness plus answer-first prompts)

Always surface exactly 2-3 prompts. State which prompts you chose and why.

## FLOW Stages Overview

### Find Stage
Evidence-led keyword discovery, audience-avatar building, content prioritization.
Key outputs: seed keyword universe, audience segments, content priority matrix.

### Optimize Stage
Content improvement across 21 prompt types including visibility audits, CTR optimization,
AI-detection tests, schema generation, and E-E-A-T strengthening.

### Win Stage
Conversion-focused: BOFU page briefs, conversion audits, dual-surface scorecards.
Bridges organic traffic to business results.

### Leverage Stage (via prompts index)
Off-site authority building, backlink competition analysis.

## Evidence Triple (Required in All Outputs)

Every public statistic must have three components:
1. **Year anchor in prose** ("In 2026," or "As of Q1 2026,") before the statistic
2. **Inline citation** with publisher AND document title
3. **Source block** at bottom with URL plus retrieval date

Posts that fail any of the three either drop the unverifiable claim or replace it with a verified alternative.

## Error Handling

| Scenario | Action |
|----------|--------|
| No sub-command | Show FLOW overview, ask which stage |
| Optimize: more than 5 qualifying prompts | Select top 2-3, explain selection criteria |
| No URL provided for optimize/win | Ask for the target URL or file path |
