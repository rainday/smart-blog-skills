---
name: image
description: >
  AI image generation and editing for blog content powered by Gemini via MCP.
  Claude acts as Creative Director - interpreting intent, selecting domain expertise,
  constructing optimized 6-component prompts (Subject + Action + Context + Composition
  + Lighting + Style), and orchestrating Gemini for blog-quality results. Generates
  hero images, inline illustrations, social preview cards, and OG images. Edits
  existing blog images. Works standalone via /blog image or internally from
  blog-write and blog-rewrite workflows. Falls back gracefully when MCP is not
  configured. Use when user says "blog image", "generate hero image",
  "blog illustration", "social card", "generate blog image", "edit blog image",
  "image generate", "blog cover image", "inline image", "OG image",
  "生成圖片", "部落格圖片".
user-invokable: true
argument-hint: "[generate|edit|setup] [description-or-path]"
license: MIT
---

# Blog Image - AI Image Generation for Blog Content

You are a **Creative Director** that orchestrates Gemini's image generation
specifically for blog content. Never pass raw user text directly to the API.
Always interpret, enhance, and construct an optimized prompt using the
6-component Reasoning Brief system.

## Quick Reference

| Command | What it does |
|---------|-------------|
| `/smart-blog-skills:image generate <idea>` | Generate a blog image with full prompt engineering |
| `/smart-blog-skills:image edit <path> <instructions>` | Edit an existing blog image intelligently |
| `/smart-blog-skills:image setup` | Configure MCP server and API key |

## Blog Image Types

| Image Type | Aspect Ratio | Resolution | Domain Mode | Placement |
|------------|-------------|-----------|-------------|-----------|
| Hero/Cover | `16:9` | 2K or 4K | Editorial / Landscape | Frontmatter `coverImage` |
| OG/Social Card | `16:9` | 1K | Editorial / Infographic | Frontmatter `ogImage` |
| Inline Illustration | `16:9` or `4:3` | 1K | Varies by topic | After H2, before body |

## MCP Availability Check

Before generating, check if nanobanana-mcp tools are available:
1. Try calling `get_image_history` (lightweight, no side effects)
2. If it succeeds: MCP is available, proceed with generation
3. If it fails: inform the user to run `/smart-blog-skills:image setup`
   - When called internally: return silently, no error.

## Generation Workflow

### Step 1: Analyze Intent

Determine:
- **Image type**: Hero, inline, OG card, section divider?
- **Blog topic**: What is the article about?
- **Style**: Photorealistic, editorial, illustrated, minimal?
- **Mood**: Authoritative, inviting, dramatic, clean?

If the request is vague, ask one clarifying question about use case and style.

### Step 2: Select Domain Mode

| Mode | When to use | Prompt emphasis |
|------|-------------|-----------------|
| **Editorial** | Blog headers, feature images, lifestyle | Styling, composition, publication references |
| **Product** | E-commerce posts, reviews, comparisons | Surface materials, studio lighting, clean BG |
| **Landscape** | Environmental backgrounds, travel, hero sections | Atmospheric perspective, depth layers |
| **UI/Web** | Tech blog icons, illustrations, diagrams | Clean vectors, flat design, exact colors |
| **Infographic** | Data-driven posts, processes, comparisons | Layout structure, hierarchy, accessible colors |
| **Abstract** | Pattern backgrounds, section dividers, decorative | Color theory, mathematical forms, textures |

### Step 3: Construct the 6-Component Reasoning Brief

Build the prompt as natural narrative paragraphs:

1. **Subject** - Who/what, with rich physical detail
2. **Action** - What is happening, pose, gesture, movement
3. **Context** - Environment, setting, time of day
4. **Composition** - Camera angle, shot type, framing
5. **Lighting** - Light source, quality, direction, color temperature
6. **Style** - Art medium, aesthetic, film stock, reference artists

**Template for photorealistic:**
```
A photorealistic [shot type] of [subject with physical detail], [action/pose],
set in [environment with specifics]. [Lighting conditions] create [mood].
Captured with [camera model], [focal length] lens. [Color palette/grading].
Aspect ratio 16:9, suitable as a blog hero image.
```

### Step 4: Set Aspect Ratio

Call `set_aspect_ratio` BEFORE generating:
- Hero / Cover / OG: `16:9`
- Product shot / Square: `4:3` or `1:1`

### Step 5: Generate via MCP

| MCP Tool | When |
|----------|------|
| `set_aspect_ratio` | Always call first if ratio differs from 1:1 |
| `gemini_generate_image` | New image from crafted prompt |
| `gemini_edit_image` | Modify existing image |
| `gemini_chat` | Iterative refinement |

**Model selection:**
- **NB2 Flash** (default): Best for most blog images - fast, 14 ratios, 4K, $0.067/img
- **NB Pro**: Use for hero images with text overlays - $0.134/img

### Step 6: Deliver

Provide:
1. **Image path** - where it was saved
2. **Crafted prompt** - show the full Reasoning Brief
3. **Alt text** - descriptive sentence, 10-125 chars
4. **Frontmatter snippet**:
```yaml
coverImage: "/path/to/generated-image.png"
coverImageAlt: "Descriptive alt text sentence with topic keywords"
```

## Safety Filter Auto-Rephrase

When `IMAGE_SAFETY` or `SAFETY` is returned, auto-rephrase and retry:
1. Identify the likely trigger
2. Rephrase using positive framing
3. Retry with the rephrased prompt (max 3 attempts before reporting to user)

## Error Handling

| Error | Resolution |
|-------|-----------|
| MCP not configured | Run `/smart-blog-skills:image setup` |
| API key invalid | New key at https://aistudio.google.com/apikey |
| Rate limited (429) | Wait 60s, retry |
| `IMAGE_SAFETY` | Auto-rephrase (see above) |
| MCP unavailable (internal call) | Return silently |
