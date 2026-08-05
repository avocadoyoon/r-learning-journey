# Learning the basics
2 + 3
25 - 5
5 / 5
4 * 6
(2 + 3) * 5
3 - # When you do not assign any number, it will just show + until you do.

sqrt(4) # find the root
abs(-10) # turns it into positive number

# First R script. Write it here, to see in on console, ALT + ENTER
# Assigning Variables
x <- 2 * 3  # <- is an assigner. It assigns the value. You can also use = but there is a difference.
x = 2 * 3 # Better to use <- (ALT + minus to have it)

# R is case-sensitive.
# To retreive the list of all the objects, use ls() - it does not need an argument.


# Numeric Vectors
# Use c() to create multi-number objects
x <- c(2, 5, 7, 8)

# x is called vector. Vector refers to the list of numbers. 
# Use (length) to check how long the vector is.
length(x)

# As you will see shortly, there are different types of vectors. The vector x contains 
numbers, so it is a vector of type 'numeric'. 
# The mode() and class() function can be used to assess vector types. 
# People often either talk of a vector's 'atomic mode' or 'atomic class'.

mode(x)
class(x)

# In R, the  colon (:) is a sequence operator that creates an integer sequence from the first number to the last number
mynums <- 10:1

sum(mynums) # sum
sum(mynums) # sum
min(mynums) # smallest value (minimum)
max(mynums) # largest value (maximum)
range(mynums) # minimum and maximum together
diff(range(mynums)) # range: difference between min and max
mean(mynums)# arithmetic mean
sd(mynums) # standard deviation
median(mynums) # median

# If you use a function such as subtraction or division on a numeric vector, the function is repeated for all entries of the vector.
mynums - 5 # subtract 5 from every number
mynums / 2 # divide every number by two

# Indexing
mynums[1]	 # retrieve value at first position
mynums[2] # retrieve value at second position
mynums[1:4]	 # retrieve first four values

# Putting a minus in front of an index spits out everything inside a vector except for that index
mynums[-1]

1:100
#The '[1]' simply means 'first position'. Whenever there's a line break, R will show the position of the first value that starts a new row. 

# Logical Vectors
mynums > 3 # Which values are larger than 3?
# each time returning a TRUE value if the number is actually larger than 3, or a FALSE if the number is smaller than 3.
# logical operator '>=' translates to 'larger than or equal to'. 
# The operators '<' and '<=' mean 'smaller than' and 'smaller than or equal to'. 
# == is equal to
## != is not equal to

mynums >= 3
mynums <= 3
mynums == 3
mynums != 3

# The result of performing a logical operation is actually a vector itself. 
# To illustrate this, the following code stores the output of a logical operation in the object mylog. 
mylog <- mynums >= 3
class(mylog)


# Logical vectors can be used for indexing. 
The following code only returns those values that are larger than or equal to 3.
mynums[mylog]

# You can also put everything into one line of code rather than defining separate vectors:
mynums[mynums >= 3]


# Character Vectors
# Almost all analysis projects involve some vectors that contain text, such information 
about a participant's age, gender, dialect, and so on. For this, 'character' vectors are 
used.
# The code below uses quotation marks to tell R that the labels 'F' and 'M' are character strings rather than object names or numbers. 
# You can use either single quotes or double quotes, but you should not mix the two.

gender <- c('F', 'M', 'M', 'F', 'F')
class(gender)
gender[2]
gender[gender == 'F']

# Factor vectors
# The following code overrides the original gender vector with a new version that has been converted to a factor using as.factor().
# This is text, but like. categorical text. Put it in neat labeled boxes."
gender <- as.factor(gender)

# The output shows text, but, unlike the character vector, there are no quotation marks. 
# The 'levels' listed below the factor are the unique categories in the vector.
# This case, the vector gender contains 5 data points, which are all tokens of the types "F" and "M". The levels can be accessed like this:
levels(gender)

# The problem: they are fixed. 
# When you attempt to insert a new value 'not_declared' into the third position of the gender vector.

gender[3] <- 'not_declared'
gender

# The third position is now set to NA, a missing value. This happened because the only two levels allowed are 'F' and 'M'.
# To insert the new value 'not_declared', you first need to change the levels.

levels(gender) <- c('F', 'M', 'not_declared')
gender[3] <- 'not_declared'
gender



# There are also as.numeric(), as.logical(), and as.character().
mynums <- as.numeric(mynums)
mynums <- as.logical(mynums)
gender <- as.character(gender)

## ???? R DATA TYPE CHEAT SHEET (1 EXAMPLE EACH)
## ???? **Character**
  
  **What it is:** plain text
**When to use:** names, free text, comments

```r
name <- c("Ana", "Luis", "Marta")
```

Output:
  
  ```r
"Ana" "Luis" "Marta"
```

---
  
  ### ??????? **Factor**
  
  **What it is:** categorical text (labels)
**When to use:** gender, groups, conditions

```r
gender <- as.factor(c("female", "male", "female"))
```

Output:
  
  ```r
female male female
Levels: female male
```

---
  
  ### ???? **Numeric**
  
  **What it is:** numbers you can calculate with
**When to use:** age, scores, reaction times

```r
age <- as.numeric(c("21", "25", "30"))
```

Output:
  
  ```r
21 25 30
```

---
  
  ### ???? **Logical**
  
  **What it is:** TRUE / FALSE
**When to use:** filtering, conditions

```r
passed <- as.logical(c(1, 0, 1))
```

Output:
  
  ```r
TRUE FALSE TRUE
```

---
  
  ## ???? TYPE CONVERSIONS (THE COMMON ONES)
  
  ---
  
  ### character ??? factor
  
  ```r
as.factor(c("low", "high", "low"))
```

---
  
  ### factor ??? character (escape factor jail)
  
  ```r
as.character(gender)
```

---
  
  ### numeric ??? logical
  
  ```r
as.logical(c(0, 2, 5))
```

?????? `FALSE TRUE TRUE`

---
  
  ### ?????? factor ??? numeric (careful!!)
  
  ```r
as.numeric(gender)
```

?????? gives **codes**, not meanings ????

byee()
0


# PRACTICE
class(prosody_practice_table)
head(prosody_practice_table)

prosody_practice_table[1]

dim(prosody_practice_table)
sapply(prosody_practice_table, class)


select(prosody_practice_table, age)
mean(prosody_practice_table$age)

summary(prosody_practice_table)
names(prosody_practice_table)
str(prosody_practice_table)


avgHNR <- mean(prosody_practice_table$hnr_db)
class(avgHNR)

sd(prosody_practice_table$hnr_db)

install.packages("dplyr")
library(dplyr)

aph <- subset(prosody_practice_table, group == "aphasia")
dim(aph)

mean(aph$f0_mean_hz, na.rm = TRUE)
tapply(prosody_practice_table$f0_mean_hz, prosody_practice_table$group, mean, na.rm = TRUE)


# Mean
tapply(prosody_practice_table$f0_mean_hz,
       prosody_practice_table$group,
       mean, na.rm = TRUE)
  
# N (non-missing)
tapply(!is.na(prosody_practice_table$f0_mean_hz),
       prosody_practice_table$group,
       sum)


# SD
tapply(prosody_practice_table$f0_mean_hz,
       prosody_practice_table$group,
       sd, na.rm = TRUE)

# Plotting
boxplot(f0_mean_hz ~ group, data = prosody_practice_table,
        main = "Mean F0 (Hz) by Group", ylab = "f0_mean_hz")

is.function(hist)
# Histogram
get("hist", envir = asNamespace("graphics"))

graphics::hist(prosody_practice_table$f0_mean_hz(prosody_practice_table$group=="control"),
     main="Control: f0_mean_hz", xlab="Hz")

hist(prosody_practice_table$f0_mean_hz(prosody_practice_table$group == "aphasia"),
     main="Aphasia: f0_mean_hz", xlab = "Hz")

# Linear Model
prosody_practice_table$group <- relevel(as.factor(prosody_practice_table$group), ref = "control")
m1 <- lm(f0_mean_hz ~ group, data = prosody_practice_table)
summary(m1)

coef(m1)
fitted(m1)[1:5]
resid(m1)[1:5]

# Predicted group means
predict(m1, newdata = data.frame(group = c("control", "aphasia")))

# check the mean within each group
tapply(prosody_practice_table$f0_mean_hz, prosody_practice_table$group, mean, na.rm =TRUE)

# residual SD (typical error size)
sigma(m1)



# Centering and Standardizing
num_cols <- names(prosody_practice_table)[sapply(prosody_practice_table, is.numeric)]
num_cols

# Correlation
cor(prosody_practice_table$f0_mean_hz, prosody_practice_table$age, use = "complete.obs")


# Centering + Standardizing
prosody_practice_table$age_c <- prosody_practice_table$age -
mean(prosody_practice_table$age, na.rm = TRUE)
prosody_practice_table$age_z <- as.numeric(scale(prosody_practice_table$age))


m2 <- lm(f0_mean_hz ~ group + age_c, data = prosody_practice_table)
summary(m2)

# Compare model fit
summary(m1)$adj.r.squared #  -0.003746144
summary(m2)$adj.r.squared # -0.003994918

# R2 almost increases when you add predictors (when the predictor improves the model)
# Here adding age did not help enough.
# "this model is worse than just predicting all's mean."


# Check assumptions
par(mfrow=c(2.2))
plot(m2)
par(mfrow=c(1.1))

# Normality test
shapiro.test(resid(m2))































