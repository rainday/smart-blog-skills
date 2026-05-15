---
name: drift
description: >
  Blog SEO drift monitoring. Capture baselines of SEO-critical elements, detect changes, and track
  regressions over time. Use when user says "drift", "SEO baseline", "track changes", "did anything
  break", "SEO regression", "before and after deployment", "monitor SEO changes", "compare SEO",
  or "deployment check".
user-invokable: true
argument-hint: "baseline|compare|history <url>"
license: MIT
---

# Drift — 部落格 SEO 變動監控

Git for your SEO. 捕捉 SEO 基準線，偵測回歸，追蹤隨時間的變化。

## 指令

| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:drift baseline <url>` | 擷取當前 SEO 狀態作為「已知良好」快照 |
| `/smart-blog-skills:drift compare <url>` | 將當前狀態與儲存的基準線比較 |
| `/smart-blog-skills:drift history <url>` | 顯示歷史比較紀錄 |

---

## 追蹤的 SEO 元素

| 元素 | 說明 |
|------|------|
| Title tag | 頁面標題（含字元數） |
| Meta description | 描述標籤（含字元數） |
| Canonical URL | 標準化 URL |
| Robots directives | meta robots 和 X-Robots-Tag |
| H1 標題 | 所有 H1 的文字和數量 |
| H2 標題 | 所有 H2 的文字和數量 |
| H3 標題 | 所有 H3 的文字和數量 |
| JSON-LD schema | 結構化資料類型和內容 |
| Open Graph 標籤 | og:title, og:description, og:image |
| HTTP 狀態碼 | 200/301/302/404/500 |
| 內容摘要 | 字數、段落數、圖片數 |

---

## 17 條比較規則（3 個嚴重程度）

### CRITICAL — SEO 中斷，可能造成流量損失

| 規則 | 觸發條件 |
|------|---------|
| Title 消失 | title 標籤為空或缺失 |
| Noindex 新增 | meta robots 新增 noindex |
| Canonical 變更 | canonical URL 改變（指向其他頁面） |
| HTTP 狀態變更 | 200 → 4xx 或 5xx |
| H1 消失 | 所有 H1 被移除 |
| Schema 完全移除 | 所有 JSON-LD 被刪除 |

### WARNING — 潛在影響，需要調查

| 規則 | 觸發條件 |
|------|---------|
| Title 文字改變 | title 內容不同 |
| Meta description 消失 | description 為空或缺失 |
| Meta description 文字改變 | description 內容不同 |
| H1 數量改變 | H1 數量增加或減少 |
| H1 文字改變 | H1 內容不同 |
| Schema 類型改變 | @type 修改或增減 |
| OG 標籤消失 | og:title 或 og:image 消失 |
| Robots 指令改變 | 非 noindex 的 robots 指令修改 |

### INFO — 知悉即可，可能是刻意修改

| 規則 | 觸發條件 |
|------|---------|
| H2 結構改變 | H2 數量或文字有差異 |
| 內容字數大幅改變 | 字數增減超過 20% |
| OG 內容更新 | og: 標籤有新內容 |

---

## 指令：baseline（擷取基準線）

### 執行步驟

1. **驗證 URL**：確認格式正確，可訪問
2. **取得頁面**：WebFetch 頁面 HTML
3. **解析元素**：提取所有追蹤元素
4. **儲存快照**：寫入基準線檔案

### 儲存格式

將快照儲存為 Markdown 檔案至 `.drift/` 目錄（可建在專案根目錄或使用者家目錄）：

```
.drift/
  baselines/
    [url-slug]_[timestamp].md
  comparisons/
    [url-slug]_compare_[timestamp].md
  index.md   （歷史紀錄索引）
```

### 基準線檔案格式

```markdown
---
url: https://example.com/blog/post
captured_at: 2026-05-15T10:30:00
status_code: 200
---

## Title
Example Blog Post Title (45 chars)

## Meta Description
Blog post description here... (155 chars)

## Canonical
https://example.com/blog/post

## Meta Robots
index, follow

## H1
- "Example Blog Post Title"

## H2 (5 headings)
- "Introduction"
- "Main Section"
- ...

## Schema Types
- BlogPosting
- Person

## Open Graph
- og:title: Example Blog Post Title
- og:description: Blog post description...
- og:image: https://example.com/img.jpg

## Word Count
~1,847 words
```

---

## 指令：compare（比較當前與基準線）

### 執行步驟

1. **讀取最新基準線**：從 `.drift/baselines/` 找最近的 `[url-slug]_*.md`
2. **取得當前狀態**：WebFetch 頁面，提取所有元素
3. **套用 17 條規則**：逐一比對
4. **產出差異報告**：分 CRITICAL / WARNING / INFO 三層
5. **存儲比較結果**：寫入 `.drift/comparisons/`

### 比較輸出格式

```markdown
# SEO Drift 報告：[URL]

**比較時間：** [Timestamp]
**基準線時間：** [Timestamp]

## 嚴重問題 CRITICAL ⛔

- **Noindex 新增**：meta robots 從 `index, follow` 變為 `noindex, follow`
  → 立即修復。頁面將被移出搜尋索引。
  → 建議：執行 `/smart-blog-skills:seo-check` 做完整 SEO 驗證

## 警告 WARNING ⚠️

- **Title 改變**
  - 舊：「2025 年最佳工具」
  - 新：「最佳工具清單」
  → 確認是刻意修改還是意外遺失關鍵字

## 資訊 INFO ℹ️

- **H2 結構改變**：從 6 個 H2 變為 8 個 H2

## 無變動 ✅

- Canonical URL：無變動
- Schema：無變動
- HTTP 狀態：200（無變動）
```

### 偵測到問題時的交叉技能建議

| 發現 | 建議 |
|------|------|
| Schema 移除或修改 | `/smart-blog-skills:schema <url>` |
| Title/meta description 改變 | `/smart-blog-skills:seo-check <url>` |
| H1/標題結構改變 | `/smart-blog-skills:analyze <url>` |
| OG 標籤消失 | `/smart-blog-skills:seo-check <url>` |
| Noindex 新增 | 立即手動檢查並修復 |

---

## 指令：history（歷史紀錄）

讀取 `.drift/index.md` 和 `.drift/comparisons/` 目錄，顯示：
- 該 URL 所有基準線的時間戳記
- 每次比較的摘要（觸發幾條 CRITICAL / WARNING / INFO）
- 時間軸上的 SEO 健康度趨勢

---

## 典型工作流程

### 部署前後檢查
```
/smart-blog-skills:drift baseline https://example.com/blog/post   # 部署前
# ... 部署 ...
/smart-blog-skills:drift compare https://example.com/blog/post    # 部署後
```

### 持續監控（每月）
```
/smart-blog-skills:drift compare https://example.com/blog/post    # 月度檢查
/smart-blog-skills:drift history https://example.com/blog/post    # 查看趨勢
```

### 調查流量下降
```
/smart-blog-skills:drift compare https://example.com/blog/post    # 查什麼變了
/smart-blog-skills:drift history https://example.com/blog/post    # 什麼時候變的
```

---

## 錯誤處理

| 狀況 | 處置 |
|------|------|
| URL 無法訪問 | 回報錯誤，不猜測狀態 |
| 無此 URL 的基準線 | 提示先執行 `baseline` |
| 返回 4xx/5xx | 仍記錄（狀態碼本身是追蹤欄位） |
| `.drift/` 目錄不存在 | 自動建立，無錯誤 |
