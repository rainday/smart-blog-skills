---
name: localize
description: >
  Cultural adaptation for translated content. Run AFTER translate completes.
  Adjusts brand examples, CTAs, legal references, and formality for the target
  market (German, French, Japanese, Spanish, etc.). Deep cultural adaptation of
  translated blog posts. Goes beyond translation to swap brand examples, adapt
  CTAs, substitute legal references, localize statistic sources where possible,
  and adjust formality (Sie/du, tu/vous, formal/informal). Makes content feel
  locally authored, not translated. Use when user says "localize blog",
  "blog localize", "cultural adaptation", "adapt for Germany", "adapt for France",
  "文化適配", "本地化".
user-invokable: true
argument-hint: "<file> --locale <locale-code>"
license: MIT
---

# Blog Localize, Cultural Deep-Adaptation

Takes a translated blog post and performs cultural adaptation so the result
feels like it was written for the target market, not translated into it.
Run AFTER `/smart-blog-skills:translate` completes.

## When to Use

- Right after `translate` produces a base translation.
- When existing translated content reads like "translated from English".
- When targeting a specific market, not just a language.

## Workflow

### Phase 1: Locale Understanding

1. Parse the locale code. Accept full codes (`de-DE`, `fr-CA`, `es-MX`, `pt-BR`, `zh-TW`) or plain language codes.
2. Identify the cultural profile for the locale.
3. Read the translated post and identify adaptation targets.

### Phase 2: Cultural Audit

Scan for elements that signal foreign origin:

| Element | What to look for |
|---------|------------------|
| Brand examples | US or UK brands with no relevance locally |
| Statistics sources | US-only studies and surveys |
| CTAs | American-style aggressive calls-to-action |
| Idioms | Literally translated English expressions |
| Legal references | Foreign laws (CCPA, FTC) where local law applies (DSGVO, RGPD) |
| Currency and pricing | USD without conversion or context |
| Tone | Too casual or too formal for the target market |
| Address form | Inconsistent Sie/du, tu/vous, formal/informal |

### Phase 3: Adaptation

#### 3a. Example Substitution
- Use WebSearch to find local case studies, brands, or scenarios.
- Replace inline, preserving the same argument and structure.

#### 3b. Statistics Localization
- Search for equivalent local statistics (`[topic] statistik [country] 2025 2026`).
- If local data exists, swap the source and the figure together.
- If not, keep the original stat but mark its geographic scope ("In the US, ...").
- Never strip source attribution.

#### 3c. CTA Adaptation
- Adjust aggressiveness level (DACH and JA prefer informational, US prefers imperative).
- Use culturally appropriate action verbs.

#### 3d. Tone Calibration
- Match formality per profile (DACH defaults to Sie for B2B, du for B2C lifestyle).
- Ensure consistent formal or informal address throughout the entire document.

#### 3e. Legal and Regulatory Context
- Replace references to foreign laws with local equivalents (CCPA becomes DSGVO in DE, RGPD in FR).

#### 3f. Brand Example Swaps

| Source (US) | DACH | FR | ES (Spain) | JA |
|-------------|------|----|----|------|
| Walmart | MediaMarkt | Carrefour | El Corte Ingles | Aeon |
| FTC | Bundeskartellamt | DGCCRF | CNMC | JFTC |
| CCPA | DSGVO | RGPD | RGPD | APPI |

### Phase 4: Quality Verification

- All critical adaptation targets addressed.
- Tone is consistent throughout.
- No remaining foreign-origin markers.
- Statistics have valid sources.
- Content still supports the same argument as the original.

### Phase 5: Save and Report

```
## Localization complete: [Title]

### Target locale: [locale-code] ([locale-name])

### Adaptations made
| Type | Count | Examples |
|------|-------|----------|
| Brand examples | [N] | Walmart -> MediaMarkt |
| Statistics | [N] | US survey -> DACH survey |
| CTAs | [N] | "Buy now" -> "Jetzt entdecken" |
| Tone adjustments | [N] | Casual -> Sie |
| Legal references | [N] | CCPA -> DSGVO |

### Cultural fit score
- Naturalness: [1-10]
- Market relevance: [1-10]
- Tone match: [1-10]
- Overall: [N]/30
```

## Error Handling

| Scenario | Action |
|----------|--------|
| No cultural profile for the locale | Build a minimal profile from the custom-locale template, proceed |
| File is not in the expected language | Warn the user, offer to translate first |
| No local statistics available | Keep the original stat with a geographic-scope note |
| Locale code ambiguous (e.g., `pt`) | Ask: "Did you mean `pt-BR` (Brazil) or `pt-PT` (Portugal)?" |

## Cross-References

- Pre-step (translation): `/smart-blog-skills:translate <file> --to <code>`
- QA across language versions: `/smart-blog-skills:locale-audit <directory>`
- One-command pipeline: `/smart-blog-skills:multilingual <topic> --languages <codes>`
