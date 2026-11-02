# Blog Post 8: Is That Wage Difference More Than Sampling Noise?

All data are simulated; no download or API key is needed. The article and all Python code are in `index.qmd`. Rendering creates `data/observed_wages.csv`, tables and `summary.json` in `results/`, and three figures in `results/figures/` (including two interactive HTML charts).

## Reproduce

Use Quarto, R, and Python 3.13. Install the R packages once in the R Console:

```r
install.packages(c("knitr", "rmarkdown", "reticulate"))
```

In the Terminal, create the Python environment if it does not already exist, then install the tested packages:

```sh
python3.13 -m venv ~/aeds6400-python
~/aeds6400-python/bin/python -m pip install numpy==2.5.3 pandas==3.0.6 matplotlib==3.11.2 plotly==7.1.0
```

The document defaults to that environment. To use another, set `RETICULATE_PYTHON` to its Python executable before rendering.

Open `blog/posts/post8/index.qmd` in RStudio and click **Render**, or run from the repository root:

```sh
quarto render blog/posts/post8/index.qmd
```

Allow a few minutes: every render reruns the simulations and recreates the outputs. The website page is written to `docs/blog/posts/post8/index.html`.

## Check the results

With seed **20261101**, the sample mean is **$20.43**, the 95% bootstrap interval is **[$19.69, $21.17]**, and the two-sided simulated p-value is **0.260**. Coverage across 5,000 samples is **93.04%, 93.94%, and 94.90%** for sample sizes 25, 100, and 400. Test Figure 1's Play/Pause and slider, and Figure 2's sample-size dropdown.

For GitHub Pages, keep the generated chart files with the page. Render `blog/index.qmd` to refresh the listing, then commit and push the source and `docs/` changes. This repository publishes the website from `docs/`.
