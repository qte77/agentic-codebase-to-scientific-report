# Plan: first end-to-end `make all` run

**Status:** open · **Tracking:** #5 · **Owner:** maintainer (needs Claude auth + API key)

## Goal

Run the full pipeline (Phase 0–4) against the reference target with Claude CLI auth
and an API key, producing `results/report.pdf` — the first real validation of the
producer → consumer → PDF flow.

## Why it is deferred

`make all` invokes `claude -p` once per phase; it spends tokens and must not run
headless. It needs a maintainer with Claude CLI auth and an API key. The pipeline
has never run against a live target.

## Steps

1. Confirm the target in `config/sources.md` (reference target: the `Agents-eval` repo).
2. `make setup_claude_code` and `make create_struct`.
3. `make all` **including the Graphify path** (not just `SKIP_GRAPHIFY=1`).
4. Expect one iteration on `analysis.yaml` content: the schema contract
   (`schema/analysis.schema.json`, checked by `make test`) constrains structure, not
   richness, so the analyzer's first output may need prompt tuning.
5. Review `results/validation-report.md` (CHT scores) and `results/report.pdf`.

## Verification

- `results/report.pdf` is produced.
- `results/sections/analysis.yaml` validates against the schema (`make test` green).
- The validator's per-section scores are at or above threshold.

See [Architecture](../architecture.md) for the phase details.
