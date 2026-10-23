---
name: trusted-review
description: Makes code reviews, audits, and review-fix rounds trustworthy, with proven findings ranked by impact, a maintainer's read of fit and public contracts, a verification pass, and fixes limited to what matters. Use when reviewing a diff, branch, PR, or feature, when auditing code, when acting on review findings or reports, or when planning a review or fix round.
---

# Trusted Review

A review exists so the user can trust its result. Report fewer, proven
findings over many plausible ones.

## Set the scope

- Review against a stated goal: the feature's user-facing behavior, the
  change's intent, or the user's question. Ask for it when it is missing and
  matters.
- Read the whole flow the change touches, not only the diff lines.

## Read it as a maintainer

Also read the change as an experienced contributor to this repository who
decides whether to merge it:

- Does it follow the repository's patterns and reuse its existing helpers?
- Is there a clearly simpler way to the same result?
- Does it change a public contract (an export, a CLI flag, a config key,
  stored data) without a migration or a note for its users?
- Would its tests fail if the change broke?
- Are docs, types, or the changelog left out of sync?
- Does the diff carry unrelated changes?

Rank these by what they cost later. A broken public contract is high or
medium. A duplicated helper or a departure from a pattern others will copy
is medium or low. A one-off naming choice is a nit.

## Prove each finding

- A finding is **proven** when a failing test, a reproduction, a log, or a
  screenshot shows it. A maintainer finding is proven by the code that shows
  it: the helper it duplicates, the caller or doc it breaks, with file and
  line. Otherwise label it **suspicion** and say what would prove it.
- Give each finding: where (file and line), what goes wrong for the user or
  the data, when it happens, and the proof.
- Before reporting a high or medium finding, check it once more yourself
  against the current code, as an attempt to disprove it. Drop or downgrade
  it when the check fails, and say so.

## Rank by impact

| Level | Meaning |
| --- | --- |
| High | Data loss, security, crash, or a main flow broken |
| Medium | A real flow wrong or misleading in a plausible case |
| Low | A rare case, with a workaround or a visible failure |
| Nit | Wording, style, naming, tidiness |

- Report every finding, ranked, with highs and mediums first. Put lows and
  nits in a short separate list the user can pick from.
- "No high or medium findings" is a valid and useful result.

## Fix by impact

A review alone changes no code. When the user asks for fixes:

- When the user names the findings to fix, fix exactly those. Their choice
  wins over the ranking.
- Otherwise, fix highs and mediums, and list lows and nits for the user to
  pick.
- Give each fix a test that fails before it and passes after.
- Prefer the smallest fix, or a visible limitation, over a new mechanism.
  Ask before adding one (a retry, a fallback, a watchdog, a cache, a state).
- Fix code added by the previous round with the same care: new code is where
  the next findings come from.

## Close the round

- After a fix round, run the full test suite, e2e, and gates once, and
  report the real output. A review alone runs only what proves its findings.
- Do not start another review round on your own. When the user asks for
  one after a fix round, review the whole flow once, not each finding again.
