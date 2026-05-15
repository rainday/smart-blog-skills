---
name: brand-mentions
description: >
  Brand mention and authority scanner for AI visibility. Analyzes brand presence across platforms
  that AI models rely on for entity recognition and citation decisions. Produces a Brand Authority
  Score (0-100) with platform-specific recommendations. Use when user says "brand mentions",
  "brand authority", "AI visibility", "brand presence", "where is my brand mentioned",
  "Reddit mentions", "YouTube mentions", "Wikipedia presence", or "GEO brand audit".
user-invokable: true
argument-hint: "<brand-name> [url]"
license: MIT
---

# Brand Mention Scanner

品牌提及分析工具，評估品牌在 AI 模型仰賴的各平台上的能見度，產出 Brand Authority Score (0-100)。

## 核心洞察

根據 Ahrefs 2025 年 12 月研究（分析 75,000 個品牌），**未連結的品牌提及**（unlinked brand mentions）對 AI 引用的預測力比傳統反向連結強約 3 倍。平台類型至關重要：YouTube 或 Reddit 上的未連結提及，往往比高 DA 部落格的 dofollow 連結更有價值。

| 信號 | 與 AI 引用的相關性 | 傳統 SEO 價值 |
|------|-------------------|--------------|
| YouTube 提及 | ~0.737（最強） | 低 |
| Reddit 提及 | 高 | 低 |
| Wikipedia 存在 | 高 | 中 |
| LinkedIn 存在 | 中 | 低 |
| Domain Rating | ~0.266 | 極高 |

---

## Brand Authority Score 計算公式

```
Brand_Authority_Score = (YouTube × 0.25) + (Reddit × 0.25) + (Wikipedia × 0.20) + (LinkedIn × 0.15) + (Other × 0.15)
```

| 分數範圍 | 評級 | 說明 |
|---------|------|------|
| 85-100 | Dominant | 各平台廣泛被認識，AI 系統極可能引用 |
| 70-84 | Strong | 跨平台存在強，AI 引用一致 |
| 50-69 | Moderate | 部分平台有缺口，AI 引用不穩定 |
| 30-49 | Weak | 平台存在薄弱，AI 不認識此實體 |
| 0-29 | Minimal | 幾乎無平台存在，AI 不會引用 |

---

## 分析流程

### Step 1: 確認品牌資訊

收集：品牌名稱（含各種拼法）、創辦人姓名、網站 URL、行業、主要產品/服務、主要競品。

### Step 2: 各平台掃描

**YouTube（權重 25%）**

用 WebFetch 或 WebSearch：
1. 搜尋 `[brand name] site:youtube.com`
2. 查 `youtube.com/@[brand-name]`（官方頻道）
3. 搜尋 `"[brand name]" site:youtube.com`（描述中的提及）

評分標準（0-100）：
| 分數 | 條件 |
|------|------|
| 90-100 | 活躍頻道 10K+ 訂閱 + 20+ 第三方影片提及 + 行業搜尋出現 |
| 70-89 | 活躍頻道 1K+ 訂閱 + 10-19 第三方提及 |
| 50-69 | 頻道存在 + 5-9 第三方提及 |
| 30-49 | 頻道存在但不活躍 + 1-4 第三方提及 |
| 10-29 | 無頻道或空頻道 + 1-2 影片提及 |
| 0-9 | 完全無 YouTube 存在 |

**Reddit（權重 25%）**

1. 搜尋 `[brand name] site:reddit.com`
2. 搜尋 `"[brand name]" site:reddit.com`（精確比對）
3. 查 `reddit.com/r/[brand-name]`（官方 subreddit）
4. 查 `reddit.com/user/[brand-name]`（官方帳號）

評分標準：
| 分數 | 條件 |
|------|------|
| 90-100 | 相關 subreddit 頻繁推薦 + 正面情緒 + 活躍官方帳號 + 5K+ 會員 subreddit |
| 70-89 | 定期提及 + 多數正面 + 部分官方存在 |
| 50-69 | 數個討論串提及 + 混合情緒 |
| 30-49 | 偶有提及 + 僅 1-2 個 subreddit |
| 10-29 | 罕見提及 |
| 0-9 | 無 Reddit 存在 |

**Wikipedia（權重 20%）**

依以下順序驗證（避免假陰性）：

1. **直接 URL 查詢**（最可靠）：WebFetch `https://en.wikipedia.org/wiki/[Brand_Name]`
2. **Wikipedia API**（備用）：WebFetch `https://en.wikipedia.org/w/api.php?action=query&list=search&srsearch=[brand]&format=json`
3. **Wikidata 查詢**：WebFetch `https://www.wikidata.org/w/api.php?action=wbsearchentities&search=[brand]&language=en&format=json`
4. **廣泛搜尋**（補充）：搜尋 `[brand name] site:wikipedia.org`

**重要：** 網路搜尋不可靠，必須用上方直接 URL 或 API 方法確認。

評分標準：
| 分數 | 條件 |
|------|------|
| 90-100 | 詳細 Wikipedia 文章（B 級以上）+ Wikidata 完整 + 多篇文章引用 |
| 70-89 | Wikipedia 文章存在（Start 級以上）+ Wikidata 存在 |
| 50-69 | Wikipedia 存在（stub）+ 基本 Wikidata |
| 30-49 | 無文章但在其他文章被引用 |
| 10-29 | 僅 1-2 篇文章中提及 |
| 0-9 | 完全無 Wikipedia/Wikidata 存在 |

**LinkedIn（權重 15%）**

1. 搜尋 `[brand name] site:linkedin.com`
2. 查 `linkedin.com/company/[brand-name]`（公司頁面）

評分標準：
| 分數 | 條件 |
|------|------|
| 90-100 | 活躍公司頁 10K+ 追蹤 + 領導層持續發文 + 業界人士頻繁提及 |
| 70-89 | 活躍頁面 5K+ 追蹤 + 部分員工思想領導力 |
| 50-69 | 頁面存在 1K+ 追蹤 + 不定期發文 |
| 30-49 | 頁面存在但稀疏或不活躍 |
| 10-29 | 基本公司頁（資訊極少） |
| 0-9 | 無 LinkedIn 公司頁 |

**Other Platforms（權重 15%）**

| 平台 | 怎麼查 | 適用類型 |
|------|--------|---------|
| Quora | `[brand] site:quora.com` | B2C、一般產品 |
| Stack Overflow | `[brand] site:stackoverflow.com` | 開發者工具 |
| GitHub | `[brand] site:github.com` | 開源、開發者 |
| Hacker News | `[brand] site:news.ycombinator.com` | 科技、SaaS |
| 新聞/媒體 | 搜尋品牌名稱，過濾近 6 個月 | 所有品牌 |
| Podcast | 搜尋品牌名稱 + podcast | 成熟品牌 |

### Step 3: 情緒評估

Reddit 和其他討論平台上的情緒：
- **正面**：推薦、正面對比競品、感謝
- **中性**：事實性提及、問題詢問
- **負面**：抱怨、警告避免
- **混合**：同時存在正負，記錄比例

### Step 4: 競品比對（選用）

若用戶提供競品，對各競品做同樣快速掃描，建立比較表格。

### Step 5: 計算分數

各平台 0-100 分 → 套用公式計算 Brand Authority Score。

---

## 輸出格式

生成 `GEO-BRAND-MENTIONS.md`：

```markdown
# Brand Authority 報告：[Brand Name]

**分析日期：** [Date]
**品牌：** [Brand Name]
**網站：** [URL]
**行業：** [Industry]

---

## Brand Authority Score：[X]/100 ([Rating])

### 各平台分數

| 平台 | 分數 | 權重 | 加權分 | 狀態 |
|------|------|------|--------|------|
| YouTube | [X]/100 | 25% | [X] | [Active/Mentioned/Absent] |
| Reddit | [X]/100 | 25% | [X] | [Active/Discussed/Absent] |
| Wikipedia | [X]/100 | 20% | [X] | [Article/Mentioned/Absent] |
| LinkedIn | [X]/100 | 15% | [X] | [Active/Basic/Absent] |
| Other | [X]/100 | 15% | [X] | [Summary] |
| **總計** | | | **[X]/100** | |

---

## 各平台詳情

[每個平台展示：官方帳號、主要發現、具體數據]

---

## 建議行動

### 立即（第 1-2 週）
1. **[Platform]：** [具體行動]

### 短期（1-3 個月）
1. **[Platform]：** [策略]

### 長期（3-12 個月）
1. **[Platform]：** [策略]

---

## 競品對比
[若有競品分析，顯示比較表]

## 關鍵洞察
[1-2 句：品牌 AI 能見度現況 + 最高影響力的單一行動]
```

---

## 快速提升各平台的方法

**YouTube 快速起步：** 上傳 3-5 支核心主題說明影片，確保品牌名稱出現在標題、描述和口語中。尋求業界 YouTube 頻道合作或客座出現。

**Reddit 快速起步：** 找出 3-5 個目標受眾活躍的 subreddit，真實參與討論（切勿刷屏），回應品牌提及。

**Wikipedia 策略：** 不要自己編輯（利益衝突）。先建立媒體曝光度和行業認可，確保 Wikidata 條目完整。

**LinkedIn 快速起步：** 優化公司頁面，鼓勵領導層每週發文，發布原創洞察。
