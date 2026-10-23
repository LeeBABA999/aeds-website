# Blog 6: Does One Year's Income Tell the Whole Story?

This tutorial matches biological fathers and adult children in official PSID
data with SQL inside Python. It compares family-income IGE estimates using
one income year, three observed income years, and two child life stages.

## Folder structure

```text
post6/
  index.qmd                 # Article and all Python analysis code
  README.md                # Replication instructions
  .gitignore               # Keeps individual records out of Git
  data/raw/                # Official Excel file and codebook, local only
  data/processed/          # Generated person-year and matched data, local only
  sql/                     # Queries saved by the code
  results/tables/
    ige_estimates.csv       # Four IGEs, confidence intervals, N, R-squared
    timing_comparison.csv   # Paired comparison of the two averaged-income IGEs
  results/figures/          # Two saved figures
```

The executable code is in `index.qmd`; a separate code folder is unnecessary.
All analysis paths are relative to the post's folder. SQL uses an in-memory
SQLite database, so no database server is needed.

## Obtain the data

1. Register and sign in at the [official PSID website](https://psidonline.isr.umich.edu/).
   Review and follow its conditions of use.
2. Go to **Data → Data Center → Variable List**. Paste this list and click
   **Add Variables**:

   ```text
   ER30001 ER30002 ER32016 ER32017
   ER30429 ER30430 V10419 V11022
   ER30463 ER30464 V11606 V12371
   ER30498 ER30499 V13011 V13623
   ER33501 ER33502 ER13010 ER16462
   ER33601 ER33602 ER17013 ER20456
   ER33701 ER33702 ER21017 ER24099
   ER34001 ER34002 ER42017 ER46935
   ER34101 ER34102 ER47317 ER52343
   ER34201 ER34202 ER53017 ER58152
   ```

3. Open the cart and select **Checkout**. Choose **PDF** codebook,
   **Microsoft Excel Spreadsheet**, **All Individuals**, and ZIP compression.
   Leave the subsetting field blank. Submit the extract.
4. Download and unzip the files. Create `data/raw/` inside `post6/`, copy the
   Excel file there, and name the copy `psid.xlsx`. Keep its codebook and labels
   in the same folder. The workbook's worksheet is named `Data`.

The tested download was extract **J366633**, obtained October 23, 2026:
46,354 individual records and 61 columns. PSID automatically added release,
relationship, and other standard columns to the 40 requested variables.
The individual file is 1968–2023 Release 2 (December 2025). The extract's
codebook records the releases of the individual and family files.
Future PSID revisions may change results. Retain the original extract locally.

The four identifiers name the person and their biological father. Each row
of the remaining variable list gives a wave's family ID, membership sequence,
household-head age, and total family income, in that order. The waves are
1984, 1985, 1986, 1999, 2001, 2003, 2009, 2011, and 2013.

## Run the analysis

Use RStudio with Quarto and the R packages `knitr`, `rmarkdown`, and `reticulate`.
The first R chunk points to the course Python environment at
`~/aeds6400-python/bin/python`. Change that line if your Python is elsewhere.

In RStudio's **Terminal**, install the tested Python dependencies:

```bash
~/aeds6400-python/bin/python -m pip install pandas==3.0.6 numpy==2.5.3 matplotlib==3.11.2 statsmodels==0.15.0 python-calamine==0.9.0
```

The `calamine` reader is needed for this PSID Excel export. It avoids an
Excel metadata error encountered with `openpyxl`.

Restart the R session, open `index.qmd`, and click **Render**. Alternatively,
from the website project root run:

```bash
quarto render blog/posts/post6/index.qmd
```

The code reads the local official extract and rebuilds the processed data,
SQL files, two results tables, and two figures. No data download occurs during
rendering. Tested with Python 3.13.2 and a full Quarto HTML render.

## Analytical choices and expected results

- A stable person ID combines original family ID and person number. Father IDs
  use `ER32016` and `ER32017`; zero father identifiers mean no identified link.
- Child and father must share a 1985 family ID, and the child's 1985 sequence
  must be 1–20, confirming presence in that family at the interview.
- Sequence 1 identifies current household heads. Children must be ages 27–32
  in 2001 and fathers ages 30–60 in 1985.
- Each person needs three usable observations in every applicable window.
  Nominal family incomes of $1 or less and missing incomes are excluded.
  Early PSID values of $1 include zero and negative income.
- Survey-year income refers to the previous calendar year. Income is converted
  to 2019 dollars using annual CPI-U, then averaged before taking logarithms.
- Father income: 1983–1985, with 1984 as the single year. Early adult-child
  income: 1998, 2000, 2002, with 2000 as the single year. Later income:
  2008, 2010, 2012, with 2010 as the single year.
- All four OLS models use the same sample and an intercept. Standard errors
  are clustered by father because siblings can have related outcomes.

Expected output for the tested extract: **170 children and 152 fathers**.
IGE estimates, in the article's order, are approximately **0.502, 0.529,
0.574, and 0.659**. The age comparison holds the father's multiyear measure
fixed. It demonstrates measurement sensitivity, not a pure age effect or
a known amount of bias relative to unobserved lifetime income.

The model table also reports R-squared. For the later three-year average,
R-squared is about 0.183: the regression explains about 18% of the sample
variation in logged adult-child family income. The fitted income ratio for
a doubling of parental income is `2 ** 0.659`, or about 1.58.

A short paired check regresses `log(later_mean / early_mean)` on
`log(parent_mean)` and an intercept, again clustering by father. Because
both age regressions use exactly the same children and parental predictor,
this slope equals the difference between their IGEs. The estimated change
is 0.130, with a 95% confidence interval of approximately [-0.021, 0.280].
The interval includes zero, so the sample does not establish an increase
in IGE between these two age windows. Calendar conditions and family
composition also change over time. The check is saved in
`results/tables/timing_comparison.csv`.

This selected, unweighted sample of household heads is not nationally
representative. Family income includes other family members' resources;
family composition and calendar conditions may change over time.

## GitHub and sources

Keep the accompanying `.gitignore`. Commit the QMD, README, SQL queries,
aggregate results table, and figures. **Do not commit the raw Excel file,
processed individual records, or matched-pair records.** Other users should
register and obtain their own extract through PSID.

The website writes this page to `docs/blog/posts/post6/index.html`.
After rendering the post, render `blog/index.qmd` to refresh the blog listing.
Commit the source and rendered website files following the project's publishing workflow.
The Sources section at the bottom of `index.qmd` cites PSID, the codebooks,
BLS CPI-U, Haider and Solon (2006), and Python SQLite documentation.
