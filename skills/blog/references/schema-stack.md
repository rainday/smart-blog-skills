# Schema 結構化資料指南

> 衍生自 STRATEGY.md 4.1 節。JSON-LD Schema 類型和範例。
>
> **相關文件：** `eeat-signals.md`（Person Schema 的 E-E-A-T 用途）、`platform-guides.md`（各平台 Schema 放置位置）

## 必要 Schema 類型

每篇文章至少 3 種（多種 Schema 有助於 AI 引用）：

| 類型 | 必要性 | 用途 |
|------|--------|------|
| BlogPosting | 必要 | 文章基本資訊 |
| Person | 必要 | 作者 E-E-A-T |
| FAQPage | 強烈建議 | FAQ 結構化（有利 AI 抓取） |
| BreadcrumbList | 建議 | 網站導覽結構 |
| ImageObject | 建議 | 圖片結構化描述 |

---

## BlogPosting Schema

```json
{
  "@context": "https://schema.org",
  "@type": "BlogPosting",
  "headline": "文章標題（60 字元以內）",
  "description": "Meta 描述（150-160 字元）",
  "image": "https://example.com/cover.webp",
  "datePublished": "2026-02-28",
  "dateModified": "2026-02-28",
  "author": {
    "@type": "Person",
    "@id": "#author"
  },
  "publisher": {
    "@type": "Organization",
    "name": "組織名稱",
    "logo": {
      "@type": "ImageObject",
      "url": "https://example.com/logo.png"
    }
  },
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "https://example.com/blog/post-slug"
  },
  "wordCount": 2500,
  "articleSection": "SEO",
  "keywords": ["關鍵字1", "關鍵字2"]
}
```

### 重點欄位

- `dateModified`：比 `datePublished` 重要，影響新鮮度訊號
- `wordCount`：幫助搜尋引擎判斷內容深度
- `@id`：用 fragment identifier 做實體連結

---

## Person Schema

```json
{
  "@type": "Person",
  "@id": "#author",
  "name": "作者姓名",
  "jobTitle": "職稱",
  "description": "50-100 字作者簡介",
  "worksFor": {
    "@type": "Organization",
    "name": "公司名稱"
  },
  "sameAs": [
    "https://linkedin.com/in/xxx",
    "https://twitter.com/xxx"
  ],
  "image": "https://example.com/author.jpg"
}
```

---

## FAQPage Schema

```json
{
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "問題文字？",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "40-60 字（中文 60-100 字）答案，包含一個統計數字和來源歸因。"
      }
    }
  ]
}
```

### FAQ 規則

- 3-5 個問題
- 每個答案 40-60 字（中文 60-100 字）
- 每個答案至少含 1 個統計數字
- 答案必須自成一體

---

## BreadcrumbList Schema

```json
{
  "@type": "BreadcrumbList",
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "name": "首頁",
      "item": "https://example.com"
    },
    {
      "@type": "ListItem",
      "position": 2,
      "name": "部落格",
      "item": "https://example.com/blog"
    },
    {
      "@type": "ListItem",
      "position": 3,
      "name": "文章標題"
    }
  ]
}
```

---

## @graph 合併模式

用 `@graph` 將多個 Schema 合併成一個 `<script>` 標籤：

```json
{
  "@context": "https://schema.org",
  "@graph": [
    { "@type": "BlogPosting", ... },
    { "@type": "Person", "@id": "#author", ... },
    { "@type": "FAQPage", ... },
    { "@type": "BreadcrumbList", ... }
  ]
}
```

### 注意事項

- Schema 必須在 HTML source 中（`<head>` 裡的 `<script type="application/ld+json">`）
- 不可用 JavaScript 動態注入（AI 爬蟲讀不到）
- 使用 [Schema.org Validator](https://validator.schema.org/) 驗證
- 已棄用 Rich Results：HowTo（2023/8）、FAQ rich results 限縮為政府和醫療網站
- 已棄用 Schema 類型：Q&A（改用 FAQPage）、SpecialAnnouncement
- **FAQPage Schema 仍建議使用** — 不再生成 rich results，但仍有利 AI 抓取和引用
