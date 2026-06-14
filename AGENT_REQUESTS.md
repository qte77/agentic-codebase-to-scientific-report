---
title: Agent Requests
description: Escalation queue for blockers that need a human maintainer
category: knowledge
version: 0.1.0
created: 2026-06-14
updated: 2026-06-14
---

When an agent is blocked — a decision it cannot make, missing information, or an
action requiring privileges it does not have — it logs the request here instead of
guessing. Format: `- [ ] [PRIORITY] Description` with Context / Action / Impact.

## Open

- [ ] [HIGH] First real `make all` end-to-end on the reference target.
  - **Context:** the pipeline has never run against a live target with Claude auth.
  - **Action:** a maintainer runs `make all` with Claude CLI auth + an API key
    (spends tokens; never headless), including the Graphify path.
  - **Impact:** validates the full producer → consumer → PDF flow; may surface a
    first iteration on `analysis.yaml` content.
  - **Plan:** [docs/plans/first-end-to-end-run.md](docs/plans/first-end-to-end-run.md).
- [ ] [MEDIUM] Enable "Require approval for first-time contributors".
  - **Context:** Settings → Actions → General; UI-only, no clean API.
  - **Action:** maintainer toggles it (org-wide fix also covers it).
  - **Impact:** prevents untrusted first-time-contributor workflow runs.

## Resolved

<!-- Move items here with the resolving PR/commit when closed. -->
