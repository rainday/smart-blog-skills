# Humanizer：29 個 AI 寫作模式偵測與修正

> 衍生自 [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)（WikiProject AI Cleanup）
> 和 [humanizer v2.5.1](https://github.com/blader/humanizer)（Siqi Chen, MIT）。
>
> **相關文件：** `content-rules.md`（觸發詞列表、反 AI 偵測指標）

## 使用時機

- **blog-writer**：寫完初稿後執行 humanizer pass（二次審稿）
- **rewrite**：改寫時對比 29 模式
- **analyze**：評分時掃描 29 模式，納入 AI 引用就緒度和內容品質評分

## 核心原則

LLM 使用統計算法預測下一個 token，結果傾向「最可能、最廣泛適用」的寫法。
這會產生可預測、無靈魂的文字。**移除 AI 模式只是一半工作 — 另一半是注入個性。**

---

## 5 大類 29 個模式

### A. 內容模式（1-6）

| # | 模式 | 監控詞 | 修正方式 |
|---|------|--------|---------|
| 1 | 誇大重要性 | stands as, testament, pivotal, crucial, marking a, shaping the, indelible mark | 移除裝飾，直述事實 |
| 2 | 堆砌媒體引用 | cited in, featured in, active social media | 只引一個 + 加入具體內容 |
| 3 | 表面 -ing 分析 | highlighting, emphasizing, reflecting, symbolizing, showcasing, fostering | 刪除或用具體事實展開 |
| 4 | 廣告式語言 | boasts, vibrant, profound, nestled, groundbreaking, breathtaking, stunning, renowned | 換成中性描述 |
| 5 | 模糊歸因 | Experts believe, Industry reports, Some critics argue | 換成具名來源 + 年份 |
| 6 | 套路式挑戰段 | Despite challenges... continues to thrive, Future Outlook | 用具體事實取代 |

### B. 語法模式（7-13）

| # | 模式 | 監控詞 | 修正方式 |
|---|------|--------|---------|
| 7 | AI 高頻詞 | additionally, delve, landscape, tapestry, enduring, intricate, showcase, underscore, pivotal, foster | 換成日常用語 |
| 8 | 迴避 is/are | serves as, stands as, features, boasts | 直接用「是」「有」 |
| 9 | 否定平行句 | Not just X, it's Y; Not merely; 尾部否定片段 "no guessing" | 直述正面主張 |
| 10 | 三項式濫用 | innovation, inspiration, and insights（強制湊三個） | 用自然數量，不必湊三 |
| 11 | 同義詞輪��� | protagonist → main character → central figure → hero | 重複使用同一個詞 |
| 12 | 假範圍 | from X to Y（X 和 Y 不在同一量尺上） | 直接列舉 |
| 13 | 被動語態/無主句 | No configuration needed; The results are preserved | 加入主詞，用主動語態 |

### C. 風格模式（14-19）

| # | 模式 | 監控詞 | 修正方式 |
|---|------|--------|---------|
| 14 | 破折號濫用 | —（em dash 過多） | 改用逗號、句號、括號 |
| 15 | 粗體濫用 | **字字加粗** | 只在真正需要強調時用 |
| 16 | 行內標題清單 | - **標題：** 內容 | 改成段落文字 |
| 17 | 標題全大寫 | ## Strategic Negotiations And Partnerships | 只首字母大寫 |
| 18 | 表情符號裝飾 | 🚀 💡 ✅ 在標題或列表中 | 移除（除非使用者要求） |
| 19 | 彎引號 | "..." 代替 "..." | 統一為直引號 |

### D. 溝通模式（20-22）

| # | 模式 | 監控詞 | 修正方式 |
|---|------|--------|---------|
| 20 | 聊天殘留 | I hope this helps, Of course!, Certainly!, Let me know | 完全移除 |
| 21 | 知識截止聲明 | as of [date], While details are limited, based on available information | 找到來源或移除 |
| 22 | 諂媚語氣 | Great question!, You're absolutely right!, That's an excellent point | 直接回答 |

### E. 填充與避險模式（23-29）

| # | 模式 | 監控詞 | 修正方式 |
|---|------|--------|---------|
| 23 | 填充短語 | In order to, Due to the fact that, At this point in time, It is important to note | 精簡（To, Because, Now） |
| 24 | 過度避險 | could potentially possibly, might have some effect | 選一個程度詞即可 |
| 25 | 套路正面結尾 | The future looks bright, Exciting times lie ahead, journey toward excellence | 用具體計畫取代 |
| 26 | 連字號過度一致 | cross-functional, data-driven, client-facing（全部一致連字號） | 混用，像人類不一致 |
| 27 | 說服式框架 | The real question is, At its core, What really matters, Fundamentally | 直述觀點 |
| 28 | 預告式導言 | Let's dive in, Let's explore, Here's what you need to know | 直接開始講內容 |
| 29 | 碎片式標題 | 標題後面跟一句重述標題的話再開始正文 | 刪除重述，直接正文 |

---

## Humanizer Pass 流程

### 用在 blog-writer（寫完初稿後）

1. **第一輪掃描**：對照 29 模式逐條檢查
2. **修正**：替換偵測到的模式
3. **注入個性**（見下方）
4. **反 AI 審稿**：問自己「這段文字哪裡一看就是 AI 寫的？」列出殘留問題
5. **二次修正**：根據審稿結果再改一輪

### 用在 analyze（評分時）

掃描 29 模式，計算偵測到的數量：
- 0-3 個：扣 0 分
- 4-8 個：扣 2 分（從 AI 引用就緒度）
- 9-15 個：扣 5 分
- 16+ 個：扣 8 分

---

## 注入個性（不只移除壞模式）

### 無��魂寫作的特徵（即使沒有 AI 模式）

- 每個句子長度和結構一樣
- 只有中性報導，沒有觀點
- 沒有承認不確定性
- 不使用第一人稱
- 沒有幽默、立場或個性
- 讀起來像維基百科或新聞稿

### 如何加入人味

| 技巧 | 說明 | 範例 |
|------|------|------|
| 有觀點 | 對事實做出反應，不只報導 | 「說實話我不確定這數字能信」 |
| 節奏變化 | 短句。然後來一個慢慢展開的長句。 | — |
| 承認複雜 | 真人會有矛盾感受 | 「這很厲害，但也有點令人不安」 |
| 第一人稱 | 「我」不代表不專業 | 「我反覆回來看這個數據...」 |
| 容許凌亂 | 完美結構感覺像算法 | 離題、括號旁白、半成形的想法 |
| 具體感受 | 不要「令人擔憂」 | 「凌晨三點 agent 還在跑，沒人看著，這感覺不太對」 |

---

## Voice Calibration（選用）

如果使用者提供寫作樣本（過去文章），在 humanizer pass 之前分析：

1. 句子長度模式（短而有力？長而流暢？）
2. 用詞水準（口語？學術？）
3. 段落開頭方式（直接切入？先設脈絡？）
4. 標點習慣（破折號多？括號旁白？）
5. 轉折方式（明確連接詞？直接下一點？）

然後用使用者的風格取代通用「乾淨」輸出。

---

## 與現有反 AI 規則的關係

`content-rules.md` 已有：
- 觸發詞列表（中文 10 個 + 英文 18 個 + 短語 4 個）
- 句長爆發性（Burstiness）指標
- 被動語態比例

本文件擴充為完整 29 模式，覆蓋面更廣：
- content-rules 的觸發詞 ⊂ 模式 #7（AI 高頻詞）
- content-rules 的被動語態 ⊂ 模式 #13
- 新增 22 個 content-rules 未覆蓋的模式

**建議：** analyze 評分時同時使用 content-rules（量化指標）和 humanizer-patterns（模式掃描），不重複扣分。
