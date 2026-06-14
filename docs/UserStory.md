---
title: User Story
description: Who the pipeline is for, the value it delivers, and its acceptance criteria
category: requirements
version: 0.1.0
created: 2026-06-14
updated: 2026-06-14
---

# User Story

## Problem statement

Producing a comprehensive, publication-quality technical report about a codebase
is slow and manual: someone must read the repository, reconstruct its
architecture, summarise decisions and results, and format everything to academic
standards. The knowledge exists in the code, docs, and history — but turning it
into a coherent ~52-page report is hours of expert effort per project.

## Target users

- **Researchers / students** documenting a project as a thesis or technical report.
- **Maintainers** producing architecture and implementation write-ups for stakeholders.
- **Evaluators / reviewers** who need a structured, citable overview of a codebase.

## Value proposition

Point the pipeline at a repository and get a structured, citation-backed report
draft — architecture, implementation, evaluation, and outlook — assembled to a
consistent academic format, with quality scored before assembly.

## User stories

- As a researcher, I want the pipeline to extract a repository's architecture and
  novel contributions, so that I can start from a structured draft instead of a
  blank page.
- As a maintainer, I want the report grounded in the actual code and docs, so that
  its technical claims are accurate and traceable.
- As an evaluator, I want each section scored for completeness, helpfulness, and
  truthfulness, so that I can trust the draft before reading it in full.
- As a contributor, I want the producer/consumer data contract validated in CI, so
  that a pipeline change cannot silently break report generation.

## Success criteria

1. `make all` produces `results/report.pdf` from a configured target repository.
2. `results/sections/analysis.yaml` validates against `schema/analysis.schema.json`
   (`make test` passes).
3. Generated sections carry the required frontmatter and resolve their figure,
   table, and citation references.
4. The validator emits `results/validation-report.md` with per-section
   completeness / helpfulness / truthfulness scores.

## Out of scope

- Authoring original research results not present in the target repository.
- Guaranteeing publication acceptance; the output is a high-quality draft.
- Remote repository access via the GitHub API (see [Roadmap](roadmap.md)).
