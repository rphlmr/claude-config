---
paths:
  - "**/*.{ts,tsx,mts,cts,js,jsx,mjs,cjs}"
  - "**/*.{swift,m,mm,kt,kts,java,dart}"
  - "**/*.{go,rs,py,rb,php,cs,scala}"
  - "**/*.{c,h,cc,cpp,hpp}"
  - "**/*.{sh,bash,zsh}"
---

# Code Spacing and Readability

Apply these rules to new and modified code, even where the surrounding code
differs. The repository's formatter and lint configuration take precedence. Do
not reformat unrelated code.

- Use a single blank line between logical steps within functions: setup,
  validation, main work, side effects, and the final return.
- Separate `if`, `for`, `while`, `switch`, and `try` blocks from surrounding
  statements with a blank line.
- Always use braces and multiline bodies for control flow.
- Keep closely related declarations together. Do not insert blank lines
  mechanically between every statement.
- Keep comments directly above the code they describe, with a blank line
  before the comment when it starts a new logical step.
- Wrap long conditions and calls across multiple lines.
