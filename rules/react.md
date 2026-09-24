---
paths:
  - "**/*.{tsx,jsx}"
---

# React

- Derive values during render instead of synchronizing derived state.
- Do not use `useEffect` for render-derived state, internal data shaping, event
  handling, or log deduplication.
- Use `useEffect` only to synchronize with external systems such as I/O,
  subscriptions, timers, DOM APIs, iframe APIs, or browser APIs.
- Keep state as local as practical.
- Preserve accessibility and loading, empty, error, and disabled states.
- Match the existing component, state-management, and styling architecture.
- For visual changes, render and inspect the result when the environment
  supports it.
