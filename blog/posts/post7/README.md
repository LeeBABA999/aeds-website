# Blog 7: Back to Normal—for Which Jobs?

This post asks whether the three main parts of U.S. leisure and hospitality had regained their February 2020 payroll-job levels by December 2025. An interactive Plotly chart compares both relative recovery and job counts.

## Data

The data are monthly, seasonally adjusted BLS employment estimates from FRED, measured in thousands of payroll jobs. The analysis covers January 2019–December 2025 (84 months), using a snapshot downloaded on October 26, 2026.

| Series | FRED ID |
|---|---|
| Arts, entertainment, and recreation | [CES7071000001](https://fred.stlouisfed.org/series/CES7071000001) |
| Accommodation | [CES7072100001](https://fred.stlouisfed.org/series/CES7072100001) |
| Food services and drinking places | [CES7072200001](https://fred.stlouisfed.org/series/CES7072200001) |
| Leisure and hospitality total | [USLAH](https://fred.stlouisfed.org/series/USLAH) |

Keep the supplied raw CSV to reproduce the reported numbers. If it is missing, the code downloads current data without an API key; later revisions may change results. The download URL and checksum are recorded in `data/raw/source.json`.

## Files

```text
index.qmd          Article and all analysis/chart code
requirements.txt   Python package versions
 data/raw/         Original CSV and source metadata
 data/processed/   Employment levels and recovery indices
 results/figures/  Self-contained interactive HTML
 results/tables/   Recovery summary CSV
```

## Reproduce

Use RStudio with Quarto, R, and Python 3.13 (the version used here). If needed, install the R packages once in the R Console:

```r
install.packages(c("knitr", "rmarkdown", "reticulate"))
```

The document defaults to `~/aeds6400-python/bin/python`. If this environment does not exist, create it in the Terminal:

```sh
python3 -m venv ~/aeds6400-python
```

From this `post7` folder in the Terminal, install the Python dependencies and render:

```sh
~/aeds6400-python/bin/python -m pip install -r requirements.txt
quarto render index.qmd
```

Alternatively, open `index.qmd` in RStudio and click **Render** after installing dependencies. To use another Python environment, set `RETICULATE_PYTHON` to its executable in the first R chunk before rendering.

Rendering regenerates the processed CSVs, summary table, and interactive chart. In this website, the article is written to `docs/blog/posts/post7/index.html`; outside a website project, it appears beside `index.qmd`. Keep the chart's relative folder path when publishing.

## Quick check

The December 2025 changes from February 2020 should round to **+7.4%** for arts/recreation, **−8.0%** for accommodation, **+0.5%** for food/drink services, and **+0.4%** for the total. Check the chart's view dropdown, hover labels, legend, and date slider in the rendered page. These are descriptive job-count comparisons, not estimates of the pandemic's causal effects.
