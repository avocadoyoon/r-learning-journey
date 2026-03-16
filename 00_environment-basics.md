## 📚 R Learning Notes
Hi! Since I'm learning R from scratch, so does this documentation. R syntax is kind of similar to that of Python, so if you know Python, you are one step ahead.

I'll try to jot down everything (even though they are super basic) for educational purposes.

The data I'll be using is also included in this repo ('prosody_practice_table.csv'), but feel free to use your own data.

I just personally believe I learn things better with information related to my current research of interest.

Sooo, Let's get into it.

## 1️⃣ Basic Arithmetic in R

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
## 2️⃣ Variables

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

## 3️⃣ Vectors

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


## 4️⃣ Sequences

The colon(:) operator creates sequences.

```
mynums <- 10:1

```

Output:

```
10 9 8 7 6 5 4 3 2 1
```

## 5️⃣ Summary Statistics

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

## 6️⃣ Vectorized Operations

Operations apply to all elements of a vector.


```
mynums - 5
mynums / 2

```
## 7️⃣ Indexing

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


## 8️⃣ Logical Vectors

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


## 9️⃣ Logical Indexing

Logical vectors can filter data.

```
mylog <- mynums >= 3
mynums[mylog]

```

Shortcut:

```
mynums[mynums >= 3]

```

## 🔟 Character Vectors

Used for text data.

```
gender <- c("F", "M", "M", "F", "F")

```

class(gender)  # Check the vector type

gender[gender == "F"]  # Select values


## 1️⃣1️⃣ Factors (Categorical Data)

Factors represent categories.

## 1️⃣2️⃣ Data Type Conversion


## 1️⃣3️⃣ Data Frames


## 1️⃣4️⃣ Accessing Data Frame Columns


## 1️⃣5️⃣ Data Frame Indexing


## 1️⃣6️⃣ Working Directory


## 1️⃣7️⃣ Reading Data


## 1️⃣8️⃣ Inspecting Data

## 1️⃣9️⃣ Descriptive Statistics by Group


## 2️⃣0️⃣ Visualization

## 2️⃣1️⃣ Linear Regression

## 2️⃣2️⃣ Installing Packages



## ⭐ Key Concepts Learned

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

That’s already a very solid R foundation.









