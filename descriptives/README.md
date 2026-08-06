# Descriptive statistics for language-background data

A single, self-contained R script for summarising participant-level language
background data: age of acquisition, language use across the lifespan,
self-rated proficiency, and group comparisons.

## Running it

```r
source("descriptive_stats.R")
```

It runs out of the box on synthetic data that it generates itself — no data
file needed. To use your own data, edit the CONFIG block near the top:

```r
USE_DEMO_DATA <- FALSE
DATA_FILE     <- file.path("data", "your_file.xlsx")
```

## What it produces

- Console tables of descriptives, for the full sample and per language group
- A formatted Word document (`output/descriptive_stats.docx`)
- Optionally, one CSV per group

## Requirements

Required: `dplyr`, `tidyr`, `readxl`
Optional: `flextable`, `officer` (Word export; skipped if absent)

```r
install.packages(c("dplyr", "tidyr", "readxl", "flextable", "officer"))
```

## Data

No participant data is included here. The demo dataset is randomly generated,
paths are relative to the project root, and language labels are generic
placeholders. Add `data/` and `output/` to `.gitignore` before pushing.
