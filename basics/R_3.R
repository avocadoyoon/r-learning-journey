# Tidyverse
install.packages('tidyverse')
install.packages('tibble')
install.packages('readr')
install.packages('dplyr')
install.packages('magrittr')
install.packages('ggplot2')
library(tidyverse)
library(tibble)
library(readr)
library(dplyr)
library(magrittr)
library(ggplot2)

library(readxl)
mydata <- read_excel("prosody_practice_table")

ls()
colnames(prosody_practice_table)
mean(prosody_practice_table$age)




# Tibble
# Load data

# prosody_practice_table <- read_csv("prosody_practice_table")

prosody_practice_table <- read.csv(file.choose()
prosody_practice_table <- as_tibble(prosody_practice_table)
prosody_practice_table

# The <dbl> stands for double, <int> stands for 'integer'; <fct> stands for 'factor'. 

# read.csv(), which automatically interprets any text column as factor. 
# So, before the data frame was converted into a tibble, the character-to-factor conversion has already happened.

# To avoid this and save yourself the conversion step, use read_csv()from the 

prosody_practice_table <- read_csv('prosody_practice_table')

# read_csv() runs faster than read.csv(), and it provides a progress bar for large datasets. 
# For files that are not comma-separated files (.csv), use read_delim(), for which the delim argument specifies the type of separator. 
# The following command loads the tab-delimited 'example_file.txt':

x <- read_delim('example_file.txt', delim = '\t')


install.packages("readxl")
library(readxl)


# dplyr
library(dplyr)
filter(prosody_practice_table, age > 40)
filter(prosody_practice_table, condition == 'empathetic')


# The select() function is used to select columns. 
# separated by commas.
# select() can also be used to reorder tibbles.

select(prosody_practice_table, sex, group)

# Using the minus sign in front of a column name excludes that column.
select(prosody_practice_table, - sex)

# Use the colon operator to select consecutive columns.
select(prosody_practice_table, sex:condition)

# The rename() function can be used to change the name of existing columns.

mydf <- rename(mydf, parti = participants)
mydf

# The mutate() function can be used to change the content of a tibble. 
# The following command creates a new column age, which is specified to be the age column divided by 100.


prosody_practice_table <- mutate(prosody_practice_table, age = age / 100)

# arrange() can be used to order a tibble in ascending or descending order. 

arrange(prosody_practice_table, age)        # ascending
arrange(prosody_practice_table, desc(age)) # descending


# ggplot2
library(ggplot2)
ggplot(prosody_practice_table) +
  geom_point(mapping = aes(x = age, y = condition))

# How exactly the data is visualized is specified by what is called a 'geom', a geometric object. 
# Each of the plots that you commonly encounter in research papers (histograms, scatterplots, bar plots, etc.) has their own geom, that is, their own basic shape. In the case of scatterplots, for example, the data is mapped to points in a 2D plane.
# Others: geom_boxplot (the data is mapped to boxes) or geom_text (the data is mapped to text).

# geom
# Specifies the primary geometric shape used to visually represent data (e.g., points, lines, bars).
# Determines how the data will appear on the plot.

# geom_point()
# Adds a point geometry to the plot.
# Used to display individual data points in a two-dimensional space.

# aes() (Aesthetic Mappings)
# Defines how variables in the dataset are mapped to visual properties of the geom.
# Specifies which data variables correspond to axes or other visual features (e.g., x, y).


ggplot(prosody_practice_table, aes(x = height_cm , y = age)) +
  geom_point()


 3 for geom_text, we need to write a label.
ggplot(prosody_practice_table, aes(x = pause_count, y = pause_total_ms, label = task)) +
  geom_text()

ggsave('prosody_practice_table.png', width = 8, height = 6) # save


# To create the two-plot arrangement displayed, use the gridExtra package.

# Create plots and save them in plot1 and plot2:
plot1 <- ggplot(prosody_practice_table) +
  geom_point(mapping = aes(x = age, y = height_cm))
plot2 <- ggplot(prosody_practice_table,
                aes(x = pause_count, y = pause_total_ms, label = condition)) +
  geom_text()

# Plot double plot:
library(gridExtra)
grid.arrange(plot1, plot2, ncol = 2)


# Piping with magrittr
# the 'pipe', which is represented by the symbol sequence '%>%'.
# The tibble prosody_practice_table is first piped to the filter() function.
# ggplot2 makes the chart.


# Plotting pipeline with %>%:
install.packages("magrittr")
install.packages('ggplot2')
library(magrittr)
library(ggplot2)

prosody_practice_table <- read_csv('prosody_practice_table')

prosody_practice_table %>%
  filter(age > 8) %>%
  ggplot(aes(x = age, y = height_cm, label = condition)) +
  geom_text()


# This is a different table, see the concept.
# icon <- read_csv('perry_winter_2017_iconicity.csv')
# mod <- read_csv('lynott_connell_2009_modality.csv')
# icon <- select(icon, Word, POS, Iconicity)
# range(icon$Iconicity)
# ggplot(icon, aes(x = Iconicity)) +
# geom_histogram(fill = 'peachpuff3') +
  # geom_vline(aes(xintercept = 0), linetype = 2) +
  # theme_minimal()


# ggplot() - Initializes the plot using the `icon` tibble as the data source.

# aes(x = ...) - Maps a variable to the x-axis (required aesthetic for a histogram).

# geom_histogram(fill = "peachpuff3") - Creates a histogram with bars filled in the color "peachpuff3".
# (The binwidth warning can be safely ignored in this case.)

# geom_vline(xintercept = 0, linetype = 2) - Adds a vertical dashed line at x = 0.

# theme_minimal() - Applies a clean, minimal theme (white background, simple grid lines).

# theme_linedraw() - Applies a theme with more pronounced lines and structure.

# theme_light() - Applies a light theme with subtle background and grid styling.

# Themes (general) - High-level formatting functions that modify the overall appearance 
# of the plot (background, grid lines, text, etc.) without manually setting each element.

# mod %>% print(width = Inf) # to display all the columns.

# The width argument allows you to control how many columns are displayed (thus, 
# expanding or shrinking the 'width' of a tibble). By setting the width to the special 
# value Inf (infinity), you display as many columns as there are in your tibble.
# You may also want to display all rows: mod %>% print(n = Inf) # output not shown.


# The argument for rows is called n in line with the statistical convention to use the letter 'N' to represent the number of data point

# it is necessary to merge the two tibbles. 
# The left_join() function call below takes two tibbles as argument, 'joining' the second tibble ('to the right') into 
# the first tibble ('to the left') both <- left_join(icon, mod)

# left_join() - Merges two tibbles by matching rows based on a common column 
# (here, the shared `Word` column is automatically used as the key).

# by = ... - Specifies the matching columns manually if the column names differ 
# between the two tibbles.

# rename() - Renames columns so they match and can be joined correctly.

# filter() - Subsets the dataset to keep only rows that meet certain conditions 
# (e.g., keeping only adjectives, verbs, and nouns).

# %in% - Compares two vectors and checks whether elements of the second vector 
# appear in the first vector (commonly used inside filter() for category selection).


# both <- filter(both,
          POS %in% c('Adjective', 'Verb', 'Noun'))


# Finally, an additional aesthetic maps the Modality categories onto the fill argument, 
# which assigns each sensory modality a unique color.
# ggplot(both,
       aes(x = Modality, y = Iconicity, fill = Modality)) +
  geom_boxplot() + theme_minimal()


# ```r id="k4mz82"
# is.na() - Returns TRUE for missing (NA) values and FALSE for non-missing values.

# !is.na(...) - Inverts the logical result so that TRUE indicates complete (non-missing) cases.

# filter(!is.na(...)) - Keeps only rows where the selected variable is not NA 
# (i.e., removes missing values).

# %>% - Pipes the output of one step into the next function.

# both %>% filter(...) - Sends the `both` tibble into filter() for subsetting.

# ... %>% ggplot() - Sends the filtered output directly into ggplot() to create a plot.
```



# To investigate this feature of the English language, 
# have a look at the counts of words per sensory modality with count().
# both %>% count(Modality)

# geom_bar() - Creates a bar plot.

# stat = "identity" - Tells geom_bar() to use the provided y-values as they are,
# instead of computing its own counts (which it does by default).

# complete.cases() - Returns TRUE for complete (non-missing) rows and FALSE for rows with NA values.

# both %>% - Pipes the `both` tibble into the next function.

# count(Modality) - Counts the number of observations per Modality category 
# and stores the counts in a column named `n`.

# filter(!is.na(Modality)) - Removes rows where Modality is missing (NA).

# ggplot(aes(x = Modality, y = n, fill = Modality)) - Initializes the plot, 
# mapping Modality to the x-axis, counts (`n`) to the y-axis, and using Modality for fill color.

# geom_bar(stat = "identity") - Draws bars using the actual count values (`n`).

# theme_minimal() - Applies a clean, minimal theme to the plot.


both %>% count(Modality) %>%
  filter(!is.na(Modality)) %>%
  ggplot(aes(x = Modality, y = n, fill = Modality)) +
  geom_bar(stat = 'identity') + theme_minimal()


# Generate 50 random uniformly distributed numbers:
x <- runif(50)
# Check:
x

x <- runif(50, min = 2, max = 6)
head(x)
hist(x, col = "purple")


x <- rnorm(50)
hist(x, col = 'steelblue')
abline(v = mean(x), lty = 2, lwd = 2)

# this code creates a line at mean
# line tyline type is indicated to be dashed (lty = 2)
# the line width is indicated to be 2 (lwd = 2).
# The rnorm() function generates data with a mean of 0 by default. 
# It also has a default for the standard deviation,
# You can override these defaults by specifying the optional arguments mean and sd.

x <- rnorm(50, mean = 5, sd = 2)
mean(x)
sd(x)
quantile(x) # will see Q1,2,3,4


# You can use the quantile() function to assess the 68%-95% rule. 
# The 68% interval corresponds to the 16th and 84th percentiles.

quantile(x, 0.16)
quantile(x, 0.84)

mean(x) - sd(x)
mean(x) + sd(x)


# 2.5th (95%) percentile:
quantile(x, 0.025)

# Should correspond to M - 2 * SD:
mean(x) - 2 * sd(x)


# 97.5th percentile:
quantile(x, 0.975)

# Should correspond to M + 2 * SD:
mean(x) + 2 * sd(x)


hist(rnorm(n = 200)) # execute repeatedly

# Tidyverse
library(tidyverse)

# to load data
# war <- read_csv('warriner_2013_emotional_valence.csv')

range(prosody_practice_table$height_cm)
filter(prosody_practice_table, height_cm == min(height_cm) | height_cm == max(height_cm))
# 'or' (represented by the vertical bar '|') 

filter(prosody_practice_table, height_cm %in% range(height_cm))


arrange(prosody_practice_table, height_cm) # ascending order
arrange(prosody_practice_table, desc(height_cm))

mean(prosody_practice_table$height_cm)
sd(prosody_practice_table$height_cm)

# 68% data
mean(prosody_practice_table$height_cm) - sd(prosody_practice_table$height_cm)
mean(prosody_practice_table$height_cm) + sd(prosody_practice_table$height_cm)
quantile(prosody_practice_table$height_cm, c(0.16, 0.84))

# median
median(prosody_practice_table$height_cm
quantile(prosody_practice_table$height_cm, 0.5)

# exercise1

install.packages('ggplot2')
library(ggplot2)

ggplot(prosody_practice_table$age)

library(tidyverse)
x <- rnorm(50)
head(x)


# Create y's with intercept = 10 and slope = 3:
y <- 10 + 3 * x


# Plotting y against x in a scatterplot (using the optional argument pch = 19 to 
# change the point characters to filled circles) reveals a straight line with no scatter.
# In other words, y is a perfect function of x -something that would never happen in linguistic data.
plot(x, y, pch = 19)


# To add noise, the rnorm() function is used a second time to generate residual

error <- rnorm(50)
y <- 10 + 3 * x + error

# similarity between this command and the regression equation ( y b = + b x + e 0 1 * ) 

plot(x, y, pch = 19)

xmdl <- lm(y ~ x)
xmdl

head(fitted(xmdl))
head(residuals(xmdl))
summary(xmdl)

coef(xmdl)

coef(xmdl)[1]


# Alternative way of indexing (by name):

coef(xmdl)['(Intercept)']


# creating numbers from -3 to 3, increasing by 0.1
library(tibble)

xvals <- seq(from = -3, to = 3, by = 0.1)
mypreds <- tibble(x = xvals)
mypreds$fit <- predict(xmdl, newdata = mypreds)
mypreds

# linear models w/ tidyverse functions
library(tibble)
library(ggplot2)
mydf <- tibble(x, y)
xmdl <- lm(y ~ x, data = mydf)

library(broom)

# Print tidy coefficient table to console:
tidy(xmdl)

# the tidy advantage: output has the structure of a data frame.
# you can easily index the relevant columns, such as the coefficient estimates.

# Extract estimate column from coefficient table:
tidy(xmdl)$estimate

# Check overall model performance:
glance(xmdl)

# To plot the model with ggplot2, 

mydf %>% ggplot(aes(x = x, y = y)) +
  geom_point() + geom_smooth(method = 'lm') +
  theme_minimal()


# Intercept placeholders
# two function calls yield equivalent results

xmdl <- lm(y ~ x, data = mydf)
# Same as:
xmdl <- lm(y ~ 1 + x, data = mydf)

# intercept = 1

# Fitting an intercept-only model:
xmdl_null <- lm(y ~ 1, data = mydf)
coef(xmdl_null)

# the model estimtes the intercept.


# No matter what value x assumes, the model predicts the same number, the mean.
mean(y)

# exercises

xmdl <- lm(y ~ x) # Fits a linear regression model predicting y from x.
xmdl_null <- lm(y ~ 1) # This predicts y using just the mean of y (ignores x completely).
res <- residuals(xmdl) 
res_null <- residuals(xmdl_null) # Gets the residuals (prediction errors) from: 1-the full model (y ~ x); 2- the null model (y ~ 1)

# (Residual = actual value ??? predicted value)

sum(res ^ 2) # Calculates the sum of squared errors (SSE) for both models.
sum(res_null ^ 2) # sum(res^2) = leftover error after using x
# sum(res_null^2) = total variation in y (error when only using the mean)


1 - (sum(res ^ 2) / sum(res_null ^ 2)) # This calculates R? (R-squared).

glance(xmdl)

# What does R? mean?#
# It tells you:
# How much of the variation in y is explained by x
# -If R? = 0 ??? x explains nothing
# -If R? = 0.40 ??? x explains 40% of the variation in y
# -If R? = 1 ??? perfect prediction

# This code:
# Fits a regression model
# Compares it to a "just take the mean" model
# Calculates how much better the regression model is
# Returns R


log10(100) # 2
10^2 # 100


RTs <- c(600, 650, 700, 1000, 4000)
RTs

# generate a log-transformed version of this vector.
logRTs <- log(RTs)
logRTs

exp(logRTs) # undo the logging


library(tidyverse)
library(broom)
ELP <- read_csv('ELP_frequency.csv')
ELP

# The following code plots the data as text with geom_text(). 
# The regression model is Linear and Nonlinear Transformations added with geom_smooth(method = 'lm')
# The ggtitle() function adds a title to the plot.

ELP %>% ggplot(aes(x = Freq, y = LogRT, label = Word)) +
  geom_text() +
  geom_smooth(method = 'lm') +
  ggtitle('Log RT ~ raw frequency') +
  theme_minimal()

library(tidyverse)
library(broom)
ELP <- ELP_frequency
ELP

# Centering and Standardizing
ELP <- mutate(ELP,
       Log10Freq_c = Log10Freq - mean(Log10Freq),
       Log10Freq_z = Log10Freq_c / sd(Log10Freq_c))

select(ELP, Freq, Log10Freq, Log10Freq_c, Log10Freq_z)

# Same as before, different approach:
ELP <- mutate(ELP,
              Log10Freq_c = scale(Log10Freq, scale = FALSE),
              Log10Freq_z = scale(Log10Freq))
# If you only want to center, you can override the default by specifying scale = FALSE

# with() function, which makes the ELP tibble available to the cor() function. 
# That way, you don't have to use the dollar sign to index 
with(ELP, cor(Log10Freq, LogRT))

# Multilinear Regression
library(tidyverse)
library(broom)
icon <- 'perry_winter_2017_iconicity.csv'
icon %>% print(n = 4, width = Inf)

icon <- mutate(icon, Log10Freq = log10(Freq))


library(tidyverse)
library(broom)
senses <- winter_2016_senses_valence
senses

install.packages("dplyr")
library(dplyr)

mod_only <- senses %>% filter (Modality == "Touch") # filter function


summary(senses)
range(senses$Val)
mean(senses$Val)
sd(senses$Val)

hist(senses$Val)


chem <- filter(senses, Modality %in% c('Taste', 'Smell'))

# tabulates the number of words per sensory modality
table(chem$Modality)

# SD and mean 
chem %>% group_by(Modality) %>%
  summarize(M	=	mean(Val),	SD	=	sd(Val))

# How could you visualize this difference????
# box and whiskers
library(ggplot2)
chem	%>%	ggplot(aes(x	=	Modality,	y	=	Val,	fill	=	Modality))	+
  geom_boxplot() + theme_minimal() +
  scale_fill_brewer(palette	=	'PuOr')

# density graph (a smoothed version of a histogram)
chem	%>%	ggplot(aes(x	=	Val,	fill	=	Modality))	+
  geom_density(alpha = 0.5) +
  scale_fill_brewer(palette	=	'PuOr')


# Treatment Coding in R
# Let us fit a regression model where vale
library(broom)

chem_mdl <- lm(Val ~ Modality, data = chem)
tidy(chem_mdl) %>% select(term, estimate)

head(fitted(chem_mdl))

chem_preds <- tibble(Modality = unique(chem$Modality))
# unique() function is used here to reduce the Modality column to the unique types.

unique(chem$Modality)

# The unique() function is quite similar to levels() but levelts is with vectors only.

chem_preds$fit	<-	predict(chem_mdl,	chem_preds)
chem_preds

# Doing Dummy Coding 'By Hand'
# The following code creates a new column Mod01 using ifelse(). 
# This function spits out '1' if the statement 'Modality == 'Taste'' is TRUE, and '0' if it is FALSE.

chem <- mutate(chem,
        Mod01 = ifelse(Modality == 'Taste', 1, 0))
select(chem, Modality, Mod01)


lm(Val ~ Mod01, data = chem)

# Changing the reference level
chem <- mutate(chem,
        Modality = factor(Modality),
        ModRe = relevel(Modality, ref = 'Taste'))

levels(chem$Modality)

levels(chem$ModRe)  # releveled factor


# The factor() function works just like as.factor() in this case.
# Rather than using relevel(), you can also define the order of levels when creating the factor. 
# Whatever is mentioned first in the levels argument below is made the reference level.
# chem <- mutate(chem,
        # ModRe = factor(Modality, levels = c( 'Taste', 'Smell')))

# If nothing else is specified, R will sort the levels alphanumerically.
# which is why 'Smell' is the reference level of the Modality column.

# fit the model with the releveled ModRe predictor.
lm(Val ~ ModRe, data = chem) %>%
  tidy %>%
  select(term, estimate)


# Sum-coding
# another commonly used coding scheme.
# When converting a categorical predictor into sum-codes,
# one category is assigned the value -1; the other is assigned +1.

# the intercept is in the middle of the two categories, which is the con ceptual analog of 'centering' for categorical predictors. 
# The y-value of the intercept is now the mean of the means
# the intercept is halfway in between the two categories.


chem <- mutate(chem, Modality = factor(Modality))
# Check:
class(chem$Modality) == 'factor'

contrasts(chem$Modality)


# R uses the treatment coding scheme (0/1) by default. 
# The contr.treatment() function can be used to create this coding scheme explicitly. 
# This function has one obligatory argument: the number of categories that you want the 
# treatment coding scheme for. Let's see how the coding scheme for a binary category 
# looks like.

contr.treatment(2) 

# contr.sum(). As you can see, when this function is run for two levels, 
# the first category is mapped to 1; the second category is mapped to -1. 
# This time around, the column doesn't have a special name.


contr.sum(2)

chem <- mutate(chem, ModSum = Modality)
contrasts(chem$ModSum) <- contr.sum(2)
lm(Val ~ ModSum, data = chem) %>%
  tidy %>% select(term, estimate) 

chem %>% group_by(Modality) %>%
  summarize(MeanVal = mean(Val)) %>%
  summarize(MeanOfMeans = mean(MeanVal))

# Using the '1' after the predictor name is a notational convention for representing 
# the slopes of sum-coded predictors in R.



# Categorical Predictors with more than one levels
unique(senses$Modality)

sense_all <- lm(Val ~ Modality, data = senses)
tidy(sense_all) %>% select(term:estimate) %>%
  mutate(estimate = round(estimate, 2))


# This provides a view of the corresponding treatment coding scheme:
contr.treatment(5)

sense_preds <- tibble(Modality =
                        sort(unique(senses$Modality)))
sense_preds
sense_preds$fit	<-	round(predict(sense_all,	sense_preds),	2)


# Assumptions again
par(mfrow = c(1, 3))

# Plot 1, histogram:
hist(residuals(sense_all), col = 'skyblue2')
# Plot 2, Q-Q plot:
qqnorm(residuals(sense_all))
qqline(residuals(sense_all))
# Plot 3, residual plot:
plot(fitted(sense_all),	residuals(sense_all))


# conform fairly well to the normality assumption: the distribution of residuals looks very normal in the histogram, 
# and the Q-Q plot also indicates a good fit with the normal distribution (you will often find that the residuals fan out 
# a tiny bit from the Q-Q line for more extreme values). 
# However, the residual plot might look weird to you. 

# Other Coding Schemes
# A lot more (e.g., 'Helmert coding' and 'forward difference coding' )

contr.helmert(4)

# first slope indicates the difference between levels 1 and 2. 
# The second slope indicates the difference between levels 1 and 2, compared to level 3. 
# The third slope indicates the difference between levels 1, 2, and 3, compared to level 4. 
# Thus, each consecutive level is compared to the mean of all previous levels in an ordered sequence.
# This is useful, for example, when testing ordered predictors such as education level (PhD > MA > BA, etc.).


# Exercise
library(ggplot2)

ggplot(senses, aes(x = Modality, y = valence)) +
  geom_boxplot() +
  labs(
    title = "Valence Distribution Across the Five Senses",
    x = "Sense (Modality)",
    y = "Valence"
  )


ggplot(senses, aes(x = valence, fill = Modality)) +
  geom_density(alpha = 0.4) +
  labs(
    title = "Density of Valence by Sensory Modality",
    x = "Valence",
    y = "Density"
  )



ggplot(senses, aes(x = valence, fill = Modality)) +
  geom_density(alpha = 0.4) +
  facet_wrap(~Modality)

# what happened when you added facet_wrap?
# The plot splits into separate panels, one for each sensory modality.

# Instead of overlapping densities, each modality gets its own subplot.

# This makes it easier to compare the shape of each distribution individually.

# Because each panel contains only one modality, the fill mapping becomes mostly redundant (each panel has a single color).



