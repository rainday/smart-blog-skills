# AI Slop Detection: Two-Tier Reflex Methodology

A phrase blocklist catches the obvious tells. Most AI-generated prose passes that filter and still reads like AI. The structural tics, the rhythmic flatness, the "everything is a three-clause sentence" cadence: those survive the first pass.

This reference defines a **two-tier reflex check** for editorial review. Run both passes before declaring a draft human-natural.

---

## Why two tiers

LLMs converge on a small set of safe patterns. The first thing the model reaches for is the **first-order reflex**: the genre-obvious tell. Replace it and the model reaches for the **second-order reflex**, the next-most-trained pattern that survives anti-AI guidance.

Most AI-detection passes only check the first-order pattern. The result is "anti-AI" rewrites that still read like AI because the structural pass was never run.

> **Note on terminology**: this file uses "first-order" and "second-order" for the two detection passes. Elsewhere in smart-blog-skills, "Tier 1 / Tier 2 / Tier 3" refers to *source authority*. The two namespaces are intentionally kept separate.

| Topic | First-order tell | Second-order tell that survives |
|---|---|---|
| SEO blog | "In today's digital landscape..." | Every H2 ends with a rhetorical question |
| SaaS post | "Game-changer," "Revolutionize" | Three-clause sentence rhythm, "While X, also Y" framings |
| How-to guide | "Dive into," "Unlock the potential" | Every step opens with an imperative verb identical in length |
| Listicle | "Cutting-edge," numbered fluff | Every item is ~80 words, identical structure |
| Thought leadership | "Comprehensive guide," "harness the power" | Hedge stack: "often," "typically," "may" within 20 words |

**A draft can score zero on a phrase blocklist and still be obviously AI.**

---

## First-order reflex（phrase + lexical）

這是 `blog-analyze` 和 `blog-reviewer` 已涵蓋的部分，記錄在此供參考。

**觸發詞（完整列表見 `agents/blog-reviewer.md`）：**

中文觸發詞：
- 「在當今數位時代」「值得注意的是」「深入探討」
- 「全面性指南」「無縫整合」「顛覆性」「賦能」
- 「不可或缺」「至關重要」「一站式」

英文觸發詞：
- "In today's digital landscape" / "In the ever-evolving"
- "It's important to note" / "It is worth mentioning"
- "Dive into" / "deep dive" / "delve"
- "Game-changer" / "Revolutionize" / "transformative"
- "Cutting-edge" / "state-of-the-art" / "robust"
- "Harness the power" / "Unlock the potential"
- "Leverage" (as a verb, non-financial)
- "Seamlessly" / "seamless integration"
- "Tapestry" / "rich tapestry" / "multifaceted"
- "Comprehensive guide" (in body text)
- "Furthermore" / "Moreover" (transition overload)
- Em dashes used as stylistic flourish

**Lexical signals：**
- AI 觸發詞密度 > 5 per 1,000 words（中文 > 3 per 1,000）
- Type-Token Ratio (TTR) < 0.40 on long-form
- Burstiness（句長 SD / mean）< 0.3

**First-order pass 結果：** 詞彙乾淨（phrase-clean）。必要但不充分。

---

## Second-order reflex（structural + rhythmic）

這些是 LLM 在替換明顯詞彙後的預設模式。語法 swap 無法修復這些。

### 結構性標記

1. **Question-cadence H2s** — 每個段落標題都是問句。真實長文混用問句、陳述句、名詞片語標題。標記：> 70% H2 以 `?` 結尾。

2. **"Here" opener** — 段落以 "Here's why..." / "Here are five..." 開頭。一次可接受，每 1,500 字出現 ≥ 3 次是 AI 指紋。

3. **Three-clause sentence rhythm** — 大部分句子都是 `[clause], [clause], [clause]` 格式，節奏如節拍器。標記：任何 200 字窗口內 > 50% 句子符合此結構。

4. **False-balance framing** — 反覆使用 "While X, also Y" 或 "On one hand X, on the other Y" 但沒有真實對比。標記：> 2 per 1,000 words。

5. **Hedge stacking** — 20 字內 ≥ 3 個避險詞（may/might/often/typically/generally/usually/tend to/perhaps/somewhat/likely）。

6. **Symmetric list bloat** — 編號或符號列表中，每個項目長度差 ≤ 10 字且語法結構相同。真實列表有長有短。標記：≥ 4 個項目的列表且 SD < 5 字。

7. **Wrap-up question** — 段落以 "What does this mean for [audience]?" 結尾。≥ 3 次 per post 是填充。

8. **Capsule transitions** — 每個 H2 開頭都是單詞轉折詞（"First..." "Next..." "Additionally..." "Crucially..."）。標記：> 50% H2 以轉折詞開頭。

9. **"Key insight" tell** — 句子以 "The key insight is..." 或 "What's important here is..." 開頭。直接刪除，讓句子自己說話。

10. **Listicle intro bloat** — 正式列表前有 > 250 字的「背景說明」。真實 listicle 快點進入列表。

### 韻律性指標

- **句長平坦**：任何段落內句長 SD < 4 → 標記
- **Opening-word 重複**：前 3 個最常見開頭詞佔所有句子開頭 > 25% → 標記
- **段落形狀平坦**：全文段落字數 SD < 25 → 標記

---

## 執行方式

用於 `blog-rewrite` 和 `blog-reviewer`：

1. 先執行 First-order pass（詞彙 + 觸發詞）。失敗 → 修正後重跑。
2. First-order 通過後，執行 Second-order pass。回報每個發現的模式與所在位置。
3. **只有兩個 pass 都通過才算通過。**

用於 `blog-write`（初稿生成時）：
- First-order 在生成時已透過 anti-phrase 列表強制執行。
- 完整初稿完成後，交付前執行一次 Second-order pass。

---

## 輸出格式

```
## AI Slop Detection Report

### First-order (Phrase + Lexical)
- Trigger phrases: [N found] -> [list with locations]
- AI trigger-word density: [N/1K words], [pass ≤5 / fail >5]
- TTR: [score], [pass ≥0.40 / fail <0.40]
- Burstiness: [score], [pass ≥0.3 / fail <0.3]

### Second-order (Structural + Rhythmic)
- Question-cadence H2s: [X%], [pass ≤70% / fail >70%]
- "Here" openers: [N], [pass ≤2 / fail ≥3]
- Three-clause rhythm: [X%], [pass ≤50% / fail >50%]
- False-balance framings: [N/1K words], [pass ≤2 / fail >2]
- Hedge stacking: [N windows], [pass 0 / fail any]
- Symmetric list bloat: [N lists], [pass 0 / fail any]
- Wrap-up questions: [N], [pass ≤2 / fail ≥3]
- Capsule transitions: [X%], [pass ≤50% / fail >50%]
- "Key insight" openers: [N], [pass 0 / fail any]
- Listicle intro bloat: [pre-list word count], [pass ≤250 / fail >250]
- Sentence-length flat paragraphs: [N], [pass 0 / fail any]
- Opening-word repetition: [top-3 share], [pass ≤25% / fail >25%]
- Paragraph-shape SD: [value], [pass ≥25 / fail <25]

### Verdict
First-order: [PASS / FAIL]
Second-order: [PASS / FAIL]
Overall: [PASS only if both passes clean]
```

---

## 為什麼這對排名和 AI 引用重要

- **Google December 2025 Core Update**：獎勵展示「經驗」和原創觀點的內容。Second-order 模式正是「AI 共識內容」的特徵——那些被降權的類型。
- **AI 引用**：ChatGPT 和 Perplexity 偏好可引用的、有鮮明特色的段落。Second-order tics 產生可互換的散文，沒有 AI 系統有理由比訓練它的來源更傾向引用它。

---

> 改編自 impeccable plugin v3.1.1（Paul Bakaus, Apache 2.0）的 UI slop 方法論。原始方法應用於 UI 設計陳腔濫調；此 reference 將相同思維模型應用於散文寫作。
