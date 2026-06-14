# Plan: drop MkDocs; keep docs/ as GitHub-rendered

**Status:** open · **Tracking:** #23

## Rationale

MkDocs is over-engineered for a 5-page docs set that GitHub already renders, and the
README's audience-segmented links already route to it. `mkdocs.yaml` is inert
(committed but never built — the live deploy was deferred). Keep the `docs/` content
(it removed the README/AGENTS redundancy); drop the site generator.

## Steps

1. Remove `mkdocs.yaml`.
2. Tidy `docs/*.md` front-matter: drop the `title:` key and restore a body `# H1`
   (MD041 is disabled and MD025 is satisfied by a single body H1). Keep the other
   metadata (`category`, `version`, `created`, `updated`) if useful.
3. Remove the "live docs site / GitHub Pages deploy" items from `docs/roadmap.md`
   and `AGENT_REQUESTS.md`.
4. No README change needed — it already links to `docs/*.md` directly.

## Verification

- `make lint_md` (recursive) stays at 0 errors.
- `lychee` link check passes.
