---
type: "configuration"
purpose: "synthesis-guidelines"
priority: "user-override"
format_version: "1.0"
---

# Section Synthesis Guidelines

## Output Files (pandoc-ready)

Write to `results/sections/`:

- `00_frontmatter.md` — YAML-only pandoc build settings (toc-depth, geometry,
  linestretch, bibliography, csl). No prose.
- `00_title_abstract.tex` — LaTeX title page + abstract, passed to pandoc via `-B`.
- `01_introduction.md` … `08_summary_outlook.md` — numbered content sections.
- `references.bib` — BibTeX bibliography (replaces a hand-written bibliography
  section). Do **not** write list-of-figures/list-of-tables files; pandoc
  auto-generates them.

## Custom Citation Style

- IEEE numeric format (`[1]`). Every external claim cites a `[@bibkey]` that
  exists in `references.bib`. Include DOI/URL and accessed date per entry.

## Artifact -> Section Mapping

- README / project intro -> `01_introduction.md`
- `docs/architecture.md`, tech stack -> `04_planning_solution.md`, `05_implementation.md`
- UserStory / acceptance criteria -> `06_control_success.md`
- Sprint results, run/eval data -> `07_results.md`
- `AGENT_LEARNINGS.md`, `CHANGELOG.md` -> difficulties/innovations in discussion
- Roadmap / future work -> `08_summary_outlook.md`

## Quality Requirements

- Realistic and understated tone; report exact scope and limitations.
- Every technical claim grounded in `analysis.yaml` / `graph.json` (prefer
  EXTRACTED-confidence facts; hedge INFERRED ones).
- Figures reference rendered PlantUML PNGs with descriptive captions.
