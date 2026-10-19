# Blog Post 5: Same Region, Different Incomes
------------------------------------

This post asks where Pennsylvania's higher-income counties are concentrated and how Philadelphia compares with four nearby counties. It maps median household income for all 67 Pennsylvania counties and compares Philadelphia, Bucks, Chester, Delaware, and Montgomery.

## Data sources
------------------------------------

- [U.S. Census Bureau, 2020–2024 American Community Survey five-year estimates](https://api.census.gov/data/2024/acs/acs5/groups/B19013.html): variable `B19013_001E`, median annual household income in inflation-adjusted 2024 dollars.
- [U.S. Census Bureau, 2024 cartographic county boundaries](https://www.census.gov/geographies/mapping-files/2024/geo/carto-boundary-file.html): the national county file at 1:500,000 scale, filtered to Pennsylvania (`STATEFP = 42`).

Income estimates and boundaries are joined using county `GEOID`. The map uses the EPSG:5070 equal-area projection. These are descriptive comparisons of survey estimates, not causal effects or comparisons of individual wages.

## Folder structure
------------------------------------

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
------------------------------------

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
------------------------------------

1. Clone or download the repository, keeping this post's `index.qmd`, `data/`, and `results/` together in `blog/posts/post5/`.
2. Open `website2.Rproj` in the repository root, then open `blog/posts/post5/index.qmd`.
3. Restart R after setting up the Python environment, then click **Render**. Run the complete document so the data and figures are regenerated in order.

Alternatively, run this command from the website repository root:

```bash
quarto render blog/posts/post5/index.qmd
```

The website configuration sets `output-dir: docs`, so the rendered page is written to `docs/blog/posts/post5/index.html`. The analysis uses paths relative to the post's directory and creates its data and results folders automatically.

### Downloads and Census API key
------------------------------------

The raw CSV and boundary ZIP are included in the repository. With both files present, the analysis reuses those inputs and does not need a Census API key or new Census downloads.

If the raw income CSV is missing, obtain and activate a [free Census API key](https://api.census.gov/data/key_signup.html). Add the following line to your user `~/.Renviron` file, replacing the placeholder with your own key, and restart R:

```text
CENSUS_API_KEY=your_key_here
```

Never commit the API key or your `.Renviron` file. Internet access is needed when either raw input must be downloaded. Keeping the saved inputs preserves the data snapshot used for the post.

## Expected results
------------------------------------

Rendering checks that all 67 counties have unique identifiers and usable positive income estimates, then saves:

- `data/processed/county_income.csv`: cleaned income estimates for all Pennsylvania counties.
- `results/figures/income_map.png`: statewide county income map.
- `results/figures/nearby_counties.png`: Philadelphia and four nearby counties.
- `results/tables/nearby_counties.csv`: the five-county comparison underlying the bar chart.

The saved data give median household income of $127,208 in Chester County and $61,953 in Philadelphia, a difference of $65,255. The HTML should display both figures and their captions.

Figures and tables are generated and saved by the code rather than copied manually. County medians hide differences within counties, the estimates have sampling uncertainty, and the comparisons do not adjust for local living costs or establish why incomes differ.

Blog Post 4: Did Paychecks Keep Up With Prices?
------------------------------------

For this post, I used Python and FRED data to check whether U.S. wages kept up with inflation after COVID. The three charts compare actual and inflation-adjusted pay, wage growth and inflation, and real pay changes across 13 industries from February 2020 to August 2026.

Where to find everything
------------------------------------

Inside `blog/posts/post4/`:

- `index.qmd` has all the code and writing.
- `data/raw/` has the FRED downloads, saved the first time the code runs.
- `data/processed/` has the cleaned monthly data.
- `results/figures/` has the three charts and `results/tables/` has two summary tables, all made by the code.
- `requirements.txt` lists the Python packages.

How to run the analysis
------------------------------------

You will need R, Quarto, and Python. Install the R packages once in the R Console:

```r
install.packages(c("knitr", "rmarkdown", "reticulate"))
```

Then set up the class Python environment once in the Terminal:

```bash
python3 -m venv ~/aeds6400-python
~/aeds6400-python/bin/python -m pip install -r blog/posts/post4/requirements.txt
```

Open `blog/posts/post4/index.qmd` and click **Render**. The code only downloads a FRED series if it isn't already in `data/raw/`, so it uses the same data I used. To get newer data, delete the files in `data/raw/` and render again; the numbers may then differ from my post. On a Mac, if the download fails with `CERTIFICATE_VERIFY_FAILED`, run `Install Certificates.command` from your Python folder in Applications.


Blog Post 3: Education and Unemployment Through the Pandemic and Recovery
------------------------------------

For this post, I used R and IPUMS CPS data to compare unemployment across education groups from 2019 to 2024. The three charts show the trends, the increase in 2020, and differences within age groups in 2024. I focus on civilians ages 25–64 in the labor force and use the CPS person weight, `WTFINL`.

Where to find everything
------------------------------------

Inside `blog/posts/post3/`:

- `index.qmd` contains all the code and writing.
- `data/` holds the downloaded CPS file locally; it is excluded from GitHub.
- `results/` contains three PNG charts and `summary_results.csv`, all generated by the code.

How to run the analysis
------------------------------------

Download the whole repository and open `website2.Rproj` in RStudio. You will need R and Quarto. Install the packages once in the R Console:

```r
install.packages(c("here", "tidyverse", "knitr", "rmarkdown"))
```

Get the data from [IPUMS CPS](https://cps.ipums.org/cps/):

1. Sign in and select **Cross-sectional**, then all **72 Basic Monthly samples** from January 2019 through December 2024. Do not select ASEC samples.
2. Include `YEAR`, `MONTH`, `ASECFLAG`, `AGE`, `EDUC`, `EMPSTAT`, and `WTFINL`. Keep the preselected variables and all person records.
3. Request **CSV**, **Rectangular (cross-sectional)** format. Rename the downloaded file `cps_2019_2024.csv.gz` and put it in `blog/posts/post3/data/`, creating that folder if needed. Keep it compressed.

Each person downloads the raw data separately because [IPUMS restricts redistribution](https://cps.ipums.org/cps/terms.shtml).

Open `blog/posts/post3/index.qmd` and click **Render**. This recreates the analysis, charts, summary CSV, and blog post. Keep the folder structure unchanged so the file paths work.





Blog Post 2: What Should I Build Next?
------------------------------------

For this post #2, I used R to collect job listings from the Python.org Job Board annd compared their topic tags to help decide whether a beginner's next Python project should focus on backend development or machine learning since I had the exact confusion when I was a freshmen.

All of the code and writing are in `blog/posts/post2/index.qmd`.

I saved a copy of the webpage because job listings change over time. This lets someone else repeat the analysis using the same listings that I used.

Where to find everything
-----------------------

Inside `blog/posts/post2/`:

- `index.qmd` has the code and blog post.
- `data/` has the saved webpage, collection date, and cleaned data.
- `results/tables/` has the topic counts, overlap results, and data checks.
- `results/figures/` has the bar chart.

How to run the analysis 
----------------------

Download the whole repository and open `website2.Rproj` in RStudio. You will need R and Quarto installed.

If you have not installed the packages yet, run this in the R Console:

```r
install.packages(c("here", "rvest", "tidyverse", "knitr", "rmarkdown"))
```

Then open `blog/posts/post2/index.qmd`, leave `refresh <- FALSE`, and click Render. The code will use the saved webpage and recreate the cleaned data, tables, chart, and blog post. To collect a newer set of listings, change `refresh` to `TRUE`. The results may then differ from those discussed in my original post.


