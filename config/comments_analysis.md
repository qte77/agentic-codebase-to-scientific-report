---
type: "configuration"
purpose: "repository-analysis"
priority: "user-override"
format_version: "1.0"
---

# Repository Analysis Guidelines

## Input Sources (read these first)

- `results/repo-context.xml` — Repomix bundle of the target repo (compressed,
  token-budgeted, secret-filtered). Use as the primary source of file contents.
- `results/graph.json` — Graphify knowledge graph (NetworkX node-link). Use the
  typed edges and community clusters for architecture and dependency claims.
  Treat `confidence: EXTRACTED` (score 1.0) edges as verifiable facts and
  `INFERRED` edges as hedged statements.
- The target's own `docs/architecture.md`, `docs/UserStory.md`, `docs/roadmap.md`,
  and `docs/sprints/` as authoritative project documentation.

## Custom Analysis Focus

- Multi-agent system architecture: agent compositions, orchestration, tier design.
- Evaluation methodology: metric definitions, scoring logic, judge design.
- Reproducibility: run/artifact layout, batch execution, trace persistence.

## Academic Emphasis

- Prioritise novel contributions (tiered MAS evaluation, agent-graph metrics)
  over standard framework usage.
- Capture experimental setup and any empirical run data for the Results section.

## Repository-Specific Instructions

- Use Graphify community clusters as candidate report-section topics.
- Map `AGENT_LEARNINGS.md` and `CHANGELOG.md` to difficulties/solutions.
- Treat Python `src/` as the implementation source of truth; docs as intent.
