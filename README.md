# smart-blog-skills

**v1.2** · 2026-03-11

用 Claude 寫部落格，不怕 AI 亂掰數據。

三層反幻覺驗證、100 分品質評分、SEO + E-E-A-T + AI 引用優化。
繁體中文優先。零 Python 依賴。一行安裝。

## 安裝

### Claude Code / Claude Desktop

```
/plugin marketplace add rainday/smart-blog-skills
/plugin install smart-bl
```

安裝完成後直接使用，不需要重啟。

### 手動安裝（Antigravity / Codex CLI / 其他平台）

**macOS / Linux**

```bash
git clone https://github.com/rainday/smart-blog-skills.git && cd smart-blog-skills && chmod +x install.sh && ./install.sh
```

**Windows (PowerShell)**

```powershell
git clone https://github.com/rainday/smart-blog-skills.git; cd smart-blog-skills; .\install.ps1
```

### 選裝：agent-browser

```bash
npm install -g agent-browser
```

agent-browser 讓研究 agent 可以用真正的瀏覽器讀取網頁，大幅降低幻覺風險。
未安裝時會退回到 WebFetch（功能有限）。

---

## 4 個指令

| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:write <主題>` | 從零寫一篇新文章 |
| `/smart-blog-skills:analyze <檔案>` | 品質審計 + 100 分評分 |
| `/smart-blog-skills:rewrite <檔案>` | 優化改寫現有文章 |
| `/smart-blog-skills:outline <主題>` | 生成 SERP 導向大綱 |

> `/smart-blog-skills:outline <主題> --full` 可產出完整內容簡報（含關鍵字研究 + 競品分析）

### 建議工作流程

```
1. /smart-blog-skills:outline "主題" --full  ← 先產大綱 + 簡報
2. /smart-blog-skills:write "主題"            ← 開始寫文章
3. /smart-blog-skills:analyze ./file.md       ← 品質檢查 100 分評分
4. /smart-blog-skills:rewrite ./file.md       ← 分數不夠就改寫
```

也可以跳過 --full，直接 `/smart-blog-skills:outline` 只產大綱。

---

## 指令詳解

### `/smart-blog-skills:write <主題>` — 從零寫一篇新文章

從一個主題開始，經過研究、大綱、寫作、品質檢查，產出一篇完整的部落格文章。

```
/smart-blog-skills:write "如何用 AI 優化 SEO"
/smart-blog-skills:write "2026 年遠端工作趨勢"
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

### `/smart-blog-skills:analyze <檔案>` — 品質審計 + 100 分評分

對現有文章做全面健檢，找出問題並給出可執行的改善建議。

```
/smart-blog-skills:analyze ./posts/my-post.md
/smart-blog-skills:analyze ./content/blog/seo-guide.mdx
/smart-blog-skills:analyze ./posts/                        # 批次分析整個目錄
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

### `/smart-blog-skills:rewrite <檔案>` — 優化改寫現有文章

先分析現有文章的弱點，再針對性改善。保留作者語氣和原創內容，只修需要修的地方。

```
/smart-blog-skills:rewrite ./posts/old-post.md             # 完整改寫
/smart-blog-skills:rewrite ./posts/old-post.md --update    # 輕量更新（只更新數據和日期）
```

**流程：**

1. **分析現況** — 對原文執行 100 分評分，識別問題清單
2. **確認方向** — 呈現分析結果，**等你確認改寫方向後才繼續**
3. **保留優點** — 識別作者語氣、原創數據、好的段落，不動這些
4. **研究補充** — 如果統計過時（>12 個月）或不足（<8 個），自動補充新數據
5. **改寫** — 修正結構、補 Answer-First、替換觸發詞、加 FAQ/TL;DR
6. **交付** — 輸出改寫後的文章 + 前後分數對比

---

### `/smart-blog-skills:outline <主題>` — 生成 SERP 導向大綱

寫文章前先做功課。分析搜尋結果前 5 名的結構，找出內容缺口，產出有競爭力的文章骨架。

```
/smart-blog-skills:outline "Next.js vs Astro 比較"
/smart-blog-skills:outline "中小企業 AI 導入指南"
```

**你會得到：**

- 推薦模板和目標字數
- 完整的文章骨架（H1 → H2 → H3），含每段字數建議
- Answer-First 提示：每個 H2 需要什麼類型的統計
- 5 個 FAQ 問題建議
- 內容缺口報告：競爭者缺少什麼、我們怎麼做得不同
- E-E-A-T 規劃：推薦作者、經驗描述方向、原創性機會
- 確認後可直接銜接 `/smart-blog-skills:write` 開始寫作

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

smart-blog-skills 的 `SKILL.md` 格式與 **Antigravity（Google）** 和 **Codex CLI（OpenAI）** 原生相容 — 這三個平台共用相同的 skill 結構，安裝後可直接使用。

對於 **Cursor**、**Cline**、**Kilo Code**，smart-blog-skills 的知識庫（寫作規則、SEO 策略、模板）可以作為 rules 或 workflow 載入，但 skill 路由和 agent 呼叫需要手動適配。

| Agent | 相容程度 | 說明 |
|-------|---------|------|
| Claude Code | 原生支援 | `/plugin install` 一鍵安裝 |
| Claude Desktop | 原生支援 | `/plugin install` 一鍵安裝 |
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
├── .claude-plugin/          ← plugin 設定
│   ├── plugin.json
│   └── marketplace.json
├── STRATEGY.md              ← 策略主文件（維護用）
├── skills/
│   ├── blog/                ← 主路由器
│   │   ├── SKILL.md
│   │   ├── references/      ← 8 個知識庫文件
│   │   └── templates/       ← 5 個內容模板
│   ├── write/               ← 寫文章
│   ├── analyze/             ← 品質分析
│   ├── rewrite/             ← 改寫
│   └── outline/             ← 大綱 + 簡報
├── agents/                  ← 2 個 Agent（researcher + writer）
├── hooks/                   ← 自動化 hook
├── settings.json            ← 預設權限
├── install.sh / install.ps1 ← 手動安裝（非 Claude Code 平台）
└── uninstall.sh / uninstall.ps1
```

## 解除安裝

```bash
# macOS / Linux
chmod +x uninstall.sh && ./uninstall.sh

# Windows
.\uninstall.ps1
```

## 更新紀錄

| 版本 | 日期 | 更新內容 |
|------|------|---------|
| v1.2 | 2026-03-11 | Hook 誤觸修復：PostToolUse hook 加入路徑排除與 frontmatter 欄位驗證，避免寫入系統目錄的 .md 檔時誤觸部落格提醒 |
| v1.1 | 2026-02-28 | 品質審計修復：統一段落/句子長度規則、補齊觸發詞列表、修正圖片格式順序、統一內部連結數量 |
| v1.0 | 2026-02-28 | 初版發布 |

## 授權

MIT License
