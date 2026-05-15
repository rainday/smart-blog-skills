---
name: locale-audit
description: >
  Audit a directory of multilingual blog content for completeness, consistency,
  hreflang correctness, meta-tag parity, and freshness. Builds a translation
  coverage matrix, flags stale translations, validates hreflang and schema,
  and emits a prioritized report with runnable fix commands.
  Use when user says "locale audit", "blog locale-audit", "check translations",
  "multilingual audit", "translation check", "hreflang check",
  "多語言稽核", "翻譯檢查".
user-invokable: true
argument-hint: "<directory>"
license: MIT
---

# Blog Locale Audit, Multilingual Quality Control

Audits a directory of multilingual blog content to ensure every language
version is complete, consistent, correctly tagged, and SEO-optimized.

## Workflow

### Phase 1: Discovery

1. Scan the target directory. Group blog posts by language using:
   - Subdirectory names (`en/`, `de/`, `fr/`).
   - Frontmatter `lang` and `translatedFrom` fields.
   - `hreflang-map.json` if present.
2. Build a content matrix mapping which post exists in which languages.
3. Detect the source language.

### Phase 2: Completeness Audit

Show which translations are missing:

```
### Translation coverage matrix

| Post (EN) | DE | FR | ES | JA |
|-----------|----|----|----|----|
| how-to-avoid-ai-slop | ok | ok | missing | missing |
| content-marketing-2026 | ok | missing | ok | missing |

Coverage: 60% (6 of 10 expected translations present)
```

### Phase 3: Content Parity Audit

For every post that exists in multiple languages:

| Check | What | Severity |
|-------|------|----------|
| Section count | Same number of H2 and H3 sections | Critical |
| FAQ count | Same number of FAQ items | High |
| Image count | Same number of images | High |
| Chart count | Same number of charts (SVG figures) | High |
| Word count ratio | Within expected band for language pair | Medium |
| Frontmatter parity | All required fields present per version | High |

### Phase 4: SEO Parity Audit

For every language version verify:

| Element | Check | Severity |
|---------|-------|----------|
| Title tag | Present, correct length | Critical |
| Meta description | Present, correct length, contains a stat | Critical |
| `lang` attribute | Present, valid ISO 639-1 | Critical |
| Schema `inLanguage` | Matches `lang` | High |
| Alt text | Translated (no English alt in non-EN posts) | High |
| Slug | Localized (no English slug in non-EN posts) | Medium |

### Phase 5: Hreflang Audit

If `hreflang-tags.html`, `hreflang-sitemap.xml`, or `hreflang-map.json` exists:

| Check | What | Severity |
|-------|------|----------|
| Self-referencing | Each page references itself | Critical |
| Return tags | Every relationship is bidirectional | Critical |
| `x-default` | Present, points to source language | Critical |
| Language codes | Valid ISO 639-1 | High |

If no hreflang files exist, report as critical gap and offer:
"Run `/smart-blog-skills:multilingual <topic> --languages ...` to regenerate."

### Phase 6: Freshness Audit

For posts with `translatedDate` in frontmatter:

| Check | What | Severity |
|-------|------|----------|
| Source updated after translation | Source modified after `translatedDate` | Critical |
| Translation older than 90 days | May need refresh | Medium |

Emit actionable commands per stale file:
```
3 translations are stale:
- de/ki-trends-2026.md (source updated 2 days ago)
  -> Run: /smart-blog-skills:translate en/ai-trends-2026.md --to de
```

### Phase 7: Report

```
## Multilingual content audit report

### Summary
- Posts audited: [N] across [N] languages
- Overall health: [score] / 100
- Critical issues: [N]
- Warnings: [N]

### Translation coverage
[Matrix from Phase 2]

### Issues found
#### Critical
#### Warnings
#### Passed

### Prioritized fixes
### Stale-translation alerts
### Quick fixes
```

## Error Handling

| Scenario | Action |
|----------|--------|
| Empty directory | "No blog posts found in [path]" |
| Only one language present | Report coverage, suggest target languages |
| No hreflang files | Flag as critical gap, offer regeneration |

## Cross-References

- Fill missing translations: `/smart-blog-skills:translate <file> --to <missing-codes>`
- Deepen weak adaptations: `/smart-blog-skills:localize <file> --locale <code>`
- Regenerate hreflang assets: `/smart-blog-skills:multilingual <topic> --languages <codes>`
