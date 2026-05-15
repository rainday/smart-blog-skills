# Research Cache 規格

> 定義 research 資料的持久化格式、目錄結構和過期規則。
> 所有涉及研究的 agent 和 skill 必須遵循此規格。

## 目錄結構

```
docs/research/{slug}/
├── meta.md           # 研究元資料（日期、關鍵字、過期設定）
├── stats.md          # 統計數據 + 驗證狀態
├── competitors.md    # SERP 競品分析
└── images.md         # 圖片資源
```

## slug 規則

與 brief 文件相同：主題轉小寫、空白換成 `-`、移除特殊字元。
繁體中文主題翻譯成英文 slug。
範例：`AI SEO 優化策略` → `ai-seo-optimization-strategy`

## meta.md 格式

```yaml
---
topic: [主題]
keyword: [主要關鍵字]
language: [zh-TW / en]
researched_at: [YYYY-MM-DD]
researcher_version: [plugin version]
stats_count: [N]
verified_count: [N]  # [V] 筆數
search_count: [N]    # [S] 筆數
failed_count: [N]    # [F] 筆數
stale_after:
  stats: [YYYY-MM-DD]       # researched_at + 3 個月
  competitors: [YYYY-MM-DD] # researched_at + 1 個月
  images: [YYYY-MM-DD]      # researched_at + 12 個月
status: fresh | partial-stale | stale
---

## 研究摘要

- 主題：[topic]
- 搜尋日期：[date]
- 統計數據：[V] N 筆 / [S] N 筆 / [F] N 筆
- 來源等級分佈：Tier 1: N / Tier 2: N / Tier 3: N
- 圖片：N 張（封面 + 內文）
- 競品分析：N 個 SERP 結果
```

## stats.md 格式

直接使用現有 researcher 輸出的「統計數據」段落格式，加上 frontmatter：

```yaml
---
topic: [主題]
researched_at: [YYYY-MM-DD]
stale_after: [YYYY-MM-DD]
count: [N]
---
```

後接每筆數據：

```markdown
### 數據 1
- 數字: [具體統計]
- 原文引用: "[從頁面逐字引用的 10-30 字]"
- 來源: [來源名稱]
- URL: [完整 URL]
- 等級: Tier [1/2/3]
- 驗證: [V] / [S] / [F]
```

## competitors.md 格式

```yaml
---
topic: [主題]
keyword: [搜尋關鍵字]
researched_at: [YYYY-MM-DD]
stale_after: [YYYY-MM-DD]
serp_count: [N]
---
```

後接 SERP 分析表格和內容缺口分析。

## images.md 格式

```yaml
---
topic: [主題]
researched_at: [YYYY-MM-DD]
stale_after: [YYYY-MM-DD]
image_count: [N]
---
```

後接圖片列表（封面 + 內文）和圖表規劃。

## 過期規則

| 資料類型 | 預設保鮮期 | 判斷依據 |
|---------|----------|---------|
| stats（統計數據） | 3 個月 | 行業報告通常每季更新 |
| competitors（SERP） | 1 個月 | 排名變動快 |
| images（圖片） | 12 個月 | 圖片 URL 穩定 |

### 過期狀態判斷邏輯

```
if today > stale_after.stats AND today > stale_after.competitors:
  status = "stale"              # 全部過期，需要完整重新研究
elif today > stale_after.stats OR today > stale_after.competitors:
  status = "partial-stale"      # 部分過期，只需更新過期部分
else:
  status = "fresh"              # 仍然新鮮，可直接使用
```

### 重新研究觸發條件

1. `status = stale` → 重新執行完整研究
2. `status = partial-stale` → 只重新研究過期的部分
3. 使用者明確要求 `--force-research` → 忽略 cache，完整重新研究
4. `status = fresh` → 直接使用 cache，跳過研究階段

## 使用優先級

1. 使用者提供的資料（最高）
2. docs/research/{slug}/ cache（新鮮的）
3. skills/blog/references/seo-landscape.md（靜態預驗證）
4. 線上搜尋（最低，但最新）
