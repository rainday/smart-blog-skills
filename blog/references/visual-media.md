# 視覺媒體指南

> 衍生自 STRATEGY.md 4.2 節。圖片來源、SVG 圖表、Alt 文字規範。
>
> **相關文件：** `platform-guides.md`（各平台 SVG 屬性差異）、`content-templates.md`（各模板圖片密度）

## 圖片來源（免費商用授權）

| 優先級 | 平台 | 搜尋方式 | 直接 URL 格式 |
|--------|------|---------|--------------|
| 1 | Pixabay | `site:pixabay.com [關鍵字]` | `https://cdn.pixabay.com/photo/...` |
| 2 | Unsplash | `site:unsplash.com [關鍵字]` | `https://images.unsplash.com/photo-<id>?w=1200&h=630&fit=crop&q=80` |
| 3 | Pexels | `site:pexels.com [關鍵字]` | 從頁面提取直接 URL |

### 圖片規格

| 用途 | 尺寸 | 注意事項 |
|------|------|---------|
| 封面圖 / OG Image | 1200x630 | 不可 lazy load |
| 內文圖 | 寬度 ≥800px | 可 lazy load |
| 格式優先 | AVIF > WebP > JPEG | AVIF 比 JPEG 小 50%，WebP 瀏覽器支援度較高 |

### 圖片密度（每篇文章）

| 內容類型 | 圖片數量 | 約每 N 字一張 |
|---------|---------|-------------|
| 教學指南 | 4-6 | 每 400 字 |
| 排行榜 | 項目數 | 每個項目一張 |
| 比較文 | 3-4 | 每 500 字 |
| 長篇指南 | 6-8 | 每 500 字 |
| 案例研究 | 3-5 | 每 500 字 |

### Alt 文字規範

- 用完整描述句（不是關鍵字堆疊）
- 自然包含主題關鍵字
- 描述圖片內容和語境

**好的：** `「SEO 優化前後的自然搜尋流量對比圖表，顯示 3 個月內流量成長 150%」`
**不好的：** `「SEO SEO優化 搜尋引擎優化 流量」`

---

## SVG 圖表（內建生成）

### 可用圖表類型

| 類型 | 適用場景 | 範例 |
|------|---------|------|
| bar | 單一維度比較 | 各工具的市佔率 |
| grouped bar | 多維度比較（前後對比） | 優化前後的指標 |
| donut | 佔比分佈 | 流量來源比例 |
| line | 時間趨勢 | 月流量變化 |
| lollipop | 排名或差異 | 各策略的效果排名 |
| area | 累積趨勢 | 總流量成長曲線 |
| radar | 多維度評分 | 5 大品質維度比較 |

### 使用規則

- 每篇 2-4 個圖表
- **不可重複相同類型**（多樣性規則）
- 均勻分佈，不要集中在一處
- 每個圖表必須有 `<figcaption>` 標註來源

### 樣式規則

- 用 `currentColor` 讓文字顏色跟隨主題（深色/淺色模式）
- `viewBox="0 0 560 380"` 標準尺寸
- WCAG 無障礙：色彩對比度 ≥ 4.5:1
- 不依賴顏色區分資訊（同時用形狀或標籤）

### 平台差異

| 平台 | SVG 屬性格式 |
|------|-------------|
| Next.js / MDX / React | camelCase：`viewBox`, `strokeWidth`, `className` |
| Hugo / Jekyll / HTML | 標準 SVG 屬性：`viewBox`, `strokeWidth`（SVG 屬性不受平台影響，永遠用原生格式） |

### 圖表嵌入格式

```html
<figure>
  <svg viewBox="0 0 560 380" xmlns="http://www.w3.org/2000/svg">
    <!-- 圖表內容 -->
  </svg>
  <figcaption>來源：[來源名稱], [年份]</figcaption>
</figure>
```
