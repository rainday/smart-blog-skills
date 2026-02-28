---
name: blog
description: >
  AI 防幻覺部落格引擎。5 個指令涵蓋完整寫作流程：寫、分析、改寫、大綱、簡報。
  雙重優化 Google 排名（E-E-A-T、2025 年 12 月核心更新）和 AI 引用平台（ChatGPT、
  Perplexity、AI Overview）。內建反幻覺三層驗證、100 分品質評分、5 個內容模板。
  支援多平台自動偵測（Next.js、Hugo、Jekyll、Astro、WordPress、靜態 HTML）。
  繁體中文優先。Use when user says "blog", "write blog", "寫文章", "部落格",
  "blog post", "分析文章", "改寫", "大綱", "內容簡報", "blog outline",
  "analyze blog", "rewrite blog", "blog strategy", "content brief", "blog brief".
user-invocable: true
argument-hint: "[write|analyze|rewrite|outline|brief] [主題或檔案]"
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - WebFetch
  - WebSearch
  - Task
---

# Smart Blog — 防幻覺部落格引擎

繁體中文優先的 AI 部落格寫作工具。內建反幻覺驗證，雙重優化 Google 排名與 AI 引用。

## 指令一覽

| 指令 | 功能 |
|------|------|
| `/blog write <主題>` | 從零寫一篇新文章 |
| `/blog analyze <檔案>` | 品質審計 + 100 分評分 |
| `/blog rewrite <檔案>` | 優化改寫現有文章 |
| `/blog outline <主題>` | 生成 SERP 導向大綱 + E-E-A-T 規劃 |
| `/blog brief <主題>` | 生成完整內容簡報 |

## 指令路由

1. 解析使用者指令，辨識子指令
2. 如果沒有子指令，問使用者要做什麼
3. 路由到對應子技能：
   - `write` / `寫` → `smart-blog-write`
   - `analyze` / `分析` / `audit` → `smart-blog-analyze`
   - `rewrite` / `改寫` / `優化` / `update` → `smart-blog-rewrite`
   - `outline` / `大綱` → `smart-blog-outline`
   - `brief` / `簡報` / `策略` → `smart-blog-brief`

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

## Agent

| Agent | 角色 |
|-------|------|
| `blog-researcher` | 搜尋 + 驗證。用 agent-browser 讀取網頁，標註 [V]/[S]/[F] |
| `blog-writer` | 寫作 + 自檢。遵循模板和寫作規則，寫完後執行檢查清單 |

## 前置需求

- **agent-browser**（建議）：`npm install -g agent-browser`
  讓研究 agent 可以真正讀取網頁內容，大幅降低幻覺風險。
  未安裝時退回到 WebFetch（幻覺風險較高）。
