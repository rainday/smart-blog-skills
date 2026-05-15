---
name: backlinks
description: >
  Blog backlink profile analysis. Analyzes referring domains, anchor text distribution, toxic link
  detection, and competitor link gap. Uses free search operators and web-accessible tools. Use when
  user says "backlinks", "link profile", "referring domains", "anchor text", "toxic links",
  "link gap", "link building", "disavow", "backlink audit", or "who links to my blog".
user-invokable: true
argument-hint: "<url>"
license: MIT
---

# Backlinks — 部落格反向連結分析

## 資料來源偵測

開始分析前，確認可用的資料來源：

1. **免費搜尋操作符**（永遠可用）：`link:domain.com`（Google 已棄用，但 Bing 仍支援）
2. **Common Crawl**（免費 API）：`https://index.commoncrawl.org/` 網域級圖譜
3. **Moz 免費工具**（需帳號）：`https://moz.com/link-explorer`
4. **Ahrefs 免費功能**（需帳號）：`https://ahrefs.com/backlink-checker`
5. **Google Search Console**（若用戶已設定）：提供最準確的自有網站反向連結

若用戶有 DataForSEO MCP，則可使用 `dataforseo_backlinks_summary` 等工具獲得更豐富數據。

---

## 分析框架（7 個區段）

### 1. 輪廓概覽（Profile Overview）

收集以下指標：

| 指標 | 良好 | 警告 | 危急 |
|------|------|------|------|
| 參照網域數 | >100 | 20-100 | <20 |
| Follow 連結比例 | >60% | 40-60% | <40% |
| 網域多樣性 | 無單一網域 >5% | 1 個網域 >10% | 1 個網域 >25% |
| 趨勢 | 成長或穩定 | 緩慢下降 | 快速下降（>20%/季） |

**資料收集方式：**
- WebFetch Moz Link Explorer（若有帳號）
- WebFetch Ahrefs Backlink Checker（若有帳號）
- WebSearch `site:domain.com` 觀察索引規模
- Common Crawl API：`https://index.commoncrawl.org/CC-MAIN-2025-*/cdx/api/v1?url=domain.com&output=json`

### 2. 錨文字分佈（Anchor Text Distribution）

健康分佈基準：

| 錨文字類型 | 目標範圍 | 過度優化信號 |
|-----------|---------|------------|
| 品牌（公司名/網域） | 30-50% | <15% |
| URL / 裸連結 | 15-25% | N/A |
| 通用（「點這裡」、「了解更多」） | 10-20% | N/A |
| 精確配對關鍵字 | 3-10% | >15% |
| 部分配對關鍵字 | 5-15% | >25% |
| 長尾 / 自然語言 | 5-15% | N/A |

**警告：** 精確配對錨文字超過 15% 是 Google Penguin 風險信號。

### 3. 參照網域品質（Referring Domain Quality）

分析：
- **TLD 分佈**：.edu、.gov、.org 高權威；大量 .xyz、.info 低品質
- **國家分佈**：是否匹配目標市場；80%+ 來自無關國家 = PBN 信號
- **權威等級分佈**：健康的輪廓包含各等級網域的連結
- **Follow/Nofollow**：僅 nofollow 的網站 SEO 價值有限

### 4. 有毒連結偵測（Toxic Link Detection）

**高風險指標（立即標記）：**
- 來自已知 PBN（私人部落格網路）的連結
- 不自然的錨文字模式（來自某網域 100% 精確配對）
- 來自已被懲罰或去索引網域的連結
- 大量目錄提交（50+ 目錄連結）
- 連結農場（每頁 10K+ 出站連結）
- 付費連結模式（網域所有頁的 footer/sidebar 連結）

**中等風險指標（人工審查）：**
- 來自無關利基的連結
- 互惠連結模式
- 薄內容頁（<100 字）的連結
- 來自單一網域的過多連結（>50 條）

### 5. 按連結數排名的頁面（Top Pages by Backlinks）

識別：
- 哪些頁面吸引最多反向連結（連結磁鐵）
- 哪些頁面有高權威連結
- 哪些頁面無反向連結（內部連結機會）
- 有連結但返回 404 的頁面（重定向機會，回收連結權重）

### 6. 競品缺口分析（Competitor Gap Analysis）

**查詢方式：**
- WebSearch `link:competitor.com` 觀察連結來源
- Moz/Ahrefs 的競品比較功能（若有帳號）

輸出：
- 連結到競品但未連結到你 = 連結建立機會（前 20 個含網域權威）
- 同時連結雙方 = 驗證現有關係
- 僅連結到你 = 競爭優勢

### 7. 新增與遺失連結（New and Lost Backlinks）

**注意：** 免費工具提供的是某時間點的快照，無法追蹤連結速度趨勢。需要 Google Search Console 或付費工具才能監控新增/遺失連結。

**紅旗警示：**
- 新連結突然大增（可能是負面 SEO 攻擊）
- 大量連結突然消失（網站懲罰或內容移除）
- 連結速度 3 個月以上持續下降（內容未能吸引連結）

---

## Backlink Health Score（0-100）

| 因素 | 權重 | 資料來源（偏好順序） |
|------|------|------------------|
| 參照網域數 | 20% | GSC > Moz > Common Crawl |
| 網域品質分佈 | 20% | Moz DA 分佈 |
| 錨文字自然度 | 15% | Moz > Ahrefs 錨文字分析 |
| 有毒連結比例 | 20% | Moz Spam Score |
| 連結速度趨勢 | 10% | GSC（唯一免費來源） |
| Follow/Nofollow 比例 | 5% | Moz |
| 地理相關性 | 10% | 分析連結來源國家 |

**數據充足性門檻：**
- 4+ 因素有數據 → 產出 0-100 數字分數
- 不足 4 個因素 → 顯示 `INSUFFICIENT DATA (X/7 因素已評分)`，不產出數字分數

---

## 輸出格式

```markdown
## Backlink Health Score：[XX]/100（或 INSUFFICIENT DATA）

| 區段 | 狀態 | 分數 | 資料來源 |
|------|------|------|---------|
| 輪廓概覽 | pass/warn/fail | XX/100 | [來源] |
| 錨文字分佈 | pass/warn/fail | XX/100 | [來源] |
| 參照網域品質 | pass/warn/fail | XX/100 | [來源] |
| 有毒連結 | pass/warn/fail | XX/100 | [來源] |
| 熱門頁面 | info | N/A | [來源] |
| 連結速度 | pass/warn/fail | XX/100 | [來源] |

## 嚴重問題（立即修復）
## 高優先級（1 個月內修復）
## 中等優先級（持續改善）
## 連結建立機會（前 10）
```

---

## 連結建立策略（部落格專用）

**高投資報酬率的部落格連結策略：**

1. **原創研究** — 獨家數據、問卷、行業調查吸引天然連結
2. **資源頁連結** — 找行業資源頁面（`"useful resources" + [niche]`），請求加入
3. **競品死連結** — 找競品 404 頁面的連結，提供你的替代內容
4. **客座文章** — 在行業部落格發文，獲得帶連結的作者簡介
5. **HARO / Source Bottle** — 回應媒體記者的資料需求，獲得媒體引用

---

## 錯誤處理

| 狀況 | 處置 |
|------|------|
| 無資料來源 | 說明限制，提供可用的免費工具連結 |
| 網站太新 | 可能 <10 條反向連結，記錄並建議連結建設策略 |
| GSC 未設定 | 建議設定，說明好處 |
| 付費工具牆 | 使用可訪問的免費替代方案 |

---

## 交叉技能整合

分析完成後，可搭配：
- `/smart-blog-skills:seo-check` — 確保連結頁面的 SEO 品質
- `/smart-blog-skills:audit` — 整合反向連結分析到全站稽核
- `/smart-blog-skills:strategy` — 根據連結缺口制定內容策略
