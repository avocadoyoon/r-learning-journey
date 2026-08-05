## 📚 R Learning Notes

Hi! I’m currently learning R from scratch — and this repository is basically my brain in progress.

If you already know Python, congrats… you’re at a slight advantage.

R has its own quirks, but some things will feel familiar.

I’m documenting everything as I go — yes, even the *very basic stuff* — because:

1. Future me will forget
2. Someone else might find it helpful too

The dataset I’m using (`prosody_practice_table.xlsx`) is included in this repo, but feel free to use your own. I tend to learn better when the data actually relates to my research interests, so here we are.

This is not meant to be perfect or polished — just real learning, step by step.

So yeah… let’s get into it 🌌


## Basic Arithmetic in R

R works like a calculator.

```
2 + 3
25 - 5
5 / 5
4 * 6
(2 + 3) * 5
``` 
To be able to see the output, do ```Alt + Enter```.

**Useful math functions**
```
sqrt(4)     # square root
abs(-10)    # absolute value
```
## Variables

Variables store values.
```
x <- 2 * 3
```

```<-```* is the preferred assignment operator in R (programming language).

_*You can type out this symbol directly with _```Alt + -```_  (I recommend getting used to it so you look cooler than you already are!)_

**NOTE:**
R is case-sensitive.

```
x
X

```
These are different objects. You cannot just write x and expect to see what X stores.

**Show all objects**
```
ls()

```

## Vectors

A vector is a list of values of the same type.

**Creating vectors**

You will use c(x,y,z) to create a vector. c stands for **combine.**

```
x <- c(2, 5, 7, 8)

```

**Some Vector properties**

```
length(x)  
mode(x)   
class(x)   

```


## Sequences

The colon(:) operator creates sequences.

```
mynums <- 10:1

```

Output:

```
10 9 8 7 6 5 4 3 2 1
```

## Summary Statistics

Common statistical functions:

```
sum(mynums)
min(mynums)
max(mynums)
range(mynums)
mean(mynums)
sd(mynums)
median(mynums)

```

## Vectorized Operations

Operations apply to all elements of a vector.


```
mynums - 5
mynums / 2

```
## Indexing

Access elements using square brackets.

```
mynums[1]
mynums[2]
mynums[1:4]

```

**Remove elements**
```
mynums[-1]

```

Returns everything except element 1.


## Logical Vectors

Logical operations return TRUE or FALSE.

```
mynums > 3
mynums >= 3
mynums <= 3
mynums == 3
mynums != 3

```

| Symbol | Meaning          |
| ------ | ---------------- |
| `>`    | greater than     |
| `<`    | less than        |
| `>=`   | greater or equal |
| `<=`   | less or equal    |
| `==`   | equal            |
| `!=`   | not equal        |


## Logical Indexing

Logical vectors can filter data.

```
mylog <- mynums >= 3
mynums[mylog]

```

Shortcut:

```
mynums[mynums >= 3]

```

## Character Vectors

Used for text data.

```
gender <- c("F", "M", "M", "F", "F")

```

class(gender)  # Check the vector type

gender[gender == "F"]  # Select values


## Factors (Categorical Data)

Factors represent categories.


```
gender <- as.factor(gender)

```

Check categories:

```
levels(gender)

```

Example output:

```
F M
```

**Factor limitation**

You cannot insert values outside the defined levels.

```
gender[3] <- "not_declared"

```

Result:

```
NA
```

Fix:

```
levels(gender) <- c("F","M","not_declared")
gender[3] <- "not_declared"
```

## Data Type Conversion

Convert between types.

Character
```
as.character(x)
```

Numeric
```
as.numeric(x)
```

Logical
```
as.logical(x)
```

Factor
```
as.factor(x)
```

⚠️** Important:**

```
as.numeric(factor)
```

Returns codes, not the labels.


## Data Frames

A data frame is a table.

Create one:
```
parti <- c("ale","nur","nahia")

mydf <- data.frame(
  parti,
  score = c(90,89,95)
)
```

View it:
```
mydf
```

**Structure information**

nrow(mydf)

ncol(mydf)

colnames(mydf)

str(mydf)

summary(mydf)


## Accessing Data Frame Columns

Use ```$```.


```
mydf$score
mydf$parti
```

**Example calculation:**

```
mean(mydf$score)
```

## Data Frame Indexing

**Rows and columns:**

```
mydf[1,]      # first row
mydf[,2]      # second column
mydf[1:2,]    # first two rows
```

**Nested indexing:**

```
mydf[,1][2]
```

**Filtering rows**

```
mydf[mydf$parti == "nur", ]
```

**Retrieve score:**

```
mydf[mydf$parti == "nur", ]$score
```


## Working Directory


**Check current folder:**

```
getwd()
```

**List files:**

```
list.files()
```

**Change directory:**

```
setwd("path")
```


## Reading Data

**Load CSV:**

```
read.csv("file.csv")

```

**Load table:**

```
read.table("file.txt", sep="\t", header=TRUE)

```


## Inspecting Data

```
head(data)
tail(data)
names(data)
str(data)
summary(data)

```


## Descriptive Statistics by Group

**Using tapply():**

```
tapply(data$f0_mean_hz, data$group, mean)
```

**Standard deviation:**

```
tapply(data$f0_mean_hz, data$group, sd)
```

**Count non-missing values:**

```
tapply(!is.na(data$f0_mean_hz), data$group, sum)
```


## Visualization

**Histogram**

```
hist(data$age)
```

**Colored histogram:**

```
hist(data$age, col="purple")

```

**Hex color:**


```
hist(data$age, col="#DD4433")

```

**Boxplot**

```
boxplot(f0_mean_hz ~ group, data = prosody_practice_table)
```


## Linear Regression

**Set reference level:**

```
prosody_practice_table$group <- relevel(
  as.factor(prosody_practice_table$group),
  ref="control"
)
```

**Run model:**

```
m1 <- lm(f0_mean_hz ~ group, data = prosody_practice_table)
```

**View results:**
```
summary(m1)

```

**Model information**

**Coefficients:**

```
coef(m1)

```


**Predicted values:**

```
fitted(m1)
```

**Residuals:**

```
resid(m1)
```

**Predicted group means:**

```
predict(m1,
        newdata=data.frame(group=c("control","aphasia")))

```

## Installing Packages

Packages extend R functionality.

**Install once:**

```
install.packages("dplyr")
```

Load every session:

```
library(dplyr)

```


## Key Concepts Learned

From these scripts you covered:

- arithmetic operations

- variables

- vectors

- logical indexing

- character vs factor

- data frames

- filtering data

- descriptive statistics

- visualization

- regression modeling

- packages











