---
type: "configuration"
purpose: "source-specification"
priority: "user-override"
format_version: "1.0"
---

# Target Repository Configuration

## Repository Source

**Primary Target:**

Repository: /workspaces/qte77/Agents-eval
Description: Multi-agent system (MAS) evaluation framework. Uses PydanticAI to
  orchestrate agent compositions over the PeerRead academic-review task and
  scores them with a tiered metric suite (BERTScore/TF-IDF text similarity,
  RAGAs/DeepEval LLM-as-judge, and graph-based coordination metrics). Ships a
  Streamlit GUI (Trace Viewer, Agent Graph, Evaluation Results) and a pandoc
  academic write-up pipeline.
Branch: main
Key Features:
    - PydanticAI multi-agent orchestration with 8 MAS compositions (T1/T2/T3 tiers)
    - Tiered evaluation: BERTScore + TF-IDF/Jaccard/Levenshtein, RAGAs, DeepEval
    - Agent interaction graph (NetworkX + Pyvis) and SQLite trace persistence
    - Streamlit multi-page GUI and Claude Code agent-teams batch runner
    - Reproducible runs with per-run artifact registry and batch aggregation

## Additional Repositories (Optional)

**Secondary Sources:**

None configured for the first end-to-end run.
