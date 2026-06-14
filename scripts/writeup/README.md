# Writeup Scripts

PDF generation and diagram rendering scripts for the project writeup.

## Scripts

- `run-pandoc.sh` — Convert markdown to PDF with citations via pandoc + texlive
- `setup-pdf-converter.sh` — Install pandoc or other PDF converters
- `generate-plantuml-png.sh` — Render PlantUML diagrams to PNG

## Usage

```bash
make pandoc_run                        # Convert results/sections/*.md to results/report.pdf
make setup_pdf_converter ARGS=pandoc   # Install pandoc + texlive
make run_puml_single INPUT_FILE=d.puml STYLE= OUTPUT_PATH=out.png  # Render one diagram
```

## Known Gotchas

### LaTeX `\@commands` in `\AtBeginDocument` Require Outer `\makeatletter`

`\AtBeginDocument` tokenizes its argument at parse time. If `@` has catcode
"other" (default), `\@ifundefined` is tokenized as `\@` (spacefactor) + literal
text. At `\begin{document}`, `\@` executes in vertical mode →
`! You can't use \spacefactor in vertical mode`.

**Fix**: Wrap in `\makeatletter...\makeatother` *outside* `\AtBeginDocument`,
not inside — catcode changes only affect future tokenization.

```latex
\makeatletter
\AtBeginDocument{\@ifundefined{refname}{}{...}}
\makeatother
```

Relevant: `run-pandoc.sh:292-296`

### Title Page Not Appearing

`00_title_abstract.tex` must be passed explicitly to `run-pandoc.sh` as the
`-B` (before-body) include. Pandoc does not auto-discover files by naming
convention. The `pandoc_run` target wires it as a positional argument:

```makefile
# Makefile:58
$(PANDOC_SCRIPT) "$(WRITEUP_DIR)/*.md" "$(OUTPUT_PDF)" "$(WRITEUP_DIR)/00_title_abstract.tex" ...
```
