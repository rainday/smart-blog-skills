---
name: llmstxt
description: >
  Analyzes and generates llms.txt files — the emerging standard for helping AI systems understand
  website and blog structure. Can validate an existing llms.txt or generate a new one from scratch
  by crawling the site. Use when user says "llms.txt", "AI guidance file", "AI site map",
  "help AI understand my site", "llms full", or "generate llms".
user-invokable: true
argument-hint: "[analyze|generate] <url>"
license: MIT
---

# llms.txt — AI Site Guidance File

`llms.txt` は AI システムがウェブサイトの構造と内容を理解するための新興標準（Jeremy Howard, 2024年9月提唱）。`robots.txt` がクローラーに「アクセスしてはいけないもの」を伝えるのに対し、`llms.txt` は AI に「最も有用なもの」を伝える。

## 指令

| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:llmstxt analyze <url>` | 驗證現有 llms.txt 並評分 |
| `/smart-blog-skills:llmstxt generate <url>` | 從零爬取網站並生成 llms.txt |

## 為什麼重要

- 2026 年初，不到 5% 的網站有 llms.txt，早期採用者有明顯優勢
- AI 系統可從單一檔案理解網站，而非爬取數十頁
- 控制 AI 對品牌的敘事，提高引用準確性
- 減少 AI 幻覺（錯誤的定價、功能、地點等）

---

## llms.txt 格式規格

```markdown
# [Site Name]

> [一句話說明網站做什麼、服務對象。限 200 字元以內。]

## Docs

- [Page Title](https://example.com/page): 說明頁面涵蓋的具體內容（10-30 字）。

## Optional

- [Secondary Page](https://example.com/other): 補充資源說明。

## Key Facts

- Founded in [year] by [name]
- Headquarters: [City, Country]
- Key products: [A], [B], [C]

## Contact

- Website: https://example.com
- Email: hello@example.com
```

### 格式規則

| 元素 | 規則 |
|------|------|
| H1 標題 | 必填，第一行，使用官方品牌名稱 |
| 描述（blockquote `>`） | 必填，200 字元以內，具體說明 |
| H2 區段 | 至少一個。常用：Docs / Blog / Products / About / Resources |
| 頁面條目 | 10-30 筆，格式 `- [Title](URL): Description` |
| URL | 絕對路徑，含 `https://`，不用相對路徑 |
| 描述長度 | 每筆 10-30 字，具體說明頁面內容 |
| Key Facts | 建議加入，提供 AI 快速查詢的事實數據 |
| Contact | 建議加入，至少含 email |

---

## 分析模式（analyze）

### Step 1: 取得檔案

用 WebFetch 讀取 `[domain]/llms.txt` 和 `[domain]/llms-full.txt`。
- **200**：存在，繼續驗證
- **404**：不存在，建議生成
- **403**：設定錯誤，回報

### Step 2: 格式驗證

| 元素 | 嚴重性 |
|------|--------|
| H1 標題 | Critical |
| Blockquote 描述 | High |
| 至少一個 H2 | Critical |
| 至少 5 筆頁面條目 | High |
| URL 為絕對路徑 | High |
| 每筆有描述 | Medium |
| Key Facts 區段 | Medium |
| Contact 區段 | Low |

### Step 3: 內容品質評分

- **Completeness (0-100)**：是否涵蓋主要導航頁面、高流量頁面、Key Facts
- **Accuracy (0-100)**：描述是否準確、URL 是否有效、事實是否正確
- **Usefulness (0-100)**：AI 能否從此檔案單獨理解網站目的

**總分** = (Completeness × 0.40) + (Accuracy × 0.35) + (Usefulness × 0.25)

### Step 4: 比對網站內容

用 WebFetch 爬主導航和 sitemap，找出重要頁面未列入 llms.txt 的缺口。

### 分析輸出

生成 `GEO-LLMSTXT-ANALYSIS.md`：

```markdown
# llms.txt 分析：[Domain]

**分析日期：** [Date]
**llms.txt 狀態：** Found / Not Found
**llms-full.txt 狀態：** Found / Not Found

## 總分：[X]/100

| 維度 | 分數 |
|------|------|
| Completeness | [X]/100 |
| Accuracy | [X]/100 |
| Usefulness | [X]/100 |

## 格式驗證

| 元素 | 狀態 | 備註 |
|------|------|------|
| H1 標題 | Pass/Fail | |
| ...（逐項列出）

## 缺漏頁面

1. [Page Title](URL) — 原因

## 改善建議

1. [具體建議]

## 建議更新版 llms.txt

[完整更新後的檔案內容]
```

---

## 生成模式（generate）

### Step 1: 網站探索

1. WebFetch 主頁，提取：網站名稱、業務描述、主導航連結
2. WebFetch `/sitemap.xml` 取得所有頁面清單
3. 判斷網站類型（SaaS、電商、本地服務、部落格、代理商）

### Step 2: 頁面優先排序

**必須加入：**
- 首頁、關於頁、定價頁、聯絡頁
- 主要產品／服務頁（前 3-5）

**有品質才加入：**
- 重要部落格文章（最新或最全面）
- 案例研究、導引資源
- FAQ 頁

**跳過：**
- 分頁頁、登入／注冊頁
- 薄內容的標籤分類頁
- 重複內容頁

### Step 3: 撰寫頁面描述

每筆描述規則：
- 10-30 字
- 說明頁面有哪些資訊（事實性，非行銷用語）
- 好範例：`說明三個定價方案（免費、Pro、企業）的功能差異和年費/月費。`
- 差範例：`了解更多關於我們的定價方案！`（含行銷語，過於模糊）

### Step 4: 收集 Key Facts

從網站收集：成立年份、創辦人、總部地點、員工數、客戶數、主要產品、行業分類。

### Step 5: 組合與驗證

組合完整 llms.txt → 驗證 URL 均可訪問 → 確認總條目 10-30 筆。

### 生成輸出

- 輸出完整 `llms.txt` 內容（可直接存至網站根目錄）
- 另輸出 `GEO-LLMSTXT-GENERATION.md`：說明選取頁面的理由、建議更新頻率

---

## 最佳實踐

1. 定期更新：活躍部落格每月更新，穩定網站每季更新
2. 以最強內容開頭（最具權威的頁面排最前）
3. 描述要具體：「含代碼範例的 3,000 字 React Server Components 完整指南」優於「React 指南」
4. 在 Key Facts 突顯差異化特點（原創研究、獨家數據）
5. URL 一律用絕對路徑（含 `https://`）
6. 確保 llms.txt 中的頁面在 robots.txt 中對 AI 爬蟲是開放的（見 `/smart-blog-skills:crawlers`）
