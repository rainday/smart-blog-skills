# 平台指南

> 衍生自 STRATEGY.md 4.3 節。平台偵測規則和各平台差異速查表。
>
> **相關文件：** `visual-media.md`（SVG 屬性差異）、`schema-stack.md`（各平台 Schema 放置位置）

## 平台自動偵測

| 偵測訊號 | 平台 | 輸出格式 |
|---------|------|---------|
| `.mdx` 檔案 + `next.config` | Next.js/MDX | JSX 相容 markdown |
| `hugo.toml` 或 `hugo.yaml` | Hugo | 標準 markdown |
| `_config.yml` | Jekyll | 標準 markdown |
| `.astro` 檔案 | Astro | MDX 或 markdown |
| `.html` 檔案 | 靜態 HTML | 語義化 HTML5 |
| `wp-content/` 目錄 | WordPress | HTML 或 Gutenberg |
| `gatsby-config.js` | Gatsby | MDX + React |
| 無法辨識 | 預設 | 標準 markdown |

---

## 通用規則（所有平台適用）

1. **SSR/SSG 必要** — 內容不可依賴 JavaScript 渲染（AI 爬蟲不執行 JS）
2. **Schema 在 HTML 中** — JSON-LD 必須在 HTML source，不可用 JS 注入
3. **Sitemap** — 必須有 `sitemap.xml`
4. **TTFB** — 目標 <200ms
5. **行動裝置友善** — 段落不超過 100 字，表格可橫向捲動
6. **OG Meta Tags** — `og:title`, `og:description`, `og:image`

---

## 各平台差異

### Next.js / MDX

- Frontmatter 用 YAML，欄位名用 camelCase：`coverImage`, `lastUpdated`
- SVG 屬性用 camelCase：`viewBox`, `strokeWidth`, `className`（非 `class`）
- Image 元件：需在 `next.config.ts` 預設外部圖片 domain
- 用 `generateStaticParams` 確保 SSG
- FAQ 可用 React 元件：`<FAQSchema faqs={[...]} />`

### Hugo

- Frontmatter 用 YAML 或 TOML
- 圖片路徑：相對路徑或 `{{ .Site.BaseURL }}` 建構
- 支援 shortcode：`{{< figure >}}`, `{{< youtube >}}`
- 分類：用 `categories` 和 `tags`
- Schema：放在 `layouts/partials/schema.html`

### Jekyll

- Frontmatter 必須有 `layout`, `date`, `categories`
- 圖片放 `assets/images/` 或 `_site/`
- 支援 Liquid 語法
- GitHub Pages 原生支援
- Schema：放在 `_includes/schema.html`

### 靜態 HTML

- 完整語義化 HTML5：`<article>`, `<section>`, `<header>`
- Schema 直接在 `<head>` 中用 `<script type="application/ld+json">`
- 圖片用 `<picture>` + `srcset` 做響應式
- 不依賴任何 JavaScript

### WordPress

- 支援 Gutenberg block 或原始 HTML
- Schema 用外掛（Yoast、Rank Math）或手動
- 圖片透過媒體庫管理
- OG tags 通常由 SEO 外掛處理

### Astro

- 支援 `.md` 和 `.mdx`
- 可混用 Astro 元件
- 內建 SSG，支援 SSR
- Schema 放在 Layout 元件中

---

## AI 爬蟲設定

### robots.txt 必須允許

```
User-agent: GPTBot
Allow: /

User-agent: ClaudeBot
Allow: /

User-agent: PerplexityBot
Allow: /

User-agent: Google-Extended
Allow: /
```

### 注意事項

- **Cloudflare 自 2024 年 7 月起提供一鍵封鎖 AI 爬蟲功能**（opt-in，許多網站已啟用）— 需確認是否影響你的網站
- GPTBot、ClaudeBot、PerplexityBot 都**不執行 JavaScript**
- 只有 Google-Extended 會執行 JS（共用 Googlebot 引擎）
- 因此 SSR/SSG 是絕對必要的

### llms.txt（新興標準）

為 AI 系統提供結構化的網站摘要：
- 在網站根目錄放置 `llms.txt`（精簡摘要）和 `llms-full.txt`（完整內容）
- 格式為純文字，包含網站名稱、描述、核心頁面列表
- 有助於 AI 系統更準確地理解和引用網站內容
- 詳見 https://llmstxt.org/
