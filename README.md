# smart-blog-skills

**v1.4** · 2026-04-06

用 Claude 寫部落格，不怕 AI 亂掰數據。

四層防線：反幻覺三層驗證 + Humanizer 29 模式反 AI 審稿。
100 分品質評分、SEO + E-E-A-T + AI 引用優化、YouTube 影片嵌入、
Google PageSpeed/CrUX 效能檢測、品質監控與月度比較、PDF 報告輸出。
繁體中文優先。

## 安裝

### Claude Code / Claude Desktop

```
/plugin marketplace add rainday/smart-blog-skills
/plugin install smart-blog-skills
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

**agent-browser**（建議）：
```bash
npm install -g agent-browser
```
讓研究 agent 可以用真正的瀏覽器讀取網頁，大幅降低幻覺風險。未安裝時退回 WebFetch。

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
不設定也可使用免費 PageSpeed（共用配額）。Config 存在 `~/.config/smart-blog-skills/`，不會進入 git。

---

## 7 個指令

所有指令都可以用 `/smart-blog-skills:` 前綴呼叫，也可以直接搜尋指令名或打 "smart-blog"。

| 指令 | 功能 | 快速搜尋 |
|------|------|---------|
| `/smart-blog-skills:blog [子指令]` | 主路由器，自動分派到子指令 | `/blog` |
| `/smart-blog-skills:write <主題>` | 從零寫一篇新文章 | `/write` |
| `/smart-blog-skills:analyze <檔案>` | 品質審計 + 100 分評分 | `/analyze` |
| `/smart-blog-skills:rewrite <檔案>` | 優化改寫現有文章 | `/rewrite` |
| `/smart-blog-skills:outline <主題>` | 生成 SERP 導向大綱 | `/outline` |
| `/smart-blog-skills:google <子指令> <URL>` | PageSpeed / CrUX 效能檢測 | `/google` |
| `/smart-blog-skills:monitor <子指令> <檔案>` | 品質監控與月度比較 | `/monitor` |

**常用 flag：**
- `--full`：outline 產出完整內容簡報（含關鍵字研究 + 競品分析）
- `--update`：rewrite 輕量更新（只更新數據和日期，保留 70%+ 原文）
- `--pdf`：analyze / monitor compare 輸出 PDF 報告
- `--force-research`：忽略 research cache，強制重新研究

### 建議工作流程

```
1. /smart-blog-skills:outline "主題" --full  ← 先產大綱 + 簡報
2. /smart-blog-skills:write "主題"            ← 寫文章（含 YouTube 嵌入 + Humanizer 審稿）
3. /smart-blog-skills:analyze ./file.md       ← 品質檢查 100 分評分
4. /smart-blog-skills:rewrite ./file.md       ← 分數不夠就改寫
5. /smart-blog-skills:monitor snapshot ./posts/ ← 建立品質快照
6. /smart-blog-skills:monitor compare ./posts/  ← 下個月比較進步
```

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

### Research Cache

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

### 英文文章

```
# 指定英文
/smart-blog-skills:write "How to Optimize for AI Search Engines"

# 系統會在主題確認時詢問語言，也可以在對話中說「用英文寫」
```

---

## 指令詳解

### write — 從零寫一篇新文章

```
/smart-blog-skills:write "如何用 AI 優化 SEO"
```

**流程：**

1. **主題確認** — 詢問目標受眾、關鍵字、字數（都有預設值，可跳過）
2. **模板選擇** — 根據主題自動匹配 8 個模板之一
3. **大綱生成** — H2/H3 結構 + 字數建議 + 圖片位置，**等你確認後才繼續**
4. **Cache 檢查** — 有未過期的研究 cache 直接使用，否則進入研究
5. **研究** — orchestrator 平行派遣 3 個 agent 搜尋統計、圖片、競品
6. **YouTube 影片發現** — 搜尋 2-3 個相關影片（品質分 60+ 才嵌入）
7. **寫作** — writer agent 撰寫 + **Humanizer Pass**（29 模式掃描 + 反 AI 審稿二次修正）
8. **交付** — 文章 + YouTube 嵌入 + VideoObject Schema + 驗證報告

### analyze — 品質審計 + 100 分評分

```
/smart-blog-skills:analyze ./posts/my-post.md
/smart-blog-skills:analyze ./posts/              # 批次分析
/smart-blog-skills:analyze ./posts/ --pdf        # 輸出 PDF 報告
```

| 類別 | 滿分 | 檢查內容 |
|------|------|---------|
| 內容品質 | 30 | 深度、可讀性、原創性、結構、參與度 |
| SEO 優化 | 25 | 標題、關鍵字佈局、內部連結、Meta 描述 |
| E-E-A-T 訊號 | 15 | 作者歸因、來源引用、信任指標、經驗訊號 |
| 技術元素 | 15 | Schema、圖片 alt、結構化資料、PageSpeed（如有設定） |
| AI 引用就緒度 | 15 | 可引用段落、Q&A 格式、Humanizer 29 模式掃描 |

等級：卓越 90+ / 優良 80+ / 及格 70+ / 待改進 60+ / 重寫 <60

### rewrite — 優化改寫

```
/smart-blog-skills:rewrite ./posts/old-post.md           # 完整改寫
/smart-blog-skills:rewrite ./posts/old-post.md --update   # 輕量更新
```

先分析弱點 → 保留作者語氣和原創內容 → 補充過時數據 → Humanizer 29 模式修正 → YouTube 影片補充 → 前後分數對比

### outline — SERP 導向大綱

```
/smart-blog-skills:outline "主題"         # 快速大綱
/smart-blog-skills:outline "主題" --full   # 完整內容簡報
```

分析 SERP 前 5 名 → 內容缺口 → 文章骨架 → E-E-A-T 規劃 → 圖片規劃
`--full` 加入：關鍵字研究 + 競品分析表 + 連結規劃 + 統計搜尋方向

---

## 四層防線：反幻覺 + 反 AI

### 反幻覺三層驗證

| 階段 | 機制 | 說明 |
|------|------|------|
| 研究時 | `[V]` / `[S]` / `[F]` 標註 | 每筆數據標記驗證狀態，絕不捏造 |
| 寫作時 | 禁用 `[F]` 數據 | 讀取失敗的數據不使用，改用 placeholder |
| 交付時 | 驗證報告 | 附上完整來源表，讓你確認 `[S]` 數據 |

- `[V]` 已驗證 — agent 成功讀取原文頁面並確認數據存在
- `[S]` 搜尋摘要 — 數據來自搜尋結果摘要，未經原文驗證
- `[F]` 讀取失敗 — 無法讀取來源頁面，數據不使用

### Humanizer 29 模式反 AI 審稿

基於 [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)，偵測並修正 5 大類 29 個 AI 寫作模式：

| 類別 | 模式數 | 範例 |
|------|--------|------|
| 內容模式 | 6 | 誇大重要性（testament, pivotal）、廣告式語言、模糊歸因 |
| 語法模式 | 7 | AI 高頻詞（delve, landscape）、迴避 is/are、同義詞輪替 |
| 風格模式 | 6 | 破折號濫用、粗體濫用、表情符號裝飾 |
| 溝通模式 | 3 | 聊天殘留（I hope this helps）、諂媚語氣 |
| 填充模式 | 7 | 填充短語（In order to）、套路結尾、預告式導言 |

**流程：** 寫完初稿 → 掃描 29 模式 → 修正 → 注入個性 → 反 AI 審稿 → 二次修正

---

## Research Cache

研究結果自動儲存在 `docs/research/{slug}/`，下次寫相同主題時直接使用。

| 資料類型 | 保鮮期 | 過期後 |
|---------|--------|--------|
| 統計數據 | 3 個月 | 自動重新搜尋 |
| 競品分析 | 1 個月 | 自動重新分析 |
| 圖片資源 | 12 個月 | 驗證 URL 後重用 |

---

## 跨平台相容性

| 平台 | 相容程度 | 說明 |
|------|---------|------|
| Claude Code | 原生支援 | `/plugin install` 一鍵安裝 |
| Claude Desktop | 原生支援 | `/plugin install` 一鍵安裝 |
| Antigravity | 原生相容 | SKILL.md 格式相同，複製到 `.agent/skills/` |
| Codex CLI | 原生相容 | SKILL.md 格式相同，複製到 `.agents/skills/` |
| Cursor | 部分相容 | references/ 可當 `.cursor/rules/` 載入 |
| Cline | 部分相容 | references/ 可當 `.clinerules/` 載入 |
| Kilo Code | 部分相容 | references/ 可當 `.kilocode/rules/` 載入 |

---

## 專案結構

```
smart-blog-skills/
├── .claude-plugin/          ← plugin 設定
│   ├── plugin.json
│   └── marketplace.json
├── STRATEGY.md              ← 策略主文件（SSoT）
├── skills/
│   ├── blog/                ← 主路由器（7 個指令入口）
│   │   ├── SKILL.md
│   │   ├── references/      ← 11 個知識庫文件
│   │   └── templates/       ← 8 個內容模板
│   ├── write/               ← 寫文章（YouTube 嵌入 + Humanizer）
│   ├── analyze/             ← 品質分析（PDF 輸出 + Monitor 同步）
│   ├── rewrite/             ← 改寫（Humanizer 29 模式修正）
│   ├── outline/             ← 大綱 + 簡報
│   ├── google/              ← PageSpeed / CrUX 效能檢測
│   └── monitor/             ← 品質監控與月度比較
├── agents/                  ← 5 個 Agent
│   ├── blog-researcher.md   ← orchestrator（派遣 3 個平行 sub-agent）
│   ├── blog-writer.md       ← 寫作 + Humanizer Pass
│   ├── stats-researcher.md  ← 統計數據搜尋 + 驗證
│   ├── image-researcher.md  ← 圖片搜尋 + 圖表規劃
│   └── competitor-researcher.md ← SERP 分析 + 競品結構
├── scripts/                 ← Python 腳本
│   └── pdf_report.py        ← Markdown → PDF（WeasyPrint）
├── hooks/                   ← 自動化 hook
├── settings.json            ← 預設權限
├── install.sh / install.ps1 ← 手動安裝
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
| v1.4 | 2026-04-06 | Humanizer 29 模式反 AI 審稿（基於 Wikipedia AI Cleanup）、YouTube 影片嵌入（srcdoc lazy-loading + VideoObject Schema）、Google PageSpeed/CrUX 整合（Tier 0/1，config 在 ~/.config/smart-blog-skills/）、品質監控 monitor（snapshot/compare/trend + docs/monitor/）、PDF 報告輸出（WeasyPrint）、所有 7 個 skill 加入 user-invocable + argument-hint + "Smart Blog" 搜尋觸發詞、Agent YAML frontmatter 標準化（model/maxTurns/tools）、SKILL.md plugin 合規性修復（移除非標準 allowed-tools） |
| v1.3 | 2026-03-28 | Research Cache 持久化 + 3 平行研究 agent + 3 新模板 |
| v1.2 | 2026-03-11 | Hook 誤觸修復 |
| v1.1 | 2026-02-28 | 品質審計修復 |
| v1.0 | 2026-02-28 | 初版發布 |

## 授權

MIT License
