---
name: trusted-review
description: Makes code reviews, audits, and review-fix rounds trustworthy, with proven findings ranked by impact, a verification pass, and fixes limited to what matters. Use when reviewing a diff, branch, PR, or feature, when auditing code, when acting on review findings or reports, or when planning a review or fix round, even if the user only says "review" or "check this".
---

# Trusted Review

A review exists so the user can trust its result. Report fewer, proven
findings over many plausible ones.

## Set the scope

- Review against a stated goal: the feature's user-facing behavior, the
  change's intent, or the user's question. Ask for it when it is missing and
  matters.
- Read the whole flow the change touches, not only the diff lines.

## Prove each finding

- A finding is **proven** when a failing test, a reproduction, a log, or a
  screenshot shows it. Otherwise label it **suspicion** and say what would
  prove it.
- Give each finding: where (file and line), what goes wrong for the user or
  the data, when it happens, and the proof.
- Before reporting a high or medium finding, check it once more against the
  current code, as an attempt to disprove it. Drop it or downgrade it when
  the check fails, and say so.

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

- Fix highs and mediums, each with a test that fails before the fix.
- Fix lows and nits only when the user picks them.
- Prefer the smallest fix, or a visible limitation, over a new mechanism.
  Ask before adding one (a retry, a fallback, a watchdog, a cache, a state).
- Fix code added by the previous round with the same care: new code is where
  the next findings come from.

## Close the round

- Run the full test suite, e2e, and gates once at the end of the round, and
  report the real output.
- After a fix round, do one fresh review of the whole flow, not another
  per-finding review. Stop there unless it finds a high or medium.
