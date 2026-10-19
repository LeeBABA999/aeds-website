# Blog Post 5: Same Region, Different Incomes

This post asks where Pennsylvania's higher-income counties are concentrated and how Philadelphia compares with four nearby counties. It maps median household income for all 67 Pennsylvania counties and compares Philadelphia, Bucks, Chester, Delaware, and Montgomery.

## Data sources

- [U.S. Census Bureau, 2020–2024 American Community Survey five-year estimates](https://api.census.gov/data/2024/acs/acs5/groups/B19013.html): variable `B19013_001E`, median annual household income in inflation-adjusted 2024 dollars.
- [U.S. Census Bureau, 2024 cartographic county boundaries](https://www.census.gov/geographies/mapping-files/2024/geo/carto-boundary-file.html): the national county file at 1:500,000 scale, filtered to Pennsylvania (`STATEFP = 42`).

Income estimates and boundaries are joined using county `GEOID`. The map uses the EPSG:5070 equal-area projection. These are descriptive comparisons of survey estimates, not causal effects or comparisons of individual wages.

## Folder structure

```text
post5/
├── index.qmd                       # Article and all analysis code
├── README.md                       # Replication instructions
├── data/
│   ├── raw/
│   │   ├── acs_2024_pa_county_income.csv
│   │   └── cb_2024_us_county_500k.zip
│   └── processed/
│       └── county_income.csv
└── results/
    ├── figures/
    │   ├── income_map.png
    │   └── nearby_counties.png
    └── tables/
        └── nearby_counties.csv
```

All Python analysis code is embedded in `index.qmd`; this is the documented equivalent of a separate `code/` folder. The small R setup chunk selects the Python environment used by `reticulate`.

## Software and setup

Use RStudio with Quarto and R. Install the R packages if needed:

```r
install.packages(c("knitr", "rmarkdown", "reticulate"))
```

The document expects the course Python environment at `~/aeds6400-python/bin/python`. On a new machine, create it first from a terminal:

```bash
python3 -m venv ~/aeds6400-python
```

If the course environment already exists, skip its creation. Install the Python dependencies into that environment:

```bash
~/aeds6400-python/bin/python -m pip install pandas geopandas matplotlib requests
```

If using another environment, update the `RETICULATE_PYTHON` path in the first chunk of `index.qmd` before rendering.

## Reproduce the post

1. Clone or download the repository, keeping this post's `index.qmd`, `data/`, and `results/` together in `blog/posts/post5/`.
2. Open `website2.Rproj` in the repository root, then open `blog/posts/post5/index.qmd`.
3. Restart R after setting up the Python environment, then click **Render**. Run the complete document so the data and figures are regenerated in order.

Alternatively, run this command from the website repository root:

```bash
quarto render blog/posts/post5/index.qmd
```

The website configuration sets `output-dir: docs`, so the rendered page is written to `docs/blog/posts/post5/index.html`. The analysis uses paths relative to the post's directory and creates its data and results folders automatically.

### Downloads and Census API key

The raw CSV and boundary ZIP are included in the repository. With both files present, the analysis reuses those inputs and does not need a Census API key or new Census downloads.

If the raw income CSV is missing, obtain and activate a [free Census API key](https://api.census.gov/data/key_signup.html). Add the following line to your user `~/.Renviron` file, replacing the placeholder with your own key, and restart R:

```text
CENSUS_API_KEY=your_key_here
```

Never commit the API key or your `.Renviron` file. Internet access is needed when either raw input must be downloaded. Keeping the saved inputs preserves the data snapshot used for the post.

## Expected results

Rendering checks that all 67 counties have unique identifiers and usable positive income estimates, then saves:

- `data/processed/county_income.csv`: cleaned income estimates for all Pennsylvania counties.
- `results/figures/income_map.png`: statewide county income map.
- `results/figures/nearby_counties.png`: Philadelphia and four nearby counties.
- `results/tables/nearby_counties.csv`: the five-county comparison underlying the bar chart.

The saved data give median household income of $127,208 in Chester County and $61,953 in Philadelphia, a difference of $65,255. The HTML should display both figures and their captions.

Figures and tables are generated and saved by the code rather than copied manually. County medians hide differences within counties, the estimates have sampling uncertainty, and the comparisons do not adjust for local living costs or establish why incomes differ.
