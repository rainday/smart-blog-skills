---
name: write
description: >
  Smart Blog 寫文章。從零寫一篇新的部落格文章，包含模板選擇、研究、
  YouTube 影片嵌入、Humanizer 反 AI 審稿、品質檢查。
  內建反幻覺驗證，繁體中文優先。
  Use when user says "write blog", "寫文章", "寫部落格", "new blog post",
  "smart-blog write", "blog write".
user-invokable: true
argument-hint: "<主題>"
---

# Blog Write — 新文章生成

## 工作流程

### Phase 0：檢查 Brief 文件

1. 如果使用者提供了 slug（如 `/write software-development-contract`），檢查 `docs/smart-blog/[slug].brief.md` 是否存在
2. 如果 brief 存在：
   - 讀取文件，直接跳到 **Phase 5（研究）**
   - 告知使用者：「找到 brief 文件，跳過大綱生成，直接進入研究與寫作」
3. 如果 brief 不存在，繼續 Phase 1

### Phase 1：主題確認

問使用者以下資訊（有預設值的可以跳過）：
1. **主題** — 必要
2. **目標受眾** — 預設：一般讀者
3. **主要關鍵字** — 預設：從主題推導
4. **字數** — 預設：2,000-2,500 字
5. **語言** — 預設：繁體中文

### Phase 2：模板選擇

1. 讀取 `skills/blog/references/content-templates.md`
2. 根據主題和搜尋意圖選擇模板：
   - 「如何...」→ how-to-guide
   - 「最佳 N 個」→ listicle
   - 「X vs Y」→ comparison
   - 廣泛主題 → pillar-page
   - 案例/成果 → case-study
3. 讀取對應模板 `skills/blog/templates/<type>.md`
4. 告知使用者選了哪個模板

### Phase 3：大綱生成

1. 根據模板結構生成大綱
2. 包含：H2/H3 標題、每段字數建議、圖片/圖表放置位置
3. **呈現大綱給使用者確認**，等待同意後再進入下一步

### Phase 4：Research Cache 檢查

1. 計算 slug（主題轉小寫、空白換 `-`、中文翻譯英文）
2. 讀取 `skills/blog/references/research-cache.md` 了解 cache 規格
3. 用 Glob 檢查 `docs/research/{slug}/meta.md` 是否存在
4. 如果存在，讀取 frontmatter 判斷 cache 狀態：

| 狀態 | 行為 |
|------|------|
| `fresh` | 告知使用者：「找到 [date] 的研究 cache（[N] 筆統計、[N] 張圖片），直接使用」→ 跳到 Phase 6（寫作） |
| `partial-stale` | 告知使用者哪些部分過期，提供選項：(a) 只更新過期部分 (b) 完整重新研究 (c) 直接使用舊資料 |
| `stale` | 告知使用者 cache 已過期 → 進入 Phase 5（研究） |

5. 如果不存在或使用者指定 `--force-research` → 進入 Phase 5（研究）

### Phase 5：研究

生成 `smart-blog-skills:blog-researcher` agent（Agent tool），提供：
- 主題和關鍵字
- 需要搜尋的統計數據數量（8-12 個）
- 需要的圖片數量（封面 1 + 內文 3-5）
- 圖表規劃建議
- slug（用於 research cache 儲存路徑）
- **YouTube 影片搜尋**：搜尋 2-3 個相關影片（見 `references/video-embeds.md`）

**反幻覺要求：** 研究報告必須包含每筆數據的 [V]/[S]/[F] 標註。

**研究不足時：** 如果研究報告中 [V]+[S] 數據不足 5 個，告知使用者並提供選項：
1. 繼續寫作（品質可能較低，placeholder 會較多）
2. 使用者提供補充數據
3. 嘗試不同搜尋角度重新研究

### Phase 5b：YouTube 影片發現

1. 用 WebSearch 搜尋 `[主題] site:youtube.com`（最多 2 次搜尋）
2. 讀取 `skills/blog/references/video-embeds.md` 的品質評分標準
3. 選出 2-3 個相關影片（品質分 ≥60）
4. 驗證影片 URL 可存取
5. 記錄影片資訊（標題、頻道、VIDEO_ID、描述）

**如果找不到合適影片：** 跳過嵌入，不影響文章品質。

### Phase 6：寫作

生成 `smart-blog-skills:blog-writer` agent（Agent tool），提供：
- 確認的大綱
- 研究報告（含驗證狀態）
- 選定的模板
- 偵測到的平台格式
- 寫作規則來源：`skills/blog/references/content-rules.md`
- Humanizer 模式來源：`skills/blog/references/humanizer-patterns.md`
- YouTube 影片清單（如有）：影片 ID、標題、建議放置位置

**重要：** blog-writer 在寫完初稿後會執行 Humanizer Pass（29 模式掃描 + 反 AI 審稿二次修正），確保輸出不像 AI 寫的。

### Phase 7：品質關卡（BLOCKING）

生成 `smart-blog-skills:blog-reviewer` agent（Agent tool），傳入：
- 完成的文章全文
- 要求執行完整 100 分評分 + Second-order AI slop detection（參考 `skills/blog/references/ai-slop-detection.md`）

**關卡規則：**

| 條件 | 行動 |
|------|------|
| 總分 ≥ 90 AND 零 P0 問題 | **通過** → 進入 Phase 8 交付 |
| 總分 < 90 OR 任何 P0 問題 | **封鎖** → 傳回問題清單給 blog-writer 修正 |

**重試機制：** 最多重試 **2 次**。每次重試都重新生成 blog-writer 修正 + blog-reviewer 重新評分。2 次後仍未通過 → 繼續交付，但在摘要中清楚標示當前分數和未解決的問題。

---

### Phase 8：交付

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

### 圖片清單

| 檔案名稱 | 放置位置 | 生成 Prompt |
|---------|---------|------------|
| [slug]-cover.webp | 封面 / OG Image (1200×630) | [prompt] |
| [slug]-01-[desc].webp | 引言之後 | [prompt] |
| [slug]-02-[desc].webp | H2: [標題] 之後 | [prompt] |

- 如已有 brief 圖片規劃，直接沿用該表格
- SVG 圖表：[N] 個（已嵌入文章）

### YouTube 影片

| 影片標題 | 放置位置 | VIDEO_ID |
|---------|---------|----------|
| [標題] | H2: [段落] 之後 | [ID] |
| [標題] | H2: [段落] 之後 | [ID] |

- 嵌入格式：srcdoc lazy-loading（見 `references/video-embeds.md`）
- VideoObject Schema 已加入文章末尾

### 文章結構
- [N] 個 H2 段落（Answer-First 格式）
- [N] 個 FAQ
- 約 [N] 字
- 預估閱讀時間：[N] 分鐘

### 品質關卡結果
- 最終評分：[N]/100（[等級]）
- P0 問題：[無 / 已修正 N 個]
- AI Slop Detection：[PASS / PASS after N retries]

### 需要使用者處理
- [ ] 確認 [S] 標記的數據
- [ ] 替換 [內部連結] placeholder
- [ ] 補充 [待補充] 的統計數據
```
