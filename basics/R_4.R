# This script was practiced with "perry_winter_2017_iconicity.xlsx" which can be found in OSF.

# Categorical*Continuous interactions
library(tidyverse)
library(broom)
icon <- perry_winter_2017_iconicity

unique(icon$POS)

# Use table()to check how many words there are per parts of speech. If you wrap 
# sort() around the table, the categories will be sorted in terms of ascending counts.

sort(table(icon$POS)) 

# filter nouns and verbs
NV <- filter(icon, POS %in% c('Noun', 'Verb'))
table(NV$POS)

NV_mdl <- lm(Iconicity ~ SER + POS, data = NV)
tidy(NV_mdl) %>% select(term, estimate)

# the intercept is the prediction for nouns with 0 sensory experience ratings. You know 
# that nouns are in the intercept (reference level) because it says 'POSVerb' in the out
# put, and because 'n' comes before 'v' in the alphabet. The positive coefficient (+0.60) 
# thus shows that verbs are more iconic than nouns.

# There are two alternative ways of specifying interactions in model formulas:
  # lm(iconicity ~ SER * POS, data = NV)
# Same as:
# lm(iconicity ~ SER + POS + SER:POS, data = NV)
# The latter effectively 'spells out' the more compressed 'SER * POS' notation and highlights that 
# the interaction involves a third term in the model, SER:POS.


NV_int_mdl <- lm(Iconicity ~ SER * POS, data = NV)
tidy(NV_int_mdl) %>% select(term, estimate) 


# Center SER:
NV <- mutate(NV, SER_c = SER - mean(SER, na.rm = TRUE))
# Fit model with centered predictor:
NV_int_mdl_c <- lm(Iconicity ~ SER_c * POS, data = NV)
#	Check	coefficients:
tidy(NV_int_mdl_c) %>% select(term, estimate)



# Categorical*Categorical interactions
sim <- winter_matlock_2013_similarity
sim

# use count() to check the number of data points per condition.
library(tidyverse)

sim %>% count(Phon, Sem)


# missing values can be assessed as follows using the is.na() function.
# The result is a logical vector containing TRUE values (for NAs) and FALSE values for complete cases. 
# When the sum() function is used on a logical vector, TRUE values are treated as 1s, and FALSE values as 0s.

sum(is.na(sim$Distance))

# Either one of the following two filter() commands exclude this data point.
sim	<-	filter(sim,	!is.na(Distance))

# Same as:

sim	<-	filter(sim,	complete.cases(Distance))

# Let's verify that the new tibble has indeed one row less:
nrow(sim)

# To get a feel for the Distance measure, compute the range.

range(sim$Distance)

library(broom)

sim_mdl	<-	lm(Distance	~	Phon	+	Sem,	data	=	sim)
tidy(sim_mdl) %>% select(term, estimate) 

# Because 'd' comes before 's' in the alphabet, R will assign the reference level to 
# 'Different' for both predictors. This results in the slopes expressing the change 
# from 'Different' to 'Similar'. As always, it's good to ask yourself what's in 
# the intercept. Here, the intercept represents the estimated distance (79.6mm) for  
# the phonologically different and semantically different condition (i.e., when both 
# are 0). Correspondingly, the two coefficients PhonSimilar and 

# Now, fit a model with the interaction term:

sim_mdl_int	<-	lm(Distance	~	Phon	*	Sem,	data	=	sim)
tidy(sim_mdl_int) %>% select(term, estimate) 

# It is absolutely essential that you remind yourself that you cannot interpret the effects of 
# the two predictors in isolation anymore.

# --------------------------------------------------------------
# Understanding 'simple effects' and 'main effects'
# --------------------------------------------------------------

# 'Simple effects' refer to the influence of one predictor 
# for a specific level of another predictor.

# 'Main effects' represent the average effect of one predictor, 
# regardless of the levels of the other predictor.

# Misinterpreting simple effects as main effects is a common problem in linguistics.

# --------------------------------------------------------------
# Using predict() to automate this process
# --------------------------------------------------------------

# If you are unsure about manually calculating effects, 
# you can use the predict() function instead.

# Step 1: Create a dataset containing all combinations of conditions 
# for which predictions should be generated.

# --------------------------------------------------------------
# Creating condition vectors
# --------------------------------------------------------------

# The rep() function repeats elements in vectors.
# rep(x, each = 2) ??? repeats each element twice.
# rep(x, times = 2) ??? repeats the entire vector twice.
# This distinction helps generate all combinations of conditions.

# --------------------------------------------------------------
# Example: defining two condition vectors
# --------------------------------------------------------------

# Create 'Different', 'Different', 'Similar', 'Similar' for phonological conditions:
Phon <- rep(c('Different', 'Similar'), each = 2)
Phon

# Create 'Different', 'Similar', 'Different', 'Similar' for semantic conditions:
Sem <- rep(c('Different', 'Similar'), times = 2)
Sem

# --------------------------------------------------------------
# Creating a tibble containing all condition combinations
# --------------------------------------------------------------

# To store both condition vectors, create a tibble:
library(tibble)  # Make sure tibble is loaded
newdata <- tibble(Phon, Sem)

# View the new dataset
newdata

# Append predictions to tibble:
newdata$fit	<-	predict(sim_mdl_int,	newdata)
newdata


# --------------------------------------------------------------
# Computing average predictions by condition
# --------------------------------------------------------------

# Assume you have model predictions stored in a column called 'fit'
# inside your 'newdata' tibble (from previous steps).

# To compute the average predicted distance for each semantic condition:
newdata %>%
  group_by(Sem) %>%
  summarize(distM = mean(fit))

# Interpretation:
# The model predicts that in the semantically *similar* condition,
# participants drew the cities approximately 10 mm closer together.

# --------------------------------------------------------------
# Changing the coding scheme from treatment to sum coding
# --------------------------------------------------------------

# By default, R uses treatment coding: categories coded as 0 and 1.
# Sum coding instead uses -1 and +1.
# This centers categorical predictors, setting "0" halfway between categories.

# The main effect coefficients in a sum-coded model represent average effects,
# not effects relative to one particular category.

# --------------------------------------------------------------
# Step 1: Convert predictors to factors
# --------------------------------------------------------------

sim <- mutate(sim,
              Phon_sum = factor(Phon),
              Sem_sum = factor(Sem))

# --------------------------------------------------------------
# Step 2: Apply sum coding to the factor predictors
# --------------------------------------------------------------

contrasts(sim$Phon_sum) <- contr.sum(2)
contrasts(sim$Sem_sum)  <- contr.sum(2)

# --------------------------------------------------------------
# Step 3: Refit the model with sum-coded predictors
# --------------------------------------------------------------

sum_mdl <- lm(Distance ~ Phon_sum * Sem_sum, data = sim)

# View key model coefficients
tidy(sum_mdl) %>% select(term, estimate)

# --------------------------------------------------------------
# Interpreting the Sem_sum1 coefficient
# --------------------------------------------------------------

# The Sem_sum1 estimate (??? 5.06) represents **half** the difference
# between the two semantic conditions because sum coding spans a 2-unit change (-1 ??? +1).
# Therefore, the full average difference ??? 5.06 * 2 = 10.12 mm.

# --------------------------------------------------------------
# Practical notes
# --------------------------------------------------------------

# - Once predictors are sum-coded, the model's main effects represent true *main effects*.
# - The intercept now approximates the grand mean (the overall average distance).
# - The sign (+/-) of a sum-coded coefficient indicates direction,
#   but for a quick conceptual understanding, you can often focus on its magnitude.
# - If interpreting contrasts feels difficult, you can always use predict()
#   to compute meaningful comparisons numerically.



# Continuous*Continuous interactions
# An interaction between two continuous predictors.
# First, the fact that the continuous predictors aren’t centered
# The following mutate() command standardizes both continuous predictors.



# Non-linear Effects
# What if the data does not follow a straight line? 
# Like interactions, such nonlinearities can be modeled by multiplications of predictor variables.


# Modeling Curved Relationships with Polynomials

# When data shows a curve (not straight line), use polynomial terms
# Visual inspection → quadratic (U-shaped/parabolic) effect here

# Quadratic = parabola = f(x) = x² (x multiplied by itself)
x <- -10:10
plot(x, x^2, type = 'b')  # Creates classic U-shaped curve

# Cubic = S-shaped = f(x) = x³ (x multiplied by itself 3 times)  
x <- -10:10
plot(x, x^3, type = 'b')  # Creates S-shaped curve

# In regression models:
# Instead of: lm(y ~ x)
# Use:       lm(y ~ x + I(x^2))     # Quadratic
# Or:        lm(y ~ x + I(x^2) + I(x^3))  # Cubic

# I() = "as-is" - tells R to treat x^2 as a new variable
# type='b' = points AND lines in plot



# High order Interactions
#  It’s also possible to fit interactions between more than two variables. 


# Interaction Terms - Higher-Order Complexity

# Three-way interaction: A * B * C
# Problem: No predictor can be interpreted alone anymore!
# Each main effect A, B, C is now conditional on the others
# Two-way interactions (A:B, B:C, A:C) are MODULATED by the three-way term

# Rule of thumb: Avoid complex interactions unless theory justifies them
# (3-way OK if you have strong theoretical reason, 4-way = usually overkill)

# Strategic formula: Limit interactions you DON'T want
y ~ (A + B) * C
# This = main effects (A, B, C) + specific interactions (A:C, B:C)
# NO A:B interaction, NO three-way A:B:C

# Equivalent expanded form:
y ~ A + B + A:C + B:C

# * = shorthand for "main effects + all interactions up to that level"
# : = specific interaction only (no main effects)

# Strategy for beginners:
# 1. Start with main effects
# 2. Add 2-way interactions with clear theory  
# 3. Use (A + B) * C to control exactly which interactions you get



## Inferential Statistics 1
# Significance Testing


# Statistical Inference - Core Concepts

# Inferential statistics: Using sample estimates → population parameters
# Sample = "snapshot" of population → different samples = different estimates
# Inference = always uncertain (we don't have full population data)

# Key Greek symbols (population parameters):
# μ = true population mean
# σ = true population standard deviation  
# β = true regression coefficients

# Sample estimates (what we calculate):
# x̄ = sample mean → estimates μ
# s = sample standard deviation → estimates σ
# b = regression coefficients → estimate β ("beta")

# Uncertainty quantification:
# Inferential stats tells us: "How confident are we in our claims?"
# Example: "90% confident true β is between 0.2 and 0.8"

# Process:
# 1. Take sample → calculate estimates (x̄, s, b's)
# 2. Use inferential methods → confidence intervals, p-values
# 3. Make claims about population (μ, σ, β's) with quantified uncertainty

# Linguistics note: Defining "population" can be tricky!


# Statistical Inference - NHST & Effect Sizes

# Null Hypothesis Significance Testing (NHST)
# Most common approach, but controversial (many critics!)
# Historical mix of Fisher + Neyman-Pearson ideas
# Frequentist view: Probability = long-run frequencies (not single events)

# 3 Key Ingredients for Confidence in Population Claims:
# 1. Effect magnitude (bigger difference = more confident)
# 2. Variability (less noise = more confident)  
# 3. Sample size (bigger N = more precise)

# Cohen's d - Standardized Effect Size for mean differences
# d = (mean1 - mean2) / s_pooled
# Example: Women vs men voice pitch difference = 100Hz
# Large d = either big difference OR small variability (signal-to-noise ratio)

# Cohen's rules of thumb:
# d = 0.2 = small effect
# d = 0.5 = medium effect  
# d = 0.8 = large effect

# Similar to Pearson's r:
# r = cov(x,y) / (s_x * s_y)
# Both are "signal" (numerator) / "noise" (denominator)


# Less overlap between group distributions = easier to detect true difference
# Low variance + large mean difference = high confidence



# Let's compute cohen's d
library(tidyverse)

chem %>%
  filter(Modality %in% c('Taste', 'Smell'))
chem %>% print(n = 4)

# Cohen’s d is implemented in the cohen.d() function from the effsize package

install.packages("effsize")
library(effsize)
cohen.d(Val ~ Modality, data = chem)


## Standard	Errors	and	Confidence	Intervals
# Notice how the formulas for Cohen’s d or Pearson’s r have no term for the sample size N. 
# This means that large effects can be obtained even for very small samples.

# Correlate the points [1,2] and [2, 3]:
x <- c(1, 2)  # create x-values
y <- c(2, 3)  # create y-values
# Perform correlation:
cor(x, y)


# Standard Error & Confidence Intervals

# Standard Error (SE) - Measures PRECISION of sample estimates
# Formula: SE = s / √N
# Combines 2 ingredients:
# - s (variability in data) = NUMERATOR ↑ → SE ↑ (less precise)
# - N (sample size) = DENOMINATOR ↓ → SE ↓ (more precise)

# Intuition:
# Small SE = precise estimate (lots of data OR low variability)
# Large SE = uncertain estimate (small N OR high variability)

# 95% Confidence Interval (CI)
# Formula: estimate ± 1.96 * SE
# Example: mean = 100, SE = 2 → CI = [96.08, 103.92]

# In R:
# mean(mtcars$mpg)           # point estimate
# confint(lm(mpg ~ wt, mtcars))  # CIs for regression coefficients

# Why CIs > p-values?
# - Shows range of plausible values
# - Visualizes uncertainty
# - Effect size + precision in one number


# Confidence Intervals - Behavior & Interpretation

# CI shrinks with:
# - Bigger N (more data) → narrower CI (more precise)
# - Smaller s (less variability) → narrower CI (less noise)

# Figure 9.3 shows:
# Left → baseline
# Middle → bigger N → CI shrinks  
# Right → bigger s → CI widens

# Frequentist 95% CI meaning (TRICKY!):
# NOT: "95% probability true value is in THIS interval"
# YES: "If we repeat sampling 100 times, ~95 intervals contain true value"

# Coin analogy:
# Single coin flip = heads OR tails (not 50% probability after flip)
# CI = like one realized interval from many possible samples
# We can't say "95% chance true μ is in [95,105]" for THIS sample

# Key distinction:
# Frequentist: Interval random, parameter fixed
# Bayesian: Parameter random, interval fixed (credible interval)

# Practical use:
# Narrow CI = precise estimate
# Wide CI = high uncertainty
# Doesn't contain 0 = "statistically significant"



# Null Hypothesis Significance Testing (NHST) - Step 1

# Setup: State TWO hypotheses about POPULATION parameters (Greek letters!)

# Null Hypothesis (H₀) - "Statistical Scapegoat"
# H₀: μ₁ = μ₂   OR   H₀: μ₁ - μ₂ = 0
# Translation: "No difference between groups in population"
# We ASSUME this is true (like "innocent until proven guilty")

# Alternative Hypothesis (Hₐ or H₁) - What you actually believe
# Hₐ: μ₁ ≠ μ₂  
# Translation: "There IS a difference between groups"

# Key Points:
# - H₀ uses = (equality) - always about population (μ, not x̄)
# - We NEVER prove H₀ true/false directly
# - We test: "How compatible is my SAMPLE DATA with H₀?"

# Process:
# 1. Assume H₀ true (groups equal in population)
# 2. Calculate test statistic from sample data
# 3. Ask: "How unusual is this data IF H₀ were true?"
# 4. If VERY unusual → reject H₀ → support Hₐ

# H₀ = straw man we build to knock down with evidence


# t-test Statistic - Measures H₀ Incompatibility

# t Formula (for 2-group difference):
# t = (x̄₁ - x̄₂) / SE
# Where SE = s / √N (standard error)

# Combines ALL 3 ingredients:
# NUMERATOR: (x̄₁ - x̄₂) = raw effect size (Ingredient 1)
# DENOMINATOR: SE = s/√N = variability + sample size (Ingredients 2+3)

# Compare to Cohen's d:
# d = (x̄₁ - x̄₂) / s           # effect / variability
# t = (x̄₁ - x̄₂) / (s/√N)     # effect / (variability/sample size)

# Key difference:
# - d: Doesn't care about N
# - t: Gets BIGGER with larger N (more precise)

# Roman letters (x̄, s, t) = calculated from SAMPLE
# Greek letters (μ, σ) = population parameters

# Decision rule:
# |t| large = data VERY incompatible with H₀
# |t| small = data compatible with H₀

# Figure 9.5 shows:
# ↑ effect size → ↑ t
# ↓ variability → ↑ t  
# ↑ sample size → ↑ t

# p-Values & t-Distribution - Decision Making

# Under H₀ (equal means), t follows t-distribution
# Looks like normal curve but fatter tails (more extreme values possible)

# t-distribution says:
# - t near 0 = probable under H₀ (small group differences expected)
# - |t| large = improbable under H₀ (weird if groups truly equal)

# p-value = P(|t| ≥ observed t | H₀ true)
# Area in BOTH tails beyond your t-value
# Example: t = 1.5 → p = 0.14 (14% chance of this extreme if H₀ true)

# Alpha threshold (α = 0.05):
# p < 0.05 → reject H₀ → "statistically significant"
# Critical t = ±1.98 (where p crosses 0.05 line)

# Decision process:
# 1. Assume H₀: μ₁ = μ₂ (population groups equal)
# 2. Calculate t from sample
# 3. Find p = P(extreme t | H₀)
# 4. If p < 0.05 → data too weird for H₀ → act like groups differ

# CRITICAL: p-value tests H₀ only!
# "Data incompatible with no difference" ≠ "Proves groups differ"
# We never test Hₐ directly

# Null Hypothesis & t-test - SIMPLE DEFINITIONS

# NULL HYPOTHESIS (H₀)
# "There is NO effect/difference in the population"
# Examples:
# H₀: μ₁ = μ₂     (two groups have same population mean)
# H₀: β₁ = 0      (predictor has no effect)
# H₀: "No relationship exists"

# T-TEST
# Tests if sample data is "too weird" for H₀ to be true
# Formula: t = (observed difference) / (expected difference under H₀)

# For 2 groups:
# t = (x̄₁ - x̄₂) / SE
# Where SE = standard error of the difference

# Decision:
# |t| BIG + p < 0.05 → "Data too extreme for H₀" → reject H₀
# |t| SMALL + p > 0.05 → "Data plausible under H₀" → don't reject

# WORKFLOW:
# 1. Assume H₀ true (groups equal)
# 2. Calculate t from your data  
# 3. Check p-value: How rare is this t if H₀ true?
# 4. p < 0.05 → reject H₀ → "Groups probably differ!"

# R example:
# t.test(group1, group2)  # Gives t, p-value, decision

## Exercise 1
library(tibble)
install.packages("effectsize")
library(effectsize)

# Number of data points:
n <- 50
# Random y:
y <- c(rnorm(n, mean = 5, sd = 1),
       rnorm(n, mean = 2, sd = 1))
# Levels for x predictor:
x <- rep(c('A', 'B'), eac= n)
# Combine:
df <- tibble(x, y)
# Calculate Cohen's d:
cohen.d(y ~ x, df)



# Inferential Statistics 2: Issues in	Significance	Testing
10.1.  Common Misinterpretations of p-Values


# Several errors can happen when engaging in null hypothesis significance testing.
# Spuriously significant results are called Type I errors.
#
# - Type I error: obtaining a significant effect (reject H0) even though the null hypothesis
#   is actually true in the population.
#   Also known as a "false positive".
#
# - Type II error: failing to obtain a significant effect (failing to reject H0) even though
#   the null hypothesis is false in the population.
#   Also known as a "false negative".
#
# Table 10.1 helps to clarify Type I and Type II errors:
#   - Rows: two states of the world
#       1. Null hypothesis is true
#       2. Null hypothesis is false
#   - Columns: two decision outcomes based on the sample
#       1. p < 0.05 → reject H0 (significant result)
#       2. p >= 0.05 → fail to reject H0 (non-significant result)
#
# In an actual analysis, the true state of the world (whether H0 is true or false) is unknown;
# we only observe the sample and the resulting p-value.


# Creating a Type I error using t.test() in R

# Null hypothesis H0: no difference between the two groups (same distribution, mu = 0)
# Type I error = rejecting H0 when it is actually true (false positive)

# Fix the random seed so your numbers match mine
set.seed(42)

# Two samples from the same normal distribution (mu = 0, same population)
# Under H0, there is no real group difference; any “significant” result is a Type I error.
t.test(rnorm(10), rnorm(10))  # Run 1: compare two random samples (output not shown)
t.test(rnorm(10), rnorm(10))  # Run 2: another pair of random samples (output not shown)
t.test(rnorm(10), rnorm(10))  # Run 3: another pair of random samples (output not shown)
t.test(rnorm(10), rnorm(10))  # Run 4: this one may give p < 0.05 → Type I error

# Interpretation:
# - If any of these t-tests gives p < 0.05, you have rejected the null hypothesis
#   even though the null is true (same distribution, mu = 0).
# - Such a rejection is a Type I error (false positive).

# TYPE I error
set.seed(42) # set random number seed
t.test(rnorm(10), rnorm(10)) # output not shown
t.test(rnorm(10), rnorm(10)) # output not shown
t.test(rnorm(10), rnorm(10)) # output not shown
t.test(rnorm(10), rnorm(10)) # p < 0.05

# Running the test four times yielded a significant result on the fourth try.
# The spuriously significant result is a Type I error because the two samples
# were generated from the same normal distribution (mu1 = mu2 = 0), so there
# is no true difference in the population.


# Interpretation:
# - Because the null hypothesis is true (same means, same distribution), any
#   p < 0.05 here is a Type I error.
# - At alpha = 0.05, Type I errors are expected to occur about 5% of the time
#   (roughly 1 in 20 tests).
# - If you set alpha = 0.01, Type I errors are expected about 1% of the time.

# Frequentist perspective:
# - For any single dataset, you can never be sure that a significant result
#   is not a Type I error; chance sampling can always create spurious patterns.
# - However, you do control the long‑run error rate: by choosing alpha (e.g.,
#   0.05 or 0.01), you specify how often you are willing to accept a Type I error
#   over many repeated tests.


# Type II error
set.seed(42)
t.test(rnorm(10, mean = 1), rnorm(10, mean = 0))
t.test(rnorm(10, mean = 1), rnorm(10, mean = 0))
t.test(rnorm(10, mean = 1), rnorm(10, mean = 0))

# If your p-value is tantalizingly close to 0.05 but still above it,
# you have failed to reject the null hypothesis at your pre-specified alpha level.

# Notes:
# - If you follow the frequentist procedure strictly, you cannot treat a result
#   with p > 0.05 as "significant", even if it's very close to 0.05.
# - Talking about "marginally significant" effects betrays the logic of
#   pre-specifying alpha: the whole point of alpha is to control the long‑run
#   Type I error rate (e.g., 5% at alpha = 0.05).

# Type II error and statistical power:
# - Type II error: failing to reject H0 when H0 is false (false negative).
#   Its probability is denoted by β.
# - Statistical power: 1 − β (often denoted by π), the probability of correctly
#   detecting a true effect.
# - Many researchers aim for power π > 0.8 (80% chance of significant result
#   when there is a real effect).

# Three factors affecting power (and Type II error):
# 1. Effect size
# 2. Variability (noise, standard deviation)
# 3. Sample size
#
# Ways to increase power:
# - Increase effect size (e.g., stronger experimental manipulation)
# - Decrease variability (e.g., more homogeneous sample)
# - Increase sample size (most common and practical route)

# Type M and Type S errors (Gelman & Carlin, 2014):
# - Type M error: exaggerated effect magnitude (your sample shows a much larger
#   effect than in the population).
# - Type S error: wrong sign of the effect (e.g., sample suggests A > B,
#   but in the population B > A).
# - Higher power reduces both Type II, Type M, and Type S errors.

# Interpretation of "null results":
# - When power is low, p > 0.05 is essentially uninterpretable.
# - "Absence of evidence is not evidence of absence":
#   you cannot confidently claim that an effect does not exist just because
#   you failed to find significance in an underpowered study.

# Commentary on linguistics:
# - Many linguistic studies have small sample sizes, making theoretical
#   conclusions quite flimsy.
# - Example: incomplete neutralization — many underpowered studies either
#   "found" or "failed to find" an effect, causing controversy.
# - Meta‑analytic work (e.g., Nicenboim, Roettger, & Vasishth, 2018) suggests
#   that when evidence is aggregated, there is a reasonable signal for
#   incomplete neutralization.
# - Small‑N studies often base claims of "no effect" on very low power,
#   which is scientifically problematic.

# General takeaway:
# - Underpowered studies are common in many fields, including linguistics,
#   and this is dangerous for cumulative science.
# - Where possible, researchers should:
#   - increase sample size,
#   - plan for adequate power (e.g., π > 0.8),
#   - and interpret non‑significant results cautiously.

# How to estimate power:
# - Power depends on:
#   - effect size (often unknown, but can be estimated from prior literature),
#   - variability (standard deviation),
#   - sample size.
# - In practice:
#   - form reasonable expectations about effect size (best case, worst case),
#   - compute power for different combinations,
#   - choose a sample size that gives acceptable power.


# Multiple Testing

# Multiple Testing Problem - Family-Wise Error Rate (FWER)

# Problem: More tests → more likely to get at least ONE false positive
# Each test has 5% Type I error rate (α = 0.05)

# Family-Wise Error Rate (FWER):
# Probability of ≥1 Type I error across k tests
# FWER = 1 - (1 - 0.05)^k

# Examples:
# k = 1 test:  FWER = 1 - 0.95^1 = 0.05 (5%)
# k = 5 tests: FWER = 1 - 0.95^5 = 0.23 (23%)  
# k = 20 tests: FWER = 1 - 0.95^20 = 0.64 (64%)

# R code:
1 - (1 - 0.05)^1    # [1] 0.05
1 - (1 - 0.05)^5    # [1] 0.23  
1 - (1 - 0.05)^20   # [1] 0.64

# Intuition:
# (1 - 0.05) = probability of NO error in 1 test
# (1 - 0.05)^k = probability of NO errors in k tests
# 1 - that = probability of AT LEAST ONE error

# Takeaway: 20 tests at α=0.05 → 64% chance of false positive somewhere!

#  let’s implement it in R and compute the probability of obtaining a Type error when performing a single test (k = 1):
1 - (1 - 0.05) ^ 1

# The formula exhibits more interesting behavior once the number of significance tests (k) is larger. 
# Let’s see what happens if a researcher were to conduct 2 or 20 tests:

1 - (1 - 0.05) ^ 2


1 - (1 - 0.05) ^ 20

# Multiple Testing Consequences & Solutions

# FWER explodes with more tests:
# 2 tests: FWER = 10%
# 20 tests: FWER = 64%  
# 100 tests: FWER ≈ 100%

# Real examples of disaster:
# Zodiac signs + health outcomes → fake correlations (Leo = more GI bleeds)
# Dead salmon fMRI → "neural activity" in dead fish brain

# Solution 1: Bonferroni Correction
# New α = α_original / k
# α_new = 0.05 / 2 = 0.025 for 2 tests

# Or adjust p-values UP:
p.adjust(0.03, method = 'bonferroni', n = 2)
# [1] 0.06  (0.03 → 0.06, now > 0.05 → not significant)

# Other corrections exist (Holm, FDR), but Bonferroni = most conservative

# BEST solution: Limit tests upfront
# - Pre-register hypotheses
# - Test only theoretically motivated questions
# - Fewer tests = less multiple testing problem

# Controversy: Some say "never correct", others "always correct"
# Conservative rule: Correct when testing many unplanned comparisons


# Stopping Rules Problem - P-hacking Danger

# DANGEROUS practice:
# 1. Collect 30 participants → p = 0.12 (not sig)
# 2. "Need more power!" → add 30 more → p = 0.03 (sig!)
# 3. Stop & publish

# Why dangerous? If H₀ true:
# p-values ~ Uniform(0,1) → ANY value equally likely
# Keep testing + adding data → p will eventually dip below 0.05

# Figure 10.1 simulation (H₀ true):
# Random walk of p-values as N increases
# Eventually crosses 0.05 → false positive!
# (Solid line: "sig" at N+8, but would rise again with more data)

# SOLUTION: Pre-define STOPPING RULE
# "I will collect exactly N=60 participants, no more, no less"

# Best practices:
# 1. **Pre-register sample size** (OSF, etc.)
# 2. **Power analysis** → calculate needed N for 80% power
# 3. **Fixed N upfront** → justify based on prior studies

# Psychology fix: Many journals now require sample size justification

# Key: Never let p-values decide if you stop collecting data!



p.adjust(0.001, method = 'bonferroni', n = 100)
p.adjust(0.005, method = 'bonferroni', n = 100)
p.adjust(0.009, method = 'bonferroni', n = 100)




# an important issue with multiple comparisons correction methods: the more tests you conduct, 
# the more you have to lower your alpha level. 
# As a result, statistical power shrinks as well.



# Standard	Errors	and	Confidence	Intervals	 

library(tidyverse)
library(broom)
library(magrittr)
install.packages("dplyr")
library(dplyr)


install.packages("readr")  # once
library(readr)

library(readr)
icon <- read_csv(file = clipboard())

head(icon, 4)


# Standardize predictors:
icon <- mutate(icon,
               SER_z = scale(SER),
               CorteseImag_z = scale(CorteseImag),
               Syst_z = scale(Syst),
               Freq_z = scale(Freq))
# Fit model:
icon_mdl_z <- lm(Iconicity ~ SER_z + CorteseImag_z +
                   Syst_z + Freq_z, data = icon)
#	Look	at	coefficient	table:
tidy(icon_mdl_z) %>%
  mutate(p.value = format.pval(p.value, 4),
         estimate = round(estimate, 2),
         std.error = round(std.error, 2),
         statistic = round(statistic, 2)) 

# =====================================================
# P-VALUE INTERPRETATION: < 2e-16 means EXTREMELY SIGNIFICANT
# =====================================================
# 
# 2e-16 = 0.0000000000000002 (2 × 10⁻¹⁶)
# This is R's way of saying "p-value is so tiny it's practically 0"
# 
# YOUR RESULTS:
# • Intercept:        p < 2e-16  → ***HIGHLY SIGNIFICANT***
# • SER_z:            p < 2e-16  → ***HIGHLY SIGNIFICANT*** (effect = 0.53)
# • CorteseImag_z:    p < 2e-16  → ***HIGHLY SIGNIFICANT*** (effect = -0.42) 
# • Syst_z:           p = 0.0735 → NOT SIGNIFICANT (p > 0.05)
# • Freq_z:           p = 0.0014 → SIGNIFICANT (p < 0.05)
# 
# KEY TAKEAWAY: Focus on EFFECT SIZES (estimate column):
# - SER_z (0.53): LARGE positive effect
# - CorteseImag_z (-0.42): LARGE negative effect
# - Syst_z & Freq_z: smaller effects
# 
# Significance is basically guaranteed for strong predictors with your sample size!
# =====================================================


# the tidy() function from the broom package can be used to create an output with 95% confidence intervals 
# for each regression coefficient when specifying the argument conf.int = TRUE. 
# In addition, the code below uses the filter() function to get rid of the row with the intercept, which we don’t want to plot in this case.

mycoefs <- tidy(icon_mdl_z, conf.int = TRUE) %>%
  filter(term != '(Intercept)')



# =====================================================
# DOT-AND-WHISKER PLOT EXPLANATION (Figure 11.1 style)
# =====================================================

# WHY coord_flip() IS NEEDED (counterintuitive but important!)

# STEP 1: Run WITHOUT coord_flip() first to understand:
mycoefs %>% 
  ggplot(aes(x = term, y = estimate)) + 
  geom_point() + 
  geom_errorbar(aes(ymin = conf.low, ymax = conf.high), width = 0.2) + 
  geom_hline(yintercept = 0, linetype = 2)

# Result: Terms on X (vertical labels, hard to read), estimates on Y (horizontal)
# Problem: Long predictor names overlap & are unreadable

# STEP 2: Add coord_flip() - flips X/Y axes:
mycoefs %>% 
  ggplot(aes(x = term, y = estimate)) + 
  geom_point() + 
  geom_errorbar(aes(ymin = conf.low, ymax = conf.high), width = 0.2) + 
  geom_hline(yintercept = 0, linetype = 2) +
  coord_flip() +          # <- FLIPS: terms become horizontal (easy to read)
  theme_minimal()

# Final result:
# • Predictor names: Horizontal (left side) - easy to read
# • Estimates: Vertical (right side) - dots + error bars (whiskers)
# • Dashed line at 0 helps see positive/negative effects

# WHAT EACH PART DOES:
# - geom_point(): Dots at estimate values
# - geom_errorbar(): Whiskers (conf.low to conf.high)
# - geom_hline(yintercept = 0): Reference line at zero effect
# - coord_flip(): Makes labels readable!
# =====================================================

# =====================================================
# ORDERING COEFFICIENTS BY SIZE (like Figure 11.1)
# =====================================================

# PROBLEM: Current plot shows terms in random/alphabetical order
# SOLUTION: Sort by estimate size → factor with custom levels

# STEP 1: Sort tibble by estimate (smallest to largest) and extract term names:
# pred_order <- arrange(mycoefs, estimate)$term
# pred_order
# Output: [shows terms ordered: smallest estimate → largest estimate]

# STEP 2: Convert 'term' column to FACTOR with this custom order:
# mycoefs <- mycoefs %>%
  #mutate(term = factor(term, levels = pred_order))

# STEP 3: Re-run plot - now coefficients appear ORDERED by size!
mycoefs %>%
  ggplot(aes(x = term, y = estimate)) +
  geom_point() +
  geom_errorbar(aes(ymin = conf.low, ymax = conf.high), width = 0.2) +
  geom_hline(yintercept = 0, linetype = 2) +
  coord_flip() +
  theme_minimal()

# RESULT:
# • Smallest estimates at TOP
# • Largest estimates at BOTTOM  
# • Looks professional like Figure 11.1!
# • Easy to see which predictors matter most (farthest from zero line)

# WHAT HAPPENED:
# - arrange(mycoefs, estimate): sorts rows by estimate column
# - $term: extracts just the term names in that order
# - factor(term, levels = pred_order): forces ggplot to use THIS order
# =====================================================



# Sort tibble by estimate and extract order of terms:
pred_order <- arrange(mycoefs, estimate)$term
pred_order

mycoefs <- mutate(mycoefs,
                  term = factor(term, levels = pred_order))

# rerun the gplot above

mycoefs %>% ggplot(aes(x = term, y = estimate)) +
  geom_point() +
  geom_errorbar(aes(ymin = conf.low, ymax = conf.high),
                width = 0.2) +
  geom_hline(yintercept = 0, linetype = 2) +
  coord_flip() + theme_minimal()


# Significance	Tests	with	Multilevel	Categorical	Predictors


install.packages("readr")  # once
library(readr)

icon <- read_csv(file = clipboard())

head(icon, 4)

senses_mdl <- lm(Val ~ Modality, data = icon)

# coefficient table

library(broom)

tidy(senses_mdl) %>%
  mutate(estimate = round(estimate, 2),
         std.error = round(std.error, 2),
         statistic = round(statistic, 2),
         p.value = format.pval(p.value, 4)) 

# Omnibus Test - Overall Model Significance

# Problem: Individual coefficients don't tell full story
# Solution: Compare full model vs NULL MODEL (intercept-only)

# NULL MODEL = no predictors, just intercept
# In R: `1` means "intercept only"
null_model <- lm(valence ~ 1, data = your_data)

# Omnibus test asks:
# "Does Modality explain ANY variance in valence vs just intercept?"

# Compare models:
anova(null_model, full_modality_model)

# Interpretation:
# Significant F-test → Modality explains significant variance
# "Overall effect of sensory modality exists"

# Why omnibus test?
# - Tests ALL predictors together
# - Type III SS problem solved
# - Confirms model better than "nothing"


senses_null <- lm(Val ~ 1, data = icon)

# ANOVA for Model Comparison

# anova() = Analysis of Variance
# Compares variance explained by predictor vs total variance

# Tests: Does predictor explain SIGNIFICANT variance?

# Setup:
# full_model <- lm(valence ~ Modality, data)
# null_model <- lm(valence ~ 1, data)  # intercept only

# Run comparison:
anova(null_model, full_model)

# Logic:
# If models differ by ONE predictor → RSS difference = that predictor's effect
# F-test: "Is extra variance explained worth the df cost?"

# Interpretation:
# Significant F → predictor explains real variance (not noise)
# p < 0.05 → full model significantly better than null model

# Key advantage:
# Tests OVERALL effect of factor (like Modality with 3+ levels)
# One test vs multiple t-tests (avoids multiple testing problem)

# Perform model comparison:
anova(senses_null, senses_mdl)

# F-test Reporting & Interpretation

# Report format:
# F(df1, df2) = F_value, p < 0.00001
# Example: F(4, 400) = 17.03, p < 0.00001

# What each number means:
# - F = 17.03: How much variance full model explains vs null
# - df1 = 4: Extra parameters in full model (Modality levels - 1)
# - df2 = 400: Residual df (total independent data points)
# - p < 0.00001: Extremely unlikely under null hypothesis

# F vs t:
# t-test: Tests single coefficient or group mean difference
# F-test: Compares variance between ENTIRE models

# glance() for single predictor models:
# Gives same F & p as anova(null_model, full_model)

# Multiple predictors warning:
# glance() tests ALL predictors together vs null
# Can't attribute p-value to specific predictor anymore

# Question F-test answers:
# "Do ALL predictors together explain significant variance?"
# vs "Does THIS predictor matter?" (t-test)


glance(senses_mdl)

# Testing Specific Predictors - When to Use What

# Summary table:
# | Predictor Type | Test Method | R Function |
# |----------------|-------------|------------|
# | **Continuous** | t-test | coef table |
# | **Binary cat** | t-test | coef table |
# | **Multilevel** | F-test | anova() |
# | **Pairwise** | adjusted t | emmeans() |

# For multilevel predictors (like Modality):
# 1. anova(null_model, full_model) → overall effect
# 2. emmeans() → specific pairwise differences

# emmeans for pairwise comparisons:

install.packages("emmeans")
library(emmeans)
emmeans(senses_mdl, pairwise ~ Modality, adjust = "bonferroni")

# What it does:
# - Compares ALL pairs: sight vs sound, sight vs touch, etc.
# - Bonferroni corrects p-values (solves multiple testing)
# - Gives adjusted p-values safe for publication

# Example output interpretation:
# sight - sound = 0.8, p_adj = 0.002 → significant difference
# sight - touch = 0.3, p_adj = 0.45 → not significant

# Workflow:
# 1. anova() → "Does Modality matter overall?"
# 2. emmeans() → "Which modality pairs differ?"



# Key Takeaways - Pairwise Comparisons

# emmeans output: 6 significant pairs after Bonferroni
# (sight/sound, sight/taste, smell/taste, sound/taste, sound/touch, taste/touch)

# CRITICAL ADVICE:
# ❌ Don't do ALL pairwise comparisons without theory
# ✅ Test ONLY theoretically motivated contrasts
# ✅ Single planned test → NO multiple testing correction needed

# Problems with full pairwise:
# 1. Power loss (Bonferroni too strict → false negatives)
# 2. Unrelated comparisons affect each other philosophically
# 3. p-value obsession (ignore coefficients, effect sizes)

# Best practice:
# 1. Pre-specify hypotheses BEFORE data collection
# 2. Test only motivated contrasts (taste vs smell here)
# 3. Report: coefficients + effect sizes + predictions
# 4. Limit statistical tests upfront


# Another	Example:	The	Absolute	Valence	of	Taste	 and Smell Words
# Standardize valence and take the absolute value:

library(tidyverse)

icon <- mutate(icon,
                 Val_z 
                 = scale(Val),
                 AbsVal = abs(Val_z))
# Omnibus test:
abs_mdl <- lm(AbsVal ~ Modality, data = icon)
# Model comparison without specifying null model directly:
anova(abs_mdl)


# ANOVA Limitations & Theory-Driven Contrasts

# anova(model) = automatic omnibus test vs null model
# glance() reports SAME F-test for single predictor models

# Problem: ANOVA says "something differs" but NOT WHICH pairs

# Solution 1: Recode for specific contrast
chems <- c('Taste', 'Smell')
senses <- mutate(senses, 
                 ChemVsRest = ifelse(Modality %in% chems, 'Chem', 'Other'))

# Now test: Chem (taste+smell) vs Other (sight+sound+touch)
# lm(valence ~ ChemVsRest) → single meaningful comparison

# Why this is better than all pairwise:
# - Theory-driven (taste/smell expected to differ)
# - No multiple testing correction needed (1 test only)
# - Higher power (Type II error reduced)



# Create taste/smell vs. sight/sound/touch predictor:
chems <- c('Taste', 'Smell')
senses <- mutate(icon,
                 ChemVsRest = ifelse(Modality %in% chems,
                                     'Chem', 'Other'))

# with() function to make the senses tibble available to the table() 
# function. 
with(senses, table(Modality, ChemVsRest))


# Test this predictor:
abs_mdl <- lm(AbsVal ~ ChemVsRest, data = senses)
tidy(abs_mdl)

# Communicating Uncertainty for Categorical Predictors

# predict() function to calculate predictions for each level of the Modality factor, 

newpreds <- tibble(Modality =
                     sort(unique(icon$Modality)))
# Check:
newpreds

# Generate predictions:

fits	<-	predict(icon,	newpreds)
fits 

# Manual 95% CI for Predictions - predict() with se.fit

# Get predictions + standard errors:
SEs <- predict(senses_mdl, newpreds, se.fit = TRUE)$se.fit

# predict(..., se.fit = TRUE) returns LIST:
# $fit     = predicted values
# $se.fit  = standard errors for MEANS
# $residual.scale = etc.

# Extract just SEs:
predict(senses_mdl, newpreds, se.fit = TRUE)$se.fit

# For 95% CI by hand:
# CI = fit ± 1.96 * SEs
# Or more precisely: fit ± qt(0.975, df) * SEs

# Full example:
preds <- predict(senses_mdl, newpreds, se.fit = TRUE)
lower <- preds$fit - 1.96 * preds$se.fit
upper <- preds$fit + 1.96 * preds$se.fit


CI_tib	<-	tibble(fits,	SEs)
CI_tib


# Compute CIs:
CI_tib <- mutate(sense_preds,
                 LB	=	fits	–	1.96	*	SEs,	#	lower	bound
                 UB	=	fits	+	1.96	*	SEs)	#	upper	bound
CI_tib


# predict() with Automatic 95% Confidence Intervals

# Easier than manual calculation:
sense_preds <- predict(senses_mdl, newpreds, interval = 'confidence')

# Output columns:
# fit  = predicted mean
# lwr  = lower 95% CI bound  
# upr  = upper 95% CI bound

# Other options:
# interval = 'confidence'  → CI around MEANS (default)
# interval = 'prediction'  → PI around INDIVIDUAL observations (wider)

# Full syntax:
predict(model, newdata, interval = 'confidence', level = 0.95)

# Example output:
#        fit      lwr       upr
# Sight  4.2    3.8      4.6
# Sound  3.9    3.5      4.3

# predict() Confidence Intervals - Automatic vs Manual

# Automatic 95% CI (easiest):
sense_preds <- predict(senses_mdl, newpreds, interval = 'confidence')
# Output: fit, lwr, upr columns ready to plot!

# Manual uses ~1.96 but predict() uses exact t-critical value
# (Slight difference for small samples, negligible for large N)

# Combine predictions + labels for plotting:
sense_preds <- cbind(newpreds, sense_preds)
# cbinds modality labels with fit/lwr/upr
# Same # rows required!

# Now ready for ggplot:
ggplot(sense_preds, aes(Modality, fit)) +
  geom_point() +
  geom_errorbar(aes(ymin = lwr, ymax = upr), width = 0.2)



# Plotting Predicted Means + 95% CIs

# Basic plot:
sense_preds %>% 
  ggplot(aes(x = Modality, y = fit)) +
  geom_point() +
  geom_errorbar(aes(ymin = lwr, ymax = upr)) +
  theme_minimal()

# Fix order (valence ascending):
sense_order <- arrange(sense_preds, fit)$Modality
sense_preds$Modality <- factor(sense_preds$Modality, levels = sense_order)

# Final polished plot:
sense_preds %>% 
  ggplot(aes(x = Modality, y = fit)) +
  geom_point(size = 4) +
  geom_errorbar(aes(ymin = lwr, ymax = upr), 
                size = 1, width = 0.5) +
  ylab('Predicted emotional valence\n') +
  xlab('Modality\n') +
  theme_minimal() +
  theme(
    axis.text.x = element_text(face = 'bold', size = 15),
    axis.text.y = element_text(face = 'bold', size = 15),
    axis.title = element_text(face = 'bold', size = 20)
  )

# Key tricks:
# factor(..., levels = sense_order) → custom x-axis order
# \n → line break in axis labels (spacing)
# width = 0.5 → thinner error bars (less overlap)


# Communicating Uncertainty for Continuous Predictors
# What about plotting predictions for a continuous predictors? 


install.packages("readr")  # once
library(readr)

ELP <- ELP_frequency
ELP


# Log-transform frequency predictor:

library(dplyr)
ELP <- mutate(ELP, Log10Freq = log10(Freq))
ELP

# Create linear model:
ELP_mdl <- lm(RT ~ Log10Freq, ELP)

# Next, you need to define the data to generate predictions for. Let’s generate a 
# sequence of log frequencies from 0 to 5.

newdata <- tibble(Log10Freq = seq(0, 5, 0.01))


# use predict(). As in the previous example, interval = 'confidence' ensures that 95% confidence interval 
# around the predictions is computed.

preds <- predict(ELP_mdl, newdata,
                 interval	=	'confidence')
head(preds)

# plotting purposes, store it in the same place
preds <- cbind(newdata, preds)
head(preds)

# Multi-Data Source Plot - Predictions + Actual Data

# Combines TWO tibbles:
# 1. preds = predictions + CIs (ribbon, line)
# 2. ELP = actual data (word labels)

# Check your actual column names first:
names(preds)

preds %>% 
  ggplot(aes(x = Log10Freq, y = fit)) +
  geom_ribbon(aes(ymin = lwr, ymax = upr),    # ← lwr/upr NOT LB/UB
              fill = 'grey', alpha = 0.5) +
  geom_line() +
  geom_text(data = ELP, aes(y = RT, label = Word)) +
  theme_minimal()

# KEY FEATURES:
# - `data = ELP` → different tibble for geom_text()
# - `alpha = 0.5` → see-through ribbon
# - `geom_text AFTER ribbon` → text stays on top
# - `aes(y = RT)` → actual response values for text position

# Layer order matters:
# 1. ribbon (background)
# 2. line  
# 3. text (foreground)


# Interpreting the 95% Confidence Region (Ribbon)

# The gray ribbon = 95% confidence band around regression line

# Visual meaning ("dance of confidence intervals"):
# - Draw 100 different samples → get 100 different regression lines
# - 95 of those lines pass through the gray ribbon
# - 5 lines miss the ribbon entirely

# Practical interpretation:
# - Narrow ribbon = precise predictions (low uncertainty)
# - Wide ribbon = high uncertainty
# - Ribbon contains 0 = effect might be zero (not significant)

# Key insight:
# Your regression line = ONE possible line from sampling variation
# Ribbon shows "plausible range" of true population regression line

# Use for:
# - Visual uncertainty quantification
# - Compare if CIs overlap (non-significant) or not (significant)














