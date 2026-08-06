# =============================================================================
# Descriptive statistics for language-background data
# =============================================================================
#
# WHAT THIS SCRIPT DOES
#   Takes a participant-level dataset describing language background
#   (which languages, age of acquisition, use in childhood vs adulthood,
#   self-rated proficiency) and produces:
#
#     1. A cleaned, standardised data frame
#     2. Participant groups derived from an ID code (mono-/bi-/tri-/quadrilingual)
#     3. Console tables of descriptive statistics, per group and overall
#     4. The same tables exported to a formatted Word document
#     5. Optional CSV exports, one per group
#
# HOW TO USE IT
#   Out of the box the script runs on a small synthetic dataset it generates
#   itself, so you can execute it top to bottom with no data file. To run it
#   on real data, set USE_DEMO_DATA <- FALSE and point DATA_FILE at your file.
#
# NOTE ON DATA
#   No real participant data is included in this repository. Paths are
#   relative, the demo data is randomly generated, and language labels are
#   generic placeholders ("Language A", "Language B", ...). Edit the CONFIG
#   block to match your own study.
#
# STRUCTURE
#   0. Packages
#   1. Configuration
#   2. Helper functions
#   3. Demo data generator
#   4. Load and standardise
#   5. Assign language groups
#   6. Descriptive tables
#   7. Console report
#   8. Word report
#   9. Optional exports and quick exploration
#
# =============================================================================


# -----------------------------------------------------------------------------
# 0. PACKAGES
# -----------------------------------------------------------------------------
# Never call install.packages() inside a script that others will run: it
# mutates their library without asking. Check and report instead.

required <- c("dplyr", "tidyr", "readxl")
optional <- c("flextable", "officer")   # only needed for the Word export

missing <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing) > 0) {
  stop("Missing required packages: ", paste(missing, collapse = ", "),
       "\nInstall them with: install.packages(c(",
       paste0('"', missing, '"', collapse = ", "), "))")
}

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(readxl)
})

CAN_EXPORT_DOCX <- all(vapply(optional, requireNamespace, logical(1), quietly = TRUE))
if (!CAN_EXPORT_DOCX) {
  message("Note: flextable/officer not installed - the Word export will be skipped.")
}


# -----------------------------------------------------------------------------
# 1. CONFIGURATION
# -----------------------------------------------------------------------------
# Everything study-specific lives here. Nothing below this block should need
# editing to adapt the script to a different dataset.

USE_DEMO_DATA <- TRUE                          # FALSE to use your own file

DATA_DIR   <- "data"                           # relative to the project root
OUTPUT_DIR <- "output"
DATA_FILE  <- file.path(DATA_DIR, "language_background.xlsx")
DOCX_FILE  <- file.path(OUTPUT_DIR, "descriptive_stats.docx")

# How many language slots does each participant have (L1 ... Ln)?
N_LANG_SLOTS <- 4

# Canonical language labels. Replace with the real languages in your study.
LANG_LEVELS <- c("Language A", "Language B", "Language C", "Other")

# Raw spellings found in the data mapped onto canonical labels. Real datasets
# are messy - typos, accents, capitalisation, two names for one language - so
# keep every observed variant here rather than fixing values by hand.
LANG_VARIANTS <- list(
  "Language A" = c("lang_a", "langa", "language a", "a"),
  "Language B" = c("lang_b", "langb", "language b", "b"),
  "Language C" = c("lang_c", "langc", "language c", "c")
)

# Participant ID codes. Example ID: "P001-A-BI-01"
# The group is read from whichever hyphen-separated segment matches a key below.
ID_SEPARATOR <- "-"
GROUP_CODES <- c(
  MO   = "Monolingual",
  BI   = "Bilingual",
  TRI  = "Trilingual",
  QUAD = "Quadrilingual"
)

# Standard column names used throughout the script. If your file uses
# different headers, list them in COLUMN_MAP below rather than renaming
# anything downstream.
ID_COL <- "participant_id"

lang_col      <- function(i) paste0("l", i)                # L1, L2, ...
age_col       <- function(i) paste0("l", i, "_age")        # age of acquisition
childhood_col <- function(i) paste0("l", i, "_childhood")  # % use in childhood
adulthood_col <- function(i) paste0("l", i, "_adulthood")  # % use in adulthood

PROFICIENCY_COLS <- c(
  spoken_proficiency  = "Spoken",
  reading_proficiency = "Reading",
  writing_proficiency = "Writing"
)

# Rename raw headers -> script names. Format: "name in your file" = "name here".
# Left empty because the demo data already uses the standard names.
COLUMN_MAP <- c(
  # "ID"            = "participant_id",
  # "L1-age"        = "l1_age",
  # "L1-childhood"  = "l1_childhood"
)

HEADER_FILL  <- "#2C5F8A"   # table header colour in the Word output
ROUND_DIGITS <- 2

set.seed(42)                # reproducible demo data


# -----------------------------------------------------------------------------
# 2. HELPER FUNCTIONS
# -----------------------------------------------------------------------------

# Descriptive statistics for one continuous variable.
# Returns a one-row data frame so results can be stacked with bind_rows().
cont_stats <- function(x, digits = ROUND_DIGITS) {
  x <- suppressWarnings(as.numeric(x))
  x <- x[!is.na(x)]
  if (length(x) == 0) {
    return(data.frame(n = 0, Mean = NA, SD = NA, Median = NA, Min = NA, Max = NA))
  }
  data.frame(
    n      = length(x),
    Mean   = round(mean(x), digits),
    SD     = round(stats::sd(x), digits),
    Median = round(stats::median(x), digits),
    Min    = round(min(x), digits),
    Max    = round(max(x), digits)
  )
}

# Frequency table for one categorical variable, sorted by descending count.
freq_table <- function(x) {
  x <- as.character(x)
  x <- x[!is.na(x) & !(tolower(x) %in% c("na", ""))]
  if (length(x) == 0) {
    return(data.frame(Value = "No data", n = 0, Percent = "0%"))
  }
  tbl <- sort(table(x), decreasing = TRUE)
  data.frame(
    Value   = names(tbl),
    n       = as.integer(tbl),
    Percent = paste0(round(100 * as.integer(tbl) / sum(tbl), 1), "%"),
    row.names = NULL
  )
}

# Collapse messy free-text language names onto the canonical labels.
# Anything non-empty that doesn't match a known variant becomes "Other",
# which keeps unexpected values visible instead of silently dropping them.
normalise_lang <- function(x, variants = LANG_VARIANTS) {
  x <- tolower(trimws(as.character(x)))
  out <- rep(NA_character_, length(x))
  for (canonical in names(variants)) {
    hits <- x %in% tolower(variants[[canonical]])
    out[hits] <- canonical
  }
  unknown <- is.na(out) & !is.na(x) & !(x %in% c("", "na"))
  out[unknown] <- "Other"
  out
}

# Console formatting.
header <- function(title, width = 70) {
  cat("\n", strrep("=", width), "\n", sep = "")
  cat(" ", title, "\n", sep = "")
  cat(strrep("=", width), "\n", sep = "")
}

subheader <- function(title) cat("\n--", title, "--\n")

# Consistent flextable styling for the Word export.
make_flextable <- function(df, title) {
  flextable::flextable(df) |>
    flextable::set_caption(title) |>
    flextable::theme_booktabs() |>
    flextable::bold(part = "header") |>
    flextable::bg(part = "header", bg = HEADER_FILL) |>
    flextable::color(part = "header", color = "white") |>
    flextable::autofit()
}

# Add a titled table to a Word document, preceded by a blank paragraph.
add_table <- function(doc, df, title) {
  doc <- officer::body_add_par(doc, "", style = "Normal")
  flextable::body_add_flextable(doc, make_flextable(df, title))
}


# -----------------------------------------------------------------------------
# 3. DEMO DATA GENERATOR
# -----------------------------------------------------------------------------
# Generates a plausible but entirely synthetic dataset so the script is
# runnable by anyone. Deliberately includes messy language spellings and
# missing values, because that is what the cleaning code exists to handle.

make_demo_data <- function(n = 87, n_slots = N_LANG_SLOTS) {

  group_code <- sample(names(GROUP_CODES), n, replace = TRUE,
                       prob = c(0.15, 0.35, 0.35, 0.15))
  n_langs <- match(group_code, names(GROUP_CODES))   # MO = 1 language, BI = 2, ...

  df <- data.frame(
    participant_id = sprintf("P%03d-%s-%s-%02d",
                             seq_len(n),
                             sample(c("A", "B"), n, replace = TRUE),
                             group_code,
                             sample(1:20, n, replace = TRUE)),
    stringsAsFactors = FALSE
  )

  # Messy variants so normalise_lang() has something to do.
  pool <- c("lang_a", "LangA", "Language A", "lang_b", "LANGB",
            "language b", "lang_c", "Lang C", "esperanto")

  for (i in seq_len(n_slots)) {
    has_lang <- n_langs >= i

    df[[lang_col(i)]]      <- ifelse(has_lang, sample(pool, n, replace = TRUE), NA)
    df[[age_col(i)]]       <- ifelse(has_lang,
                                     round(pmax(0, stats::rnorm(n, mean = 2 + 6 * (i - 1), sd = 3))),
                                     NA)
    df[[childhood_col(i)]] <- ifelse(has_lang,
                                     round(pmin(100, pmax(0, stats::rnorm(n, 60 - 15 * (i - 1), 20)))),
                                     NA)
    df[[adulthood_col(i)]] <- ifelse(has_lang,
                                     round(pmin(100, pmax(0, stats::rnorm(n, 40 + 5 * (i - 1), 20)))),
                                     NA)
  }

  for (col in names(PROFICIENCY_COLS)) {
    df[[col]] <- sample(1:7, n, replace = TRUE)
  }

  # A realistic scatter of missing values.
  df[sample(seq_len(n), 5), "spoken_proficiency"] <- NA
  df
}


# -----------------------------------------------------------------------------
# 4. LOAD AND STANDARDISE
# -----------------------------------------------------------------------------

load_data <- function() {
  if (USE_DEMO_DATA) {
    message("Using synthetic demo data (set USE_DEMO_DATA <- FALSE for real data).")
    return(make_demo_data())
  }
  if (!file.exists(DATA_FILE)) {
    stop("Data file not found: ", normalizePath(DATA_FILE, mustWork = FALSE),
         "\nCheck DATA_FILE in the CONFIG block, or set USE_DEMO_DATA <- TRUE.")
  }
  ext <- tolower(tools::file_ext(DATA_FILE))
  raw <- switch(ext,
    "xlsx" = readxl::read_excel(DATA_FILE),
    "xls"  = readxl::read_excel(DATA_FILE),
    "csv"  = utils::read.csv(DATA_FILE, stringsAsFactors = FALSE, check.names = FALSE),
    stop("Unsupported file type: .", ext)
  )
  as.data.frame(raw, check.names = FALSE)
}

# Apply COLUMN_MAP, then confirm the columns the analysis depends on exist.
standardise_columns <- function(df, column_map = COLUMN_MAP) {
  if (length(column_map) > 0) {
    hits <- match(names(column_map), names(df))
    names(df)[stats::na.omit(hits)] <- column_map[!is.na(hits)]
  }
  expected <- c(
    ID_COL,
    unlist(lapply(seq_len(N_LANG_SLOTS),
                  function(i) c(lang_col(i), age_col(i),
                                childhood_col(i), adulthood_col(i)))),
    names(PROFICIENCY_COLS)
  )
  missing_cols <- setdiff(expected, names(df))
  if (length(missing_cols) > 0) {
    warning("Columns not found and skipped:\n  ",
            paste(missing_cols, collapse = ", "), call. = FALSE)
  } else {
    message("All expected columns found.")
  }
  df
}


# -----------------------------------------------------------------------------
# 5. ASSIGN LANGUAGE GROUPS
# -----------------------------------------------------------------------------
# Reads the group from the ID by splitting on the separator and matching whole
# segments. Splitting beats a regex like grepl("BI", id): substring matching
# would fire on any ID that happens to contain those letters.

assign_group <- function(df, id_col = ID_COL, codes = GROUP_CODES) {
  ids <- as.character(df[[id_col]])
  segments <- strsplit(toupper(ids), ID_SEPARATOR, fixed = TRUE)

  df$language_group <- vapply(segments, function(parts) {
    hit <- parts[parts %in% toupper(names(codes))]
    if (length(hit) == 1) unname(codes[[match(hit[1], toupper(names(codes)))]]) else "Unknown"
  }, character(1))

  df$language_group <- factor(df$language_group,
                              levels = c(unname(codes), "Unknown"))

  cat("\nParticipants per language group:\n")
  print(table(df$language_group))

  unmatched <- df[df$language_group == "Unknown", id_col, drop = TRUE]
  if (length(unmatched) > 0) {
    cat("\nUnmatched or ambiguous IDs (", length(unmatched), "):\n", sep = "")
    print(unmatched)
  } else {
    cat("\nAll IDs matched a group.\n")
  }
  df
}

split_by_group <- function(df) {
  groups <- split(df, df$language_group, drop = TRUE)
  groups[vapply(groups, nrow, integer(1)) > 0]
}


# -----------------------------------------------------------------------------
# 6. DESCRIPTIVE TABLES
# -----------------------------------------------------------------------------
# Each function returns a plain data frame, so the same result can be printed
# to the console, written to Word, or exported to CSV without recomputation.

# Age of acquisition per language slot.
table_aoa <- function(dat) {
  rows <- lapply(seq_len(N_LANG_SLOTS), function(i) {
    col <- age_col(i)
    stats_row <- if (col %in% names(dat)) cont_stats(dat[[col]]) else cont_stats(numeric(0))
    cbind(Variable = paste0("L", i, " - age of acquisition"), stats_row)
  })
  do.call(rbind, rows)
}

# Which languages occupy the L1 and L2 slots, side by side.
table_lang_identity <- function(dat) {
  slots <- seq_len(min(2, N_LANG_SLOTS))
  cats  <- lapply(slots, function(i) {
    col <- lang_col(i)
    if (col %in% names(dat)) normalise_lang(dat[[col]]) else character(0)
  })

  out <- data.frame(Language = c(LANG_LEVELS, "TOTAL"), stringsAsFactors = FALSE)
  for (i in slots) {
    cat_i  <- cats[[i]]
    counts <- vapply(LANG_LEVELS, function(l) sum(cat_i == l, na.rm = TRUE), integer(1))
    total  <- sum(!is.na(cat_i))
    pct    <- if (total > 0) paste0(round(100 * counts / total, 1), "%") else rep("-", length(counts))
    out[[paste0("L", i, "_n")]]   <- c(counts, total)
    out[[paste0("L", i, "_pct")]] <- c(pct, if (total > 0) "100%" else "-")
  }
  out
}

# Mean use in childhood vs adulthood, per language slot.
table_period <- function(dat) {
  safe <- function(col, f) {
    if (!col %in% names(dat)) return(NA_real_)
    v <- suppressWarnings(as.numeric(dat[[col]]))
    if (all(is.na(v))) NA_real_ else round(f(v, na.rm = TRUE), 1)
  }
  data.frame(
    Slot            = paste0("L", seq_len(N_LANG_SLOTS)),
    Childhood_mean  = vapply(seq_len(N_LANG_SLOTS), function(i) safe(childhood_col(i), mean), numeric(1)),
    Childhood_SD    = vapply(seq_len(N_LANG_SLOTS), function(i) safe(childhood_col(i), stats::sd), numeric(1)),
    Adulthood_mean  = vapply(seq_len(N_LANG_SLOTS), function(i) safe(adulthood_col(i), mean), numeric(1)),
    Adulthood_SD    = vapply(seq_len(N_LANG_SLOTS), function(i) safe(adulthood_col(i), stats::sd), numeric(1))
  )
}

# Self-rated proficiency.
table_proficiency <- function(dat) {
  rows <- lapply(names(PROFICIENCY_COLS), function(col) {
    stats_row <- if (col %in% names(dat)) cont_stats(dat[[col]]) else cont_stats(numeric(0))
    cbind(Variable = unname(PROFICIENCY_COLS[[col]]), stats_row)
  })
  do.call(rbind, rows)
}

# L1 x L2 contingency table with row and column totals.
table_crosstab <- function(dat) {
  if (N_LANG_SLOTS < 2 || !all(c(lang_col(1), lang_col(2)) %in% names(dat))) return(NULL)
  l1 <- normalise_lang(dat[[lang_col(1)]])
  l2 <- normalise_lang(dat[[lang_col(2)]])
  keep <- !is.na(l1) & !is.na(l2)
  if (sum(keep) == 0) return(NULL)

  ct <- addmargins(table(L1 = l1[keep], L2 = l2[keep]))
  ct <- as.data.frame.matrix(ct)
  cbind(L1 = rownames(ct), ct, row.names = NULL)
}

# Build every table for one subset in a single call.
build_all_tables <- function(dat) {
  list(
    "Age of acquisition"                  = table_aoa(dat),
    "Language identity (L1 and L2)"       = table_lang_identity(dat),
    "Language use: childhood vs adulthood" = table_period(dat),
    "Self-rated proficiency (1-7)"        = table_proficiency(dat),
    "L1 x L2 crosstab (counts)"           = table_crosstab(dat)
  )
}


# -----------------------------------------------------------------------------
# 7. CONSOLE REPORT
# -----------------------------------------------------------------------------

print_report <- function(dat, label) {
  header(paste0(label, "  (n = ", nrow(dat), ")"))
  tables <- build_all_tables(dat)
  for (title in names(tables)) {
    if (is.null(tables[[title]])) next
    subheader(title)
    print(tables[[title]], row.names = FALSE)
  }
  invisible(tables)
}


# -----------------------------------------------------------------------------
# 8. WORD REPORT
# -----------------------------------------------------------------------------

write_docx_report <- function(subsets, path = DOCX_FILE) {
  if (!CAN_EXPORT_DOCX) {
    message("Skipping Word export (flextable/officer not available).")
    return(invisible(NULL))
  }
  dir.create(dirname(path), showWarnings = FALSE, recursive = TRUE)

  doc <- officer::read_docx()
  doc <- officer::body_add_par(doc, "Descriptive statistics: language background",
                               style = "heading 1")
  doc <- officer::body_add_par(doc, format(Sys.Date(), "Generated %d %B %Y"),
                               style = "Normal")

  for (label in names(subsets)) {
    dat <- subsets[[label]]
    doc <- officer::body_add_par(doc, paste0(label, " (n = ", nrow(dat), ")"),
                                 style = "heading 2")
    tables <- build_all_tables(dat)
    for (title in names(tables)) {
      if (is.null(tables[[title]])) next
      doc <- add_table(doc, tables[[title]], title)
    }
  }

  print(doc, target = path)
  message("Word document written to: ", normalizePath(path))
  invisible(path)
}


# -----------------------------------------------------------------------------
# 9. RUN
# -----------------------------------------------------------------------------

df <- load_data() |> standardise_columns() |> assign_group()

groups  <- split_by_group(df)
subsets <- c(list("Full sample" = df), groups)

# Console output
for (label in names(subsets)) print_report(subsets[[label]], label)

# Word output
write_docx_report(subsets)


# --- Optional: one CSV per group ---------------------------------------------
# Writes only derived group files, never the raw dataset.

write_group_csvs <- function(groups, dir = OUTPUT_DIR) {
  dir.create(dir, showWarnings = FALSE, recursive = TRUE)
  for (label in names(groups)) {
    path <- file.path(dir, paste0(tolower(gsub("\\s+", "_", label)), ".csv"))
    utils::write.csv(groups[[label]], path, row.names = FALSE)
  }
  message("Wrote ", length(groups), " group CSV files to ", normalizePath(dir))
}

# write_group_csvs(groups)


# --- Optional: quick exploration ---------------------------------------------
# Kept commented: these are interactive checks, not part of the pipeline.

# summary(df)
# psych::describe(df)                     # richer summary: skew, kurtosis, SE
# rstatix::get_summary_stats(df)          # tidy summary, easy to pipe
# gtsummary::tbl_summary(df)              # publication-ready summary table
#
# hist(df$spoken_proficiency, main = "Spoken proficiency", xlab = "Rating (1-7)")
# boxplot(spoken_proficiency ~ language_group, data = df,
#         main = "Spoken proficiency by group", xlab = "", ylab = "Rating (1-7)")
#
# df |>
#   group_by(language_group) |>
#   summarise(across(where(is.numeric), list(mean = ~mean(.x, na.rm = TRUE),
#                                            sd   = ~sd(.x,   na.rm = TRUE))))

header("Done.")
