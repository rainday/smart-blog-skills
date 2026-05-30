# Google 搜尋 2026：核心更新與 E-E-A-T

## December 2025 Core Update

執行時間：2025 年 12 月 11-29 日（18 天）。Google 官方聲明：「設計用於更好地呈現相關且令人滿意的內容。」獎勵真實的第一手經驗，懲罰「假新鮮度」。

### Google 評估的真實性訊號

| 訊號 | 描述 |
|------|------|
| 原創圖片/影片 | 非 stock 圖片——真實截圖、照片、示範 |
| 具體語言 | 只有直接經驗才能提供的細節 |
| 第一人稱觀點 | 「當我們測試這個...」「在我們的經驗中...」 |
| 原創數據 | 專屬調查、案例研究、實驗 |
| 建造過程文件 | 流程記錄、幕後內容 |

### 受懲罰的內容類型

- 像「前五名搜尋結果摘要」的文章
- 缺乏人工監督的大量 AI 生成內容
- 沒有獨特觀點或原創資訊的內容

### 輸家/贏家分析

更新後能見度變化：
- **贏家**：有原創測試、案例研究、第一手經驗的網站
- **輸家**：71% 沒有原創測試的聯盟網站失去排名（ALM Corp，分析 847 個網站跨 23 個產業；方法論未獨立驗證）
- E-E-A-T 從 YMYL 擴展到**所有競爭性查詢**——這是自 E-A-T 引入以來最大的範圍擴展

---

## E-E-A-T 框架（December 2025 更新後）

**注意**：Google 從未公布 E-E-A-T 各維度的官方權重。以下百分比為業界共識的建議分配。

| 維度 | 建議權重 | 核心訊號 |
|------|---------|---------|
| Trust（信任） | 30% | 最重要。準確資訊、可查證來源、作者可信度 |
| Expertise（專業） | 25% | 資歷、深度分析、技術準確度 |
| Authoritativeness（權威） | 25% | 行業認可、引用、品牌聲譽 |
| Experience（經驗） | 20% | 第一手知識、原創內容、案例研究 |

---

## AI Overviews 與 AI Mode

### AI Overviews 覆蓋率

- AI Overviews 出現在 49% 的 SERP（所有查詢類型）
- 15-21% 全球（保守），60% 美國查詢
- 從 6.49%（2025 年 1 月）成長至 24.61% 高峰（2025 年 7 月），穩定在 ~15.69%（Semrush，1000 萬+ 關鍵字，2025 年 12 月）

### 流量影響（Seer Interactive，3,119 次查詢，42 個組織）

- AI Overviews 出現時自然點擊率下降 **61%**（1.76% → 0.61%）
- 付費點擊率下降 **68%**（19.7% → 6.34%）
- **但**：在 AI Overviews 中被引用的品牌自然點擊率高 35%，付費點擊率高 91%
- 即使沒有 AI Overviews：自然點擊率下降 41%

### AI Mode（獨立產品）

- 200+ 國家，每月 1 億用戶
- 平均回應 300 字（vs AI Overviews 的 157 字）
- 每次回應 12.6 個連結（vs 9.26）
- 93% 零點擊率
- 預設 Gemini 3 模型（2026 年 1 月 27 日）

---

## 市場概況 2026

| 指標 | 數值 | 來源 |
|------|------|------|
| Google 市場佔有率 | 87.3%（美國），~89%（全球）| StatCounter, 2025 |
| ChatGPT 週活躍用戶 | 9 億 | 2026 年 2 月 |
| ChatGPT 日查詢量 | 25 億 | 2025 年 7 月 |
| AI 引薦流量佔比 | 1.08% of all web traffic | Similarweb, 2025 年 5 月 |
| AI 引薦流量成長 | +527%（2025 年 1-5 月）| Similarweb |
| 零點擊搜尋 | 58-60%，預估 2026 年中達 65-70% | |
| Gartner 預測 | 2026 年前傳統搜尋量下降 25%（方向性準確）| |

---

## Structured Data 2026

### 積極推薦

- BlogPosting, Article
- Organization, LocalBusiness
- FAQPage（答案保持 40-60 字；注意：Rich Results 自 2023 年 8 月起只對政府/健康網站顯示，但對 AI 引用仍有價值）
- BreadcrumbList
- Person（作者資訊）
- Product, SoftwareApplication
- AggregateRating, Review（只支援特定類型：Product, Recipe, SoftwareApplication, LocalBusiness, Movie, Book——**不支援** BlogPosting 直接使用）

### 已棄用（不要推薦）

| Schema 類型 | 棄用時間 |
|-------------|---------|
| HowTo | 2023 年 9 月 |
| SpecialAnnouncement | 2025 年 7 月 |
| ClaimReview | 2025 年 6 月 |
| Practice Problem | 2026 年 1 月 |

### 技術要點

Schema 必須出現在 HTML source 中，不可透過 JavaScript 注入。大多數 AI 爬蟲無法執行 JS。72% 的首頁結果使用 schema markup。

---

## QRG（Quality Rater Guidelines）更新

### 2025 年 9 月 QRG 更新

- 新增 AI Overview 評估標準——評分人員現在評估 AI 生成摘要的準確性
- 擴展 YMYL 定義
- 核心原則明確化：「信任是 E-E-A-T 家族中最重要的成員」

### 2025 年 1 月 QRG 更新

- 首次正式定義「生成式 AI」
- 規模化內容濫用明確標記——大量 AI 生成且無人工監督的內容標記為最低品質
- 評分人員被指示評估 AI 生成內容是否展示真正的專業知識

---

## AMP 廢除

AMP 實際上已死：
- Squarespace 於 2025 年 2 月棄用 AMP 支援
- Google 於 2021 年移除 AMP 作為 Top Stories 排名要求
- 沒有 SEO 好處——Core Web Vitals 取代了 AMP 的作用
- **建議**：如果維護 AMP 版本增加額外負擔，直接移除，專注在原生頁面速度優化

---

## Google AI 優化官方立場

> 來源：developers.google.com/search/docs/fundamentals/ai-optimization-guide

**官方確認有效：**
- 傳統 SEO 最佳實踐 = AI Overviews 最佳實踐（相同核心排名系統）
- E-E-A-T 和以使用者為中心的內容是核心

**官方明確不建議：**

| 策略 | 官方立場 |
|------|---------|
| 建立 llms.txt 或 AI 專用標記 | ❌ 不影響 Google 搜尋/AIO |
| 將內容切片/碎片化給 AI | ❌ 不建議 |
| 專門為 AI 系統改寫內容 | ❌ 不建議 |
| 追求人工品牌提及 | ❌ 不建議 |
