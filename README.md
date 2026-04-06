# smart-blog-skills

**v1.4** · 2026-04-06

用 Claude 寫部���格，不怕 AI 亂掰���據。

三層反幻覺驗證、100 分品質評分、SEO + E-E-A-T + AI 引用優化。
YouTube 影片嵌入、Google PageSpeed/CrUX 效能檢測、品質監控與月度比較、PDF 報告輸出。
繁體中文優先。一行安��。

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

### 選裝

**agent-browser**（��議）：
```bash
npm install -g agent-browser
```
讓研究 agent 可以用真正的瀏覽器讀取網��，大幅降低幻覺風險。未安裝時退回 WebFetch。

**PDF 報告**（選用）：
```bash
pip install weasyprint markdown
```
讓 analyze 和 monitor 可以輸出 PDF 報告。未安裝時輸出 Markdown。

**Google API Key**（選用）：
```
/smart-blog-skills:google setup
```
設定後可使用 PageSpeed Insights（專屬配額）和 CrUX 真實用戶數據。
不設定也可使用免費 PageSpeed（共用配額）。Config 存在 `~/.config/smart-blog-skills/`。

---

## 6 個指令

| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:write <主題>` | 從零寫一篇新文章（含 YouTube 嵌入） |
| `/smart-blog-skills:analyze <檔案>` | 品質審計 + 100 分評分 |
| `/smart-blog-skills:rewrite <檔案>` | 優化改寫現有文章 |
| `/smart-blog-skills:outline <主題>` | 生成 SERP 導向大綱 |
| `/smart-blog-skills:google <pagespeed\|crux\|setup> <URL>` | PageSpeed / CrUX 效能檢測 |
| `/smart-blog-skills:monitor <snapshot\|compare\|trend> <檔案>` | 品質監控與月度比較 |

> `/smart-blog-skills:outline <主題> --full` 可產出完整內容簡報（含關鍵字研究 + 競品分析）
> `/smart-blog-skills:analyze <檔案> --pdf` 可輸出 PDF 報告（需 Python + WeasyPrint）

### 建議工作流程

```
1. /smart-blog-skills:outline "主題" --full  ← 先產大綱 + 簡報
2. /smart-blog-skills:write "主題"            ← 開始寫文章（自動嵌入 YouTube 影片）
3. /smart-blog-skills:analyze ./file.md       ← 品質檢查 100 分評分
4. /smart-blog-skills:rewrite ./file.md       ← 分數���夠就改寫
5. /smart-blog-skills:monitor snapshot ./posts/ ← 建立品質快照
6. /smart-blog-skills:monitor compare ./posts/  ← 下個月比較進步
```

也可以跳過 --full，直接 `/smart-blog-skills:outline` 只產大綱。

---

## 使用範例

### 從零開始寫一篇文章

```
/smart-blog-skills:outline "如何用 AI 優化 SEO" --full
```

系統會分析 SERP 前 5 名、產出完整大綱 + 關鍵字研究 + 競品分析，存入 `docs/smart-blog/ai-seo-optimization.brief.md`。確認後：

```
/smart-blog-skills:write ai-seo-optimization
```

自動讀取 brief，跳過大綱步驟，直接進入研究和寫作。

### 不同文章類型

```
# 教學文（自動匹配 how-to-guide 模板）
/smart-blog-skills:write "如何設定 Next.js 的 ISR"

# 比較文（自動匹配 comparison 模板）
/smart-blog-skills:write "Tailwind CSS vs Bootstrap 2026 比較"

# 排行文（自動匹配 listicle 模板）
/smart-blog-skills:write "2026 年 10 個最佳 AI 寫作工具"

# 新聞分析（自動匹配 news-analysis 模板）
/smart-blog-skills:write "Google 2026 年 3 月核心更新影響分析"

# 基準測試報告（自動匹配 benchmark-report 模板）
/smart-blog-skills:write "AI 寫作工具效能實測：品質與速度比較"

# 專家訪談（自動匹配 interview 模板）
/smart-blog-skills:write "專訪 Vercel CEO：AI 對前端開發的影響"

# 案例分析（自動匹配 case-study 模板）
/smart-blog-skills:write "某電商如何用 SEO 三個月提升 200% 流量"

# 主題指南（自動匹配 pillar-page 模板）
/smart-blog-skills:write "2026 年完整 SEO 指南"
```

### 分析和改寫現有文章

```
# 分析單篇文章
/smart-blog-skills:analyze ./posts/my-old-post.md

# 批次分析整個目錄
/smart-blog-skills:analyze ./posts/

# 改寫低分文章（完整改寫）
/smart-blog-skills:rewrite ./posts/my-old-post.md

# 輕量更新（只更新過時數據和日期，保留 70%+ 原文）
/smart-blog-skills:rewrite ./posts/my-old-post.md --update
```

### Research Cache 使用

```
# 第一次寫 AI SEO 主題 → 完整研究，結果自動存入 docs/research/ai-seo-optimization/
/smart-blog-skills:write "AI SEO 優化策略"

# 兩週後寫相關主題 → cache 仍新鮮，跳過研究直接寫作
/smart-blog-skills:write "AI SEO 實戰技巧"

# 四個月後更新文章 → cache 統計數據已過期，只重新搜尋統計，圖片沿用
/smart-blog-skills:rewrite ./posts/ai-seo.md

# 強制重新研究（忽略 cache）
/smart-blog-skills:write "AI SEO 優化策略" --force-research
```

### Google PageSpeed 檢測

```
# 設定 API Key（選用，不設定也能用免費版）
/smart-blog-skills:google setup

# 檢測頁面效能
/smart-blog-skills:google pagespeed https://example.com/blog/my-post

# CrUX 真實用戶數據（需要 API Key）
/smart-blog-skills:google crux https://example.com
```

### 品質監控

```
# 建立品質快照
/smart-blog-skills:monitor snapshot ./posts/

# 下個月建立新快照後，比較變化
/smart-blog-skills:monitor compare ./posts/

# 查看歷史趨勢
/smart-blog-skills:monitor trend ./posts/
```

### 英文文��

```
# 指定英文
/smart-blog-skills:write "How to Optimize for AI Search Engines"

# 系統會在主題確認時詢問語言，也可以在對話中說「用英文寫」
```

### 只產大綱不寫文章

```
# 快速大綱（不含競品分析）
/smart-blog-skills:outline "遠端工作生產力工具推薦"

# 完整內容簡報（含關鍵字研究 + 競品分析 + 圖片規劃）
/smart-blog-skills:outline "遠端工作生產力工具推薦" --full
```

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
4. **Cache 檢查** — 如有未過期的研究 cache 直接使用，否則進入研究階段
5. **研究** — orchestrator 平行派遣 3 個 researcher agent 搜尋統計、圖片、競品
6. **寫作** — writer agent 根據大綱和研究報告撰寫
7. **交付** — 輸出完成的文章 + 驗證報告

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

## Research Cache

研究結果自動儲存在 `docs/research/{slug}/`，下次寫相同主題時直接使用 cache，不需重複搜尋。

| 資料類型 | 保鮮期 | 過期後 |
|---------|--------|--------|
| 統計數據 | 3 個月 | 自動重新搜尋 |
| 競品分析 | 1 個月 | 自動重新分析 |
| 圖片資源 | 12 個月 | 驗證 URL 後重用 |

- `--force-research` flag 可忽略 cache 強制重新研究
- 適用指令：write、rewrite、outline

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
│   │   ├── references/      ← 10 個知識庫文件（含 video-embeds.md）
│   │   └── templates/       ← 8 個內容模板
│   ├── write/               ← 寫文章（含 YouTube 嵌入）
│   ├── analyze/             ← 品質分析（支援 PDF 輸出）
│   ├── rewrite/             ← 改寫
│   ├── outline/             ← 大綱 + 簡報
│   ├── google/              ← PageSpeed / CrUX 效能檢測
│   └── monitor/             ← 品質監控與月度比較
├── agents/                  ← 5 個 Agent（orchestrator + 3 researchers + writer）
├── scripts/                 ← Python 腳本（PDF 報告等）
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

| ��本 | 日期 | 更新內容 |
|------|------|---------|
| v1.4 | 2026-04-06 | YouTube 影片嵌入（srcdoc lazy-loading + VideoObject Schema）、Google PageSpeed/CrUX 整合（Tier 0/1）、品質監控 monitor（snapshot/compare/trend + docs/monitor/ 共用資料）、PDF 報告輸出（WeasyPrint）、Agent YAML frontmatter 標準化、SKILL.md plugin 合規性修復 |
| v1.3 | 2026-03-28 | Research Cache 持久化 + 3 平行研究 agent + 3 新模板（news-analysis, benchmark-report, interview）|
| v1.2 | 2026-03-11 | Hook 誤觸修復：PostToolUse hook 加入路徑排除與 frontmatter 欄位驗證，避免寫入系統目錄的 .md 檔時誤觸部落格提醒 |
| v1.1 | 2026-02-28 | 品質審計修復：統一段落/句子長度規則、補齊觸發詞列表、修正圖片格式順序、統一內部連結數量 |
| v1.0 | 2026-02-28 | 初版發布 |

## 授權

MIT License
