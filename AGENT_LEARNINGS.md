---
title: Agent Learnings
description: Accumulated non-obvious patterns that prevent repeated mistakes
category: knowledge
version: 0.1.0
created: 2026-06-14
updated: 2026-06-14
---

Durable, hard-won patterns for this repository. Referenced by
`.claude/rules/compound-learning.md`. Add an entry the **second** time a problem
recurs; promote to `.claude/rules/` on the third. Keep entries tight; prune
aggressively.

Entry template: **Context** / **Problem** / **Solution** / **Example** / **References**.

## markdownlint passes locally but fails in CI

- **Context:** adding or editing Markdown docs.
- **Problem:** `make lint_md` uses the repo's lenient `.markdownlint-cli2.jsonc`, but
  CI's reusable workflow downloads the stricter `qte77/.github` `.markdownlint.jsonc`.
  Local green does not imply CI green.
- **Solution:** any `docs/**` file with a front-matter `title:` must start its body at
  `##` (no body `# H1`) — the front-matter title is the page title. Verify against the
  org rules before pushing.
- **Example:** temporarily drop the org `.markdownlint.jsonc` in place, run
  `make lint_md`, expect 0 errors, then delete it (do not commit it).
- **References:** `.markdownlint-cli2.jsonc`; CHANGELOG entry for the docs site.

## main requires signed commits

- **Context:** merging a green PR.
- **Problem:** `main` enforces a signed-commit ruleset; branches built in an
  unsigned environment are `BLOCKED` even when CI is green.
- **Solution:** merge with `gh pr merge <n> --squash --admin --delete-branch` — GitHub
  signs the resulting squash commit. Confirm before bypassing the ruleset.
- **Example:** `mergeStateStatus: BLOCKED` with all checks passing → use `--admin`.
- **References:** `CONTRIBUTING.md` → Commit & PR workflow.
