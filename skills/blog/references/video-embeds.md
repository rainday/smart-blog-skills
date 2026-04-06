# YouTube 影片嵌入指南

> 在部落格文章中發現並嵌入相關 YouTube 影片，提升使用者參與度和停留時間。
>
> **相關文件：** `schema-stack.md`（VideoObject Schema）、`visual-media.md`（圖片規範）

## 嵌入策略

每篇文章嵌入 **2-3 個**相關 YouTube 影片：
- 影片之間至少間隔 **500 字**
- 第一個影片放在引言之後或第一個 H2 之後
- 避免連續放置兩個影片

## 影片品質評分（0-100）

| 維度 | 權重 | 說明 |
|------|------|------|
| 相關性 | 40% | 影片主題與文章段落的匹配程度 |
| 觀看數 | 20% | >100K = 滿分，>10K = 80，>1K = 60 |
| 新鮮度 | 20% | <6 個月 = 滿分，<1 年 = 80，<2 年 = 60 |
| 頻道權威 | 10% | 訂閱數、是否為官方/產業頻道 |
| 互動率 | 10% | 按讚比例、留言數 |

**最低門檻：** 60 分以上才嵌入

## 影片發現流程

### 搜尋查詢模式

```
[主題] tutorial site:youtube.com
[主題] explained site:youtube.com
[主題] 教學 site:youtube.com
[關鍵字] 2025 2026 site:youtube.com
```

### 搜尋預算

- 最多 **2 次 WebSearch** + **3 次 URL 驗證**

### 驗證步驟

1. 確認影片 URL 格式正確（`youtube.com/watch?v=` 或 `youtu.be/`）
2. 用 WebFetch 讀取影片頁面，提取標題、頻道、觀看數
3. 確認影片未被刪除或設為私人

## 嵌入格式

### Lazy-Loading srcdoc 模式（推薦）

比直接嵌入 iframe 節省 ~495KB 初始載入：

```html
<div class="video-embed" style="position:relative;padding-bottom:56.25%;height:0;overflow:hidden;max-width:100%;margin:1.5rem 0;">
  <iframe
    style="position:absolute;top:0;left:0;width:100%;height:100%;"
    srcdoc="<style>*{padding:0;margin:0;overflow:hidden}html,body{height:100%}img,span{position:absolute;width:100%;top:0;bottom:0;margin:auto}span{height:1.5em;text-align:center;font:48px/1.5 sans-serif;color:white;text-shadow:0 0 .5em black}</style><a href='https://www.youtube.com/embed/VIDEO_ID?autoplay=1'><img src='https://img.youtube.com/vi/VIDEO_ID/hqdefault.jpg' alt='影片標題'><span>&#x25BA;</span></a>"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
    allowfullscreen
    loading="lazy"
    title="影片標題"
  ></iframe>
  <noscript><a href="https://www.youtube.com/watch?v=VIDEO_ID">影片標題 - 在 YouTube 觀看</a></noscript>
</div>
```

### 各平台格式

| 平台 | 格式 |
|------|------|
| Next.js/MDX | JSX 元件 `<YouTubeEmbed videoId="..." title="..." />` |
| Hugo | `{{</* youtube VIDEO_ID */>}}` shortcode |
| Astro | MDX 同 Next.js，或 Astro 元件 |
| WordPress | HTML iframe（上方 srcdoc 模式） |
| Jekyll | HTML iframe |
| 靜態 HTML | HTML iframe |
| Markdown | HTML iframe（大多數 renderer 支援內嵌 HTML） |

### noscript 備援

每個影片嵌入都必須包含 `<noscript>` 標籤，提供純文字連結：
- AI 爬蟲可能不執行 JavaScript，noscript 確保影片資訊可被抓取
- 格式：`<noscript><a href="YouTube URL">影片標題 - 在 YouTube 觀看</a></noscript>`

## VideoObject Schema

每個嵌入的影片都應產生 VideoObject Schema：

```json
{
  "@type": "VideoObject",
  "name": "影片標題",
  "description": "影片描述（50-100 字）",
  "thumbnailUrl": "https://img.youtube.com/vi/VIDEO_ID/hqdefault.jpg",
  "uploadDate": "2026-01-15",
  "contentUrl": "https://www.youtube.com/watch?v=VIDEO_ID",
  "embedUrl": "https://www.youtube.com/embed/VIDEO_ID",
  "duration": "PT10M30S"
}
```

將 VideoObject 加入 `@graph` 陣列（見 `schema-stack.md`）。

## 禁止嵌入

- 影片長度 <1 分鐘或 >60 分鐘
- 頻道訂閱數 <1,000
- 影片觀看數 <500
- 明顯的業配/廣告影片（除非與文章主題直接相關）
- 非目標語言的影片（除非是唯一權威來源）
