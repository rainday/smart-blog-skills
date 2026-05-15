---
name: geo
description: >
  AI citation readiness audit. Use whenever the user wants their content to rank
  in ChatGPT, Perplexity, Claude, Gemini, or Google AI Overviews. Scores blog
  posts for ChatGPT, Perplexity, and Google AI Overview citability. Evaluates
  passage-level citability, Q&A formatting, entity clarity, structured data,
  and AI crawler accessibility. Generates citation capsules and a 0-100 AI
  Citation Readiness score. Use when user says "geo", "ai citation", "ai
  optimization", "citation audit", "aeo", "perplexity optimization",
  "chatgpt citation", "AI 引用", "AI 優化".
user-invokable: true
argument-hint: "<file-path>"
license: MIT
---

# Blog GEO -- AI Citation Optimization Audit

Scores blog posts for AI citation readiness across ChatGPT, Perplexity, and
Google AI Overviews. Generates citation capsules and a 0-100 AI Citation
Readiness score with platform-specific recommendations.

## Key Research Data

Reference these benchmarks throughout the audit:

- Only 11% of domains cited by both ChatGPT and Perplexity
- 80% of LLM citations don't rank in Google's top 100 (Ahrefs)
- Brands 6.5x more likely cited through third-party sources (AirOps)
- 120-180 word sections get 70% more ChatGPT citations (SE Ranking, Nov 2025)
- Comparison tables with `<thead>` achieve 47% higher AI citation rates
- Content freshness: 76.4% of top citations updated within 30 days (Ahrefs)

## Audit Process

### Step 1: Read Content

Extract from the blog post:
- Full content text and word count
- Heading structure (H1, H2, H3 hierarchy)
- Individual paragraphs and their word counts
- FAQ sections (if present)
- Schema markup (JSON-LD, microdata, RDFa)
- Any TL;DR or summary boxes
- Comparison tables and their HTML structure

### Step 2: Passage-Level Citability (4 pts)

Check each section between headings for AI-extractable passages:

| Check | Criteria |
|-------|----------|
| Word count | Each section contains 120-180 word self-contained passages |
| Context independence | Each passage makes sense extracted from surrounding context |
| Claim structure | Passages contain: specific claim + supporting evidence + source attribution |

**Scoring:** Count passages meeting all criteria vs total sections.
- 4 pts: 80%+ sections have citable passages
- 3 pts: 60-79%
- 2 pts: 40-59%
- 1 pt: 20-39%
- 0 pts: <20%

### Step 3: Q&A Formatting (3 pts)

| Check | Criteria |
|-------|----------|
| Question headings | 60-70% of H2s are phrased as questions |
| Answer-first format | Opening paragraph under each H2 provides a direct answer |
| FAQ section | Dedicated FAQ section with structured question-answer pairs |

### Step 4: Entity Clarity (3 pts)

| Check | Criteria |
|-------|----------|
| Canonical topic | One unambiguous primary topic per page |
| Consistent naming | Same entity name used throughout |
| Intro statement | Clear topic statement in the introduction paragraph |

### Step 5: Content Structure for Extraction (3 pts)

| Check | Criteria |
|-------|----------|
| TL;DR box | 40-60 word standalone summary present at top |
| Comparison tables | Tables with proper HTML `<thead>` (47% higher citation rate) |
| Ordered lists | Numbered lists for processes and step-by-step instructions |
| Citation capsules | 40-60 word definitive statements in each major section |

### Step 6: AI Crawler Accessibility (2 pts)

| Check | Criteria |
|-------|----------|
| Static HTML | Content rendered in static HTML, not behind JavaScript |
| robots.txt | Allows AI crawlers: GPTBot, ChatGPT-User, ClaudeBot, PerplexityBot |
| Schema in HTML | Schema markup in static HTML, not JS-injected |

### Step 7: Platform-Specific Analysis

#### ChatGPT
- Favors "Best X" listicles (43.8% of citations)
- Recency matters -- recent updates get priority
- Domain authority influences citation likelihood

#### Perplexity
- Favors Reddit sources (6.6% of all citations)
- Rapid content decay: 2-3 day citation window
- Freshness is the most critical factor

#### Google AI Overviews
- High Domain Rating strongly correlated with citation
- Present in 49% of SERPs
- Prefers content that already ranks well organically

### Step 8: Generate Citation Capsules

For each H2 section, write a citation capsule:
- **Length**: 40-60 words, self-contained
- **Structure**: Specific claim + data point + source attribution

### Step 9: Calculate AI Citation Readiness Score (0-100)

| Category | Raw Points | Max Display Score |
|----------|-----------|-------------------|
| Passage-Level Citability | /4 | 27 |
| Q&A Formatting | /3 | 20 |
| Entity Clarity | /3 | 20 |
| Content Structure | /3 | 20 |
| AI Crawler Accessibility | /2 | 13 |
| **Total** | **/15** | **100** |

Rating thresholds:
- 90-100: Excellent
- 70-89: Good
- 50-69: Needs Work
- Below 50: Poor

### Step 10: Generate Report

```
## AI Citation Readiness Report: [Title]

**AI Citation Readiness Score: [X]/100** -- [Rating]

### Score Breakdown
| Category | Raw | Display | Max |
|----------|-----|---------|-----|

### Per-Section Citability Analysis
| Section (H2) | Word Count | Self-Contained | Claim+Evidence | Citable |

### Platform-Specific Optimization

### Generated Citation Capsules

### Priority Action Items
```
