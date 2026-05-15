---
name: cluster
description: >
  Semantic topic cluster planning and automated execution engine.
  Performs SERP-based keyword research, groups keywords by search intent and
  SERP overlap, builds a hub-and-spoke cluster architecture, generates an
  interactive SVG cluster map, and executes the full cluster by orchestrating
  write calls with shared cluster context and automatic internal-link
  injection. Fills the strategy-to-execution gap: strategy plans the
  blueprint, cluster builds the house.
  Use when user says "blog cluster", "topic cluster", "content cluster",
  "cluster plan", "cluster execute", "pillar content", "hub and spoke",
  "content ecosystem", "cluster map".
user-invokable: true
argument-hint: "[plan|execute] [seed-keyword|cluster-plan.json]"
license: MIT
---

# Blog Cluster (Semantic Topic Cluster Engine)

Plans and executes entire interlinked content ecosystems from a single seed
keyword. Three layers: Semantic Clustering (the brain), Cluster Architecture
(the structure), and Execution Engine (the machine).

## Commands

| Command | What it does |
|---------|--------------|
| `/smart-blog-skills:cluster` | Interactive. Asks whether to plan or execute. |
| `/smart-blog-skills:cluster plan <seed-keyword>` | SERP-based semantic analysis. Outputs cluster plan + map. |
| `/smart-blog-skills:cluster plan --from strategy [path]` | Imports existing strategy cluster build plan and validates against SERP data. |
| `/smart-blog-skills:cluster execute [path-to-plan]` | Sequential write calls with cluster context and auto-interlinks. |

## Command Routing

1. Parse the user's command to determine the sub-command.
2. If the user typed only `/smart-blog-skills:cluster`, ask: "Would you like to **plan** a new cluster or **execute** an existing plan?"
3. Route:
   - `plan <keyword>` to the Plan Phase (below)
   - `plan --from strategy [path]` to the Strategy Import flow (below)
   - `execute [path]`, `build`, or `run` to the Execute Phase (below)

---

## Plan Phase: `/smart-blog-skills:cluster plan <seed-keyword>`

### Step 1. Seed keyword expansion

Use WebSearch to expand the seed into a keyword universe of 30 to 50 phrases:

1. Direct search of `<seed>` to capture related searches and "People also ask".
2. Long-tail expansion: `<seed> guide`, `<seed> tips`, `<seed> tools`, `<seed> examples`, `<seed> vs`, `best <seed>`, `how to <seed>`.
3. Question mining: `what is <seed>`, `how does <seed> work`, `why <seed>`, `<seed> for beginners`.
4. Intent variants: add commercial, informational, and transactional modifiers.
5. Year freshness: `<seed> 2026`.

### Step 2. Semantic clustering

Group the expanded keywords:

1. **SERP Overlap Analysis** is the primary signal. Two keywords with 5 or more shared top-10 results target the same intent and belong in one post.
2. **Intent Classification** assigns each keyword to informational, commercial, transactional, or navigational.
3. **Entity Mapping** identifies the people, products, frameworks, and organizations Google associates with the topic.
4. **Grouping** combines keywords that share intent and topical proximity. Each group becomes one branch of the hub and spoke.

### Step 3. Cluster architecture design

Build the hub and spoke:

- **Pillar (hub)**: targets the broadest keyword. Word count 2,500 to 4,000. Template `pillar-page`. Links down to every spoke.
- **Spokes**: each targets a long-tail cluster. Word count 1,200 to 1,800. Template auto-selected by intent. Links up to the pillar and across to siblings.

Cluster formation rules:

- 2 to 5 clusters per pillar.
- 2 to 4 spokes per cluster.
- Total: 1 pillar plus 5 to 15 spokes.
- Every spoke targets a unique primary keyword (zero cannibalization).

### Step 4. Internal link matrix

For each spoke `S`:

- `S` to Pillar (always; anchor text uses the pillar's primary keyword).
- Pillar to `S` (always; anchor text uses `S`'s primary keyword).
- `S` to other spokes in the same cluster (2 to 3 links each, contextual anchors).

Verify every spoke has at least 3 incoming links.

### Step 5. Generate output files

All plan and execute artifacts go into a single subdirectory of the current working directory:

```
<cwd>/
└── cluster-<seed-keyword-slug>/
    ├── cluster-plan.json
    ├── cluster-map.html
    ├── pillar-<slug>.md       (Execute Phase)
    ├── <spoke-slug>.md        (Execute Phase, one per spoke)
    └── cluster-scorecard.md   (Execute Phase)
```

#### `cluster-plan.json` schema

```json
{
  "seed_keyword": "<seed>",
  "generated_at": "YYYY-MM-DDTHH:MM:SSZ",
  "pillar": {
    "id": "P",
    "title": "Title of the pillar",
    "primary_keyword": "broadest keyword",
    "template": "pillar-page",
    "word_count_target": 3000
  },
  "clusters": [
    {
      "name": "Cluster A: Theme",
      "intent": "informational",
      "posts": [
        {
          "id": "A1",
          "title": "Post title",
          "primary_keyword": "long-tail keyword",
          "template": "how-to-guide",
          "word_count_target": 1500,
          "links_to": ["P", "A2"],
          "links_from": ["P", "A2"]
        }
      ]
    }
  ],
  "total_posts": 9,
  "total_interlinks": 23
}
```

#### `cluster-map.html` (XSS-safe)

A static, self-contained HTML file with an embedded SVG visualization. Hard rules:

- No inline `<script>` blocks. No `onclick`, `onmouseover`, or any `on*` event attributes.
- No external script `<src>` references.
- Every text label drawn into the SVG must be escaped: `&`, `<`, `>`, `"`, `'`.
- Hover effects use CSS `:hover` only. No JavaScript.

### Step 6. Present plan to user

Show a summary table of clusters and posts, total interlinks, estimated words, and the file paths. Ask for confirmation before proceeding to execution. Wait for explicit user approval. Do not auto-execute.

---

## Strategy Import: `/smart-blog-skills:cluster plan --from strategy [path]`

Bridges `strategy` output into a cluster plan.

1. Locate strategy output. Scan for a file containing a `Cluster Build Plan` table with the columns `# | Spoke Topic | Template | Target Keyword | Word Count | Internal Links`.
2. Parse the table. Extract the pillar row (marked `P`), the spoke rows, template assignments, target keywords, word counts, and link relationships.
3. Validate and enrich. Run SERP overlap validation on each keyword.
4. If SERP data contradicts the strategy table, flag the conflict; do not silently override the user's strategic intent.
5. Generate `cluster-plan.json` and `cluster-map.html` and wait for user confirmation.

---

## Execute Phase: `/smart-blog-skills:cluster execute [path-to-plan]`

### Step 1. Load plan

Read `cluster-plan.json` from the user-specified path or the most recent `cluster-*/cluster-plan.json` in the working directory. If no plan exists, return: "No cluster plan found. Run `/smart-blog-skills:cluster plan <seed-keyword>` first."

### Step 2. Determine execution order

1. Pillar page first (so spokes can link to a known filename).
2. Then spokes, ordered by cluster priority and search volume estimate.

### Step 3. For each post: build cluster context and call `write`

Construct the cluster context block and prepend it to the topic prompt passed to the Task tool invoking `write`. The context tells `write` the cluster name, the post's role (pillar or spoke), the primary and secondary keywords, the chosen template, the word count target, and the linking requirements.

**FLOW evidence triple propagation (required):** The cluster context must include this directive for every spoke and the pillar: "Apply the FLOW evidence triple to every public statistic. Year anchor in prose ('In 2026,'), inline citation with publisher and title, URL with retrieval date in the source block."

### Step 4. Per-post optional hero image

If `nanobanana-mcp` is configured, call `/smart-blog-skills:image generate` via the Task tool to produce a 16:9 hero image. If the MCP is unavailable or fails, log a warning and continue without images. Image generation is non-blocking.

### Step 5. Backward link injection

After each post is written:

1. Scan all previously written posts in the cluster directory for `[INTERNAL-LINK: keyword -> filename.md]` markers that reference the just-written post.
2. Replace each match with a real markdown link: `[keyword](filename.md)`.

### Step 6. Failure handling

If `write` fails for a single post, log the failure and continue with remaining posts. Do not abort the cluster. The scorecard will mark the gap and recommend a retry.

### Step 7. Generate `cluster-scorecard.md`

After all attempted posts complete, produce a markdown scorecard covering:

- Per-post status (written, failed, skipped) with file path and word count.
- Cluster cohesion score: a 0 to 100 composite.
- Internal-link audit: outgoing and incoming counts per post, orphan flags.
- Cannibalization check: any two posts sharing primary keyword.
- Recommended next actions: schema generation, per-post SEO validation, repurposing.

---

## Quality Gates

| Gate | Check | Action on fail |
|------|-------|----------------|
| Cluster minimum | At least 2 clusters with at least 2 posts each | Warn during plan; suggest expansion |
| Cannibalization | No two posts share primary keyword | Block execution; require plan adjustment |
| Link completeness | Every post has 3 or more incoming internal links | Warn in scorecard |
| Word count | Pillar at least 2,500 words; spokes at least 1,200 words | Pass to `write` as a hard constraint |

---

## Error Handling

| Scenario | Action |
|----------|--------|
| Seed keyword too broad (more than 50 keyword variants) | Suggest narrowing the focus before clustering. |
| Seed keyword too narrow (fewer than 5 keyword variants) | Offer a smaller cluster (pillar plus 2 to 3 spokes) or suggest broadening. |
| WebSearch unavailable | Fall back to Claude's reasoning for keyword expansion and grouping. |
| `write` fails for one post | Log, skip, continue. Mark the gap in the scorecard. |
| `cluster-plan.json` malformed | Validate JSON and report parse errors with line numbers. |
| User cancels execution | Save progress; resume on next invocation with already-written posts auto-detected. |
| `nanobanana-mcp` not configured | Skip hero image generation; warn once at start of execute. |
