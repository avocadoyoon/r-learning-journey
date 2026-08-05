# r-learning-journey

A personal, open-ended record of me learning R. This repo is not a course, a package, or a tutorial series — it's a working notebook. Scripts land here as I write them, in whatever order I happen to learn things.

## What's in here

Roughly two kinds of files:

**1. Fundamentals**
Short scripts where I work through the basics: vectors and data types, subsetting, control flow, writing functions, `apply`/`map` family, reading and writing files, and general "how does this actually behave" experiments.

**2. Practice on a synthetic prosody dataset**
Most of the applied work uses a **fake prosody dataset I generated myself**. It's designed to look like the kind of data you'd get from an annotated speech corpus (speakers, items, conditions, f0 and duration measures), which makes it a good sandbox for:

- data wrangling and reshaping (`dplyr`, `tidyr`)
- plotting, mostly `ggplot2` — distributions, group comparisons, faceting, custom themes
- descriptive and inferential statistics
- linear mixed-effects models (`lme4`, `lmerTest`) with random effects for speaker and item
- model checking, diagnostics, and interpreting output

> ⚠️ **The data is not real.** It was simulated for practice only. Nothing here should be read as a finding about prosody, speech, or any language.

## Structure

```
r-learning-journey/
├── basics/          # fundamentals, syntax, small exercises
├── wrangling/       # cleaning and reshaping practice
├── plots/           # ggplot2 practice
├── models/          # statistics and mixed models
├── data/            # simulated prosody data + generation script
└── README.md
```

*(Adjust these folder names to match what you actually end up using — or drop the section entirely if you'd rather keep everything flat.)*

## Tools

Written in R (RStudio). Packages that show up most often:

`tidyverse` · `ggplot2` · `dplyr` · `tidyr` · `lme4` · `lmerTest` · `emmeans` · `broom`

## Notes on how to read this repo

- Scripts are **exploratory**. There's trial and error, commented-out lines, and things I later did better elsewhere. That's intentional — the mistakes are part of the record.
- Topics are **not sequential**. A file from last month might be more advanced than one from this week.
- Older scripts don't get retroactively cleaned up. If something looks clumsy, it probably reflects what I knew at the time.

## Why this exists

Mostly for myself: to keep track of what I've tried, to have somewhere to look things up, and to see progress over time. If someone else finds a snippet useful, that's a bonus.
