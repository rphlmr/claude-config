# Changelog

## [4.9.0](https://github.com/rphlmr/claude-config/compare/v4.8.0...v4.9.0) (2026-10-24)


### Features

* ✨ skip state machines only for units with no transitions, tested by asking whether an event can ever be refused or handled differently, with an eval ([71899ba](https://github.com/rphlmr/claude-config/commit/71899bac4a7bc729308a91f1f09e44e101d4f6fe))

## [4.8.0](https://github.com/rphlmr/claude-config/compare/v4.7.0...v4.8.0) (2026-10-24)


### Features

* ✨ name XState events in dot.case, as Stately recommends for v5, and keep states, machine ids and wire messages out of the rename ([289eb2b](https://github.com/rphlmr/claude-config/commit/289eb2b361078f38cd8b8e7930cd31c4c5d38627))
* ✨ raise the default subagent cap to three per request ([2db4c94](https://github.com/rphlmr/claude-config/commit/2db4c94a0b455256d9f8ad19eb45864125f8d07a))
* ✨ rank implicit state machines as medium at least so they land in the fix set ([934143b](https://github.com/rphlmr/claude-config/commit/934143bc5c7205c66780c3e81e6c992203aa66e0))

## [4.7.0](https://github.com/rphlmr/claude-config/compare/v4.6.0...v4.7.0) (2026-10-24)


### Features

* ✨ count every unit with phases in state machine audits, whatever its size or bugs, flag machines that only mirror status, and name the skip reason for any unit called fine, with an eval ([fa7b6bf](https://github.com/rphlmr/claude-config/commit/fa7b6bfa540e1330ed1963a25189309eac7a50e4))
* ✨ draw Scannable visuals in calm neutral and pastel colors, with color only where it carries meaning ([a0a91a1](https://github.com/rphlmr/claude-config/commit/a0a91a1a8125fdeb68e71a18b6a920e902c94b8a))
* ✨ make Scannable replies lead with the verdict, keep everything in one reply with linked tables for findings and plans, and draw architecture as an inline visual ([98d1136](https://github.com/rphlmr/claude-config/commit/98d11364ddf6cb7609bf033c9f28b2ccd02d8268))
* ✨ pre-approve XState, store states as enums not booleans, keep test helpers out of src, follow the React Router docs, write plain UI copy, drop the invariant exception for inline comments, and tighten devrel article wording ([6895fa6](https://github.com/rphlmr/claude-config/commit/6895fa678af855a83514e756d33eae7ecd740056))

## [4.6.0](https://github.com/rphlmr/claude-config/compare/v4.5.0...v4.6.0) (2026-10-23)


### Features

* ✨ guard against premise-blind code and UI text used as logic, keep review fix rounds from growing the code, and add a trusted-review eval for both ([db3e9c6](https://github.com/rphlmr/claude-config/commit/db3e9c6203f216c9a864926b94cdf2747bb5f231))


### Bug Fixes

* 🐛 leave data loading and mutations to the framework's loaders and actions instead of a state machine, with an eval ([a006c24](https://github.com/rphlmr/claude-config/commit/a006c24eea39d4724a39b836a1cbe2233dd3ee89))

## [4.5.0](https://github.com/rphlmr/claude-config/compare/v4.4.0...v4.5.0) (2026-10-23)


### Features

* ✨ add a maintainer lens to trusted-review, with an eval, and fix the clean-code eval fixture ([5a91303](https://github.com/rphlmr/claude-config/commit/5a91303b7a9707691b8d42fc767426c9b9ebc277))
* ✨ add evals for trusted-review and devrel-voice, and tighten doc comment rules ([fc57b86](https://github.com/rphlmr/claude-config/commit/fc57b86efa6380448e7593da844406fd9398bc44))
* ✨ add trust rules, a trusted-review skill and a devrel-voice skill ([d1c00a6](https://github.com/rphlmr/claude-config/commit/d1c00a6b6ba4cc8a5cec84f348bac02b77b9af06))

## [4.4.0](https://github.com/rphlmr/claude-config/compare/v4.3.0...v4.4.0) (2026-10-20)


### Features

* **output-styles:** add Scannable output style for reply formatting ([b62941f](https://github.com/rphlmr/claude-config/commit/b62941f6ec3e5bddf5c7a1ddfd02a5cf5523cc16))

## [4.3.0](https://github.com/rphlmr/claude-config/compare/v4.2.0...v4.3.0) (2026-10-19)


### Features

* **instructions:** raise subagent cap to two per request ([c706aa3](https://github.com/rphlmr/claude-config/commit/c706aa326e815cfb28af63adef298751192be5d6))
* **rules:** add kebab-case file naming rule ([106283e](https://github.com/rphlmr/claude-config/commit/106283e75c21c8b0ae420ed6a0bde416d1594e12))

## [4.2.0](https://github.com/rphlmr/claude-config/compare/v4.1.0...v4.2.0) (2026-10-18)


### Features

* **rules:** add zod, error handling, and architecture guidance ([71fa3d6](https://github.com/rphlmr/claude-config/commit/71fa3d6e75a98e9cb7813ede79904fda971bcf4d))

## [4.1.0](https://github.com/rphlmr/claude-config/compare/v4.0.0...v4.1.0) (2026-10-16)


### Features

* **rules:** replace code-spacing with a code-style rule drawn from hand-written code ([4696380](https://github.com/rphlmr/claude-config/commit/46963803c67d00844c2a6cca83fea93108e9d903))
* **state-machines:** make explicit state machines the default for states, workflows, and sequences ([4696380](https://github.com/rphlmr/claude-config/commit/46963803c67d00844c2a6cca83fea93108e9d903))

## [4.0.0](https://github.com/rphlmr/claude-config/compare/v3.0.1...v4.0.0) (2026-10-14)


### ⚠ BREAKING CHANGES

* /final-implementation-plan, /implement-plan, /verify-implementation, /future-architect-mode, and /markdown-output are removed, with the implementer, light-implementer, verifier, and future-architect agents. Use plan mode, the main session, and /code-review instead. sync-skills.sh does not delete them from ~/.claude, so remove them there by hand.

### Features

* **brainstorm:** add /brainstorm skill to replace the superpowers brainstorming flow ([33474ee](https://github.com/rphlmr/claude-config/commit/33474ee6966bdbe180d59a7e104413a4545e95e3))


### Bug Fixes

* **claude-md:** ask through the question tool and offer design variants only when they add value ([33474ee](https://github.com/rphlmr/claude-config/commit/33474ee6966bdbe180d59a7e104413a4545e95e3))
* **claude-md:** drop the global continuity rule and add narrow checks while iterating ([33474ee](https://github.com/rphlmr/claude-config/commit/33474ee6966bdbe180d59a7e104413a4545e95e3))


### Code Refactoring

* remove plan, implement, verify, and architect workflows in favor of native claude code features ([33474ee](https://github.com/rphlmr/claude-config/commit/33474ee6966bdbe180d59a7e104413a4545e95e3))

## [3.0.1](https://github.com/rphlmr/claude-config/compare/v3.0.0...v3.0.1) (2026-10-05)


### Bug Fixes

* **remote-control:** open the claude desktop app code tab from the menu bar instead of the website ([8760750](https://github.com/rphlmr/claude-config/commit/87607503ae991c03b249146123cd69b4611f98c2))

## [3.0.0](https://github.com/rphlmr/claude-config/compare/v2.2.0...v3.0.0) (2026-10-05)


### ⚠ BREAKING CHANGES

* **implementer:** consult an opus advisor at decision points on sonnet 5.5
the super-implementer agent is removed. /implement-plan now routes hard and high-risk work (authentication, security, persistence, migrations, inference-heavy types, state machines, unchecked concurrency) to implementer, which consults the advisor set by advisorModel. Enable it with /advisor or "advisorModel": "claude-opus-5-5", and delete ~/.claude/agents/super-implementer.md after syncing.

### Features

* **claude-md:** keep multi-device apps consistent across every surface ([42ba2b5](https://github.com/rphlmr/claude-config/commit/42ba2b5701ae0d2b88e7d64df9164203a60a2799))
* **implementer:** consult an opus advisor at decision points on sonnet 5.5 ([d5022c4](https://github.com/rphlmr/claude-config/commit/d5022c4078c6b9f396c6bcc286a1ac2567999a06))
* **implementer:** consult the advisor on ui/ux continuity drift and report findings ([d5022c4](https://github.com/rphlmr/claude-config/commit/d5022c4078c6b9f396c6bcc286a1ac2567999a06))
* **implementer:** run implementer on opus 5.5 at medium effort ([42ba2b5](https://github.com/rphlmr/claude-config/commit/42ba2b5701ae0d2b88e7d64df9164203a60a2799))
* **light-implementer:** consult the advisor only for ui/ux continuity drift ([d5022c4](https://github.com/rphlmr/claude-config/commit/d5022c4078c6b9f396c6bcc286a1ac2567999a06))
* **remote-control:** add claude-rc launcher for background remote control servers ([307161f](https://github.com/rphlmr/claude-config/commit/307161f96ff4ab2e3a76ffe9cedce6ae5945e312))
* **remote-control:** add sessionstart hook mode that starts the deepest configured project ([307161f](https://github.com/rphlmr/claude-config/commit/307161f96ff4ab2e3a76ffe9cedce6ae5945e312))
* **remote-control:** add swiftbar menu bar plugin to start and stop servers ([307161f](https://github.com/rphlmr/claude-config/commit/307161f96ff4ab2e3a76ffe9cedce6ae5945e312))
* **remote-control:** start configured servers at login with a launchagent ([307161f](https://github.com/rphlmr/claude-config/commit/307161f96ff4ab2e3a76ffe9cedce6ae5945e312))
* **sync:** add sync-remote-control.sh to install claude-rc, the plugin, and the launchagent ([307161f](https://github.com/rphlmr/claude-config/commit/307161f96ff4ab2e3a76ffe9cedce6ae5945e312))


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
