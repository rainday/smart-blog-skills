---
name: google
description: >
  Google API 整合。支援 PageSpeed Insights、CrUX Core Web Vitals 查詢。
  無 API key 時使用免費端點，有 API key 時解鎖完整功能。
  Config 儲存於 ~/.config/smart-blog-skills/。
  Use when user says "pagespeed", "core web vitals", "CrUX", "page speed",
  "網頁速度", "效能檢測", "google api setup".
user-invocable: true
argument-hint: "[pagespeed|crux|setup] <URL>"
---

# Google API — 效能檢測

整合 Google PageSpeed Insights 和 CrUX API，為 blog analyze 提供真實效能數據。

## 指令一覽

| 指令 | 功能 | 需要 API Key |
|------|------|-------------|
| `/smart-blog-skills:google setup` | 設定 API key | 否 |
| `/smart-blog-skills:google pagespeed <URL>` | PageSpeed Insights 分析 | 否（建議有） |
| `/smart-blog-skills:google crux <URL>` | CrUX 真實用戶數據 | 是 |

## Tier 系統

| Tier | 需要什麼 | 解鎖功能 | 限制 |
|------|---------|---------|------|
| 0（免費） | 無需任何設定 | PageSpeed Insights（無 key） | 25 次/天（共用配額，可能被限流） |
| 1（API Key） | Google Cloud Console 免費 API Key | PageSpeed（專屬配額）+ CrUX | PageSpeed 400 次/天，CrUX 150 次/天 |

### 如何取得 API Key（免費）

1. 前往 [Google Cloud Console](https://console.cloud.google.com/)
2. 建立專案（或選擇現有專案）
3. 啟用 API：
   - PageSpeed Insights API
   - Chrome UX Report API
4. 建立憑證 → API Key
5. 執行 `/smart-blog-skills:google setup` 輸入 key

## Config 管理

### 儲存位置

```
~/.config/smart-blog-skills/
├── config.json          ← API key 和偏好設定
└── .gitignore           ← 防止意外提交
```

### config.json 格式

```json
{
  "google_api_key": "",
  "default_strategy": "mobile",
  "locale": "zh-TW",
  "created": "2026-04-06",
  "updated": "2026-04-06"
}
```

### 安全措施

1. **檔案權限**：建立後設定 `chmod 600 config.json`（Unix）
2. **不在專案目錄**：config 在 `~/.config/` 下，不會被 git commit
3. **config 目錄 .gitignore**：額外防護，目錄內含 `*` 排除規則
4. **環境變數備援**：也支援 `SMART_BLOG_GOOGLE_API_KEY` 環境變數
5. **API Key 限制建議**：在 Google Cloud Console 設定 HTTP referrer 或 IP 限制

## Setup 流程

### Step 1：建立 config 目錄

```bash
mkdir -p ~/.config/smart-blog-skills
echo '*' > ~/.config/smart-blog-skills/.gitignore
```

### Step 2：詢問 API Key

問使用者：

> 要設定 Google API Key 嗎？
>
> - **有 Key**：輸入 key，解鎖 CrUX + 專屬 PageSpeed 配額
> - **沒有 Key**：按 Enter 跳過，仍可使用免費 PageSpeed（共用配額）
>
> API Key 儲存在 `~/.config/smart-blog-skills/config.json`，不會進入 git。

### Step 3：寫入 config

將使用者提供的資訊寫入 `~/.config/smart-blog-skills/config.json`。

### Step 4：設定檔案權限

```bash
chmod 600 ~/.config/smart-blog-skills/config.json
```

Windows 環境跳過此步驟（NTFS 權限由系統管理）。

## PageSpeed 分析流程

### Step 1：讀取 Config

1. 讀取 `~/.config/smart-blog-skills/config.json`
2. 如果 `google_api_key` 有值 → Tier 1 模式
3. 如果沒有 → Tier 0 模式（免費端點）

### Step 2：呼叫 API

**Tier 0（無 key）：**
```
WebFetch: https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url={URL}&strategy=mobile&locale=zh-TW
```

**Tier 1（有 key）：**
```
WebFetch: https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url={URL}&strategy=mobile&locale=zh-TW&key={API_KEY}
```

### Step 3：解析結果

從回傳的 JSON 提取：

| 指標 | 欄位路徑 | 好 | 待改善 | 差 |
|------|---------|---|--------|---|
| Performance Score | `lighthouseResult.categories.performance.score` | ≥0.9 | 0.5-0.89 | <0.5 |
| FCP | `lighthouseResult.audits.first-contentful-paint` | ≤1.8s | 1.8-3s | >3s |
| LCP | `lighthouseResult.audits.largest-contentful-paint` | ≤2.5s | 2.5-4s | >4s |
| TBT | `lighthouseResult.audits.total-blocking-time` | ≤200ms | 200-600ms | >600ms |
| CLS | `lighthouseResult.audits.cumulative-layout-shift` | ≤0.1 | 0.1-0.25 | >0.25 |
| Speed Index | `lighthouseResult.audits.speed-index` | ≤3.4s | 3.4-5.8s | >5.8s |

### Step 4：輸出報告

```markdown
## PageSpeed 報告：{URL}

**策略：** Mobile
**Performance Score：** {score}/100

### Core Web Vitals

| 指標 | 數值 | 狀態 |
|------|------|------|
| LCP（最大內容繪製） | {value} | {好/待改善/差} |
| FCP（首次內容繪製） | {value} | {好/待改善/差} |
| TBT（總阻塞時間） | {value} | {好/待改善/差} |
| CLS（累積版面偏移） | {value} | {好/待改善/差} |
| Speed Index | {value} | {好/待改善/差} |

### 改善建議（前 5 項）

| 優先級 | 問題 | 預估節省 |
|--------|------|---------|
| {高/中/低} | {描述} | {時間} |
```

## CrUX 分析流程（Tier 1 only）

### 呼叫 API

```
WebFetch: https://chromeuxreport.googleapis.com/v1/records:queryRecord?key={API_KEY}
```

POST body:
```json
{
  "url": "{URL}",
  "formFactor": "PHONE"
}
```

### 解析結果

提取真實用戶的 Core Web Vitals 分佈（p75 值）：
- LCP、FID/INP、CLS
- 好/待改善/差的百分比分佈

### 輸出

附加到 PageSpeed 報告後方：

```markdown
### CrUX 真實用戶數據（28 天）

| 指標 | p75 | 好 | 待改善 | 差 |
|------|-----|---|--------|---|
| LCP | {value} | {%} | {%} | {%} |
| INP | {value} | {%} | {%} | {%} |
| CLS | {value} | {%} | {%} | {%} |
```

## 與 analyze 整合

當使用者執行 `/smart-blog-skills:analyze` 且文章的 frontmatter 包含 `url` 或 `canonical` 欄位時：

1. 自動偵測是否有 config
2. 如果有 → 在技術元素評分中加入 PageSpeed 數據
3. 如果沒有 → 跳過，使用原有的純內容分析

這讓 analyze 的「技術元素」類別（15 分）可以基於真實數據評分，而非只檢查 HTML 結構。

## 錯誤處理

| 情境 | 行為 |
|------|------|
| 無 API Key + 被限流 | 提示使用者申請免費 API Key |
| API Key 無效 | 提示檢查 key，退回 Tier 0 |
| URL 無法存取 | 報告錯誤，跳過效能檢測 |
| CrUX 無數據 | 說明該 URL 流量不足，CrUX 無法提供數據 |
