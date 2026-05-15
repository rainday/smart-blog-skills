---
name: monitor
description: >
  Smart Blog 品質監控與月度比較。追蹤文章分數變化，產出 delta 報告。
  資料儲存在 docs/monitor/，JSON 格式可供其他 skill 共用。
  Use when user says "monitor", "監控", "追蹤", "compare scores",
  "monthly report", "月報", "品質趨勢", "smart-blog monitor", "delta".
user-invokable: true
argument-hint: "[snapshot|compare|trend] [檔案或目錄]"
---

# Blog Monitor — 品質監控與比較

追蹤部落格文章的品質分數變化，產出月度 delta 報告。

## 指令一覽

| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:monitor snapshot <檔案或目錄>` | 擷取當前品質快照，存入 docs/monitor/ |
| `/smart-blog-skills:monitor compare <檔案>` | 比較最新快照與上一次，產出 delta 報告 |
| `/smart-blog-skills:monitor trend <檔案或目錄>` | 顯示歷史趨勢（所有快照） |

## 資料結構

```
docs/monitor/
├── snapshots/
│   ├── 2026-04-06/
│   │   ├── meta.json                    ← 該次快照的元資料
│   │   ├── my-post-slug.json            ← 單篇文章的評分詳情
│   │   └── another-post.json
│   ├── 2026-05-06/
│   │   └── ...
│   └── latest -> 2026-04-06/            ← symlink 指向最新快照
├── reports/
│   ├── 2026-05-06-monthly.md            ← 月度比較報告
│   └── ...
└── index.json                           ← 所有快照索引
```

### index.json 格式

```json
{
  "project": "my-blog",
  "snapshots": [
    {
      "date": "2026-04-06",
      "file_count": 15,
      "avg_score": 72.3,
      "min_score": 45,
      "max_score": 91
    }
  ],
  "last_updated": "2026-04-06"
}
```

### 單篇快照 JSON 格式

```json
{
  "file": "posts/ai-seo-guide.md",
  "slug": "ai-seo-guide",
  "date": "2026-04-06",
  "scores": {
    "total": 78,
    "content_quality": 24,
    "seo": 20,
    "eeat": 12,
    "technical": 11,
    "ai_citation": 11
  },
  "ai_detection": {
    "burstiness": 0.42,
    "trigger_words_per_1k": 2.1,
    "passive_voice_pct": 8.5
  },
  "stats": {
    "word_count": 2350,
    "h2_count": 6,
    "faq_count": 5,
    "image_count": 4,
    "internal_links": 7,
    "external_links": 5,
    "stats_with_source": 9
  },
  "issues": {
    "critical": 0,
    "high": 2,
    "medium": 3
  }
}
```

## Snapshot 流程

### Step 1：確認範圍

- 如果是單一檔案 → 只快照該檔案
- 如果是目錄 → 用 Glob 找出所有 `.md` / `.mdx` 檔案

### Step 2：執行分析

對每個檔案執行 analyze 的完整分析邏輯（與 `/smart-blog-skills:analyze` 相同的 5 大類評分）。

### Step 3：儲存快照

1. 建立 `docs/monitor/snapshots/{YYYY-MM-DD}/` 目錄
2. 每篇文章存為 `{slug}.json`
3. 建立 `meta.json`：

```json
{
  "date": "2026-04-06",
  "file_count": 15,
  "avg_score": 72.3,
  "min_score": 45,
  "max_score": 91,
  "score_distribution": {
    "excellent_90plus": 2,
    "good_80plus": 5,
    "pass_70plus": 4,
    "improve_60plus": 3,
    "rewrite_below_60": 1
  }
}
```

4. 更新 `docs/monitor/index.json`

### Step 4：輸出摘要

```markdown
## 快照完成：{日期}

- 分析文章：{N} 篇
- 平均分數：{N}/100
- 最高：{檔案} ({N}/100)
- 最低：{檔案} ({N}/100)

### 分數分佈

| 等級 | 數量 |
|------|------|
| 卓越（90+） | {N} |
| 優良（80-89） | {N} |
| 及格（70-79） | {N} |
| 待改進（60-69） | {N} |
| 需重寫（<60） | {N} |

快照已存入 `docs/monitor/snapshots/{日期}/`
```

## Compare 流程

### Step 1：找到比較基準

1. 如果使用者指定兩個日期 → 比較這兩個快照
2. 如果只指定檔案 → 比較最新快照和上一次快照
3. 如果只有一次快照 → 提示需要至少兩次快照

### Step 2：計算 Delta

對每篇文章計算：

```
delta = current_score - previous_score
```

### Step 3：產出報告

存入 `docs/monitor/reports/{YYYY-MM-DD}-monthly.md`：

```markdown
## 月度品質報告：{起始日期} → {結束日期}

### 整體趨勢

| 指標 | 上次 | 本次 | 變化 |
|------|------|------|------|
| 平均分數 | {N} | {N} | {+/-N} |
| 文章數量 | {N} | {N} | {+/-N} |
| 卓越文章（90+） | {N} | {N} | {+/-N} |
| 需重寫（<60） | {N} | {N} | {+/-N} |

### 各類別平均變化

| 類別 | 上次 | 本次 | 變化 |
|------|------|------|------|
| 內容品質 | {N}/30 | {N}/30 | {+/-N} |
| SEO 優化 | {N}/25 | {N}/25 | {+/-N} |
| E-E-A-T | {N}/15 | {N}/15 | {+/-N} |
| 技術元素 | {N}/15 | {N}/15 | {+/-N} |
| AI 引用 | {N}/15 | {N}/15 | {+/-N} |

### 進步最大（Top 5）

| 文章 | 上次 | 本次 | 變化 |
|------|------|------|------|
| {slug} | {N} | {N} | +{N} |

### 退步最多（Top 5）

| 文章 | 上次 | 本次 | 變化 |
|------|------|------|------|
| {slug} | {N} | {N} | -{N} |

### 新增文章（本次有、上次無）

| 文章 | 分數 |
|------|------|
| {slug} | {N}/100 |

### 建議行動

1. **優先改寫：** {列出分數最低的 3 篇}
2. **趨勢警告：** {列出連續下降的文章}
3. **品質提升機會：** {列出 70-79 分的文章，改善空間最大}
```

## Trend 流程

讀取 `docs/monitor/index.json`，顯示歷史趨勢：

```markdown
## 品質趨勢：{專案名稱}

| 日期 | 文章數 | 平均分 | 最高 | 最低 |
|------|--------|--------|------|------|
| 2026-04-06 | 15 | 72.3 | 91 | 45 |
| 2026-03-06 | 12 | 68.7 | 88 | 41 |
| ... | ... | ... | ... | ... |
```

## 與其他 Skill 共用

`docs/monitor/` 的 JSON 格式設計為可被其他 skill 讀取：

- 其他 SEO/內容 skill 可讀取 snapshot 中的分數做整站分析
- **analyze** 執行後可自動更新對應的 snapshot 檔案
- **rewrite** 完成後可觸發 re-snapshot 看改善效果

### 共用協議

1. 讀取：任何 skill 可讀取 `docs/monitor/snapshots/*/` 下的 JSON
2. 寫入：只有 monitor skill 寫入 snapshot；其他 skill 可寫入 `docs/monitor/external/` 子目錄
3. 索引：修改 snapshot 後必須更新 `index.json`
