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


