---
name: chart
description: >
  Generate dark-mode-compatible inline SVG data visualization charts for blog
  posts. Supports horizontal bar, grouped bar, donut, line, lollipop, area,
  and radar charts with automatic platform detection (HTML vs JSX/MDX).
  Enforces chart type diversity, accessible markup (role=img, aria-label),
  source attribution, and transparent backgrounds. Use when user says "blog chart",
  "generate chart", "data visualization", "svg chart", "blog graph",
  "visualize data", "圖表", "資料視覺化".
user-invokable: false
---

# Blog Chart -- Built-In SVG Data Visualization

Generates dark-mode-compatible inline SVG charts for blog posts. Invoked
internally by `write` and `rewrite` when chart-worthy data is identified.

**Styling source of truth:** `references/visual-media.md`

## Chart Type Selection

Select based on the data pattern. Diversity is mandatory - never repeat a
type within one post.

| Data Pattern | Best Chart Type |
|-------------|-----------------|
| Before/after comparison | Grouped bar chart |
| Ranked factors / correlations | Lollipop chart |
| Parts of whole / market share | Donut chart |
| Trend over time | Line chart |
| Percentage improvement | Horizontal bar chart |
| Distribution / range | Area chart |
| Multi-dimensional scoring | Radar chart |

## Styling Rules (Non-Negotiable)

All charts must work on both dark and light backgrounds:

```
Text elements:     fill="currentColor"
Grid lines:        stroke="currentColor" opacity="0.08"
Axis lines:        stroke="currentColor" opacity="0.3"
Background:        transparent (no fill on root SVG)
Subtitle text:     fill="currentColor" opacity="0.45"
Source text:        fill="currentColor" opacity="0.35"
Label text:        fill="currentColor" opacity="0.8"
```

### Color Palette

| Color | Hex | Use Case |
|-------|-----|----------|
| Orange | `#f97316` | Primary / highest value |
| Sky Blue | `#38bdf8` | Secondary / comparison |
| Purple | `#a78bfa` | Tertiary / special category |
| Green | `#22c55e` | Quaternary / positive indicator |

## Standard SVG Shell (HTML)

```xml
<svg
  viewBox="0 0 560 380"
  style="max-width: 100%; height: auto; font-family: 'Inter', system-ui, sans-serif"
  role="img"
  aria-label="Chart description with key data point"
>
  <title>Chart Title</title>
  <desc>Description for screen readers with all key data points and source</desc>

  <!-- Chart content -->

  <text x="280" y="372" text-anchor="middle" font-size="10" fill="currentColor" opacity="0.35">
    Source: Source Name (Year)
  </text>
</svg>
```

## JSX/MDX Shell (camelCase attributes)

```jsx
<svg
  viewBox="0 0 560 380"
  style={{maxWidth: '100%', height: 'auto', fontFamily: "'Inter', system-ui, sans-serif"}}
  role="img"
  aria-label="Chart description"
>
  <title>Chart Title</title>
  <desc>Description for screen readers</desc>
  <text x="280" y="372" textAnchor="middle" fontSize="10" fill="currentColor" opacity="0.35">
    Source: Source Name (Year)
  </text>
</svg>
```

## JSX Attribute Conversion (Required for MDX)

| HTML | JSX |
|------|-----|
| `stroke-width` | `strokeWidth` |
| `text-anchor` | `textAnchor` |
| `font-size` | `fontSize` |
| `font-weight` | `fontWeight` |
| `class` | `className` |
| `style="..."` | `style={{...}}` |

## Output Format

Wrap every chart in a `<figure>` element:

**HTML:**
```html
<figure>
  <svg viewBox="0 0 560 380" style="max-width: 100%; height: auto;" role="img" aria-label="[description]">
    <title>[Chart Title]</title>
    <desc>[Full description for screen readers]</desc>
    <!-- chart content -->
    <text x="280" y="372" text-anchor="middle" font-size="10" fill="currentColor" opacity="0.35">
      Source: [Source Name] ([Year])
    </text>
  </svg>
</figure>
```

## Quality Checklist (Verify Before Returning)

- [ ] No hardcoded text colors (all use `currentColor`)
- [ ] No white/light backgrounds (transparent or none)
- [ ] Source attribution text present at bottom
- [ ] `role="img"` and `aria-label` present on `<svg>`
- [ ] `<title>` and `<desc>` present inside `<svg>`
- [ ] Chart type not already used in this post
- [ ] If MDX: all attributes camelCased (no hyphens in attribute names)
- [ ] Data values match the source data exactly
- [ ] Color palette uses only approved colors
- [ ] ViewBox is `0 0 560 380` (standard) or justified alternative
