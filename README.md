# smart-blog

用 Claude Code 寫部落格，不怕 AI 亂掰數據。

繁體中文優先。零 Python 依賴。一行安裝。

## 安裝

複製下面這行貼到 Claude Code 裡，讓 agent 幫你安裝：

```
從 https://github.com/rainday/smart-blog-skills 安裝 smart-blog skill。請 clone repo 後執行安裝腳本。
```

或手動安裝：

**macOS / Linux**

```bash
git clone https://github.com/rainday/smart-blog-skills.git && cd smart-blog-skills && chmod +x install.sh && ./install.sh
```

**Windows (PowerShell)**

```powershell
git clone https://github.com/rainday/smart-blog-skills.git; cd smart-blog-skills; .\install.ps1
```

安裝完成後重啟 Claude Code，輸入 `/blog` 開始使用。

### 建議：安裝 agent-browser

```bash
npm install -g agent-browser
```

agent-browser 讓研究 agent 可以用真正的瀏覽器讀取網頁，大幅降低幻覺風險。
未安裝時會退回到 WebFetch（功能有限）。

---

## 5 個指令

| 指令 | 功能 |
|------|------|
| `/blog write <主題>` | 從零寫一篇新文章 |
| `/blog analyze <檔案>` | 品質審計 + 100 分評分 |
| `/blog rewrite <檔案>` | 優化改寫現有文章 |
| `/blog outline <主題>` | 生成 SERP 導向大綱 |
| `/blog brief <主題>` | 生成完整內容簡報 |

### 建議工作流程

```
1. /blog brief "主題"      ← 先產內容簡報（關鍵字 + 競品 + 大綱）
2. /blog write "主題"       ← 開始寫文章
3. /blog analyze ./file.md  ← 品質檢查 100 分評分
4. /blog rewrite ./file.md  ← 分數不夠就改寫
```

也可以跳過 brief，直接 `/blog write` — write 指令內建會產大綱讓你確認。

---

## 指令詳解

### `/blog write <主題>` — 從零寫一篇新文章

從一個主題開始，經過研究、大綱、寫作、品質檢查，產出一篇完整的部落格文章。

```
/blog write "如何用 AI 優化 SEO"
/blog write "2026 年遠端工作趨勢"
```

**流程：**

1. **主題確認** — 你提供主題，系統詢問目標受眾、關鍵字、字數（都有預設值，可直接跳過）
2. **模板選擇** — 根據主題自動匹配模板（「如何...」→ how-to-guide、「X vs Y」→ comparison 等）
3. **大綱生成** — 產出 H2/H3 結構、每段字數建議、圖片位置，**等你確認後才繼續**
4. **研究** — researcher agent 上網搜尋 8-12 個統計數據 + 封面圖 + 內文圖，每筆標註驗證狀態
5. **寫作** — writer agent 根據大綱和研究報告撰寫，遵循 Answer-First 格式、反 AI 偵測規則
6. **交付** — 輸出完成的文章 + 驗證報告

**你會得到：**

- 一篇 2,000-2,500 字（可自訂）的完整文章，含 YAML frontmatter
- 每個 H2 段落開頭都有統計數據支撐（Answer-First 格式）
- TL;DR 摘要、FAQ 段落、圖片/圖表標記、內部連結 placeholder
- 資料來源驗證報告：列出每筆數據的來源和 `[V]`/`[S]` 狀態
- 待辦清單：哪些 `[S]` 數據需要你二次確認、哪些 placeholder 需要替換

---

### `/blog analyze <檔案>` — 品質審計 + 100 分評分

對現有文章做全面健檢，找出問題並給出可執行的改善建議。

```
/blog analyze ./posts/my-post.md
/blog analyze ./content/blog/seo-guide.mdx
/blog analyze ./posts/                        # 批次分析整個目錄
```

**分析項目：**

| 類別 | 滿分 | 檢查內容 |
|------|------|---------|
| 內容品質 | 30 | 深度、可讀性、原創性、結構、參與度 |
| SEO 優化 | 25 | 標題、關鍵字佈局、內部連結、Meta 描述、URL |
| E-E-A-T 訊號 | 15 | 作者歸因、來源引用、信任指標、經驗訊號 |
| 技術元素 | 15 | Schema、圖片 alt、結構化資料、頁面速度 |
| AI 引用就緒度 | 15 | 可引用段落、Q&A 格式、實體清晰度、TL;DR |

**你會得到：**

- **總分 N/100** 和等級（卓越 90+ / 優良 80+ / 及格 70+ / 待改進 60+ / 重寫 <60）
- **AI 內容偵測**：句長爆發性、觸發詞密度、被動語態比例
- **問題清單**：按嚴重度排序（🔴 致命 → 🟡 高 → 🟠 中）
- **前 3 個改善建議**：最有影響力的改善行動

---

### `/blog rewrite <檔案>` — 優化改寫現有文章

先分析現有文章的弱點，再針對性改善。保留作者語氣和原創內容，只修需要修的地方。

```
/blog rewrite ./posts/old-post.md             # 完整改寫
/blog rewrite ./posts/old-post.md --update    # 輕量更新（只更新數據和日期）
```

**流程：**

1. **分析現況** — 對原文執行 100 分評分，識別問題清單
2. **確認方向** — 呈現分析結果，**等你確認改寫方向後才繼續**
3. **保留優點** — 識別作者語氣、原創數據、好的段落，不動這些
4. **研究補充** — 如果統計過時（>12 個月）或不足（<8 個），自動補充新數據
5. **改寫** — 修正結構、補 Answer-First、替換觸發詞、加 FAQ/TL;DR
6. **交付** — 輸出改寫後的文章 + 前後分數對比

---

### `/blog outline <主題>` — 生成 SERP 導向大綱

寫文章前先做功課。分析搜尋結果前 5 名的結構，找出內容缺口，產出有競爭力的文章骨架。

```
/blog outline "Next.js vs Astro 比較"
/blog outline "中小企業 AI 導入指南"
```

**你會得到：**

- 推薦模板和目標字數
- 完整的文章骨架（H1 → H2 → H3），含每段字數建議
- Answer-First 提示：每個 H2 需要什麼類型的統計
- 5 個 FAQ 問題建議
- 內容缺口報告：競爭者缺少什麼、我們怎麼做得不同
- E-E-A-T 規劃：推薦作者、經驗描述方向、原創性機會
- 確認後可直接銜接 `/blog write` 開始寫作

---

### `/blog brief <主題>` — 生成完整內容簡報

比 outline 更完整的前置作業。包含關鍵字研究、競品分析、模板推薦、大綱、統計需求和圖片規劃。適合交給寫手或團隊執行。

```
/blog brief "電商 SEO 完整攻略"
/blog brief "AI 客服導入指南"
```

**你會得到：**

- 關鍵字策略：主要關鍵字 + 長尾關鍵字 + 搜尋意圖
- 競品分析表：前 3-5 名的結構、字數、差異化機會
- 推薦模板和目標字數
- 完整文章大綱（同 outline 格式）
- 統計數據搜尋方向（8-12 個）
- 視覺元素規劃：封面圖 + 內文圖 + 圖表
- E-E-A-T 和內部連結規劃
- 確認後可直接進入 `/blog write` 寫作

---

## 反幻覺機制

所有涉及網路研究的指令都內建三層驗證：

| 階段 | 機制 | 說明 |
|------|------|------|
| 研究時 | `[V]` / `[S]` / `[F]` 標註 | researcher agent 對每筆數據標記驗證狀態 |
| 寫作時 | 禁用 `[F]` 數據 | 讀取失敗的數據不會出現在文章中，改用 placeholder |
| 交付時 | 驗證報告 | 附上完整的資料來源表，讓你確認 `[S]` 標記的數據 |

- `[V]` 已驗證 — agent 成功讀取原文頁面並確認數據存在
- `[S]` 搜尋摘要 — 數據來自搜尋結果摘要，未經原文驗證
- `[F]` 讀取失敗 — 無法讀取來源頁面，數據不使用

---

## 跨 Agent 相容性

smart-blog 的 `SKILL.md` 格式與 **Antigravity（Google）** 和 **Codex CLI（OpenAI）** 原生相容 — 這三個平台共用相同的 skill 結構，安裝後可直接使用。

對於 **Cursor**、**Cline**、**Kilo Code**，smart-blog 的知識庫（寫作規則、SEO 策略、模板）可以作為 rules 或 workflow 載入，但 skill 路由和 agent 呼叫需要手動適配。

| Agent | 相容程度 | 說明 |
|-------|---------|------|
| Claude Code | 原生支援 | `install.sh` 一鍵安裝 |
| Antigravity | 原生相容 | SKILL.md 格式相同，複製到 `.agent/skills/` 即可 |
| Codex CLI | 原生相容 | SKILL.md 格式相同，複製到 `.agents/skills/` 即可 |
| Cursor | 部分相容 | references/ 可當 `.cursor/rules/` 載入，需手動建 commands |
| Cline | 部分相容 | references/ 可當 `.clinerules/` 載入 |
| Kilo Code | 部分相容 | references/ 可當 `.kilocode/rules/` 載入，workflow 需轉換 |

> Antigravity 和 Codex CLI 的相容性基於 2026 年 2 月的官方文件確認。Cursor / Cline / Kilo Code 的適配方式為根據各平台 rules 機制的建議做法。

---

## 專案結構

```
smart-blog-skills/
├── STRATEGY.md              ← 策略主文件（維護用）
├── blog/
│   ├── SKILL.md             ← 主路由器
│   ├── references/          ← 8 個知識庫文件
│   └── templates/           ← 5 個內容模板
├── skills/                  ← 5 個子技能
├── agents/                  ← 2 個 Agent（researcher + writer）
├── install.sh / install.ps1
└── uninstall.sh / uninstall.ps1
```

## 解除安裝

```bash
# macOS / Linux
chmod +x uninstall.sh && ./uninstall.sh

# Windows
.\uninstall.ps1
```

## 授權

MIT License
