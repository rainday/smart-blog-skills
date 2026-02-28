---
name: smart-blog-write
description: >
  從零寫一篇新的部落格文章。包含模板選擇、研究、大綱、寫作、品質檢查。
  內建反幻覺驗證，繁體中文優先。
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - WebFetch
  - WebSearch
  - Task
---

# Blog Write — 新文章生成

## 工作流程

### Phase 1：主題確認

問使用者以下資訊（有預設值的可以跳過）：
1. **主題** — 必要
2. **目標受眾** — 預設：一般讀者
3. **主要關鍵字** — 預設：從主題推導
4. **字數** — 預設：2,000-2,500 字
5. **語言** — 預設：繁體中文

### Phase 2：模板選擇

1. 讀取 `blog/references/content-templates.md`
2. 根據主題和搜尋意圖選擇模板：
   - 「如何...」→ how-to-guide
   - 「最佳 N 個」→ listicle
   - 「X vs Y」→ comparison
   - 廣泛主題 → pillar-page
   - 案例/成果 → case-study
3. 讀取對應模板 `blog/templates/<type>.md`
4. 告知使用者選了哪個模板

### Phase 3：大綱生成

1. 根據模板結構生成大綱
2. 包含：H2/H3 標題、每段字數建議、圖片/圖表放置位置
3. **呈現大綱給使用者確認**，等待同意後再進入下一步

### Phase 4：研究

生成 `blog-researcher` agent（Task tool），提供：
- 主題和關鍵字
- 需要搜尋的統計數據數量（8-12 個）
- 需要的圖片數量（封面 1 + 內文 3-5）
- 圖表規劃建議

**反幻覺要求：** 研究報告必須包含每筆數據的 [V]/[S]/[F] 標註。

**研究不足時：** 如果研究報告中 [V]+[S] 數據不足 5 個，告知使用者並提供選項：
1. 繼續寫作（品質可能較低，placeholder 會較多）
2. 使用者提供補充數據
3. 嘗試不同搜尋角度重新研究

### Phase 5：寫作

生成 `blog-writer` agent（Task tool），提供：
- 確認的大綱
- 研究報告（含驗證狀態）
- 選定的模板
- 偵測到的平台格式
- 寫作規則來源：`blog/references/content-rules.md`

### Phase 6：交付

輸出完成的文章 + 以下摘要：

```
## 文章完成：[標題]

### 使用模板
[模板名稱]

### 統計數據
- [N] 筆有來源的統計數據
- [N] 個不同來源
- ✅ [V] 已驗證：N 筆
- ⚠️ [S] 搜尋摘要：N 筆
- 📝 待補充：N 處 placeholder

### 視覺元素
- 封面圖：[來源]
- 內文圖：[N] 張
- 圖表標記：[N] 個

### 文章結構
- [N] 個 H2 段落（Answer-First 格式）
- [N] 個 FAQ
- 約 [N] 字
- 預估閱讀時間：[N] 分鐘

### 需要使用者處理
- [ ] 確認 [S] 標記的數據
- [ ] 替換 [內部連結] placeholder
- [ ] 補充 [待補充] 的統計數據
- [ ] 執行 `/blog analyze` 取得正式評分
```
