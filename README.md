# smart-blog-skills

**v1.5** · 2026-05-15

用 Claude 寫部落格，不怕 AI 亂掰數據。

34 個子技能：寫作核心、SEO 分析、AI 能見度、多語言、內容策略、受眾研究、社群擴散、監控。
四層防線：反幻覺三層驗證 + Humanizer 29 模式反 AI 審稿。
100 分品質評分、E-E-A-T + AI 引用優化、YouTube 影片嵌入、PDF 報告輸出。
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

**Google API Key**（選用）：
```
/smart-blog-skills:google setup
```
設定後可使用 PageSpeed Insights（專屬配額）和 CrUX 真實用戶數據。
Config 存在 `~/.config/smart-blog-skills/`，不會進入 git。

---

## 34 個子技能

### 寫作核心

| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:write <主題>` | 從零寫一篇新文章（研究 + YouTube 嵌入 + Humanizer） |
| `/smart-blog-skills:analyze <檔案或目錄>` | 品質審計 + 100 分評分（可輸出 PDF） |
| `/smart-blog-skills:rewrite <檔案>` | 優化改寫（`--update` 輕量更新） |
| `/smart-blog-skills:outline <主題>` | SERP 導向大綱（`--full` 加入競品分析） |
| `/smart-blog-skills:brief <主題>` | 詳細內容簡報 + 12 種模板 |
| `/smart-blog-skills:factcheck <檔案>` | 統計數據驗證 |
| `/smart-blog-skills:flow <主題或URL>` | FLOW 框架（Find, Optimize, Win） |

### SEO 分析

| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:seo-check <檔案>` | 發布前 SEO 驗證清單（Pass/Fail） |
| `/smart-blog-skills:schema <檔案>` | JSON-LD 結構化標記生成（@graph 模式） |
| `/smart-blog-skills:backlinks <url>` | 反向連結輪廓分析（錨文字、毒性、競品缺口） |
| `/smart-blog-skills:cannibalization [目錄]` | 關鍵字重疊偵測 |
| `/smart-blog-skills:drift baseline|compare|history <url>` | SEO 漂移監控（部署前後比較） |

### AI 能見度

| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:geo <檔案>` | AI 引用就緒度稽核（0-100 分） |
| `/smart-blog-skills:crawlers <url>` | AI 爬蟲可訪問性分析（robots.txt 審計） |
| `/smart-blog-skills:llmstxt analyze|generate <url>` | llms.txt AI 網站導引檔案生成/驗證 |
| `/smart-blog-skills:brand-mentions <品牌> [url]` | 品牌在 AI 平台的提及與權威分數（Brand Authority Score） |

### 多語言

| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:translate <檔案> --to <語言碼>` | SEO 優化翻譯（關鍵字本地化） |
| `/smart-blog-skills:localize <檔案> --locale <語言碼>` | 文化深度本地化 |
| `/smart-blog-skills:multilingual <主題> --languages <語言碼>` | 一鍵多語言發布（含 hreflang） |
| `/smart-blog-skills:locale-audit [目錄]` | 多語言內容品質稽核 |

### 內容策略

| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:strategy <利基>` | 部落格定位與 Hub-and-Spoke 架構 |
| `/smart-blog-skills:cluster plan|execute <關鍵字>` | 語意主題群組規劃 + 執行 |
| `/smart-blog-skills:calendar [目錄]` | 編輯行事曆 + 內容衰退偵測 |
| `/smart-blog-skills:customer-research analyze|research|persona <主題>` | 受眾研究（VOC、ICP、Persona 生成） |

### 社群擴散

| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:repurpose <檔案>` | 跨平台二創（Twitter/X、LinkedIn、YouTube、Reddit、Email） |
| `/smart-blog-skills:persona create|list|use <名稱>` | 寫作人設管理（NNGroup 4 維度框架） |
| `/smart-blog-skills:taxonomy suggest|sync|audit <檔案>` | CMS 標籤分類管理（WordPress、Ghost、Strapi 等） |

### 監控 & 工具

| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:monitor snapshot|compare|trend <目錄>` | 品質監控與月度比較（可輸出 PDF） |
| `/smart-blog-skills:google pagespeed|crux <URL>` | Google PageSpeed / CrUX 效能檢測 |
| `/smart-blog-skills:audit [目錄]` | 全站部落格健康度稽核（6 個平行 agent） |
| `/smart-blog-skills:image generate|edit|setup <描述>` | Gemini AI 圖片生成 |
| `/smart-blog-skills:audio generate|voices|setup <檔案>` | Gemini TTS 音訊旁白（30 種聲音） |
| `/smart-blog-skills:notebooklm ask|discover|library` | Google NotebookLM 文件查詢 |

> `chart` 是內部技能，由 `write` 和 `rewrite` 自動呼叫，不需直接使用。

**常用 flag：**
- `--full`：outline 產出完整內容簡報
- `--update`：rewrite 輕量更新（保留 70%+ 原文）
- `--pdf`：analyze / monitor 輸出 PDF 報告
- `--force-research`：忽略 research cache，強制重新研究

---

## 工作流程

### 工作流程 1：從零寫一篇文章

```bash
# 1. 先出大綱確認方向
/smart-blog-skills:outline "如何用 AI 寫 SEO 文章" --full
# → 產出 brief.md，含競品分析、關鍵字、圖片規劃

# 2. 寫文章（自動讀取 brief，跳過大綱步驟）
/smart-blog-skills:write ai-seo-writing
# → 3 個 agent 平行研究 → 寫作 → Humanizer 29 模式審稿

# 3. 品質評分
/smart-blog-skills:analyze ./posts/ai-seo-writing.md

# 4. 分數不夠就改寫，目標 80+
/smart-blog-skills:rewrite ./posts/ai-seo-writing.md

# 5. 發布前加 Schema + SEO 驗證
/smart-blog-skills:schema ./posts/ai-seo-writing.md
/smart-blog-skills:seo-check ./posts/ai-seo-writing.md
```

### 工作流程 2：AI 能見度設定（新網站必做）

```bash
# 1. 確認 AI 爬蟲（GPTBot、ClaudeBot、PerplexityBot 等）能否訪問
/smart-blog-skills:crawlers https://myblog.com
# → 輸出: GEO-CRAWLER-ACCESS.md + 建議 robots.txt

# 2. 生成 llms.txt，告訴 AI 你的部落格結構
/smart-blog-skills:llmstxt generate https://myblog.com

# 3. 評估品牌在 AI 平台的存在（YouTube / Reddit / Wikipedia / LinkedIn）
/smart-blog-skills:brand-mentions "品牌名稱" https://myblog.com
# → Brand Authority Score (0-100)

# 4. 文章 AI 引用就緒度
/smart-blog-skills:geo ./posts/my-post.md
```

### 工作流程 3：SEO 健康監控

```bash
# 部署前：擷取基準線
/smart-blog-skills:drift baseline https://myblog.com/posts/my-post

# 部署後：偵測回歸（CRITICAL / WARNING / INFO 三層）
/smart-blog-skills:drift compare https://myblog.com/posts/my-post

# 反向連結分析
/smart-blog-skills:backlinks https://myblog.com

# 全站品質監控（每月）
/smart-blog-skills:monitor snapshot ./posts/
/smart-blog-skills:monitor compare ./posts/
```

### 工作流程 4：內容策略規劃

```bash
# 了解受眾真實需求（訪談記錄或線上研究）
/smart-blog-skills:customer-research research "你的產品利基"

# 制定部落格定位
/smart-blog-skills:strategy "SaaS 行銷部落格"

# 規劃主題群組
/smart-blog-skills:cluster plan "內容行銷"
# → Hub + Spoke 架構，cluster-plan.json

# 設定寫作人設
/smart-blog-skills:persona create "技術型 CMO"
```

### 工作流程 5：多語言發布

```bash
# 一鍵多語言（寫→翻譯→本地化→hreflang）
/smart-blog-skills:multilingual "文章主題" --languages zh-TW,en,ja

# 或逐步進行
/smart-blog-skills:translate ./posts/my-post.md --to en
/smart-blog-skills:localize ./posts/my-post-en.md --locale en-US
/smart-blog-skills:locale-audit ./posts/
```

### 工作流程 6：社群擴散

```bash
# 一篇文章拆解成多個平台
/smart-blog-skills:repurpose ./posts/my-post.md
# → Twitter 推文串 / LinkedIn 文章 / YouTube 腳本 / Reddit 貼文 / Email

# 事實查核
/smart-blog-skills:factcheck ./posts/my-post.md
```

---

## 不同文章類型示例

```bash
# 教學文（自動匹配 how-to-guide 模板）
/smart-blog-skills:write "如何設定 Next.js 的 ISR"

# 比較文（自動匹配 comparison 模板）
/smart-blog-skills:write "Tailwind CSS vs Bootstrap 2026 比較"

# 排行文（自動匹配 listicle 模板）
/smart-blog-skills:write "2026 年 10 個最佳 AI 寫作工具"

# 案例分析（自動匹配 case-study 模板）
/smart-blog-skills:write "某電商如何用 SEO 三個月提升 200% 流量"

# 主題指南（自動匹配 pillar-page 模板）
/smart-blog-skills:write "2026 年完整 SEO 指南"

# 基準測試報告（自動匹配 benchmark-report 模板）
/smart-blog-skills:write "AI 寫作工具效能實測：品質與速度比較"
```

---

## 四層防線：反幻覺 + 反 AI

### 反幻覺三層驗證

| 階段 | 機制 | 說明 |
|------|------|------|
| 研究時 | `[V]` / `[S]` / `[F]` 標註 | 每筆數據標記驗證狀態，絕不捏造 |
| 寫作時 | 禁用 `[F]` 數據 | 讀取失敗的數據改用 placeholder |
| 交付時 | 驗證報告 | 附上完整來源表，讓你確認 `[S]` 數據 |

- `[V]` 已驗證 — agent 成功讀取原文頁面並確認數據存在
- `[S]` 搜尋摘要 — 數據來自搜尋結果摘要，未經原文驗證
- `[F]` 讀取失敗 — 無法讀取來源頁面，數據不使用

### Humanizer 29 模式反 AI 審稿

基於 [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)，偵測並修正 5 大類 29 個 AI 寫作模式。

| 類別 | 模式數 | 範例 |
|------|--------|------|
| 內容模式 | 6 | 誇大重要性、廣告式語言、模糊歸因 |
| 語法模式 | 7 | AI 高頻詞（delve, landscape）、同義詞輪替 |
| 風格模式 | 6 | 破折號濫用、粗體濫用 |
| 溝通模式 | 3 | 諂媚語氣、聊天殘留 |
| 填充模式 | 7 | 套路結尾、預告式導言 |

---

## Research Cache

研究結果自動儲存在 `docs/research/{slug}/`，下次寫相同主題時直接使用。

| 資料類型 | 保鮮期 | 過期後 |
|---------|--------|--------|
| 統計數據 | 3 個月 | 自動重新搜尋 |
| 競品分析 | 1 個月 | 自動重新分析 |
| 圖片資源 | 12 個月 | 驗證 URL 後重用 |

---

## Agent 架構

```
write / rewrite
  └→ blog-researcher (orchestrator, Agent tool)
       ├→ stats-researcher      ← 平行執行
       ├→ image-researcher      ← 平行執行
       └→ competitor-researcher ← 平行執行
  └→ blog-writer (含 Humanizer Pass)

analyze → blog-reviewer
translate / multilingual → blog-translator
seo-check / backlinks → blog-seo
```

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

---

## 專案結構

```
smart-blog-skills/
├── .claude-plugin/          ← plugin 設定
│   ├── plugin.json
│   └── marketplace.json
├── skills/
│   ├── blog/                ← 主路由器（34 個子技能入口）
│   │   ├── SKILL.md
│   │   ├── references/      ← 11 個知識庫文件
│   │   └── templates/       ← 8 個內容模板
│   ├── write/               ← 寫文章
│   ├── analyze/             ← 品質分析（PDF 輸出）
│   ├── rewrite/             ← 改寫（Humanizer 29 模式）
│   ├── outline/             ← 大綱 + 簡報
│   ├── brief/               ← 詳細內容簡報
│   ├── factcheck/           ← 統計數據驗證
│   ├── flow/                ← FLOW 框架
│   ├── seo-check/           ← 發布前 SEO 驗證
│   ├── schema/              ← JSON-LD 結構化標記
│   ├── backlinks/           ← 反向連結分析
│   ├── cannibalization/     ← 關鍵字重疊偵測
│   ├── drift/               ← SEO 漂移監控
│   ├── geo/                 ← AI 引用就緒度
│   ├── crawlers/            ← AI 爬蟲訪問分析
│   ├── llmstxt/             ← llms.txt 生成/驗證
│   ├── brand-mentions/      ← 品牌 AI 能見度評分
│   ├── translate/           ← SEO 優化翻譯
│   ├── localize/            ← 文化本地化
│   ├── multilingual/        ← 一鍵多語言
│   ├── locale-audit/        ← 多語言品質稽核
│   ├── strategy/            ← 部落格定位策略
│   ├── cluster/             ← 主題群組規劃
│   ├── calendar/            ← 編輯行事曆
│   ├── customer-research/   ← 受眾研究與 VOC
│   ├── repurpose/           ← 跨平台二創
│   ├── persona/             ← 寫作人設管理
│   ├── taxonomy/            ← CMS 標籤分類
│   ├── monitor/             ← 品質監控
│   ├── google/              ← PageSpeed / CrUX
│   ├── audit/               ← 全站稽核
│   ├── image/               ← AI 圖片生成
│   ├── audio/               ← TTS 音訊旁白
│   ├── notebooklm/          ← NotebookLM 查詢
│   └── chart/               ← 圖表生成（內部，自動呼叫）
├── agents/                  ← 8 個 Agent
│   ├── blog-researcher.md   ← orchestrator（派遣 3 個平行 sub-agent）
│   ├── blog-writer.md       ← 寫作 + Humanizer Pass
│   ├── blog-reviewer.md     ← 100 分品質評分
│   ├── blog-seo.md          ← SEO 分析
│   ├── blog-translator.md   ← 翻譯與本地化
│   ├── stats-researcher.md  ← 統計數據搜尋 + 驗證
│   ├── image-researcher.md  ← 圖片搜尋 + 圖表規劃
│   └── competitor-researcher.md ← SERP 分析 + 競品結構
├── scripts/
│   └── pdf_report.py        ← Markdown → PDF（WeasyPrint）
├── hooks/                   ← 自動化 hook
├── settings.json
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

---

## 更新紀錄

| 版本 | 日期 | 更新內容 |
|------|------|---------|
| v1.5 | 2026-05-15 | 新增 27 個子技能：llmstxt、brand-mentions、drift、crawlers、customer-research、backlinks、persona、repurpose、schema、seo-check、taxonomy、translate、localize、multilingual、locale-audit、audit、strategy、cluster、brief、calendar、factcheck、flow、notebooklm、google、monitor、image、audio。新增 3 個 agent：blog-reviewer、blog-seo、blog-translator。修正全部 user-invokable 拼字。更新 plugin.json 和 README。 |
| v1.4 | 2026-04-06 | Humanizer 29 模式反 AI 審稿、YouTube 影片嵌入、Google PageSpeed/CrUX 整合、品質監控 monitor、PDF 報告輸出 |
| v1.3 | 2026-03-28 | Research Cache 持久化 + 3 平行研究 agent + 3 新模板 |
| v1.2 | 2026-03-11 | Hook 誤觸修復 |
| v1.1 | 2026-02-28 | 品質審計修復 |
| v1.0 | 2026-02-28 | 初版發布 |

## 授權

MIT License
