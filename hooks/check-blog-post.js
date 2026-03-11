#!/usr/bin/env node
const fs = require("fs");

let input;
try {
  input = JSON.parse(fs.readFileSync(0, "utf8"));
} catch (e) {
  process.exit(0);
}

const fp = (input.tool_input && input.tool_input.file_path) || "";
const content = (input.tool_input && input.tool_input.content) || "";

// Must be .md or .mdx
if (!/\.(md|mdx)$/i.test(fp)) process.exit(0);

// Exclude non-blog directories
if (
  /[/\\](docs|node_modules|\.claude|memory|plans|skills|agents|hooks|references)[/\\]/i.test(
    fp
  )
)
  process.exit(0);

// Check for blog frontmatter (title + date in first 30 lines)
const head = content.split("\n").slice(0, 30).join("\n");
if (/^title\s*:/m.test(head) && /^date\s*:/m.test(head)) {
  console.log(
    "Blog post detected! Remind user to run /smart-blog-skills:analyze for quality scoring."
  );
}
