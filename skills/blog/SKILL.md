---
name: blog
description: >
  Smart Blog 防幻覺部落格引擎。34 個子技能：寫、分析、改寫、大綱、摘要簡報、
  編輯行事曆、關鍵字重疊偵測、圖表、事實查核、FLOW 框架、AI 引用優化、圖片生成、
  多語言稽核、文化本地化、人設語氣、跨平台二創、Schema 標記、SEO 驗證、
  分類標籤、翻譯、音訊旁白、NotebookLM、策略規劃、主題群組、多語言一鍵發布、
  全站稽核、效能檢測、品質監控、llms.txt 生成、品牌提及掃描、SEO 漂移監控、
  AI 爬蟲分析、受眾研究、反向連結分析。雙重優化 Google 排名（E-E-A-T）和 AI 引用平台
  （ChatGPT、Perplexity、AI Overview）。繁體中文優先。
  Use when user says "blog", "write blog", "smart-blog", "smart blog",
  "寫文章", "部落格", "blog post", "分析文章", "改寫", "大綱", "內容簡報",
  "blog outline", "analyze blog", "rewrite blog", "blog strategy", "blog brief".
user-invokable: true
argument-hint: "[write|analyze|rewrite|outline|brief|calendar|...] [主題或檔案]"
---

# Smart Blog — 防幻覺部落格引擎

繁體中文優先的 AI 部落格寫作工具。內建反幻覺驗證，雙重優化 Google 排名與 AI 引用。

## 指令一覽

| 指令 | 功能 |
|------|------|
| `/smart-blog-skills:write <主題>` | 從零寫一篇新文章 |
| `/smart-blog-skills:analyze <檔案>` | 品質審計 + 100 分評分 |
| `/smart-blog-skills:rewrite <檔案>` | 優化改寫現有文章 |
| `/smart-blog-skills:outline <主題>` | 生成 SERP 導向大綱 + 競品分析 |
| `/smart-blog-skills:brief <主題>` | 詳細內容簡報 + 12 種模板 |
| `/smart-blog-skills:calendar [目錄]` | 編輯行事曆 + 內容衰退偵測 |
| `/smart-blog-skills:strategy <利基>` | 部落格定位與內容架構策略 |
| `/smart-blog-skills:cluster [plan\|execute] <關鍵字>` | 語意主題群組規劃 + 執行 |
| `/smart-blog-skills:seo-check <檔案>` | 發布前 SEO 驗證清單 |
| `/smart-blog-skills:schema <檔案>` | JSON-LD 結構化標記生成 |
| `/smart-blog-skills:geo <檔案>` | AI 引用就緒度稽核（0-100 分） |
| `/smart-blog-skills:image [generate\|edit\|setup] <描述>` | Gemini AI 圖片生成 |
| `/smart-blog-skills:audio [generate\|voices\|setup] <檔案>` | Gemini TTS 音訊旁白 |
| `/smart-blog-skills:repurpose <檔案>` | 跨平台二創（Twitter/X、LinkedIn、YouTube、Reddit、Email） |
| `/smart-blog-skills:factcheck <檔案>` | 統計數據驗證 |
| `/smart-blog-skills:cannibalization [目錄]` | 關鍵字重疊偵測 |
| `/smart-blog-skills:persona [create\|list\|use\|show] <名稱>` | 寫作人設管理 |
| `/smart-blog-skills:taxonomy [suggest\|sync\|audit] <檔案>` | CMS 標籤分類管理 |
| `/smart-blog-skills:translate <檔案> --to <語言碼>` | SEO 優化翻譯 |
| `/smart-blog-skills:localize <檔案> --locale <語言碼>` | 文化深度本地化 |
| `/smart-blog-skills:multilingual <主題> --languages <語言碼>` | 一鍵多語言發布 |
| `/smart-blog-skills:locale-audit [目錄]` | 多語言內容品質稽核 |
| `/smart-blog-skills:audit [目錄]` | 全站部落格健康度稽核 |
| `/smart-blog-skills:flow [find\|optimize\|win\|prompts] <主題\|URL>` | FLOW 框架（Find, Optimize, Win） |
| `/smart-blog-skills:notebooklm [ask\|discover\|library\|setup]` | Google NotebookLM 文件查詢 |
| `/smart-blog-skills:google [pagespeed\|crux\|setup] <URL>` | Google PageSpeed / CrUX 效能檢測 |
| `/smart-blog-skills:monitor [snapshot\|compare\|trend] <檔案>` | 品質監控與月度比較 |
| `/smart-blog-skills:llmstxt [analyze\|generate] <url>` | llms.txt AI 網站導引檔案生成/驗證 |
| `/smart-blog-skills:brand-mentions <品牌名稱> [url]` | 品牌在 AI 平台的提及與權威分數 |
| `/smart-blog-skills:drift [baseline\|compare\|history] <url>` | SEO 漂移監控（部署前後比較） |
| `/smart-blog-skills:crawlers <url>` | AI 爬蟲可訪問性分析（robots.txt 審計） |
| `/smart-blog-skills:customer-research [analyze\|research\|persona] <主題>` | 受眾研究與 VOC 分析 |
| `/smart-blog-skills:backlinks <url>` | 反向連結輪廓分析 |

> **注意：** `chart` 是內部技能（user-invokable: false），由 `write` 和 `rewrite` 自動呼叫，不需要直接使用。

## 指令路由

1. 解析使用者指令，辨識子指令
2. 如果沒有子指令，問使用者要做什麼
3. 路由到對應子技能：
   - `write` / `寫` / `新文章` → `write`
   - `analyze` / `分析` / `評分` → `analyze`
   - `rewrite` / `改寫` / `優化` / `update` → `rewrite`
   - `outline` / `大綱` → `outline`
   - `brief` / `簡報` / `content brief` → `brief`
   - `calendar` / `行事曆` / `schedule` → `calendar`
   - `strategy` / `策略` / `定位` → `strategy`
   - `cluster` / `主題群組` / `topic cluster` → `cluster`
   - `seo-check` / `seo check` / `SEO 驗證` → `seo-check`
   - `schema` / `結構化資料` / `json-ld` → `schema`
   - `geo` / `AI 引用` / `citation audit` → `geo`
   - `image` / `圖片` / `generate image` → `image`
   - `audio` / `音訊` / `narrate` / `tts` → `audio`
   - `repurpose` / `二創` / `社群媒體` → `repurpose`
   - `factcheck` / `事實查核` / `verify` → `factcheck`
   - `cannibalization` / `重疊` / `cannibalize` → `cannibalization`
   - `persona` / `人設` / `voice` / `tone` → `persona`
   - `taxonomy` / `tags` / `categories` / `標籤` → `taxonomy`
   - `translate` / `翻譯` / `translation` → `translate`
   - `localize` / `本地化` / `cultural adaptation` → `localize`
   - `multilingual` / `多語言` / `international` → `multilingual`
   - `locale-audit` / `多語言稽核` / `hreflang check` → `locale-audit`
   - `audit` / `全站稽核` / `site audit` → `audit`
   - `flow` / `FLOW` / `evidence-led` → `flow`
   - `notebooklm` / `notebook` / `document query` → `notebooklm`
   - `google` / `pagespeed` / `crux` / `效能` → `google`
   - `monitor` / `監控` / `追蹤` / `trend` / `snapshot` / `compare` → `monitor`
   - `llmstxt` / `llms.txt` / `AI 導引` / `AI site map` → `llmstxt`
   - `brand-mentions` / `品牌提及` / `brand authority` / `AI 能見度` → `brand-mentions`
   - `drift` / `SEO baseline` / `SEO 漂移` / `deployment check` / `部署檢查` → `drift`
   - `crawlers` / `AI crawlers` / `robots.txt` / `AI 爬蟲` / `GPTBot` → `crawlers`
   - `customer-research` / `受眾研究` / `VOC` / `ICP research` / `Reddit mining` → `customer-research`
   - `backlinks` / `反向連結` / `link profile` / `referring domains` / `anchor text` → `backlinks`

## 通用 Flag

| Flag | 說明 | 適用指令 |
|------|------|---------|
| `--force-research` | 忽略 research cache，強制重新研究 | write, rewrite, outline |
| `--pdf` | 輸出 PDF 報告（需要 Python + WeasyPrint） | analyze, monitor compare |

## 平台自動偵測

在使用者的專案目錄中偵測以下訊號：

| 偵測訊號 | 平台 | 輸出格式 |
|---------|------|---------|
| `.mdx` + `next.config` | Next.js/MDX | JSX 相容 markdown |
| `hugo.toml` / `hugo.yaml` | Hugo | 標準 markdown |
| `_config.yml` | Jekyll | 標準 markdown |
| `.astro` 檔案 | Astro | MDX 或 markdown |
| `wp-content/` | WordPress | HTML |
| `gatsby-config.js` | Gatsby | MDX |
| `.html` 檔案 | 靜態 HTML | 語義化 HTML5 |
| 無法辨識 | 預設 | 標準 markdown |

## 核心差異：反幻覺三層驗證

所有涉及網路研究的指令都內建驗證機制：

1. **研究時** — 每筆數據標註 `[V]` 已驗證 / `[S]` 搜尋摘要 / `[F]` 讀取失敗
2. **寫作時** — 只使用 `[V]` 和 `[S]` 的數據，`[F]` 用 placeholder 替代
3. **交付時** — 附上資料來源驗證報告，讓使用者確認

## 參考文件（按需載入）

- `references/seo-landscape.md` — SEO + AI 引用優化
- `references/content-rules.md` — 寫作規則 + 100 分評分
- `references/eeat-signals.md` — E-E-A-T 作者與信任指標
- `references/content-templates.md` — 5 個模板選擇指南
- `references/platform-guides.md` — 平台偵測與差異
- `references/visual-media.md` — 圖片與圖表規範
- `references/schema-stack.md` — JSON-LD Schema 範例
- `references/internal-linking.md` — 內部連結策略
- `references/research-cache.md` — Research cache 規格和過期規則
- `references/video-embeds.md` — YouTube 影片嵌入策略與 VideoObject Schema
- `references/humanizer-patterns.md` — 29 個 AI 寫作模式偵測與修正（基於 Wikipedia AI Cleanup）

## Agent

呼叫 Agent tool 時必須使用完整名稱（含 plugin prefix）：

| Agent type（呼叫時使用） | 角色 |
|--------------------------|------|
| `smart-blog-skills:blog-researcher` | 研究協調者。管理 cache + 派遣平行 sub-agents |
| `smart-blog-skills:stats-researcher` | 搜尋 + 驗證統計數據（由 blog-researcher 派遣） |
| `smart-blog-skills:image-researcher` | 搜尋圖片 + 圖表規劃（由 blog-researcher 派遣） |
| `smart-blog-skills:competitor-researcher` | SERP 分析 + 競品結構（由 blog-researcher 派遣） |
| `smart-blog-skills:blog-writer` | 寫作 + 自檢。遵循模板和寫作規則 |

