# Changelog

## [2.1.0](https://github.com/rphlmr/claude-config/compare/v2.0.0...v2.1.0) (2026-09-26)


### Features

* **skills:** add apple-hig skill for iOS, iPadOS and macOS design guidance ([80f93c2](https://github.com/rphlmr/claude-config/commit/80f93c2b0b68a651f55b09d1cd40273ae52ac250))

## [2.0.0](https://github.com/rphlmr/claude-config/compare/v1.0.0...v2.0.0) (2026-09-25)


### ⚠ BREAKING CHANGES

* **instructions:** limit required approvals to external deletions and git publishing
Claude no longer asks before destructive local changes, external writes, publishing, deployment, merging, dependency changes, scope expansion, or divergent product behavior. It asks only before deleting files outside the current project and before creating commits, pushing, or opening pull requests. Anything else, including merges and deployments, now proceeds without confirmation unless you add those checks back to your instructions or permission settings.

### Features

* **instructions:** cap subagents at one per request and ban em dashes ([36d6c12](https://github.com/rphlmr/claude-config/commit/36d6c124070e9147dd336fc5426aa097176dac93))
* **instructions:** limit required approvals to external deletions and git publishing ([b653503](https://github.com/rphlmr/claude-config/commit/b65350383e518fa0a06733f791188f53bc945839))

## 1.0.0 (2026-09-24)


### Features

* add global Claude Code instructions and sync scripts ([b3675c7](https://github.com/rphlmr/claude-config/commit/b3675c7d0084bc5e7c2202fa33a853ee373aa5dd))
* **agents:** add commit-message, pr-changelog, future-architect, implementer, light-implementer, and verifier agents ([b3675c7](https://github.com/rphlmr/claude-config/commit/b3675c7d0084bc5e7c2202fa33a853ee373aa5dd))
* **rules:** add path-scoped react and typescript rules ([b3675c7](https://github.com/rphlmr/claude-config/commit/b3675c7d0084bc5e7c2202fa33a853ee373aa5dd))
* **skills:** add commit-message, pr-changelog, markdown-output, and state-machines skills with evals ([b3675c7](https://github.com/rphlmr/claude-config/commit/b3675c7d0084bc5e7c2202fa33a853ee373aa5dd))
* **skills:** add plan, implementation, verification, architecture review, and session handoff workflow skills ([b3675c7](https://github.com/rphlmr/claude-config/commit/b3675c7d0084bc5e7c2202fa33a853ee373aa5dd))
