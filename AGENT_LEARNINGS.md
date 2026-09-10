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

## Creating signed commits via the GitHub API (no local GPG key)

- **Context:** authoring commits in a sandbox that has no GPG key configured, on a
  branch that will PR into `main`.
- **Problem:** `main` enforces a signed-commit ruleset. A plain local `git commit`
  there produces an unsigned commit, so the PR's `mergeStateStatus` stays blocked
  on the signature requirement no matter how green CI is — a passing CI run does
  not satisfy this, and the underlying commit itself has to be signed.
  Admin-override merge flags (e.g. `gh pr merge --admin`) are not a reliable bypass.
- **Solution:** create the commit through GitHub's own API instead — the
  `createCommitOnBranch` GraphQL mutation (the same mechanism GitHub's web file
  editor uses). Flow: fetch the target branch's current tip SHA (`gh api
  repos/<owner>/<repo>/commits/main --jq .sha` when branching fresh off `main`, or
  `git/refs/heads/<branch> --jq .object.sha` for an existing branch); create a
  branch ref at that SHA if new (`gh api repos/<owner>/<repo>/git/refs -f ref=...
  -f sha=...`); build the file changes as `fileChanges.additions` with full
  base64-encoded file content; submit via `gh api graphql -f query=...
  createCommitOnBranch(...)` with `expectedHeadOid` set to that tip SHA. Commits
  created this way come back auto-signed. Open/update the PR normally afterward
  with `gh pr create`.
- **Example:** PR #33 and PR #34 — both authored via `createCommitOnBranch`, both
  landed with `mergeStateStatus: CLEAN` and head-commit `verification.verified: true`.
- **References:** `CONTRIBUTING.md` → Commit & PR workflow.
