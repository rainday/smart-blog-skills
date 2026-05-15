---
name: multilingual
description: >
  One-command multilingual blog creation. Writes a blog post, translates it
  into user-specified languages, applies cultural adaptation, and emits
  hreflang tags, sitemap entries, and a CMS-ready language map. The complete
  write-to-publish pipeline for international content. Orchestrates write,
  translate, localize, and hreflang generation.
  Use when user says "multilingual blog", "blog multilingual", "write in
  multiple languages", "international blog", "mehrsprachiger Blog", "blog
  multilingue", "create blog in German and French".
user-invokable: true
argument-hint: "<topic> --languages <comma-separated-codes>"
license: MIT
---

# Blog Multilingual, One-Command International Publishing

The flagship multilingual orchestrator. Combines blog writing, translation,
cultural adaptation, and full international SEO into a single command.
Produces publication-ready blog posts in every target language with hreflang
tags, localized JSON-LD schema, and CMS-integration metadata.

## Dependencies

Invoked internally by this orchestrator:

| Component | Source | Required |
|-----------|--------|----------|
| `write` | smart-blog-skills | Yes |
| `translate` | smart-blog-skills | Yes |
| `localize` | smart-blog-skills | Yes (when `--localize` is on, default) |

## Command Syntax

```
/smart-blog-skills:multilingual <topic> --languages <lang1,lang2,...> [--source <lang>] [--no-localize] [--format <md|mdx|html>]
```

| Argument | Required | Default | Description |
|----------|----------|---------|-------------|
| `<topic>` | Yes | | Blog topic or working title |
| `--languages` | Yes | | Comma-separated ISO 639-1 codes (e.g. `de,fr,es,ja,pt-BR`) |
| `--source` | No | `en` | Source language to write the original in |
| `--no-localize` | No | off | Skip cultural adaptation (translation only) |
| `--format` | No | auto | Output format: `md`, `mdx`, or `html` |

If `--languages` is missing, ask the user once before running anything:
"Which languages should the blog be published in? Provide ISO 639-1 codes
separated by commas (e.g., `de,fr,es,ja,pt-BR`). The post will be written in
`<source>` first, then translated."

## Workflow

### Phase 1: Configuration

1. Parse arguments. Extract topic, target languages, source, format.
2. Validate each language code against ISO 639-1 (region suffixes like
   `pt-BR`, `es-MX`, `zh-TW` are also accepted).
3. Detect output format from the project or use `--format`.
4. Resolve source language. If a target language equals `--source`, drop it
   from the translation list with a notice.
5. Create the output directory inside the current working directory:
   ```
   multilingual/
     {source-lang}/
     {lang-1}/
     {lang-2}/
     ...
   ```
   Output MUST stay inside the project root. Never write outside the cwd.

Progress: `Phase 1: Configuration complete, [N] languages selected ([codes])`

### Phase 2: Write Original Blog

Invoke the `write` sub-skill so all existing rules apply: template auto-selection,
sourced statistics, citation capsules, FAQ schema, internal-link zones, charts,
image embedding. Pass the topic and any write parameters surfaced by the user.

Save the original to `multilingual/{source-lang}/{slug}.{ext}`.

Progress: `Phase 2: Original written, multilingual/{source-lang}/{slug}.{ext}`

### Phase 3: Translate to All Target Languages

For each target language, invoke `translate`:

- Input: the original blog post produced in Phase 2.
- Target: the specific language code.
- Run targets in parallel where the runtime supports it (one Task per
  language) to reduce wall-clock time.

Save translations to `multilingual/{lang}/{localized-slug}.{ext}`.

Progress: `Phase 3: Translating to [lang] ([X]/[N])` per language.

### Phase 4: Cultural Adaptation

If `--no-localize` is NOT set, invoke `localize` for every translated post:

- Input: the translated blog post.
- Locale: the target language or region code.
- Run in parallel.

Update files in place. The localizer swaps brand examples, adapts CTAs,
substitutes legal references, and adjusts formality.

Progress: `Phase 4: Cultural adaptation complete for [N] languages`.

### Phase 5: International SEO Generation

Generate three artifacts plus localized schema.

#### 5a. Hreflang Tags (HTML)

Copy-paste ready tags for `<head>`:

```html
<!-- Hreflang tags. Paste into <head> of each language version. -->
<link rel="alternate" hreflang="{source}" href="{source-url}" />
<link rel="alternate" hreflang="{lang-1}" href="{lang-1-url}" />
<link rel="alternate" hreflang="{lang-2}" href="{lang-2-url}" />
<link rel="alternate" hreflang="x-default" href="{source-url}" />
```

Rules:
- Every page references all alternates including itself (self-referencing).
- `x-default` points to the source-language version.
- All URLs use the same protocol (HTTPS) and trailing-slash convention.
- Bidirectional: every relationship is reciprocal.

Save to `multilingual/hreflang-tags.html`.

#### 5b. Hreflang Sitemap Fragment

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xhtml="http://www.w3.org/1999/xhtml">
  <url>
    <loc>{source-url}</loc>
    <xhtml:link rel="alternate" hreflang="{source}" href="{source-url}" />
    <xhtml:link rel="alternate" hreflang="{lang-1}" href="{lang-1-url}" />
    <xhtml:link rel="alternate" hreflang="x-default" href="{source-url}" />
  </url>
  <!-- Repeat one <url> block per language version -->
</urlset>
```

Save to `multilingual/hreflang-sitemap.xml`.

#### 5c. Hreflang Map (JSON)

Machine-readable mapping for CMS integration:

```json
{
  "sourceSlug": "how-to-avoid-ai-slop",
  "sourceLanguage": "en",
  "generatedDate": "YYYY-MM-DD",
  "versions": [
    {
      "lang": "en",
      "slug": "how-to-avoid-ai-slop",
      "file": "en/how-to-avoid-ai-slop.md"
    },
    {
      "lang": "de",
      "slug": "wie-man-ki-slop-vermeidet",
      "file": "de/wie-man-ki-slop-vermeidet.md"
    }
  ],
  "hreflang": {
    "method": "html",
    "x-default": "en"
  }
}
```

Save to `multilingual/hreflang-map.json`.

### Phase 6: Delivery Summary

```
## Multilingual blog complete: [Title]

### Original
- Language: [source]
- File: multilingual/{source}/{slug}.{ext}

### Translations
| Language | File | Localized | Keywords adapted |
|----------|------|-----------|------------------|
| de | multilingual/de/{slug}.md | yes | [N] |
| fr | multilingual/fr/{slug}.md | yes | [N] |

### International SEO assets
- multilingual/hreflang-tags.html
- multilingual/hreflang-sitemap.xml
- multilingual/hreflang-map.json

### Total
- [N] posts in [N] languages
- [N] SEO assets generated

### Next steps
- Replace `{url}` placeholders in hreflang tags with your real URLs.
- Merge `hreflang-sitemap.xml` into your existing sitemap.
- Run `/smart-blog-skills:locale-audit multilingual/` to verify completeness.
- Resolve `[INTERNAL-LINK]` placeholders with locale-specific URLs.
```

## Cross-References

| When | Run |
|------|-----|
| To regenerate or reword the source | `/smart-blog-skills:write <topic>` |
| To translate one existing file only | `/smart-blog-skills:translate <file> --to <codes>` |
| To deepen cultural fit on one file | `/smart-blog-skills:localize <file> --locale <code>` |
| To audit a multilingual directory | `/smart-blog-skills:locale-audit <directory>` |

## Error Handling

| Scenario | Action |
|----------|--------|
| One translation fails | Complete the rest, report partial results, suggest a retry command |
| Source language equals a target | Skip that target, log a notice |
| More than 10 target languages | Warn about wall-clock time, proceed if confirmed |
