# Smart Blog 策略總覽

> 這是整個 smart-blog skill 的唯一策略來源 (Single Source of Truth)。
> 所有 reference 文件、模板、agent 規則都從本文件衍生。
> 新策略先更新此文件 → 再同步到對應的 reference 和模板。

**最後更新：2026-02-28**
**版本：v1.0**

---

## 一、SEO 核心策略

### 1.1 Google 演算法現況（2025 年 12 月核心更新）

**重點變化：**
- E-E-A-T 從 YMYL（健康、財務）擴展到**所有競爭性查詢**
- 「真實性訊號」成為排名因素：原創圖片、第一人稱敘述、原創數據
- Hidden Gems 系統持續提升有「真實經驗」的內容
- AI 生成內容不會自動被懲罰，但缺乏「資訊增量」的 AI 內容排名下降
- 聯盟行銷型網站受創最嚴重（71% 流量下降，SISTRIX, 2025）

**關鍵數據：**
- Google 市場佔有率：87.3%（桌面），95.2%（行動）（StatCounter, 2025）
- AI Overviews 出現時，自然搜尋 CTR 下降 61%（Seer Interactive, 2025）
- 有 AI Overview 的查詢，前 3 名以下的點擊率幾乎歸零
- 長尾查詢（5+ 字）中 AI Overview 覆蓋率最高

### 1.2 E-E-A-T 要求

| 維度 | 建議權重 | 核心要求 |
|------|---------|---------|
| Trust（信任） | 30% | 最重要。準確的資訊、可查證的來源、作者可信度 |
| Experience（經驗） | 25% | 第一人稱敘述、實測結果、原創截圖/照片 |
| Expertise（專業） | 25% | 作者資歷、深度分析、技術準確度 |
| Authoritativeness（權威） | 20% | 外部引用、反向連結、品牌知名度 |

> **注意：** Google 從未公布 E-E-A-T 各維度的官方權重。以上百分比為業界共識的建議分配，用於內部評分參考。

**最低要求：**
- 每篇文章必須有具名作者（非「管理員」或「團隊」）
- 作者簡介含職稱、經歷、社群連結
- 至少 3 個來自 Tier 1-2 來源的引用

### 1.3 AI 內容評估框架

Google 不懲罰 AI 內容本身，而是懲罰**低品質內容**。判斷標準：

| 正面訊號 | 負面訊號 |
|---------|---------|
| 原創數據或見解 | 只是重述已知資訊 |
| 第一人稱經驗 | 空泛的通用建議 |
| 具體案例和數字 | 沒有來源的聲明 |
| 句長有自然變化 | 均勻的句子長度 |
| 使用縮寫（它、這個） | 過度正式語氣 |

### 1.4 關鍵數據清單

以下為經驗證的數據。使用前建議重新驗證，因為原始報告可能更新。

| 數據 | 來源 | 年份 | 驗證狀態 | 用途 |
|------|------|------|---------|------|
| 自然 CTR 下降 61%（AI Overview） | Seer Interactive | 2025 | ✅ 可查證 | SEO 議題文章 |
| E-E-A-T 擴展到所有查詢 | Google QRG 更新 | 2025 | ✅ 可查證 | E-E-A-T 文章 |
| 聯盟網站流量下降 71% | SISTRIX | 2025 | ✅ 可查證 | 內容策略文章 |
| AI Overview 涵蓋 47% 搜尋 | BrightEdge | 2025 | ✅ 可查證 | AI 搜尋文章 |
| Google 市場佔有率 87.3%/95.2% | StatCounter | 2025 | ✅ 可查證 | 搜尋引擎文章 |
| Answer-First 引用率 +340% | GEO 研究 (Aggarwal et al.) | 2023 | ⚠️ 需確認出處 | AI 引用文章 |
| 數據支撐段落引用率高 3.4 倍 | GEO 研究 | 2023 | ⚠️ 需確認出處 | AI 引用文章 |
| 76% AI 引用來自 30 天內更新內容 | Zyppy | 2025 | ⚠️ 需確認出處 | 內容更新策略 |
| 跨平台引用重疊率 12% | Zyppy | 2025 | ⚠️ 需確認出處 | 多平台策略 |
| 站外訊號影響 88-92% | Zyppy Off-Site Study | 2025 | ⚠️ 需確認出處 | 站外優化文章 |
| FAQPage Schema +28% AI 引用 | 待確認 | — | ❌ 待驗證 | Schema 文章 |
| 3+ Schema 類型 +13% AI 引用 | 待確認 | — | ❌ 待驗證 | Schema 文章 |

> **驗證狀態說明：**
> - ✅ 可查證：來源機構和研究確認存在，數據可從官方報告取得
> - ⚠️ 需確認出處：數據可能正確但具體出處需要進一步確認
> - ❌ 待驗證：尚未找到可信的原始來源，使用時務必先驗證或標註為估計值
>
> **GEO 研究原始論文：** Aggarwal et al., "GEO: Generative Engine Optimization", Princeton/Georgia Tech, 2023 (arxiv.org/abs/2311.09735)
> **Google QRG：** https://services.google.com/fh/files/misc/hsw-sqrg.pdf

---

## 二、AI 引用優化策略 (GEO/AEO)

### 2.1 AI 引用核心原則

> **來源說明：** 本節數據主要來自 Princeton/Georgia Tech GEO 研究（Aggarwal et al., 2023）、
> Zyppy SEO Research (2024-2025)、及各 AI 平台官方文件。具體 URL 見 1.4 節關鍵數據清單。

AI 系統（ChatGPT、Perplexity、Google AI Overview、Gemini）引用內容的條件：
1. **可提取性** — 段落必須自成一體，不依賴上下文就能理解
2. **有數據支撐** — 含具體數字 + 來源歸因的段落引用率高 3.4 倍（GEO 研究）
3. **結構化** — Q&A 格式、表格、清單比純文字更容易被引用
4. **新鮮度** — 76% 的 AI 引用來自 30 天內更新的內容（Zyppy, 2025）

### 2.2 Answer-First 格式

**最有效的單一策略，引用率提升 +340%（GEO 研究）。**

規則：每個 H2 段落的前 40-60 字（中文 60-100 字）必須包含：
- 一個具體統計數字 + 來源歸因
- 對標題隱含問題的直接回答

```markdown
## AI 搜尋如何影響自然流量？

根據 Seer Interactive 的 2025 年研究，當 AI Overview 出現時，自然搜尋的
點擊率下降了 61%（[Seer Interactive](https://seerinteractive.com), 2025）。
這意味著傳統的「排名第一」策略已經不夠，內容必須同時為 AI 系統優化。
```

### 2.3 段落可引用性

- **最佳段落長度：120-180 字**（中文約 200-300 字）
- 每個段落應自成一體（self-contained）
- 包含：一個主張 + 一個數據點 + 來源歸因
- 用宣告式語氣寫（非問句或假設句）

### 2.4 跨平台引用差異

| 平台 | 偏好格式 | 引用特徵 |
|------|---------|---------|
| ChatGPT | 長段落、深度分析 | 傾向引用 2,000+ 字的長文 |
| Perplexity | 結構化數據、表格 | 偏好可直接引用的數據段落 |
| Google AI Overview | 簡短摘要、清單 | 從前 3 名結果提取答案 |
| Gemini | 多來源綜合 | 偏好多來源比對 |

**關鍵發現：** 不同平台的引用重疊率只有 12%（Zyppy, 2025），必須同時優化所有格式。

### 2.5 站外訊號影響

88-92% 的 AI 引用受站外訊號影響（Zyppy Off-Site SEO Study, 2025）：
- YouTube 影片：相關性 0.737（最強）
- 反向連結：相關性 0.218
- Reddit 討論：可提升 AI 可見度 +450%
- 多平台評論存在：引用倍率 2.6-3.5x

---

## 三、內容品質標準

### 3.1 五大類 100 分評分系統

| 類別 | 滿分 | 評分維度 |
|------|------|---------|
| 內容品質 | 30 | 深度(7)、可讀性(7)、原創性(5)、結構(4)、參與度(4)、文法/反模式(3) |
| SEO 優化 | 25 | 標題(4)、標題層級(5)、關鍵字(4)、內部連結(4)、Meta描述(3)、外部連結(2)、URL(3) |
| E-E-A-T 訊號 | 15 | 作者(4)、引用(4)、信任指標(4)、經驗訊號(3) |
| 技術元素 | 15 | Schema(4)、圖片(3)、結構化資料(2)、速度(2)、行動裝置(2)、社群 meta(2) |
| AI 引用就緒度 | 15 | 可引用段落(4)、Q&A 格式(3)、實體清晰度(3)、提取結構(3)、爬蟲可及性(2) |

**評分等級：**
- 90-100：卓越（可直接發布）
- 80-89：優良（微調後發布）
- 70-79：及格（需要改善）
- 60-69：待改進（需大幅修改）
- <60：重寫（基本面有問題）

### 3.2 寫作規則摘要

**段落規則：**

| 規則 | 中文 | 英文 |
|------|------|------|
| 段落長度 | 60-120 字 | 40-80 字 |
| 絕對上限 | 200 字 | 150 字 |
| 句子長度 | 15-25 字 | 15-20 字 |
| 句子上限 | 35 字 | 25 字 |

- 每段以最重要的資訊開頭

**標題規則：**
- 一個 H1（文章標題）
- H2 用於主要段落（60-70% 用問句）
- H3 用於子段落，不可跳級（H2→H4 是錯的）
- 主要關鍵字自然出現在 2-3 個標題中

**可讀性目標：**
- Flesch Reading Ease：60-70（英文），中文對應為句長 15-20 字平均
- 被動語態 ≤10%
- 轉折詞比例 20-30%

**引用格式：**
```markdown
根據 [來源名稱](URL) 的 YYYY 年研究，[統計數字]（[來源](URL), YYYY）。
```

### 3.3 反 AI 偵測策略

AI 生成的文章有明顯特徵，需主動規避：

**必須做：**
- 句子長度要有「爆發性」變化（短句 8 字 + 長句 25 字交替）
- 使用口語化縮寫（「它」「這個」「不是嗎？」）
- 每 200-300 字加入一個修辭問句
- 加入第一人稱經驗描述（「我們測試後發現...」）

**絕對禁止的 AI 觸發詞：**

中文觸發詞：
- 「在當今數位時代」「值得注意的是」「深入探討」
- 「全面性指南」「無縫整合」「顛覆性」「賦能」
- 「一站式」「不可或缺」「至關重要」

英文觸發詞：
- "delve", "tapestry", "multifaceted", "testament", "pivotal"
- "robust", "cutting-edge", "leverage", "comprehensive", "landscape"
- "crucial", "foster", "illuminate", "paramount", "nuanced"
- "intricate", "meticulous", "seamlessly"

英文觸發短語：
- "in today's digital landscape", "it's important to note"
- "game-changer", "navigate the landscape"

**AI 偵測指標：**
- Burstiness（句長變異係數）：≥0.4 為自然，<0.3 被標記
- 詞彙多樣性 TTR：≥0.4 為自然，<0.35 為 AI 風險
- AI 觸發詞密度：每 1,000 字 ≤3 個（中文），≤5 個（英文）

### 3.4 品質閘門（發布前必須通過）

| 規則 | 等級 | 條件 |
|------|------|------|
| 無捏造統計 | 🔴 致命 | 每個數字必須有具名來源 |
| 標題層級正確 | 🔴 致命 | H1→H2→H3，不可跳級 |
| 具名作者 | 🔴 致命 | 非「管理員」或通用名 |
| Answer-First 格式 | 🟡 高 | 每個 H2 前 40-60 字（中文 60-100 字）含統計 |
| TL;DR 區塊 | 🟡 高 | 文章開頭 40-60 字摘要 |
| Meta Description | 🟡 高 | 150-160 字元，含數據 |
| 8+ 個有來源統計 | 🟡 高 | 每 2,000 字至少 8 個 |
| 3-5 個 FAQ | 🟠 中 | 40-60 字（中文 60-100 字）答案，含數據 |
| 3-5 張圖片 | 🟠 中 | 有描述性 alt text |
| 內部連結（依字數） | 🟠 中 | 1,500 字以下 3-5 個；1,500-2,500 字 5-8 個；2,500+ 字 8-12 個 |

---

## 四、技術實作標準

### 4.1 Schema 必要類型

每篇文章至少 3 種 Schema（多種 Schema 有助於 AI 引用，具體提升幅度待驗證）：

| Schema 類型 | 必要性 | 用途 |
|------------|--------|------|
| BlogPosting | 必要 | 文章基本資訊 |
| Person | 必要 | 作者 E-E-A-T 訊號 |
| FAQPage | 強烈建議 | FAQ 段落，有助 AI 引用（Google 已取消一般網站的 FAQ rich results，但 Schema 仍有利於 AI 抓取） |
| BreadcrumbList | 建議 | 網站導覽結構 |
| ImageObject | 建議 | 圖片結構化描述 |

### 4.2 圖片規範

- **封面圖**：1200x630（OG 相容）
- **來源優先級**：Pixabay > Unsplash > Pexels（皆為免費商用授權）
- **格式優先**：AVIF > WebP > JPEG（AVIF 比 JPEG 小 50%，WebP 瀏覽器支援度較高）
- **Alt 文字**：完整描述句，自然包含主題關鍵字
- **Hero 圖片**：不可 lazy load（影響 LCP）
- **內文圖片密度**：每 200-400 字一張

**SVG 圖表：**
- 內建生成，不需外部工具
- 7 種圖表類型：bar, grouped bar, donut, line, lollipop, area, radar
- 每篇不可重複相同類型
- 必須支援深色模式（用 `currentColor`）
- 每篇 2-4 個圖表，均勻分佈

### 4.3 平台通用規則

| 規則 | 說明 |
|------|------|
| SSR/SSG 必要 | 內容不可依賴 JavaScript 渲染（AI 爬蟲不執行 JS） |
| Schema 在 HTML 中 | JSON-LD 必須在 HTML source 中，不可用 JS 注入 |
| Sitemap | 必須有 sitemap.xml 讓爬蟲發現內容 |
| TTFB | 目標 <200ms |
| 行動裝置友善 | 段落不超過 100 字，表格可橫向捲動 |

**平台偵測規則：**

| 偵測訊號 | 平台 | 輸出格式 |
|---------|------|---------|
| `.mdx` + `next.config` | Next.js/MDX | JSX 相容 markdown（camelCase 屬性） |
| `hugo.toml` / `hugo.yaml` | Hugo | 標準 markdown + YAML frontmatter |
| `_config.yml` | Jekyll | 標準 markdown + YAML frontmatter |
| `.astro` 檔案 | Astro | MDX 或 markdown |
| `.html` 檔案 | 靜態 HTML | 語義化 HTML |
| `wp-content/` | WordPress | Gutenberg blocks 或 HTML |
| `gatsby-config.js` | Gatsby | MDX + React |
| 無法偵測 | 預設 | 標準 markdown |

### 4.4 AI 爬蟲可及性

**重要：Cloudflare 自 2024 年 7 月起提供一鍵封鎖 AI 爬蟲功能（opt-in），許多網站已啟用。**

必須允許的爬蟲：
```
User-agent: GPTBot
Allow: /

User-agent: ClaudeBot
Allow: /

User-agent: PerplexityBot
Allow: /

User-agent: Google-Extended
Allow: /
```

已知 AI 爬蟲 JS 執行能力：
- GPTBot：不執行 JS
- ClaudeBot：不執行 JS
- PerplexityBot：不執行 JS
- Google-Extended：執行 JS（與 Googlebot 共用引擎）

**llms.txt（新興標準）：**
- 在網站根目錄放置 `llms.txt`（精簡摘要）和 `llms-full.txt`（完整內容）
- 幫助 AI 系統更準確地理解和引用網站內容
- 詳見 https://llmstxt.org/

---

## 五、研究與驗證策略

### 5.1 反幻覺三層驗證

這是 smart-blog 的核心差異化設計。

**Layer 1 — 結構化研究輸出**

研究 agent 必須用以下格式回報每筆資料：
```
- 數據: [具體數字]
- 原文引用: "[從 WebFetch 結果逐字複製的原文]"
- 來源: [來源名稱]
- URL: [完整 URL]
- 驗證狀態: [V] 已驗證 / [S] 搜尋摘要 / [F] 讀取失敗
```

**Layer 2 — 寫作時標註**
- `[V]` 已驗證數據：直接使用
- `[S]` 搜尋摘要數據：使用但加上 `<!-- [S] 未經原文驗證 -->` 註記
- `[F]` 讀取失敗：不使用，以 `[待補充：需要關於 X 的統計數據]` 替代

**Layer 3 — 交付時揭露**

文章結尾附上驗證報告：
```markdown
## 資料來源驗證報告

| # | 數據 | 來源 | 狀態 |
|---|------|------|------|
| 1 | CTR 下降 61% | Seer Interactive | ✅ [V] 已驗證 |
| 2 | 47% 搜尋含 AI Overview | BrightEdge | ⚠️ [S] 搜尋摘要 |
| 3 | — | — | ❌ [F] 未找到相關數據 |
```

### 5.2 來源分級

| 等級 | 描述 | 範例 |
|------|------|------|
| Tier 1 | 一級研究、政府、學術 | nature.com, .gov, .edu, arxiv.org |
| Tier 2 | 權威媒體、產業研究 | reuters.com, gartner.com, mckinsey.com, statista.com |
| Tier 3 | 可靠產業來源 | 知名公司官方部落格、產業分析師 |
| Tier 4 | 不使用 | 內容農場、聯盟行銷站、匿名部落格 |

**規則：** 只使用 Tier 1-3 來源。Tier 1 來源每篇至少 1 個。

### 5.3 資料來源優先級

搜集資料時的優先順序：

1. **使用者提供的資料**（最可靠，零幻覺風險）
   - 先問使用者：「你有想引用的數據或案例嗎？」
2. **Reference 文件中的已整理數據**（如 seo-landscape.md）
   - 這些數據已整理進 reference 文件，agent 可直接讀取使用
3. **即時搜尋 + 驗證**（需要標註驗證狀態）
   - 每筆必須標註 [V]/[S]/[F]
   - 未驗證的加上 placeholder

---

## 六、變更日誌

| 日期 | 變更內容 | 影響範圍 |
|------|---------|---------|
| 2026-02-28 | v1.1 品質審計修復 | 全部 |
| | - 修復段落/句子長度不一致（統一為 60-120 字/15-25 字） | content-rules, blog-writer |
| | - 補齊觸發詞列表（+intricate, meticulous, seamlessly, 短語） | content-rules, blog-writer, STRATEGY |
| | - 修正圖片格式順序（AVIF > WebP > JPEG） | visual-media, STRATEGY |
| | - 統一內部連結數量（依字數分級） | content-rules, internal-linking, STRATEGY |
| | - 修正 E-E-A-T 權重標註為「建議權重」 | eeat-signals, STRATEGY |
| | - 修正範例文字標註為示範格式 | eeat-signals |
| | - 修正 Cloudflare 日期（2024/7 opt-in） | platform-guides, STRATEGY |
| | - 移除未驗證的 GPTBot 500M 數據 | STRATEGY |
| | - 標註 FAQPage Schema 不再生成 rich results | schema-stack, seo-landscape, STRATEGY |
| | - 加入 ImageObject Schema | schema-stack, STRATEGY |
| | - 加入所有 reference 文件交叉引用 | 所有 reference |
| | - 加入 llms.txt 指南 | platform-guides |
| | - 加入 GEO/AEO 統計來源說明和驗證狀態 | STRATEGY |
| | - 補齊模板 coverImageAlt 和圖片規劃 | 所有 templates |
| | - 修復 blog-writer：加入 Schema 輸出和觸發詞完整列表 | blog-writer |
| | - 修復 blog-researcher：加入搜尋預算、中文搜尋、WebFetch fallback | blog-researcher |
| | - 修復 blog/SKILL.md：加入 brief 路由 | blog/SKILL |
| | - 修復 smart-blog-write：加入研究不足處理 | smart-blog-write |
| 2026-02-28 | v1.0 初版建立 | 全部 |

---

## 附錄：STRATEGY.md 與 Reference 文件的對應關係

| 本文件章節 | 衍生的 Reference 文件 |
|-----------|---------------------|
| 一、SEO 核心策略 | `seo-landscape.md` |
| 二、AI 引用優化策略 | `seo-landscape.md`（共用） |
| 三、內容品質標準 | `content-rules.md` |
| 三、3.3 反 AI 偵測 | `content-rules.md`（含觸發詞列表） |
| 三、3.1 評分系統 | `content-rules.md`（含評分細則） |
| 四、4.1 Schema | `schema-stack.md` |
| 四、4.2 圖片 | `visual-media.md` |
| 四、4.3 平台規則 | `platform-guides.md` |
| 四、4.4 AI 爬蟲 | `platform-guides.md`（含爬蟲設定） |
| 五、研究與驗證 | 直接嵌入 `agents/blog-researcher.md` |
| E-E-A-T（1.2 節） | `eeat-signals.md` |
| 連結策略 | `internal-linking.md` |
| 模板相關 | `content-templates.md` |
