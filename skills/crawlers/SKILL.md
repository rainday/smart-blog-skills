---
name: crawlers
description: >
  AI crawler access analysis for blogs and websites. Checks robots.txt, meta tags, and HTTP headers
  to determine which AI crawlers can access the site. Provides a complete access map and
  recommendations for maximizing AI visibility. Use when user says "AI crawlers", "robots.txt",
  "AI access", "block AI crawlers", "allow AI bots", "GPTBot", "ClaudeBot", "PerplexityBot",
  "AI crawler audit", or "can AI read my blog".
user-invokable: true
argument-hint: "<url>"
license: MIT
---

# AI Crawler Access Analysis

分析部落格和網站的 AI 爬蟲可訪問性。若 AI 爬蟲被封鎖，無論內容品質多高，都無法出現在 AI 生成的回應中。

## 重要背景

2026 年初的 Originality.ai 研究發現，前 1,000 名網站中：
- 35% 以上封鎖了至少一個主要 AI 爬蟲
- 5-10% 封鎖了所有 AI 爬蟲

許多網站透過過於激進的 robots.txt（繼承自舊版 SEO 設定）意外封鎖 AI 爬蟲。**封鎖 AI 爬蟲是使網站在 AI 搜尋結果中消失最快的方法。**

---

## AI 爬蟲完整參考表

### Tier 1：AI 搜尋能見度的關鍵（建議：允許）

| 爬蟲 | User-Agent | 運營者 | 目的 | 建議 |
|------|-----------|--------|------|------|
| GPTBot | `GPTBot` | OpenAI | ChatGPT 網頁瀏覽、搜尋 | **ALLOW** — 300M+ 週活用戶 |
| OAI-SearchBot | `OAI-SearchBot` | OpenAI | ChatGPT 搜尋功能（不用於訓練） | **ALLOW** — 搜尋專用，無訓練風險 |
| ChatGPT-User | `ChatGPT-User` | OpenAI | 用戶主動請求 ChatGPT 訪問特定 URL | **ALLOW** — 阻止用戶從 ChatGPT 讀取你的內容 |
| ClaudeBot | `ClaudeBot` | Anthropic | Claude 網頁搜尋和分析 | **ALLOW** — Claude 市占率持續增長 |
| PerplexityBot | `PerplexityBot` | Perplexity AI | Perplexity AI 搜尋（含來源引用） | **ALLOW** — 最佳 AI 搜尋引薦流量來源 |

### Tier 2：更廣泛 AI 生態系（建議：允許）

| 爬蟲 | User-Agent | 運營者 | 備註 |
|------|-----------|--------|------|
| Google-Extended | `Google-Extended` | Google | Gemini 訓練和 AI Overview 改善（**不影響**標準搜尋排名） |
| GoogleOther | `GoogleOther` | Google | Google 研究和 AI 相關資料收集 |
| Applebot-Extended | `Applebot-Extended` | Apple | Apple Intelligence 功能（2B+ 裝置） |
| Amazonbot | `Amazonbot` | Amazon | Alexa 和 Amazon AI |
| FacebookBot | `FacebookBot` | Meta | Meta AI（3B+ 合併用戶） |

### Tier 3：純訓練爬蟲（依策略決定）

| 爬蟲 | User-Agent | 建議 |
|------|-----------|------|
| CCBot | `CCBot` | 依情況 — 訓練數據，不影響 AI 搜尋能見度 |
| anthropic-ai | `anthropic-ai` | 依情況 — Claude 模型訓練（非即時功能） |
| Bytespider | `Bytespider` | **BLOCK** — 爬蟲行為激進，西方市場效益低 |
| cohere-ai | `cohere-ai` | 依情況 — Cohere 模型訓練 |

---

## 分析流程

### Step 1: 讀取 robots.txt

WebFetch `[domain]/robots.txt`，解析所有 User-agent 指令：

對每個 AI 爬蟲確認：
- 是否有專屬 User-agent 區塊？
- 是否有 `User-agent: *` 萬用字元規則？
- **有效狀態**：Allowed / Blocked / Not Mentioned（繼承萬用字元規則）
- 是否有 `Crawl-delay`（可能減慢 AI 爬蟲）？
- 是否有 `Sitemap` 指令（AI 爬蟲用於發現內容）？

### Step 2: 檢查 Meta Robots 標籤

WebFetch 5-10 個關鍵頁面，查詢：
- `<meta name="robots" content="noindex">` — 封鎖所有機器人
- `<meta name="robots" content="noai">` — 封鎖 AI 使用（新興標籤）
- `<meta name="robots" content="noimageai">` — 封鎖 AI 圖片訓練
- 爬蟲特定標籤：`<meta name="GPTBot" content="noindex">`

### Step 3: 檢查 HTTP Headers

同樣頁面查詢 response headers：
- `X-Robots-Tag: noindex` — HTTP header 版 noindex
- `X-Robots-Tag: noai` — 封鎖 AI 使用
- `X-Robots-Tag: noimageai` — 封鎖 AI 圖片訓練

### Step 4: 檢查 AI 專屬檔案

- `/llms.txt` — AI 爬蟲導引（見 `/smart-blog-skills:llmstxt`）
- `/.well-known/ai-plugin.json` — OpenAI plugin manifest
- `/ai.txt` — 提案中的標準

### Step 5: JavaScript 渲染評估

檢查網站是否需要 JS 渲染：
- AI 爬蟲 JS 渲染能力有限（GPTBot、ClaudeBot、PerplexityBot 均受限）
- 若關鍵內容依賴 JS 渲染，標記為潛在問題
- 確認是否有 SSR / SSG 作為解決方案

### Step 6: Content Signals 解析

在 robots.txt 掃描 `Content-Signal:` 指令（IETF 草案）：
- 有效 key：`ai-train`, `search`, `ai-personalization`, `ai-retrieval`
- 有效 value：`yes`, `no`
- 若無此指令：建議加入以明確聲明 AI 使用偏好

---

## 評分方式

**AI Crawler Access Score (0-100)**：

| 組成 | 權重 | 評分方式 |
|------|------|---------|
| Tier 1 爬蟲允許數 | 50% | 每允許一個 Tier 1 = 10 分（共 5 個） |
| Tier 2 爬蟲允許數 | 25% | 每允許一個 Tier 2 = 5 分（共 5 個） |
| 無全面封鎖 | 15% | 無 `User-agent: * Disallow: /` + 無 noai meta |
| AI 專屬檔案 | 10% | llms.txt = 5 分，sitemap 可訪問 = 5 分 |

---

## 輸出格式

生成 `GEO-CRAWLER-ACCESS.md`：

```markdown
# AI Crawler Access 報告：[Domain]

**分析日期：** [Date]
**robots.txt 狀態：** Found / Not Found

## Crawler Access 總覽

| 爬蟲 | 運營者 | Tier | 狀態 | 影響 |
|------|--------|------|------|------|
| GPTBot | OpenAI | 1 | Allowed/Blocked | [說明] |
| OAI-SearchBot | OpenAI | 1 | ... | |
| ChatGPT-User | OpenAI | 1 | ... | |
| ClaudeBot | Anthropic | 1 | ... | |
| PerplexityBot | Perplexity | 1 | ... | |
| Google-Extended | Google | 2 | ... | |
| ... | | | | |

## AI 能見度分數：[X]/100

Tier 1 訪問：[X/5 爬蟲允許]
Tier 2 訪問：[X/5 爬蟲允許]

## 嚴重問題

[列出被封鎖的 Tier 1 爬蟲]

## 建議

### 立即行動
[具體的 robots.txt 修改]

### 建議 robots.txt（AI 爬蟲部分）
[完整建議的 robots.txt 內容]

### 技術發現
- Meta Robots 標籤：[發現]
- X-Robots-Tag：[發現]
- JavaScript 渲染：[評估]
- llms.txt：[存在/不存在]
- Sitemap 可訪問性：[評估]

### Content Signals
[存在/不存在，若存在顯示解析結果]
```

---

## 最大化 AI 能見度的 robots.txt 範本

```
# AI 爬蟲 — 允許（AI 搜尋能見度）
User-agent: GPTBot
Allow: /

User-agent: OAI-SearchBot
Allow: /

User-agent: ChatGPT-User
Allow: /

User-agent: ClaudeBot
Allow: /

User-agent: anthropic-ai
Allow: /

User-agent: PerplexityBot
Allow: /

User-agent: Google-Extended
Allow: /

User-agent: GoogleOther
Allow: /

User-agent: Applebot-Extended
Allow: /

User-agent: Amazonbot
Allow: /

User-agent: FacebookBot
Allow: /

# AI 爬蟲 — 封鎖（激進/低效益）
User-agent: Bytespider
Disallow: /
```

---

## 交叉技能整合

- **llms.txt 設定**：見 `/smart-blog-skills:llmstxt`
- **AI 引用就緒度**：見 `/smart-blog-skills:geo`
- **品牌在 AI 平台的存在**：見 `/smart-blog-skills:brand-mentions`
