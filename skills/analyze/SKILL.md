---
name: analyze
description: >
  Smart Blog 品質分析。5 大類 100 分評分，包含 Humanizer 29 模式 AI 偵測、
  SEO 驗證、E-E-A-T 評估、PageSpeed 整合。支援 PDF 報告輸出。
  Use when user says "analyze blog", "分析文章", "blog audit", "品質評分",
  "smart-blog analyze", "blog analyze".
user-invocable: true
argument-hint: "<檔案或目錄> [--pdf]"
---

# Blog Analyze — 文章品質分析

## 工作流程

### Step 1：讀取文章

1. 讀取指定的文章檔案
2. 提取 YAML frontmatter
3. 分離正文內容

### Step 2：內容分析

讀取 `skills/blog/references/content-rules.md` 的評分標準，對文章執行以下分析：

#### 2a. 結構分析
- 計算 H1/H2/H3 數量
- 檢查標題層級是否正確（無跳級）
- 計算 H2 問句比例
- 檢查 Answer-First 格式（H2 前 40-60 字 / 中文 60-100 字含統計）

#### 2b. 段落分析
- 計算每段字數
- 找出超過 150 字的段落
- 計算理想範圍（中文 60-120 字 / 英文 40-80 字）的段落比例

#### 2c. 引用分析
- 計算統計數字數量
- 計算有來源歸因的統計數量
- 計算無來源的統計數量
- 分析來源等級（Tier 1/2/3）

#### 2d. 視覺元素
- 計算圖片數量和 alt text 覆蓋率
- 計算 SVG 圖表數量

#### 2e. FAQ 分析
- 是否有 FAQ 段落
- FAQ 問題數量

#### 2f. 連結分析
- 內部連結數量
- 外部連結數量
- 錨文字品質

### Step 3：AI 內容偵測

#### Humanizer 29 模式掃描

讀取 `skills/blog/references/humanizer-patterns.md`，掃描文章中出現的 AI 寫作模式：

- 逐條對照 29 個模式的監控詞
- 計算偵測到的模式數量
- 扣分規則（從 AI 引用就緒度扣）：
  - 0-3 個：扣 0 分
  - 4-8 個：扣 2 分
  - 9-15 個：扣 5 分
  - 16+ 個：扣 8 分
- 列出偵測到的具體模式和位置

**注意：** humanizer 模式與下方觸發詞掃描有部分重疊（模式 #7 ⊃ 觸發詞列表），不重複扣分。

#### 句長爆發性（Burstiness）
- 計算每個句子的字數
- 算出標準差 / 平均值 = 變異係數
- ≥0.4 = 自然，0.3-0.4 = 邊界，<0.3 = AI 風險

#### AI 觸發詞掃描
- 掃描禁止觸發詞列表（見 content-rules.md）
- 計算每 1,000 字的觸發詞密度
- ≤3/千字 = 正常，3-5 = 注意，>5 = 高風險

#### 被動語態估算
- 計算「被」字句和被動結構的比例
- ≤10% = 正常，10-15% = 注意，>15% = 高風險

### Step 4：評分

根據 `content-rules.md` 的 100 分標準打分：

| 類別 | 滿分 |
|------|------|
| 內容品質 | 30 |
| SEO 優化 | 25 |
| E-E-A-T 訊號 | 15 |
| 技術元素 | 15 |
| AI 引用就緒度 | 15 |

### Step 5：輸出報告

```markdown
## 品質分析報告：[檔案名稱]

### 總分：[N]/100 — [等級]

| 類別 | 得分 | 滿分 |
|------|------|------|
| 內容品質 | [N] | 30 |
| SEO 優化 | [N] | 25 |
| E-E-A-T 訊號 | [N] | 15 |
| 技術元素 | [N] | 15 |
| AI 引用就緒度 | [N] | 15 |

### AI 內容偵測
- 句長爆發性：[數值]（[自然/邊界/AI風險]）
- AI 觸發詞：[N]/千字（[正常/注意/高風險]）
- 被動語態：[N]%（[正常/注意/高風險]）

### 問題清單（依嚴重度排序）

#### 🔴 致命
[列出致命問題]

#### 🟡 高優先
[列出高優先問題]

#### 🟠 中優先
[列出中優先問題]

### 改善建議
[前 3 個最有影響力的改善行動]
```

### Step 5b：PageSpeed 整合（選用）

如果文章的 frontmatter 包含 `url` 或 `canonical` 欄位：

1. 檢查 `~/.config/smart-blog-skills/config.json` 是否存在
2. 如果有 → 呼叫 PageSpeed API，將結果納入技術元素評分
3. 如果沒有 → 跳過，使用純內容分析

### Step 6：PDF 輸出（--pdf）

如果使用者加了 `--pdf` flag：

1. 將 Markdown 報告轉換為 HTML
2. 使用 Python + WeasyPrint 生成 PDF
3. 輸出到與文章相同的目錄：`{filename}-analysis.pdf`

**需求：** Python 3.11+ 和 WeasyPrint (`pip install weasyprint`)

```bash
/c/Users/EricHsu/AppData/Local/Programs/Python/Python313/python.exe scripts/pdf_report.py --input report.md --output report.pdf
```

如果 Python 或 WeasyPrint 未安裝，提示使用者安裝方式，繼續輸出 Markdown 報告。

### Step 7：Monitor 快照（自動）

分析完成後，如果 `docs/monitor/` 目錄存在：
1. 自動將分析結果存為 JSON 快照到 `docs/monitor/snapshots/{today}/{slug}.json`
2. 更新 `docs/monitor/index.json`
3. 告知使用者：「分析結果已同步到 monitor 快照」

如果 `docs/monitor/` 不存在，跳過此步驟。

### 批次分析

如果使用者提供目錄路徑：
1. 用 `Glob` 找出所有 `.md` / `.mdx` / `.html` 檔案
2. 逐一分析
3. 輸出摘要表格，按分數排序
4. 如果 `docs/monitor/` 存在，自動建立批次快照
