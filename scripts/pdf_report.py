#!/usr/bin/env python3
"""
smart-blog-skills PDF Report Generator

Converts Markdown analysis reports to styled PDF documents.
Requires: weasyprint, markdown

Usage:
    python pdf_report.py --input report.md --output report.pdf
    python pdf_report.py --input report.md  # outputs report.pdf (same dir)

Install dependencies:
    pip install weasyprint markdown
"""

import argparse
import sys
from pathlib import Path

try:
    import markdown
except ImportError:
    print("Error: 'markdown' package not installed. Run: pip install markdown")
    sys.exit(1)

try:
    from weasyprint import HTML
except ImportError:
    print("Error: 'weasyprint' package not installed. Run: pip install weasyprint")
    print("Note: WeasyPrint requires GTK libraries. See https://doc.courtbouillon.org/weasyprint/stable/first_steps.html")
    sys.exit(1)


CSS_TEMPLATE = """
@page {
    size: A4;
    margin: 2cm;
    @bottom-center {
        content: "smart-blog-skills | Page " counter(page) " of " counter(pages);
        font-size: 9px;
        color: #888;
    }
}

body {
    font-family: "Noto Sans TC", "Microsoft JhengHei", "PingFang TC", sans-serif;
    font-size: 11pt;
    line-height: 1.6;
    color: #1a1a1a;
    max-width: 100%;
}

h1 {
    color: #1a365d;
    font-size: 22pt;
    border-bottom: 3px solid #2b6cb0;
    padding-bottom: 8px;
    margin-top: 0;
}

h2 {
    color: #2b6cb0;
    font-size: 16pt;
    border-bottom: 1px solid #bee3f8;
    padding-bottom: 4px;
    margin-top: 24px;
}

h3 {
    color: #2c5282;
    font-size: 13pt;
    margin-top: 16px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin: 12px 0;
    font-size: 10pt;
}

th {
    background-color: #1a365d;
    color: white;
    padding: 8px 12px;
    text-align: left;
    font-weight: 600;
}

td {
    padding: 6px 12px;
    border-bottom: 1px solid #e2e8f0;
}

tr:nth-child(even) td {
    background-color: #f7fafc;
}

code {
    background-color: #edf2f7;
    padding: 2px 6px;
    border-radius: 3px;
    font-size: 9.5pt;
}

pre {
    background-color: #1a202c;
    color: #e2e8f0;
    padding: 12px 16px;
    border-radius: 6px;
    font-size: 9pt;
    overflow-x: auto;
    white-space: pre-wrap;
}

pre code {
    background: none;
    padding: 0;
    color: inherit;
}

blockquote {
    border-left: 4px solid #2b6cb0;
    margin: 12px 0;
    padding: 8px 16px;
    background-color: #ebf8ff;
    color: #2c5282;
}

.score-excellent { color: #22543d; font-weight: bold; }
.score-good { color: #2b6cb0; font-weight: bold; }
.score-pass { color: #744210; font-weight: bold; }
.score-improve { color: #c05621; font-weight: bold; }
.score-rewrite { color: #c53030; font-weight: bold; }

ul, ol {
    padding-left: 24px;
}

li {
    margin-bottom: 4px;
}
"""


def md_to_pdf(input_path: Path, output_path: Path) -> None:
    """Convert a Markdown file to a styled PDF."""
    md_content = input_path.read_text(encoding="utf-8")

    html_body = markdown.markdown(
        md_content,
        extensions=["tables", "fenced_code", "codehilite", "toc"],
    )

    full_html = f"""<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="utf-8">
    <style>{CSS_TEMPLATE}</style>
</head>
<body>
{html_body}
</body>
</html>"""

    HTML(string=full_html).write_pdf(str(output_path))
    print(f"PDF generated: {output_path}")


def main():
    parser = argparse.ArgumentParser(description="Convert Markdown report to PDF")
    parser.add_argument("--input", "-i", required=True, help="Input Markdown file")
    parser.add_argument("--output", "-o", help="Output PDF file (default: same name .pdf)")
    args = parser.parse_args()

    input_path = Path(args.input)
    if not input_path.exists():
        print(f"Error: Input file not found: {input_path}")
        sys.exit(1)

    output_path = Path(args.output) if args.output else input_path.with_suffix(".pdf")

    md_to_pdf(input_path, output_path)


if __name__ == "__main__":
    main()
