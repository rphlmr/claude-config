---
name: markdown-output
description: Formats Markdown the user will copy, save, share, or pass to another tool or agent as one intact block with balanced fences. Use when the user asks for Markdown intended to be copied or reused verbatim, such as a prompt, a README section, or a document for another tool or agent.
---

# Markdown Output

When the user asks for Markdown intended to be copied, saved, shared, or passed
to another tool or agent:

- Return the Markdown as one intact copyable block unless the user requests
  another format.
- Keep all Markdown fences balanced. If the content contains fenced code
  blocks, use an outer fence longer than every fence contained inside it.
- Do not escape or alter inner Markdown merely to make the outer response
  render correctly.
- Before responding, verify that headings, lists, indentation, and fenced
  blocks remain structurally valid when copied verbatim.
