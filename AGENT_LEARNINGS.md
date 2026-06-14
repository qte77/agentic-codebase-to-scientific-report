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

## Docs with a front-matter title must start at H2

- **Context:** adding or editing Markdown docs that carry YAML front-matter.
- **Problem:** default MD025 treats a front-matter `title:` as the document H1, so a
  body `# H1` becomes a second top-level heading and fails the lint.
- **Solution:** any doc with a front-matter `title:` starts its body at `##` — the
  front-matter title is the page title. README/CHANGELOG (no front-matter) keep a body H1.
- **Example:** `docs/architecture.md` — front-matter `title`, body opens `## System overview`.
- **References:** `.markdownlint.jsonc` (single rules file). Globs live in `make lint_md`,
  which `ci.yaml` runs recursively, so local `make lint_md` equals CI.

## main requires signed commits

- **Context:** merging a green PR.
- **Problem:** `main` enforces a signed-commit ruleset; branches built in an
  unsigned environment are `BLOCKED` even when CI is green.
- **Solution:** merge with `gh pr merge <n> --squash --admin --delete-branch` — GitHub
  signs the resulting squash commit. Confirm before bypassing the ruleset.
- **Example:** `mergeStateStatus: BLOCKED` with all checks passing → use `--admin`.
- **References:** `CONTRIBUTING.md` → Commit & PR workflow.
