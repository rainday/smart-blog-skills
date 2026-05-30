# AI 爬蟲可及性指南（2026）

## 快速參考：robots.txt AI 爬蟲模板

```
# ===========================================
# AI Search & LLM Crawlers: Explicitly Allow
# ===========================================

# OpenAI（三bot框架：訓練/搜尋索引/用戶檢索）
User-agent: GPTBot
Allow: /

User-agent: OAI-SearchBot
Allow: /

User-agent: ChatGPT-User
Allow: /

# Anthropic
User-agent: ClaudeBot
Allow: /

User-agent: Claude-SearchBot
Allow: /

User-agent: Claude-User
Allow: /

# Deprecated（保留相容性）
# User-agent: Claude-Web
# User-agent: anthropic-ai

# Google AI
User-agent: Google-Extended
Allow: /

User-agent: Google-Agent
Allow: /

# Perplexity
User-agent: PerplexityBot
Allow: /

User-agent: Perplexity-User
Allow: /

# 其他主要 AI 爬蟲
User-agent: Meta-ExternalAgent
Allow: /

User-agent: Applebot-Extended
Allow: /

User-agent: Amazonbot
Allow: /

User-agent: DuckAssistBot
Allow: /

User-agent: Bytespider
Allow: /

User-agent: YouBot
Allow: /

User-agent: CCBot
Allow: /

# ===========================================
# 傳統搜尋引擎
# ===========================================

User-agent: Googlebot
Allow: /

User-agent: Bingbot
Allow: /

User-agent: *
Allow: /

Sitemap: https://example.com/sitemap.xml
```

---

## 爬蟲識別表

主要 AI 平台現在都採用**三 bot 框架**：訓練 bot、搜尋索引 bot、用戶檢索 bot。封鎖搜尋索引 bot = 你的內容不出現在該 AI 平台的回答。

| 爬蟲 | 營運商 | 類型 | 是否遵守 robots.txt |
|------|--------|------|-------------------|
| GPTBot | OpenAI | 訓練 | ✅ |
| OAI-SearchBot | OpenAI | 搜尋索引 | ✅ |
| ChatGPT-User | OpenAI | 用戶檢索 | ✅ |
| ClaudeBot | Anthropic | 訓練 | ✅ |
| Claude-SearchBot | Anthropic | 搜尋索引 | ✅ |
| Claude-User | Anthropic | 用戶檢索 | ✅ |
| Google-Extended | Google | AI/Gemini 訓練 | ✅ |
| Google-Agent | Google | Project Mariner（2026）| ✅ |
| PerplexityBot | Perplexity | 搜尋索引 | ✅ |
| Perplexity-User | Perplexity | 用戶檢索 | 部分 |
| Applebot-Extended | Apple | Apple Intelligence | ✅ |
| Meta-ExternalAgent | Meta | 大量資料收集 | ✅ |
| Bytespider | ByteDance | 訓練/索引 | 部分（已知問題）|
| CCBot | Common Crawl | 開放資料集（許多 LLM 使用）| ✅ |

### 三類 bot 的處理策略

- **訓練 bot**（GPTBot, ClaudeBot, CCBot）：自行決定。封鎖不影響搜尋能見度，但影響你的內容是否進入未來模型訓練。
- **搜尋索引 bot**（OAI-SearchBot, Claude-SearchBot, PerplexityBot）：**強烈建議允許。** 封鎖 = 不出現在 ChatGPT/Claude/Perplexity 的答案。
- **用戶檢索 bot**（ChatGPT-User, Perplexity-User）：可能不完全遵守 robots.txt，由即時用戶查詢觸發。

---

## ⚠️ Cloudflare 封鎖問題（CRITICAL）

**自 2025 年 7 月起，Cloudflare 對新域名預設封鎖 AI 爬蟲。** 這是部落格對 AI 系統不可見的最常見原因，即使 robots.txt 設定正確也沒用。

### 修復方法

1. 登入 Cloudflare Dashboard
2. 前往 **Security > Bots > AI Crawlers**
3. 對每個想允許的 AI 爬蟲切換為 "Allow"
4. 儲存

### Cloudflare 對新域名的預設狀態

| 爬蟲 | 新域名預設 |
|------|-----------|
| GPTBot | ❌ 封鎖 |
| ClaudeBot | ❌ 封鎖 |
| PerplexityBot | ❌ 封鎖 |
| CCBot | ❌ 封鎖 |
| Google-Extended | ❌ 封鎖 |
| Applebot-Extended | ✅ 允許 |
| Googlebot | ✅ 允許（非 AI 爬蟲）|

### 驗證（Bash）

```bash
# 模擬 GPTBot
curl -s -A "Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.0; +https://openai.com/gptbot)" \
  https://yourdomain.com/blog/test-post | head -50

# 快速確認 HTTP 狀態碼
curl -s -o /dev/null -w "%{http_code}" \
  -A "Mozilla/5.0 (compatible; ClaudeBot/1.0)" https://yourdomain.com/
```

403 或出現 Cloudflare 頁面 = 爬蟲被封。

---

## 伺服器端渲染需求

AI 爬蟲**不執行 JavaScript**。CSR 渲染的內容對所有 AI 系統不可見（除 Googlebot 和 AppleBot 外）。

| 渲染策略 | AI 能見度 | 建議 |
|---------|----------|------|
| SSG（靜態生成）| 最佳 | ✅ 部落格首選 |
| SSR（伺服器端渲染）| 優秀 | ✅ 適合動態內容 |
| ISR（增量靜態再生）| 優秀 | ✅ 大型網站 |
| CSR（客戶端渲染）| ❌ 無 | ❌ 絕不用於內容頁 |

### CSR 的紅旗（內容對 AI 不可見）

| 指標 | 代表意義 |
|------|---------|
| 空白 `<div id="root"></div>` | React CSR：內容只透過 JS 載入 |
| 空白 `<div id="__next"></div>`（無 SSR）| Next.js 未用 getServerSideProps |
| `<noscript>` 包含主要內容 | 明確對非 JS 客戶端隱藏內容 |
| HTML < 5KB（長篇文章）| 未伺服器端渲染 |

### 快速測試

```bash
# 確認 AI 爬蟲實際看到什麼
curl -s https://yourdomain.com/blog/your-post | head -200

# 確認主要內容是否在 HTML 中
curl -s https://yourdomain.com/blog/your-post | grep -c "<article"

# 偵測 JS-only 渲染
curl -s https://yourdomain.com/blog/your-post | grep -c "id=\"__next\""
```

---

## 效能門檻

AI 檢索系統有嚴格的延遲預算。慢速網站在內容品質被評估前就被排除。

| 指標 | 目標 | 上限 | 超過後果 |
|------|------|------|---------|
| TTFB | < 200ms | < 600ms | 排除出候選答案池 |
| 完整頁面載入 | < 500ms | < 1,000ms | 降低爬取頻率 |
| HTML 大小 | < 200KB | < 500KB | 部分內容提取 |

> **來源說明**：以上門檻來自 Discovered Labs、Prerender.io、Kevin Indig 的觀察，非 OpenAI/Anthropic/Perplexity 官方規格。作為方向性目標，非保證截止值。

---

## AI 爬蟲流量成長數據（Cloudflare Radar, 2025）

| 指標 | 數值 |
|------|------|
| GPTBot 流量成長 | +305% YoY |
| PerplexityBot 流量成長 | +157,490% YoY |
| AI 爬取量整體 | +32% YoY |
| AI 引薦流量佔比 | 1.08% of all web traffic |
| AI 引薦流量成長 | +527%（2025 年 1-5 月）|

---

## AI 爬蟲可及性 Checklist

| 檢查項目 | 通過 | 失敗 |
|---------|------|------|
| robots.txt 允許 AI 爬蟲 | 主要 bot 全部 Allow: / | 有 Disallow 或缺少條目 |
| Cloudflare AI 設定已審查 | Dashboard 明確允許 | 保留預設封鎖 |
| llms.txt 存在 | < 10KB，含重要 URL | 不存在或 > 10KB |
| 內容在 HTML source | curl 直接取得完整內容 | 空白 div、JS-only |
| TTFB < 200ms | 從 CDN edge 測量 | > 600ms = 排除 |
| Schema 在 HTML source | JSON-LD 在 `<head>/<body>` | Schema 透過 JS 注入 |
| sitemap.xml 可存取 | 有效 XML，含所有文章 URL | 不存在或 404 |
| Cloudflare bot UA 回傳 200 | 200 status code | 403 或 challenge 頁面 |
