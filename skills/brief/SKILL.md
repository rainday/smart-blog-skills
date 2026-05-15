---
name: brief
description: >
  Generate detailed content briefs for blog posts with target keywords,
  content outlines, competitive analysis, recommended statistics, image and
  chart suggestions, word count targets, internal linking architecture,
  template recommendations (12 types), TL;DR drafts, citation capsule
  planning, information gain prompts, and multi-channel distribution plans.
  Briefs are optimized for Google rankings and AI citations (GEO/AEO). Use
  when user says "content brief", "blog brief", "write brief", "outline blog",
  "plan blog post", "blog outline", "content outline", "內容簡報", "文章計畫".
user-invokable: true
argument-hint: "<topic>"
license: MIT
---

# Blog Brief Generator -- Content Planning

Generates comprehensive content briefs that guide blog writing for maximum
impact on both Google rankings and AI citation platforms.

Reference documents:
- `references/content-templates.md` -- template selection criteria
- `references/internal-linking.md` -- link architecture patterns

## Workflow

### Step 1: Topic Intake

Gather from the user:
1. **Topic or keyword** (required)
2. **Target audience** (who reads this?)
3. **Search intent** -- Informational, commercial, transactional, navigational
4. **Business context** -- What does the company do? What's the CTA?

If only a topic is given, infer the rest from context.

### Step 2: Keyword Research

Using WebSearch:
1. Search for the target keyword -- analyze what currently ranks
2. Identify **primary keyword** (exact match target)
3. Identify **3-5 secondary keywords** (related terms, long-tail)
4. Identify **3-5 question queries** (People Also Ask style)
5. Note the **search intent** -- what do searchers actually want?

### Step 2.5: Template Recommendation

Analyze the topic, search intent, and competitive landscape to recommend one
of 12 content templates. Load `references/content-templates.md` for selection
criteria.

**Available templates:**
| Template | Best For |
|----------|----------|
| `how-to-guide` | Step-by-step instructional content |
| `listicle` | Curated lists, ranked items, resource roundups |
| `case-study` | In-depth analysis of a specific example or result |
| `comparison` | Side-by-side evaluation of 2+ options |
| `pillar-page` | Comprehensive topic hub linking to cluster content |
| `product-review` | Detailed evaluation with pros/cons/verdict |
| `thought-leadership` | Expert opinion, industry trends, predictions |
| `roundup` | Expert quotes, tool collections, best-of lists |
| `tutorial` | Technical walkthrough with code/config examples |
| `news-analysis` | Timely coverage with expert commentary |
| `data-research` | Original data, survey results, benchmark findings |
| `faq-knowledge` | Question-driven reference content |

### Step 3: Competitive Analysis

Analyze the top 3-5 ranking pages for the target keyword:
1. **Content length** -- What's the average word count?
2. **Heading structure** -- How many H2s? What topics do they cover?
3. **Visual elements** -- Do competitors use charts, images, videos?
4. **Content gaps** -- What do all competitors miss?
5. **Freshness** -- How recently were they updated?
6. **Schema** -- Do they use FAQ or other rich results?
7. **Template pattern** -- What content format do top results use?

### Step 4: Statistics Research

Find 8-12 statistics the article should include:
1. Search: `[topic] study 2025 2026 data statistics research`
2. Prioritize tier 1-3 sources
3. For each stat, record: value, source, URL, date, methodology
4. Identify 2-4 stats suitable for chart visualization
5. Identify 1-2 stats suitable for TL;DR and social sharing

### Step 5: Generate the Brief

Output format:

```
# Content Brief: [Title Suggestion]

## Template
**Recommended**: [template-name] -- [1-sentence rationale]

## Target Keywords
- **Primary**: [keyword]
- **Secondary**: [keyword 1], [keyword 2], [keyword 3]
- **Questions**: [question 1], [question 2], [question 3]

## Search Intent
[Informational/Commercial/Transactional] -- [1-2 sentence explanation]

## Content Parameters
- **Word count**: [2,000-2,500] words
- **H2 sections**: [6-8]
- **Images**: 3-5
- **Charts**: 2-4
- **FAQ items**: 3-5

## Recommended Title
[Question-format title including primary keyword, under 60 chars]

## Meta Description
[150-160 chars, fact-dense, includes 1 statistic]

## TL;DR Draft
> **TL;DR:** [40-60 word summary with key finding + 1 statistic + source.]

## Information Gain Opportunities
- **[ORIGINAL DATA]**: [Suggestion for proprietary data or experiment]
- **[PERSONAL EXPERIENCE]**: [First-hand observation or test result]
- **[UNIQUE INSIGHT]**: [Contrarian take or novel analysis]

## Content Outline

### Introduction (100-150 words)
- Hook: [Surprising statistic to open with]
- Problem: [What challenge does the reader face?]
- Promise: [What will they learn?]

### H2: [Question Format] (300-400 words)
- **Answer-first**: Open with [specific stat + source]
- **Chart**: [Type] showing [data description]

[... repeat for 6-8 sections ...]

### FAQ Section (3-5 items)

### Conclusion (100-150 words)

## Statistics to Include

| # | Statistic | Source | Year | Section |
|---|-----------|--------|------|---------|
| 1 | [stat] | [source + URL] | 2025 | H2: Section 1 |

## Citation Capsule Plan
| Section | Capsule Focus | Key Stat | Source |
|---------|--------------|----------|--------|

## Visual Element Plan
| # | Type | Data | Section |
|---|------|------|---------|

## Internal Link Architecture
- **Link TO**: [3-5 existing pages to link to]
- **Link FROM**: [3-5 existing pages that should link here]

## Distribution Plan
- **Reddit**: [Subreddits + approach]
- **YouTube**: [Video companion concept]
- **LinkedIn**: [Article excerpt angle]
- **Email**: [Newsletter excerpt + subject line]
```

### Step 6: Save the Brief

Save to the user's project as `briefs/[slug]-brief.md` or to a location
they specify. Confirm the brief is ready for `/smart-blog-skills:write`.
