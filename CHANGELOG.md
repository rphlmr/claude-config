# Changelog

## [3.0.0](https://github.com/rphlmr/claude-config/compare/v2.2.0...v3.0.0) (2026-10-01)


### ⚠ BREAKING CHANGES

* **implementer:** consult an opus advisor at decision points on sonnet 5.5
the super-implementer agent is removed. /implement-plan now routes hard and high-risk work (authentication, security, persistence, migrations, inference-heavy types, state machines, unchecked concurrency) to implementer, which consults the advisor set by advisorModel. Enable it with /advisor or "advisorModel": "claude-opus-5-5", and delete ~/.claude/agents/super-implementer.md after syncing.

### Features

* **claude-md:** keep multi-device apps consistent across every surface ([42ba2b5](https://github.com/rphlmr/claude-config/commit/42ba2b5701ae0d2b88e7d64df9164203a60a2799))
* **implementer:** consult an opus advisor at decision points on sonnet 5.5 ([d5022c4](https://github.com/rphlmr/claude-config/commit/d5022c4078c6b9f396c6bcc286a1ac2567999a06))
* **implementer:** consult the advisor on ui/ux continuity drift and report findings ([d5022c4](https://github.com/rphlmr/claude-config/commit/d5022c4078c6b9f396c6bcc286a1ac2567999a06))
* **implementer:** run implementer on opus 5.5 at medium effort ([42ba2b5](https://github.com/rphlmr/claude-config/commit/42ba2b5701ae0d2b88e7d64df9164203a60a2799))
* **light-implementer:** consult the advisor only for ui/ux continuity drift ([d5022c4](https://github.com/rphlmr/claude-config/commit/d5022c4078c6b9f396c6bcc286a1ac2567999a06))


### Bug Fixes

* **commit-message:** stop the agent from consulting the advisor tool ([d5022c4](https://github.com/rphlmr/claude-config/commit/d5022c4078c6b9f396c6bcc286a1ac2567999a06))
* **pr-changelog:** stop the agent from consulting the advisor tool ([d5022c4](https://github.com/rphlmr/claude-config/commit/d5022c4078c6b9f396c6bcc286a1ac2567999a06))

## [2.2.0](https://github.com/rphlmr/claude-config/compare/v2.1.0...v2.2.0) (2026-09-28)


### Features

* **claude-md:** make replies scannable with short blocks, bold key points, recommendations and diagrams ([75b46cb](https://github.com/rphlmr/claude-config/commit/75b46cb7ada68ea00a36ca9f03ea5a662d1b2589))
* **claude-md:** offer two or three variants with a recommendation for ui mockups ([75b46cb](https://github.com/rphlmr/claude-config/commit/75b46cb7ada68ea00a36ca9f03ea5a662d1b2589))
* **implement-plan:** route state machines and unchecked concurrency to super-implementer ([75b46cb](https://github.com/rphlmr/claude-config/commit/75b46cb7ada68ea00a36ca9f03ea5a662d1b2589))
* **super-implementer:** add persistence, SQL, and schema safety rules ([5808bf1](https://github.com/rphlmr/claude-config/commit/5808bf1760fff62ba9c88653510ed4343b455e35))

## [2.1.0](https://github.com/rphlmr/claude-config/compare/v2.0.0...v2.1.0) (2026-09-28)


### Features

* **agents:** add super-implementer on opus 5.5 for hard and high-risk plans ([79ddd65](https://github.com/rphlmr/claude-config/commit/79ddd65f847bded46df6a96db4261530b87e8a2d))
* **agents:** guide implementers on shared targets, swift concurrency and state machines ([79ddd65](https://github.com/rphlmr/claude-config/commit/79ddd65f847bded46df6a96db4261530b87e8a2d))
* **agents:** move implementer and light-implementer to sonnet 5.5 ([79ddd65](https://github.com/rphlmr/claude-config/commit/79ddd65f847bded46df6a96db4261530b87e8a2d))
* **claude-md:** suggest manual workflow commands at the right moment ([d222623](https://github.com/rphlmr/claude-config/commit/d222623cd574b68a148d5b3e7ca8b1eebc0c87db))
* **final-implementation-plan:** add an implementation agent section to final plans ([79ddd65](https://github.com/rphlmr/claude-config/commit/79ddd65f847bded46df6a96db4261530b87e8a2d))
* **implement-plan:** prefer the stronger agent when unclear and report the selection ([79ddd65](https://github.com/rphlmr/claude-config/commit/79ddd65f847bded46df6a96db4261530b87e8a2d))
* **implement-plan:** route security, data, type-level and hard tasks to super-implementer ([79ddd65](https://github.com/rphlmr/claude-config/commit/79ddd65f847bded46df6a96db4261530b87e8a2d))
* **skills:** add apple-hig skill for iOS, iPadOS and macOS design guidance ([80f93c2](https://github.com/rphlmr/claude-config/commit/80f93c2b0b68a651f55b09d1cd40273ae52ac250))
* **verifier:** flag missed targets, silenced concurrency diagnostics and untested transitions ([79ddd65](https://github.com/rphlmr/claude-config/commit/79ddd65f847bded46df6a96db4261530b87e8a2d))

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
