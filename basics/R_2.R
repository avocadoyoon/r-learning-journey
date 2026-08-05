
# Data Frames
# The data.frame() function is used to create a data frame by hand. Each argument of this function becomes a column. 

parti <- c('mike', 'john', 'alessia')
mydf <- data.frame(parti, score = c(90, 89, 95))
mydf

# nrow = number of rows
# ncol = number of columns
# colnames = name of the columns

nrow(mydf)
ncol(mydf)
colnames(mydf)

# Data frames can be indexed via the name of the column by using the dollar sign operator '$'.
mydf$score
mydf$parti


# If the results are in a numeric vector. You can then apply summary functions to this vector, such as computing the mean:
mean(mydf$score)


# You can check the structure of the data frame with the str() function.
# Lists all the columns and their vector types.
str(mydf)

# The participant column is indicated to be a factor vector, even though you only supplied a character vector.
# The data.frame() function secretly converted your character vector into factor vector.
# The summary() function provides a useful summary, listing the number of data points for each participant, as well as what is called a 'five number summary' of the score column (see Chapter 3).

summary(mydf)

# To index rows or columns by position, you can use square brackets.
# Gotta add a column (,) though.

mydf[1,] # first row
mydf[, 2] # second column
mydf[1:2,] # first two rows

# And these operations can be stacked, such as:
mydf[, 1][2]	# first column, second entry

mydf[mydf$parti == 'alessia', ]

# Using the data frame mydf, extract only those rows for which the statement mydf$participant == 'vincenzo' returns a TRUE value.
mydf[mydf$parti == 'mike',] $score

# Loading in Files
# When loading in files into your current working environment, R needs to know which folder on your computer to look at, what is called the 'working directory'.
# Use getwd() to check the current working directory.

getwd()  # output specific to one's computer

# You can look at the folder's content from within R, using the list.files() function. 
# This should remind you of the ls() function. Whereas ls() displays the R-internal objects, list.files() displays R-external files.

list.files()

# To change your working directory to where your files are, you can use setwd() (computer-specific).

read.csv

#  The head() function shows the first six rows of the nettle data frame (the 'head' of the data frame)
head(mydf)

# The tail() function displays last six rows (the 'tail' of the data frame)
tail(mydf)

# Let's say you accidentally override the score column with NAs (missing values).
mydf$score <- NA

# You can use read.table() to load in this file as follows:
# mydf <- read.table('example_file.txt',
                   # sep = '\t', header = TRUE)

# Load the file into R as text, using readLines().
# x <- readLines('example_file.txt', n = 2)

#  The save() function allows you to save R objects in .RData files, as demonstrated here for the object mydf. 
# You can use load() to load an .RData file into your current R session.
# The n argument specifies the number of lines to be read. 

# You can use this information to provide the right arguments to the read.table() function.

# Plotting
# The height of each rectangle (called 'bin') indicates the number of data points contained within the range covered by the rectangle, what is called the 'bin width'
# hist creates this histogram

hist(prosody_practice_table$age)

# Let's rerun the histogram command and make the bins have a certain color.

hist(prosody_practice_table$age, col = 'purple')

# The col argument is an optional argument of the hist() function.

# The code below shows only the first six colors.
head(colors())

# You can also specify hexadecimal color codes.
hist(prosody_practice_table$age, col = '#DD4433')

# Installing, Loading, and Citing Packages
# New functions are assembled into libraries called 'packages', which can be installed using the install.packages() function. The following code installs the car package.

install.packages('car')

# Once a package is installed, you can load it like this:
library(car)                                            

# If you close R and reopen it, you will have to reload the package. 
# That is, packages are only loaded for a single session.
# To cite each package and report its package version, which is demonstrated here for car:

citation('car')$textVersion
packageVersion('car')

# EASIER VERSIONS:
# '$textVersion' and '$version.string'. 
# You can also simply run the citation() and R.Version() functions without these statements, which returns more extensive outputs.

citation('car')$textVersion
citation('car')$version.string
R.Version()$version.string

# Seeking Help
# seq() function with ?, which is for generating number sequences.

?seq

# If you forgot a function name and wanted to search for it from within R, use apropos() function. For example, running apropos('test').
# will display all functions that have the string 'test' in their name.

apropos('test')
head(apropos('test')) # shows the first 6 commands!

# Keyboard Shortcuts
# Ctrl/Command + N open new script
# Ctrl/Command + Enter run current line (send from script to console)
# Alt/Option + Minus '-' insert '<-'
# Ctrl/Command + Alt/Option + I insert code chunk (R markdown)
# Ctrl/Command + Shift + M insert pipe (tidyverse)

# Shift + Left/Right highlight subsection of text
# Ctrl + Left/Right (Windows) move cursor by a word
# Command + Left/Right (Mac) move cursor to beginning/end of line
# Home/End (Windows & Linux) move cursor to beginning/end of line
# Ctrl + K delete line from position of cursor onwards
# Ctrl/Command + X cut
# Ctrl/Command + Z undo
# Ctrl/Command + A select all

# Exercises
plot(x = 1, y = 1, type = 'n',
     xlim = c(-2, 2), ylim = c(-2, 2)
points(x = -1, y = 1)
segments(x0 = -1.5, y0 = -2, x1 = 1.5, y1 = -2)

# PRACTICE THIS YOU COULD NOT MAKE IT.
# The first line opens up an empty plot with a point at the coordinates x = 1 and y = 1. 
# The type = 'n' argument means that this point is not actually displayed. 
# xlim and ylim specify the plot margins.

# The points() function plots a single point at the specified coordinates. 
# The segments() function plots a line segment. 
# The beginning of the line segment is given by the arguments x0 and y0. 
# The end points are given by x1 and y1.
# What is displayed in your plotting window is actually a one-eyed smiley. 
# By adding additional points() and segments(), can you create a more elaborate smiley? 
  
x_values <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
mean_x <- mean(x_values)

x <- c(2, 3, 4, '4')
as.numeric(x)
mean(as.numeric(x))


head(prosody_practice_table)
prosody_practice_table[2,5]

prosody_practice_table[1:4, ]
prosody_practice_table[1:4, 1:2]
prosody_practice_table[prosody_practice_table$age == '45', ]
prosody_practice_table[prosody_practice_table$condition == 'neutral', 5]
prosody_practice_table[prosody_practice_table$sex == 'M', ] [, 5]
prosody_practice_table[prosody_practice_table$group == 'aphasia', ] $condition
prosody_practice_table[prosody_practice_table$age == '40', 'sex']
prosody_practice_table[1:4, ] $age[2]
prosody_practice_table[1:6, c('sex', 'condition')] 
head(prosody_practice_table[,])


install.packages('swirl')  # LEARNING + PRACTICING

# Remember that if you have questions about a particular R function, you can access its documentation with a question mark followed by the function name: ?function_name_here.
# However, in the case of an operator like the colon used above, you must enclose the symbol in backticks like this: ?`:`. (NOTE: The backtick (`) key is generally located in the top left corner of a keyboard, above the Tab key. 
# If you don't have a backtick key, you can use regular quotes.

?':'

seq(1,20) # same as :

seq(0, 10, by=0.5) # incremented by 0.5

my_seq <- seq(5, 10, length=30) # a sequence of 30 numbers between 5 and 10.

length(my_seq)

1:length(my_seq)
seq(along.with = my_seq) # another way
seq_along(my_seq)

# rep() replicate
rep(0, times = 40) # creating a vector that contains 40 zeros
rep(c(0, 1, 2), times = 10) # If instead we want our vector to contain 10 repetitions of the vector (0, 1, 2).

rep(c(0, 1, 2), each = 10) # contain 10 zeros, then 10 ones, then 10 twos.


# Vectors
# Atomic vectors and lists. An atomic vector contains exactly one data type, whereas a list may contain multiple data types. 
# We'll explore atomic vectors further before we get to lists.

num_vect <- c(0.5, 55, -10, 6)
tf <- num_vect < 1
num_vect >= 6

# logical operators ==, <=, >= etc.

# !A is the negation of A.

(3 > 5) & (4 == 4)

# & == BOTH VTRUE
# | in the middle states that AT LEAST ONE of the pieces is TRUE.

# Character vector
# "" is used.

my_char <- c("My", "name", "is")
my_char
paste(my_char, collapse = " ")

# `The `collapse` argument to the paste() function tells R that when we join together the elements of the my_char character vector, we'd like to separate them with single spaces.

my_name <-  c(my_char, "Naz")
my_name
paste(my_name, collapse = " ")

paste("Hello", "world!", sep = " ")

paste(1:3, c("X", "Y", "Z"), sep = "") # we can join two vectors, each of length 3

paste(LETTERS, 1:4, sep = "-")

# Vector recycling! Try paste(LETTERS, 1:4, sep = "-"), where LETTERS is a predefined
# variable in R containing a character vector of all 26 letters in the English alphabet.
# The numeric vector 1:4 gets 'coerced' into a character vector by the paste() function.

# Missing Value = NA

x <- c(44, NA, 5, NA)
x*3

y <- rnorm(1000)
z <- rep(NA, 1000)
my_data <- sample(c(y,z), 100)
my_na <- is.na(my_data)
my_na


my_data == NA



# R represents TRUE as the number 1 and FALSE as the number 0.

sum(my_na)
my_data

# NaN = not a number

0 / 0

# Inf = infinity

Inf - Inf 

2

0


x
x[1:10]

# Let's start by indexing with logical vectors. 
# One common scenario when working with real-world data is that we want to extract all elements of a vector that are not NA (i.e. missing data). 
# Recall that is.na(x) yields a vector of logical values the same length as x, with TRUEs corresponding to NA values in x and FALSEs corresponding to non-NA values in x.
x[is.na(x)]
1

# !is.na(x) can be read as 'is not NA'

y <- x[!is.na(x)]
y
4
y[y > 0]
x[x >0] # NA > 0 evaluates to NA. Hence we get a bunch of NAs mixed in with our positive numbers when we do this.

x[!is.na(x) & x > 0]

#'zero-based indexing', which means that the first element of a vector is considered element 0. 
# R uses 'one-based indexing', which means the first element of a vector is considered element 1.

x[c(3, 5, 7)]
x[0]
x[3000]


x[c(-2, -10)] # all elements of x EXCEPT for the 2nd and 10
x[-c(2, 10)]  # same


vect <- c(foo = 11, bar = 2, norf = NA)
vect
names(vect)

vect2 <- c(11, 2, NA)

names(vect2) <- c("foo", "bar", "norf")
identical(vect, vect2)

1

vect["bar"]
vect[c("foo", "bar")] # specify the vector's names
1
1
7

#  Matrices and Data Frames
# they are used to store tabular data, with rows and columns.

my_vector <- 1:20
my_vector
dim(my_vector) # 'dimensions' of an object. It does not have it being a vector.

length(my_vector)

dim(my_vector) <- c(4,5) # attributing dim
dim(my_vector)
attributes(my_vector)

# the first number is the number of rows and the second is the number of columns.
# Therefore, we just gave my_vector 4 rows and 5 columns.
# Not it is  matrix, not a vector.

my_vector
class(my_vector)

my_matrix <- my_vector

?matrix

my_matrix2 <-  matrix(data = 1:20, nrow = 4, ncol = 5, byrow = FALSE,
       dimnames = NULL)
identical(my_matrix, my_matrix2)

patients <- c('Bill', 'Gina', 'Kelly', 'Sean')

cbind(patients, my_matrix) # 'combine columns'

# it has "" for all, so it is matrix of character strings, which is not good.

# matrices can only contain ONE class of data. 
# Therefore, when we tried to combine a character vector with a numeric matrix, R was forced to 'coerce' the numbers to characters, hence the double quotes.

my_data <- data.frame(patients, my_matrix) # data.frame() function allowed us to store our character vector of names right alongside our matrix of numbers
my_data

class(my_data)

cnames <- c('patient', 'age', 'weight', 'bp', 'rating', 'test')
colnames(my_data) <- cnames
my_data
2
1
0

# Logic
# two logical values in R = TRUE & FALSE (boolean values)
# == equal operator

TRUE == TRUE
(TRUE == TRUE) == TRUE
(FALSE == TRUE) == FALSE
6 == 7


6 < 7
10 <= 10
1
3
5 != 7
# !TRUE, !FALSE

5 !== 7
(info)
nxt()
5 != 7
!(5 == 7)
1
4


# There are two AND operators in R, `&` and `&&`.
# Both operators work similarly, if the right and left operands of AND are both TRUE the
# entire expression is TRUE, otherwise it is FALSE. For example, TRUE & TRUE evaluates to TRUE

FALSE & FALSE
TRUE & c(TRUE, FALSE, FALSE)

# The OR operator follows a similar set of rules. 
# The `|` version of OR evaluates OR across an entire vector, 
# while the `||` version of OR only evaluates the first member of a vector-

TRUE | c(TRUE, FALSE, FALSE)
TRUE || c(TRUE, FALSE, FALSE)

5 > 8 || 6 != 8 && 4 > 3.9

# AND operators then OR

3
1
3
2

# The function isTRUE() takes one argument.
# If that argument evaluates to TRUE, the function will return TRUE.

isTRUE(6 > 4)

2

identical('twins', 'twins')
4

#  xor() function, which takes two arguments
# exclusive OR.
# If one argument evaluates to TRUE and one argument evaluates to FALSE, then this function will return TRUE


xor(5 == 6, !FALSE)
4

ints <- sample(10)  # creating vector of integers
ints
ints > 5


# The which() function takes a logical vector as an argument and returns the indices of the vector 
# that are TRUE.

which(ints > 7)
4


# any() and all() take logical vectors as their argument.
# The any() function will return TRUE if one or more of the elements in the logical vector is TRUE.
# The all() function will return TRUE if every element in the logical vector is TRUE.


#1: sum() returns the sum of a vector.
# 	Ex: sum(c(1, 2, 3)) evaluates to 6
#
# Hint #2: length() returns the size of a vector.
# 	Ex: length(c(1, 2, 3)) evaluates to 3

# Let me show you an example of a function I'm going to make up called
# increment(). Most of the time I want to use this function to increase the
# value of a number by one. This function will take two arguments: "number" and
# "by" where "number" is the digit I want to increment and "by" is the amount I
# want to increment "number" by. I've written the function below. 
#
# increment <- function(number, by = 1){
#     number + by
# }
#
# If you take a look in between the parentheses you can see that I've set
# "by" equal to 1. This means that the "by" argument will have the default
# value of 1.
#
# I can now use the increment function without providing a value for "by": 
# increment(5) will evaluate to 6. 
#
# However if I want to provide a value for the "by" argument I still can! The
# expression: increment(5, 2) will evaluate to 7. 
# 
# You're going to write a function called "remainder." remainder() will take
# two arguments: "num" and "divisor" where "num" is divided by "divisor" and
# the remainder is returned. Imagine that you usually want to know the remainder
# when you divide by 2, so set the default value of "divisor" to 2. Please be
# sure that "num" is the first argument and "divisor" is the second argument.
#
# Hint #1: You can use the modulus operator %% to find the remainder.
#   Ex: 7 %% 4 evaluates to 3. 
#
# Remember to set appropriate default values! Be sure to save this 
# script and type submit() in the console after you write the function.

# remainder <- function(num, divisor = 2) {
  # num %% divisor

#    1. evaluate(sum, c(2, 4, 6)) should evaluate to 12
#    2. evaluate(median, c(7, 40, 9)) should evaluate to 9
#    3. evaluate(floor, 11.1) should evaluate to 11


# The ellipses can be used to pass on arguments to other functions that are
# used within the function you're writing. Usually a function that has the
# ellipses as an argument has the ellipses as the last argument. The usage of
# such a function would look like:
#
# ellipses_func(arg1, arg2 = TRUE, ...)
#
# In the above example arg1 has no default value, so a value must be provided
# for arg1. arg2 has a default value, and other arguments can come after arg2
# depending on how they're defined in the ellipses_func() documentation.
# Interestingly the usage for the paste function is as follows:
#
# paste (..., sep = " ", collapse = NULL)
#
# Notice that the ellipses is the first argument, and all other arguments after
# the ellipses have default values. This is a strict rule in R programming: all
# arguments after an ellipses must have default values. Take a look at the
# simon_says function below:
#
# simon_says <- function(...){
#   paste("Simon says:", ...)
# }
#
# The simon_says function works just like the paste function, except the
# begining of every string is prepended by the string "Simon says:"
#
# Telegrams used to be peppered with the words START and STOP in order to
# demarcate the beginning and end of sentences. Write a function below called 
# telegram that formats sentences for telegrams.
# For example the expression `telegram("Good", "morning")` should evaluate to:
# "START Good morning STOP"

# telegram <- function(...){
  # paste("START",..., "STOP")
  # paste("START", "and", "STOP")

# The syntax for creating new binary operators in R is unlike anything else in
# R, but it allows you to define a new syntax for your function. I would only
# recommend making your own binary operator if you plan on using it often!
#
# User-defined binary operators have the following syntax:
#      %[whatever]% 
# where [whatever] represents any valid variable name.
# 
# Let's say I wanted to define a binary operator that multiplied two numbers and
# then added one to the product. An implementation of that operator is below:
#
# "%mult_add_one%" <- function(left, right){ # Notice the quotation marks!
#   left * right + 1
# }
#
# I could then use this binary operator like `4 %mult_add_one% 5` which would
# evaluate to 21.
#
# Write your own binary operator below from absolute scratch! Your binary
# operator must be called %p% so that the expression:
#
#       "Good" %p% "job!"
#
# will evaluate to: "Good job!"

# "%p%" <- function(left, right){
  paste(left, right)
}

# 'I' %p% 'love' %p% 'R!'


any(ints < 0)
all(ints > 0)

4
2
1


9

# Functions
# The Sys.Date() function returns a string representing today's date.

Sys.Date()
mean(c(2,4,5))

....


bye()


)
swirl()

1

head(flags)
dim(flags)
viewinfo()
class(flags)


# lapply and sapply
# l - list /// lapply  takes a list as input, applies a function to each element of the list, then returns a list of the same length as the original one.

cls_list <- lapply(flags, class)
cls_list
class(cls_list)

# cls_list can be simplified to a character vector. To do this manually, type as.character(cls_list).

as.character(cls_list)


# get the class of each column of the flags dataset 

cls_vect <-  sapply(flags, class)
class(cls_vect)

?sapply

)
swirl()


1
sum(flags$orange)
flag_colors <- flags[, 11:17]
head(flag_colors)

lapply(flag_colors, sum)
sapply(flag_colors, sum)

# The result is a list, since lapply() always returns a list. 
# Each element of this list is of length one, so the result can be simplified to a vector by calling sapply().

sapply(flag_colors, mean)

flag_shapes <- flags[, 19:23]

lapply(flag_shapes, range)

# The range() function returns the minimum and maximum of its first argument, which should be a numeric vector.

shape_mat <- sapply(flag_shapes, range)
shape_mat
class(shape_mat)

# returns a vector with all duplicate elements removed. 
# In other words, unique() returns a vector of only the 'unique' elements.
unique(c(3,4,5,5,5,6,6))

unique_vals <- lapply(flags, unique)
unique_vals

sapply(unique_vals, length)

sapply(flags, unique)


lapply(unique_vals, function(elem) elem[2])

#  return a list containing the second item from each element of the unique_vals list.

1
1

11

sapply(flags, unique)

# vapply() allows you to specify it explicitly.

vapply(flags, unique, numeric(1))
# you expect each element of the result to be a numeric vector of length 1.
# Since this is NOT actually the case, YOU WILL GET AN ERROR.

ok()

sapply(flags, class)

vapply(flags, class, character(1))

# you'll often wish to split your data up into groups based on the value
# of some variable, then apply a function to the members of each group. The next function
# we'll look at, tapply(), does exactly that.

?tapply

table(flags$landmass)
table(flags$animate)


tapply(flags$animate, flags$landmass, mean)
tapply(flags$population, flags$red,summary)

2


tapply(flags$population, flags$landmass, summary)
1

1
1

12

ls()
class(plants)
# data.frame = rectangular (2 dim - rows and cols)
dim(plants)
nrow(plants)
ncol(plants)

# If you are curious as to how much space the dataset is occupying in memory:
object.size(plants)

names(plants) #  return a character vector of columns

head(plants)

head(plants, 10) # normally shows 6, altering the rnow
tail(plants)
tail(plants, 15)


summary(plants)

# how many times each value actually occurs in the data
table(plants$Active_Growth_Period)



str(plants)

# it combines many of the features of the other functions you've already seen.
# all in a concise and readable format. At the very top, it tells us that the
# class of plants is 'data.frame' and that it has 5166 observations and 10 variables. 
# It then gives us the name and class of each variable, as well as a preview of its contents.


2
1
13

# Simulation
?sample
# sample takes a sample of the specified size from the elements of x using either with or without replacement.
sample(1:20, 10) # generate random numbers

# Since the last command sampled without replacement,
# no number appears more than once in the output.

LETTERS # Since the last command sampled without replacement, no number appears more than once in the output.

sample(LETTERS)

flips <- sample(c(0,1), 100, replace = TRUE, prob = c(0.3, 0.7))
flips

sum(flips)

?rbinom
# Density, distribution function, quantile function and random generation for the binomial distribution with parameters size and prob.
# This is conventionally interpreted as the number of 'successes' in size trials


# Each probability distribution in R has an r*** function (for "random"), a d*** function
# (for "density"), a p*** (for "probability"), and q*** (for "quantile"). 
# We are most interested in the r*** functions in this lesson, but I encourage you to explore the others on your own.


rbinom(1, size = 100, prob = 0.7) # you only specify the probability of 'success' (heads) and NOT the probability of 'failure' (tails).


flips2 <- rbinom(100, size = 1, prob = 0.7)
flips2

sum(flips2)

?rnorm

# The standard normal distribution has mean 0 and standard deviation 1. 
# The default values for the 'mean' and 'sd' arguments to rnorm() are 0 and 1, respectively. 
# Thus, rnorm(10) will generate 10 random numbers from a standard normal distribution.

rnorm(10, mean = 100, sd = 25)

# the poisson distribution
# Density, distribution function, quantile function and random generation for the Poisson distribution with parameter lambda.

rpois(5, 10)

my_pois <-  replicate(100, rpois(5, 10)) # to perform this 100 times
my_pois



cm <- colMeans(my_pois)
hist(cm)

1
1

14

d1 <- Sys.Date() # to get the current date 
class(d1)
unclass(d1) #  to see what d1 looks like internally.
d1

d2 <- as.Date("1969-01-01")
unclass(d2)

t1 <- Sys.time()
t1
class(t1)


# POSIXct is just one of two ways that R represents time information.

unclass(t1)
t2 <- as.POSIXlt(Sys.time())
class(t2)
t2
unclass(t2)

str(unclass(t2))

t2$min

weekdays(d1)
months(t1)
quarters(t2)


t3 <- "October 17, 1986 08:24"

t4 <- strptime(t3, "%B %d, %Y %H:%M") # converts character vectors to POSIXlt.

t4
class(t4)



Sys.time() > t1
Sys.time() - t1

difftime(Sys.time(), t1, units = 'days')
# to find the amount of time in DAYS that has passed since you created t1.

2
1
15

# Base Graphics
data(cars)

?cars

head(cars)
plot(cars) # scatterplotting

?plot

plot(x = cars$speed, y = cars$dist)

plot(x = cars$dist, y = cars$speed)

plot(x = cars$speed, y = cars$dist, xlab = "Speed") # label
plot(x = cars$speed, y = cars$dist, ylab = "Stopping Distance")

plot(x = cars$speed, y = cars$dist, xlab = "Speed", ylab = "Stopping Distance")

plot(cars, main = "My Plot")
plot(cars, sub = "My Plot Subtitle") # subtitle

?par

plot(cars, col = 2)
plot(cars, xlim = c(10, 15))

# change the shape of the plot

?points

plot(cars, pch = 2)

data(mtcars)

# play() In the middle of a swirl lesson, just type play(). This temporarily suspends the lesson

?boxplot

boxplot(formula = mpg ~ cyl, data = mtcars)

hist(mtcars$mpg)


# Satstistical Inference

# there are two broad flavors of inference.
# the first is frequency, which uses "long run proportion of times an event occurs in independent, identically distribute repetitions." 
# The second is Bayesian in which the probability estimate for a hypothesis is updated as additional evidence is acquired. 

# Probability

# the probability of E, denoted P(E), is always between 0 and 1. 
# Impossible events have a probability of 0 (since they can't occur) 
# and events that are certain to occur have a probability of 1.

# experiment with n possible outcomes
# sum of them is 1.
# If all is equal, probability is 1/n.

1 - (2+1)/36

deck
13 x 4

52

4 / 52

0.0769230769

skip()

0.2307692308

3

2/51

plot(child ~ parent, galton)
plot(jitter(child, 4)~ parent,galton)

regrline <- lm(child ~ parent, galton) # regression line
abline(regrline, lwd=3, col= 'red') # on the plot
summary(regrline)

3
1
2
2
3
0
0



#Here are the vectors of variations or tweaks
sltweak <- c(.01, .02, .03, -.01, -.02, -.03) #one for the slope
ictweak <- c(.1, .2, .3, -.1, -.2, -.3)  #one for the intercept
lhs <- numeric()
rhs <- numeric()
#left side of eqn is the sum of squares of residuals of the tweaked regression line
for (n in 1:6) lhs[n] <- sqe(ols.slope+sltweak[n],ols.ic+ictweak[n])
#right side of eqn is the sum of squares of original residuals + sum of squares of two tweaks
for (n in 1:6) rhs[n] <- sqe(ols.slope,ols.ic) + sum(est(sltweak[n],ictweak[n])^2)


lhs-rhs


all.equal(lhs, rhs)
varChild <- var(galton$child)
varRes <- var(fit$residuals)

# calculate the estimates (y- coordinates) = est

varEst <- var(est(ols.slope, ols.ic))

all.equal(varChild,varEst+varRes)

3

# generate regression line
efit <- lm(accel ~ mag+dist, attenu)
mean(efit$residuals)


# cov to verify the residuals are uncorrelated with the magnitude predictor (attenu$mag)

cov(efit$residuals, attenu$mag)
cov(efit$residuals, attenu$dist)  # distance predictor











0.8*1.6
1.28/2

0.8

0.64/1

1
mypdf
integrate(mypdf,0,1.6)
skip()

)
swirl()

1
fit <- lm(child ~ parent, galton)
fit$residuals
summary(fit)
mean(fit$residuals)

# correlation
cov(fit$residuals, galton$parent)

2

# cal the sum of the squared residuals = sqe

ols.ic <- fit$coef[1]   # intercept - first element
ols.slope <- fit$coef[2] # slope second element

3
)
swirl()

7
2
3
8
6
fit <- lm(child ~ parent, galton)

sqrt(sum(fit$residuals^2) / (n-2))

summary(fit)$sigma

sqrt(deviance(fit)/ (n-2))

mu <- mean(galton$child)

sTot <- sum((galton$child-mu)^2)

sRes <- deviance(fit)

1-sRes/sTot # This is the value R^2.

summary(fit)$r.squared

cor(galton$child, galton$parent)^2


# R^2
# It is the percentage of variation explained by the regression model.
# As a percentage it is between 0 and 1.
# It also equals the sample correlation squared. 
# However, R^2 doesn't tell the whole story.


# MultiVar_Examples
2

all <- lm(Fertility ~ ., swiss)

summary(all)


# The "*" at the far end of the row indicates that the influence of X on is significant.
1

summary(lm(Fertility ~ Agriculture, swiss))
4

# coefficient = estimate

2

cor(swiss$Education, swiss$Examination)

cor(swiss$Agriculture,swiss$Education)

# makelms() which generates a sequence of five linear models. 

makelms <- function(){
  # Store the coefficient of linear models with different independent variables
  cf <- c(coef(lm(Fertility ~ Agriculture, swiss))[2], 
          coef(lm(Fertility ~ Agriculture + Catholic,swiss))[2],
          coef(lm(Fertility ~ Agriculture + Catholic + Education,swiss))[2],
          coef(lm(Fertility ~ Agriculture + Catholic + Education + Examination,swiss))[2],
          coef(lm(Fertility ~ Agriculture + Catholic + Education + Examination +Infant.Mortality, swiss))[2])
  print(cf)
}

# Regressor generation process 1.
rgp1 <- function(){
  print("Processing. Please wait.")
  # number of samples per simulation
  n <- 100
  # number of simulations
  nosim <- 1000
  # set seed for reproducability
  set.seed(4321)
  # Point A:
  x1 <- rnorm(n)
  x2 <- rnorm(n)
  x3 <- rnorm(n)
  # Point B:
  betas <- sapply(1 : nosim, function(i)makelms(x1, x2, x3))
  round(apply(betas, 1, var), 5)
}

# Regressor generation process 2.
rgp2 <- function(){
  print("Processing. Please wait.")
  # number of samples per simulation
  n <- 100
  # number of simulations
  nosim <- 1000
  # set seed for reproducability
  set.seed(4321)
  # Point C:
  x1 <- rnorm(n)
  x2 <- x1/sqrt(2) + rnorm(n) /sqrt(2)
  x3 <- x1 * 0.95 + rnorm(n) * sqrt(1 - 0.95^2)
  # Point D:
  betas <- sapply(1 : nosim, function(i)makelms(x1, x2, x3))
  round(apply(betas, 1, var), 5)
}


makelms()

4


ec <- swiss$Examination+swiss$Catholic

efit <- lm(Fertility ~ . + ec, swiss)

all$coefficients - efit$coefficients

1
2
2
0

# MultiVar_Examples2
6
B

dim(InsectSprays)

head(InsectSprays, 15)

sA

summary(InsectSprays[,2])

sapply(InsectSprays, class)

# the linear model in which count is the dependent variable and spray is the independent. 
# Recall that in R formula has the form y ~ x, where y depends on the predictor x.

fit <- lm(count ~ spray, InsectSprays)

summary(fit)$coef

est <- summary(fit)$coef[,1]

mean(sA)

2

mean(sB)

nfit <- lm(count ~ spray - 1, InsectSprays)

summary(nfit)$coef

1
1

#  relevel does precisely this. It re-orders the levels of a factor.

spray2 <- relevel(InsectSprays$spray, "C")

fit2 <- lm(count ~ spray2, InsectSprays)

summary(fit2)$coef

4

mean(sC)

3

(fit$coef[2]-fit$coef[3])/1.6011

2
2
3
0


# MultiVar_Examples3
dim(hunger)

948
names(hunger)

fit <- lm(Numeric ~ Year, hunger)
summary(fit)$coef
3
2
1

lmF <- lm(hunger$Numeric[hunger$Sex=="Female"] ~ hunger$Year[hunger$Sex=="Female"])
lmM <- lm((hunger$Numeric[hunger$Sex=="Male"] ~ hunger$Year[hunger$Sex=="Male"]))

2

# dependent ~ independent1 + independent2.

lmBoth <- lm(Numeric ~ Year + Sex, hunger)
summary(lmBoth)

#  R treats the first (alphabetical) factor as the reference and its estimate is the intercept which
# represents the percentage of hungry females at year 0. The estimate given for the factor Male is a distance from the
# intercept (the estimate of the reference group Female). To calculate the percentage of hungry males at year 0 you have to
# add together the intercept and the male estimate given by the model.

633.5283 +  1.9027
1
2



3

lmInter <- lm(Numeric ~ Year + Sex + Sex*Year, hunger)
summary(lmInter)
1

# replot the data points along with two new lines using different colors
2

4
1
20
0

2
3
9

# Residuals Diagnostics and Variation

fit <- lm(y ~ x, out2)

# The simplest diagnostic plot displays residuals versus fitted values. 
# Residuals should be uncorrelated with the fit, independent and (almost) identically distributed with mean zero.

plot(fit, which = 1)
1
1

fitno <- lm(y ~ x, out2[-1, ]) # excluding the outlier

plot(fitno, which = 1)

# Subtract coef(fitno) from coef(fit) to see the change induced by including the influential first sample.

coef(fit) - coef(fitno)

# dfbeta: The function, dfbeta, does the equivalent calculation for every sample in the data. The first row of dfbeta(fit)
# should match the difference we've just calculated. The second row is a similar calculation for the second sample, and so on.

head(dfbeta(fit)) # you can also use view

# influence/leverage/hat value
# When a sample is included in a model, it pulls the regression line closer to itself (orange line) than that of the model
# which excludes it (black line.) Its residual, the difference between its actual y value and that of a regression line, is
# thus smaller in magnitude when it is included (orange dots) than when it is omitted (black dots.) The ratio of these two
# residuals, orange to black, is therefore small in magnitude for an influential sample. For a sample which is not influential
# the ratio would be close to 1. Hence, 1 minus the ratio is a measure of influence, near 0 for points which are not
# influential, and near 1 for points which are.

resno <- out2[1, "y"] - predict(fitno, out2[1,])

# calculate the influence of our outlier using 
1-resid(fit)[1]/resno

# hatvalues: The function, hatvalues, performs for every sample a calculation equivalent to the one you've just done.
head(hatvalues(fit))


sigma <- sqrt(deviance(fit)/df.residual(fit))

# standardized residual
rstd <- resid(fit)/(sigma * sqrt(1-hatvalues(fit)))

head(cbind(rstd, rstandard(fit)))  # compare two calculations


# A Scale-Location plot shows the square root of standardized residuals against fitted values.
plot(fit, which = 3)

# QQ residuals
plot(fit, which=2)

# Studentized residuals, (sometimes called externally Studentized residuals,) estimate the standard deviations of individual
# residuals using, in addition to individual hat values, the deviance of a model which leaves the associated sample out.


sigma1 <- sqrt(deviance(fitno)/df.residual(fitno))

# the Studentized residual for the outlier

resid(fit)[1]/(sigma1*sqrt(1-hatvalues(fit)[1]))

head(rstudent(fit))

# Cook's distance
# the sum of squared differences between values fitted with and without a particular sample.
# tells how much a given sample changes a model.


dy <- predict(fitno, out2)- predict(fit, out2)

sum(dy^2)/(2*sigma^2)  # calculating Cook's distance

# cooks.distance

plot(fit, which=5)
1
2
0



)
install_course("Regression Models")
swirl()


1
12


# 10: Variance Inflation Factors 

# In modeling, we aim for simple and clear models that help explain the data without unnecessary complexity.
# A good model should be both parsimonious (not too many variables) and interpretable (easy to understand).
# If we leave out important variables, the model’s coefficient estimates become biased –
# unless the omitted variables are completely uncorrelated with those we kept.
# But adding more variables has a downside too:
# Each new variable increases the actual (not just estimated) standard errors of other variables.
# This means our coefficient estimates become less precise.
# So, we shouldn’t just add variables without careful thought.
# This lesson focuses on the second problem — the increase in standard errors —
# an issue known as *variance inflation*.

## THE COURSE vifSims

makelms <- function(x1, x2, x3){
  # Simulate a dependent variable, y, as x1
  # plus a normally distributed error of mean 0 and 
  # standard deviation .3.
  y <- x1 + rnorm(length(x1), sd = .3)
  # Find the coefficient of x1 in 3 nested linear
  # models, the first including only the predictor x1,
  # the second x1 and x2, the third x1, x2, and x3.
  c(coef(lm(y ~ x1))[2], 
    coef(lm(y ~ x1 + x2))[2], 
    coef(lm(y ~ x1 + x2 + x3))[2])
}

# Regressor generation process 1.
rgp1 <- function(){
  print("Processing. Please wait.")
  # number of samples per simulation
  n <- 100
  # number of simulations
  nosim <- 1000
  # set seed for reproducibility
  set.seed(4321)
  # Point A
  x1 <- rnorm(n)
  x2 <- rnorm(n)
  x3 <- rnorm(n)
  # Point B
  betas <- sapply(1 : nosim, function(i)makelms(x1, x2, x3))
  round(apply(betas, 1, var), 5)
}

# Regressor generation process 2.
rgp2 <- function(){
  print("Processing. Please wait.")
  # number of samples per simulation
  n <- 100
  # number of simulations
  nosim <- 1000
  # set seed for reproducibility
  set.seed(4321)
  # Point C
  x1 <- rnorm(n)
  x2 <- x1/sqrt(2) + rnorm(n) /sqrt(2)
  x3 <- x1 * 0.95 + rnorm(n) * sqrt(1 - 0.95^2)
  # Point D
  betas <- sapply(1 : nosim, function(i)makelms(x1, x2, x3))
  round(apply(betas, 1, var), 5)
}




3
# rgp1() – Point A:
# x1 <- rnorm(n)
# x2 <- rnorm(n)
# x3 <- rnorm(n)
# Each variable is generated independently from N(0,1),
# so x1, x2, and x3 are (in theory) uncorrelated.

# rgp2() – Point C:
# x1 <- rnorm(n)
# x2 <- x1/sqrt(2) + rnorm(n)/sqrt(2)
# x3 <- x1 * 0.95 + rnorm(n) * sqrt(1 - 0.95^2)
# Here x2 and x3 are built using x1, so x1, x2, and x3 are correlated.
# Therefore, x1, x2, and x3 are uncorrelated in rgp1(), but not in rgp2().



# The function rgp1() computes the variance in estimates of the coefficient of x1 in each of the three model

rgp1()

rgp2()

# Run rgp2() to simulate standard errors in the coefficient of x1 for cases in which x1 is correlated with the other regressors


# Variance Inflation Factor (VIF) - Key Concept
# VIF measures how much multicollinearity inflates the variance of a coefficient.
# Formula: VIF_i = (variance with ith regressor) / (variance with ideal uncorrelated regressor)

# What it means:
# - VIF = 1: No correlation with other variables (perfect!)
# - VIF > 5-10: Problematic multicollinearity (coefficients unreliable)

# How it's calculated:
# For each predictor i, regress it against all other predictors
# VIF_i = 1 / (1 - R² from that auxiliary regression)

# car package makes this easy:
# library(car)
# model <- lm(y ~ x1 + x2 + x3, data = swiss)  # Swiss data from datasets package
# vif(model)  # Returns VIF for each predictor

# Example with Swiss data coming up next...

head(swiss)

mdl <- lm(Fertility ~ Agriculture + Examination + Education + Catholic + Infant.Mortality, swiss)

vif(mdl)

mdl2 <- lm(Fertility ~ Agriculture + Education + Catholic + Infant.Mortality, swiss)
vif(mdl2)

# A VIF describes the increase in the variance of a coefficient due to the correlation of its regressor with the other regressor.
#  VIF is the square of standard error inflation.

# If a regressor is strongly correlated with others, hence will increase their VIF's, why shouldn't we just exclude it?
# Excluding it might bias coefficient estimates of regressors with which it is correlated.


# Why not always use uncorrelated regressors (PCA/Factor Analysis)?

# Methods like factor analysis or PCA can create uncorrelated predictors
# from correlated ones, eliminating variance inflation problems.

# But here's the catch:
# The new "uncorrelated" variables are mathematical combinations
# of the original variables (e.g., PC1 = 0.4*X1 + 0.7*X2 - 0.3*X3)

# Problem: These combinations lose their real-world meaning!
# - Original X1 = "years of education" → interpretable
# - PC1 = ??? → what does "0.4*education + 0.7*income" represent?

# Key tradeoff:
# Uncorrelated regressors = Precise coefficients (low VIF)
# BUT = Difficult interpretation (what do they actually mean?)

# Goal of modeling: Understand the phenomenon
# We need BOTH precision AND interpretability
# That's why we live with some correlation rather than blind PCA transformation.

)
swirl()


# 11: Overfitting and Underfitting


simbias <- function(seed=8765){
  # The default seed guarantees a nice histogram. This is the only
  # reason that accepting the default, x1c <- simbias(), is required in the lesson. 
  # The effect will be evident with other seeds as well.
  set.seed(seed) 
  temp <- rnorm(100)
  # Point A
  x1 <- (temp + rnorm(100))/sqrt(2)
  x2 <- (temp + rnorm(100))/sqrt(2)
  x3 <- rnorm(100)
  # Function to simulate regression of y on 2 variables.
  f <- function(k){
    # Point B
    y <- x1 + x2 + x3 + .3*rnorm(100)
    # Point C
    c(lm(y ~ x1 + x2)$coef[2],
      lm(y ~ x1 + x3)$coef[2])
  }
  # Point D
  sapply(1:150, f)
}

# Illustrate the effect of bogus regressors on residual squared error.
bogus <- function(){
  temp <- swiss
  # Add 41 columns of random regressors to a copy of the swiss data.
  for(n in 1:41){temp[,paste0("random",n)] <- rnorm(nrow(temp))}
  # Define a function to compute the deviance of Fertility regressed
  # on all regressors up to column n. The function, deviance(model), computes
  # the residual sum of squares of the model given as its argument.
  f <- function(n){deviance(lm(Fertility ~ ., temp[,1:n]))}
  # Apply f to data from n=6, i.e., the legitimate regressors,
  # through n=47, i.e., a full complement of bogus regressors.
  rss <- sapply(6:47, f)
  # Display result.
  plot(0:41, rss, xlab="Number of bogus regressors.", ylab="Residual squared error.",
       main="Residual Squared Error for Swiss Data\nUsing Irrelevant (Bogus) Regressors",
       pch=21, bg='red')
}

# Plot histograms illustrating bias in estimates of a regressor
# coefficient 1) when an uncorrelated regressor is missing and
# 2) when a correlated regressor is missing.
x1hist <- function(x1c){
  p1 <- hist(x1c[1,], plot=FALSE)
  p2 <- hist(x1c[2,], plot=FALSE)
  yrange <- c(0, max(p1$counts, p2$counts))
  plot(p1, col=rgb(0,0,1,1/4), xlim=range(x1c), ylim=yrange, xlab="Estimated coefficient of x1",
       main="Bias Effect of Omitted Regressor")
  plot(p2, col=rgb(1,0,0,1/4), xlim=range(x1c), ylim=yrange, add=TRUE)
  legend(1.1, 40, c("Uncorrelated regressor, x3, omitted", "Correlated regressor, x2, omitted"),
         fill=c(rgb(0,0,1,1/4), rgb(1,0,0,1/4)))
}


x1c <- simbias()

apply(x1c, 1, mean) # find the means of each row.

# Adding even irrelevant regressors can cause a model to tend toward a perfect fit.



# adding random regressors decreased deviance, but we would be mistaken to believe that such decreases are significant. 
# To assess significance, we should take into account that adding regressors reduces residual degrees of freedom. 
# Analysis of variance (ANOVA) is a useful way to quantify the significance of additional regressors.


fit1 <- lm(Fertility ~ Agriculture, swiss)
fit3 <- lm(Fertility ~ Agriculture + Examination + Education, swiss)


# The null hypothesis is that the added regressors are not significant.

anova(fit1, fit3)


# The three asterisks, ***, at the lower right of the printed table indicate that the null hypothesis is rejected at the 0.001 level, 
# so at least one of the two additional regressors is significant. Rejection is based on a right-tailed F test, Pr(>F), applied to an F value.


# An F statistic is a ratio of two sums of squares divided by their respective degrees of freedom.


# ANOVA Table - RSS Explanation

# RSS = Residual Sum of Squares (unexplained variation)
# Row 1 (Model 1): Fertility ~ Agriculture
# Res.Df = 45, RSS = 6283.1

# Row 2 (Model 2): Fertility ~ Agriculture + Examination + Education  
# Res.Df = 43, RSS = 3180.9

# The TWO relevant RSS values (chi-squared sums):
# 6283.1 (simple model) and 3180.9 (complex model)

# F-test compares: How much RSS drops when adding predictors?
# Sum of Sq = 6283.1 - 3180.9 = 3102.2 (explained by new variables!)
# F = 20.968 → p < 0.001 → Model 2 much better!


# R's function, deviance(model), calculates the residual sum of squares, also known as the deviance, of the linear model given as its argument.

deviance(fit3)

# how to calculate F value
# Calculating F-statistic - Denominator (Mean Square Error)

# F = (explained variation / df1) / (unexplained variation / df2)
# We're calculating DENOMINATOR = MSE = RSS / residual df

# fit3 = Fertility ~ Agriculture + Examination + Education + intercept
# n = 47 observations (swiss dataset)
# k = 4 parameters (3 predictors + 1 intercept)
# Res.Df = 47 - 4 = 43 ✓

# R command:
d <- deviance(fit3) / 43

# deviance(fit3) = RSS = 3180.9 (from ANOVA table)
# d = 3180.9 / 43 = 74.0 (approx)

# This is the "average unexplained variation per degree of freedom"
# Smaller d = better model fit

# Next step will be numerator (extra RSS reduction / df reduction)


d <- deviance(fit3)/43

# F-statistic Numerator (Mean Square Improvement)

# F = (extra explained variation / extra df lost) / (leftover error / leftover df)

# NUMERATOR = [RSS_model1 - RSS_model3] / df_difference
# fit1: Fertility ~ Agriculture (RSS = 6283.1, Res.Df = 45)
# fit3: Fertility ~ Agriculture + Examination + Education (RSS = 3180.9, Res.Df = 43)

# df_difference = 45 - 43 = 2 (2 new predictors added)

# Calculate:
n <- (deviance(fit1) - deviance(fit3)) / 2

# Check: 6283.1 - 3180.9 = 3102.2
# 3102.2 / 2 = 1551.1

# What n represents:
# "Average improvement per new predictor"
# How much RSS drops PER degree of freedom used by new variables

# Next: F = n / d = 1551.1 / 74.0 ≈ 20.968 ✓

n <- (deviance(fit1) - deviance(fit3))/2

n/d # calculate the ratio


# calculate the p-value
# which is the probability that a value of n/d or larger would be drawn from an F distribution which has parameters 2 and 43

pf(n/d, 2, 43, lower.tail=FALSE)


# ANOVA Conclusion & Residual Normality Check

# F-test result: p = 4.4e-07 << 0.05
# Conclusion: fit3 SIGNIFICANTLY better than fit1
# "Adding Examination + Education explains A LOT more Fertility variation"

# BIG CAVEAT: ANOVA assumes NORMAL RESIDUALS
# If residuals non-normal → F-test unreliable (could get false significance)

# Test residuals normality:
shapiro.test(fit3$residuals)

# Shapiro-Wilk test:
# H₀: residuals ~ Normal(0,1)
# p < 0.05 → reject normality → ANOVA suspect
# p > 0.05 → normality plausible → trust F-test

# Expected output (swiss data):
# W ≈ 0.97, p > 0.05 → residuals approximately normal ✓
# ANOVA trustworthy!

# ALWAYS check residuals after significant F-tests

shapiro.test(fit3$residuals)



anova(fit1, fit3, fit5, fit6)

)
swirl()




#  12: Binary Outcomes  
#  glm() to model a process with a binary outcome and a continuous predictor.
# If p is the probability of an event, the associated odds are p/(1-p).

ravenData

# Logistic regression model for Ravens win probability

# We expect the relationship between score and win probability to be smooth.
# The Ravens should not win exactly half the games when they score 0 points,
# nor win 100% of the games when they score more than 28.
# A generalized linear model with a logit link models this smooth curve.

# In logistic regression, the log odds of a win are modeled as linear in the score:
#
#   log(p / (1 - p)) = b0 + b1 * score
#
# where:
#   p        = probability the Ravens win
#   log(p/(1-p)) = logit (log odds of a win)

# This logit link ensures that:
#   - p stays between 0 and 1
#   - the win probability curve is smooth and S‑shaped as a function of score

# Fit the model in R using glm with family = binomial (logit link)
# Example:
#
#   model <- glm(win ~ score, data = ravens_data, family = binomial)


# The "best" b0 and b1 are those which maximize the likelihood of the actual win/loss record. 
# Based on the score of a game, b0 and b1 give us a log odds, which we can convert to a probability, p, of a win.



mdl <- glm(ravenWinNum ~ ravenScore, binomial, ravenData)

# to see the model's estimates for lower scores

lodds <- predict(mdl, data.frame(ravenScore = c(0, 3, 6)))


# To convert log odds to probabilities use
exp(lodds)/(1+exp(lodds))

summary(mdl)

# To get the corresponding intervals for exp(b0) and exp(b1).
exp(confint(mdl))

anova(mdl)


qchisq(0.95, 1) # to compute the threshold of this percentile.

2
1
0
0


)
swirl()

1
13

# 13: Count Outcomes   

# Poisson Regression - Main Ideas

# Many real-world data are COUNTS:
# - number of calls
# - number of flu cases
# - number of cars passing a bridge

# Sometimes data are RATES or PROPORTIONS:
# - percent of children passing a test
# - percent of visits from another site

# For count data, Poisson regression is often used.

# Poisson distribution:
# - Models events that happen independently
# - Events occur one at a time
# - There is an average rate of occurrence called lambda (λ)

# In this lesson:
# - λ = expected visits per day
# - As the website gets more popular, λ increases over time

# Important Poisson property:
# - mean = λ
# - variance = λ
# So the variance is equal to the mean.

# Example in R:
var(rpois(1000, 50))
# This should be close to 50, because the theoretical mean and variance are both 50.


# Central Limit Theorem (CLT) - Key Idea

# CLT says: Sample means become normally distributed as n → ∞
# Even if original data is skewed, uniform, whatever!

# Poisson + CLT connection:
# Small λ (λ=2): Poisson = skewed, discrete
# Large λ (λ=100): Poisson ≈ Normal (bell-shaped)

# Why? Counts over time = sum of many tiny events
# CLT applies → sums look normal for large λ

# Visual progression:
# λ=2:   Sparse, right-skewed bars
# λ=50:  Filling out, more symmetric  
# λ=100: Almost perfect normal curve

# Takeaway: Large λ Poisson ≈ Normal
# This justifies using normal-based methods for big counts


# Poisson Regression Model - Exponential Growth

# Poisson model assumes:
# log(λ) = b0 + b1 × date
# Where λ = expected visits per day

# Transform back to λ:
# λ = exp(b0 + b1 × date)
# λ = exp(b0) × exp(b1 × date)
# λ = exp(b0) × [exp(b1)]^date

# Key interpretation:
# exp(b1) = **daily growth factor**
# Example: 
# - exp(b1) = 1.05 → 5% growth per day
# - exp(b1) = 1.10 → 10% growth per day

# Why log link?
# - λ must be positive (> 0)
# - Linear predictor can be any real number
# - log() + exp() guarantees positive λ

# Visual: Smooth black curve through data points
# Shows exponential growth pattern
# Perfect fit for Poisson regression!

# In R:
# glm(visits ~ date, family = poisson(link = "log"))


head(hits)


class(hits[,'date'])




# Dates can, for example, be added or subtracted, or easily coverted to numbers

as.integer(head(hits[,'date']))

mdl <- glm(visits ~ date, poisson, hits)


# The black line is the estimated lambda, or mean number of visits per day. We see that 
# mean visits per day increased from around 5 in early 2011 to around 10 by 2012, and to around 20 by late 2013. 


summary(mdl)


exp(confint(mdl, 'date'))    # Get the 95% confidence interval for exp(b1) by exponentiating 



# To find the exact date we can use gives the row
which.max(hits[,'visits'])

hits[704,]


lambda <- mdl$fitted.values[704]


# We can find the 95th percentile of this distribution using 
qpois(.95, lambda)

# Poisson Regression for PROPORTIONS - Using Offset

# Problem: Proportions are fractions (0.23), Poisson needs WHOLE COUNTS (0,1,2...)
# Solution: Model numerator with denominator as OFFSET

# Data:
# simplystats = visits FROM Simply Statistics (numerator)
# visits = TOTAL visits (denominator) 

# Goal: Model fraction = simplystats / (visits + 1)

# Poisson model with offset:
# log(λ) = log(visits + 1) + b0 + b1*date
# Coefficient of log(visits+1) = 1 (FIXED)

# Simplify:
# log(λ / (visits + 1)) = b0 + b1*date
# log(proportion) = b0 + b1*date ✓

# Why +1? Avoids log(0) when visits = 0

# In R:
# glm(simplystats ~ date + offset(log(visits + 1)), 
#     family = poisson)

# Interpretation:
# b1 = change in log(proportion) per day
# exp(b1) = multiplicative change in proportion per day


mdl2 <- glm(simplystats ~ date, poisson, hits, offset=log(visits+1))



# model is not that impressive.
# verify this weakness in the model by finding mdl2's 95th percentile for that day. 
qpois(.95, mdl2$fitted.values[704])


2
2

)
install_course("Getting and Cleaning Data")
swirl()

1

00
0

)
install_course("Statistical Inference")
swirl()

3

1

# Statistical Inference 1

# Statistic vs Random Variable

# A statistic is a number computed from a sample.
# Example: sample mean, sample variance, sample correlation.
# Statistics are used to learn about a population.

# A random variable is the outcome of a random process.
# Example: the number that comes up on a die roll, or the result of a coin toss.

# Important idea:
# If you apply a formula to random data, the result is also random.
# So sample means, sample variances, and other statistics are random variables too.

# Why this matters:
# Different samples give different statistics.
# That is why statistics have their own probability distributions.

# Keep these two distributions separate:
# 1. The distribution of the raw data.
# 2. The distribution of the statistic computed from that data.



# Two broad flavors of inference

# 1. Frequentist inference
# Probability means the long-run proportion of times an event happens
# in many repeated, identical experiments.
# Parameters are treated as fixed, and data are random.

# 2. Bayesian inference
# Probability represents uncertainty or belief about a hypothesis.
# As new data arrive, you update the probability of the hypothesis.
# Prior belief + new evidence = updated belief (posterior).

# Very short version:
# Frequentist = long-run frequency
# Bayesian = update beliefs with evidence

2
0
)
swirl()

2

# Probability

4
2
# Probability - Basic Definition

# P(event) = # favorable outcomes / # all possible outcomes
# Range: 0 ≤ P ≤ 1

# Examples:
# Coin flip: P(heads) = 1/2 = 0.5
# 6-sided die: P(3) = 1/6 ≈ 0.167  
# 2 heads in 2 flips: P(HH) = 1/4 = 0.25

2

# Probability Properties

# P(E) = # ways E occurs / # all possible outcomes
# Always: 0 ≤ P(E) ≤ 1

# Boundary cases:
# P(impossible) = 0
# P(certain) = 1

# Key rule:
# Σ P(all outcomes) = 1

# Equal probability case:
# Fair die: P(each face) = 1/6
# n outcomes: P(each) = 1/n

# Examples:
# Coin: P(H) + P(T) = 0.5 + 0.5 = 1
# Die: 6 × (1/6) = 1

# If A and B are two independent events then the probability of them both
# occurring is the product of the probabilities. P(A&B) = P(A) * P(B)

3

# Addition Rule for Disjoint (Mutually Exclusive) Events

# If event E can happen multiple disjoint ways:
# P(E) = P(E1) + P(E2) + P(E3) + ...

# Disjoint = mutually exclusive = cannot happen together

# Examples:
# P(even die roll) = P(2) + P(4) + P(6) = 1/6 + 1/6 + 1/6 = 3/6 = 0.5

# P(pass exam) = P(A) + P(B) + P(C) = 0.2 + 0.3 + 0.4 = 0.9

# Key: Only works for DISJOINT events!
# If events overlap → use P(A or B) = P(A) + P(B) - P(A and B)


# General Addition Rule (Overlapping Events)

# P(A ∪ B) = P(A) + P(B) - P(A ∩ B)
# "At least one of A or B" = individual probs minus overlap

# Why subtract intersection?
# Without subtraction: P(A) + P(B) double-counts A∩B region
# Subtract P(A∩B) once → correct total

# Examples:
# P(red OR blue marble) = P(red) + P(blue) - P(red AND blue)
# Die: P(≤3 OR even) = P(≤3) + P(even) - P(≤3 AND even)

# Special case (disjoint):
# If A ∩ B = ∅ → P(A ∪ B) = P(A) + P(B) - 0 = P(A) + P(B)


1

# Two dice: P(even sum OR sum > 8)

# Calculate each:
# P(even sum) = 18/36  (2,4,6,8,10,12 for each die1)
# P(sum > 8) = 10/36  (9,10,11,12)
# P(both) = 4/36      (10,12 even AND >8)

# Formula: P(A∪B) = P(A) + P(B) - P(A∩B)
# (18 + 10 - 4)/36 = 24/36 = 2/3 ≈ 0.667 ✓

# Check options:
# 1: (18+10-4)/36 = ✓ CORRECT
# 2: (18+10-2)/36 = wrong intersection
# 3: (18+10)/36 = double-counts overlap
# 4: Wrong numbers

4


1 - (2+1)/36



deck

13*4

4/52

12/52


# Face card same suit, 2nd draw (no replacement)

# Standard deck: 52 cards, 4 suits, 3 face cards per suit (J,Q,K)
# Total face cards = 12

# Step 1: P(1st = face card) = 12/52 = 3/13
# (Any face card works)

# Step 2: GIVEN 1st was face card, P(2nd = same suit face card)
# Same suit had 3 face cards originally
# 1 used → 2 face cards left in that suit
# Total cards left = 51
# P = 2/51

# Total probability:
# P = (12/52) × (2/51) = (3/13) × (2/51) = 6/663 = 2/221 ≈ 0.009

# Answer: 2/51

2
0



)
swirl()

3


# Continuous Random Variables

# Definition: Can take ANY value in a range (infinite possibilities)
# Examples: 
# - Time (3.24 seconds)
# - Distance (1.73 meters)  
# - Weight (68.4 kg)
# - Temperature (22.7°C)

# Key point:
# Measurements seem discrete due to precision limits
# (We measure height to mm, but it's truly continuous)
# But we model them as continuous for math

# Contrast with discrete:
# Discrete: 1, 2, 3, ... (countable)
# Continuous: 1.23, 1.234, 1.2345... (uncountable)




# A probability mass function (PMF) gives the probability that a discrete random variable is exactly equal to some value.

0.64/1

3

mypdf

integrate(mypdf,0,1.6)


3

4

1


# A probability model connects data to a population using assumptions.
# Be careful to distinguish between population medians and sample medians
#  A sample median is an estimator of a population median (the estimand).

1

0


)
swirl()


4

# Conditional Probability

1

3

# Conditional Probability

# P(A | B) means: the probability that A happens GIVEN that B has already happened.

# Formula:
# P(A | B) = P(A ∩ B) / P(B)

# In words:
# - P(A ∩ B) = probability that BOTH A and B happen
# - P(B) = probability that B happens

# Important:
# This only works if P(B) > 0.

# Example:
# If B is "it is raining" and A is "the ground is wet",
# then P(A | B) is the probability the ground is wet given that it is raining.



2

1



P(B|A) = P(B&A)/P(A) = P(A|B) * P(B)/P(A)


# Bayes' Theorem - Derivation & Formula

# From conditional probability:
# P(A&B) = P(A|B) × P(B) = P(B|A) × P(A)

# Solve for P(B|A):
# P(B|A) = [P(A|B) × P(B)] / P(A)

# If P(A) unknown, use Law of Total Probability:
# P(A) = P(A|B) × P(B) + P(A|~B) × P(~B)

# Full Bayes' Rule:
# P(B|A) = [P(A|B) × P(B)] / [P(A|B) × P(B) + P(A|~B) × P(~B)]

# Notation:
# ~B = "not B" (B complement)
# P(~B) = 1 - P(B)

# Intuition:
# Updates probability of B given evidence A
# Uses "likelihood" P(A|B) + prior P(B)



P(B|A) = P(A|B) * P(B) / ( P(A|B) * P(B) + P(A|~B) * P(~B) )


1

2


# By Bayes' Formula, P(D|+) = P(+|D) * P(D) / ( P(+|D) * P(D) + P(+|~D) * P(~D) )


997*0.001

skip()

(1-.985)*(1-.001)


(.997*.001) / (.997*.001 + .015*.999)

4

2

2

3

2


1

4

2



# IID - Independent and Identically Distributed

# **Independent**: Statistically unrelated
# One variable's value gives no info about others

# **Identically Distributed**: Same population distribution
# Same mean, variance, shape for all

# Examples of IID:
# - 6 coin flips (independent, all Bernoulli p=0.5)
# - Heights of 100 random people (independent, all Normal μ,σ)

# Why it matters:
# - Default assumption for random samples
# - Foundation for t-tests, ANOVA, regression
# - Central Limit Theorem requires IID

# In practice:
# We usually assume samples are IID
# Violating IID → biased standard errors, wrong p-values



2
0


)
swirl()

5

# Expectations 

# EXPECTED VALUE E(X) - Discrete Case

# Definition:
# E(X) = Σ [x * p(x)] over all possible x
# = weighted average where weights = probabilities

# Example: Die roll (fair 6-sided)
# x <- 1:6                    # possible values
# p_x <- rep(1/6, 6)          # PMF: equal probs
# E_X <- sum(x * p_x)         # E(X) = 3.5
# or: mean(1:6) = 3.5

# R code:
# expected_value <- function(x, p_x) {
  # sum(x * p_x)
# }

# Coin flip example: X = 1 (heads), 0 (tails), p=0.5
# E_X_coin <- 1*0.5 + 0*0.5  # = 0.5

# Intuition: "Center of mass" of {x, p(x)} points
# If you repeat experiment many times, average → E(X)


# another term for expected value = mean

(1+2+3+4+5+6)/6

expect_dice

dice_high

expect_dice(dice_high) # calculate the expected value of a roll of dice_high

expect_dice(dice_low)

# LINEARITY OF EXPECTATION - Super Useful Property!

# Rules (work for ANY random variables X, Y):
# 1. E(c*X) = c * E(X)         # Scaling
# 2. E(X + Y) = E(X) + E(Y)    # Addition  
# 3. E(aX + bY) = aE(X) + bE(Y) # Combined

# Examples:
# Die roll X, E(X) = 3.5
E(2*X) = 2*3.5 = 7        # Double the die
E(X + 3) = 3.5 + 3 = 6.5  # Die + constant

# Two coins X (coin1), Y (coin2), each E() = 0.5
E(X + Y) = 0.5 + 0.5 = 1  # Total heads in 2 flips

# R demo:
x <- 1:6; p_x <- rep(1/6, 6)
E_X <- sum(x * p_x)  # 3.5

# Linearity check:
sum((2*x) * p_x)     # = 7 ✓ E(2X)
sum((x + 3) * p_x)   # = 6.5 ✓ E(X+3)

# Why amazing? No need to know joint distribution!
# Works even if X, Y dependent

skip()


1

integrate(myfunc, 0, 2)

spop

mean(spop)

allsam

apply(allsam,1,mean)


mean(smeans)

# 1/n * (E(X_1) + E(X_2) + ... + E(X_n)) = (1/n)*n*mu = mu


2

# Expected values are properties of distributions. The average, or mean, of random variables is itself a random variable and its associated
# distribution itself has an expected value. The center of this distribution is the same as that of the original distribution.

# a population mean is a center of mass of population.


1

0

)
swirl()

2
3
7

# Common Distributions

1

# Bernoulli

# associated with experiments which have only 2 possible outcomes. 
# These are also called (by people in the know) binary trials.

1


# Bernoulli random variables take only the values 1 and 0
3

# Bernoulli PMF

# If x = 1:
# p^1 * (1-p)^0 = p
# → probability of 1

# If x = 0:
# p^0 * (1-p)^1 = 1-p
# → probability of 0

# So the general formula is:
# P(X = x) = p^x * (1-p)^(1-x)

4


1

# Bernoulli mean

# X = 1 with probability p
# X = 0 with probability 1-p

# Expected value:
# E(X) = 1*p + 0*(1-p) = p

# So the mean of a Bernoulli random variable is p


2

2

# Binomial PMF - Correct Answer: 2

# P(X=x) = choose(n,x) * p^x * (1-p)^(n-x)

# Why this formula?
# 1. choose(n,x) = number of ways to get x successes in n trials
# 2. p^x = probability of x successes  
# 3. (1-p)^(n-x) = probability of (n-x) failures

# Why others wrong?
# 1: Swapped exponents → p^(failures) * (1-p)^(successes) ❌
# 3: Missing combinations & failures → only successes ❌  
# 4: Nonsense formula ❌

# When x=1, n=1 → reduces to Bernoulli: p^1 * (1-p)^0 = p ✓


2


# Manual formula: choose(n,x) * p^x * (1-p)^(n-x)

n <- 5; p <- 0.8

# P(X=3):
choose(5,3) * (0.8)^3 * (0.2)^2
# 10 * 0.512 * 0.04 = 0.2048

# P(X=4):  
choose(5,4) * (0.8)^4 * (0.2)^1
# 5 * 0.4096 * 0.2 = 0.4096

# P(X=5):
choose(5,5) * (0.8)^5 * (0.2)^0
# 1 * 0.32768 * 1 = 0.32768

# Total P(X≥3):
0.2048 + 0.4096 + 0.32768 = 0.94208 


# verify your answer with the R function pbinom
pbinom(2, 5, 0.8, lower.tail = FALSE)

# NORMAL (GAUSSIAN) DISTRIBUTION

# Key facts:
# - Bell-shaped curve, symmetric around mean μ
# - X ~ N(μ, σ²)    # μ = center, σ² = width/spread

# Visual:
# Higher σ² → fatter/wider bell
# Lower σ² → skinny/tall bell

# Notation:
# X ~ N(μ, σ²)     # General normal
# Z ~ N(0, 1)      # STANDARD normal (special case)

# In R:
# rnorm(100, mean=0, sd=1)    # Generate standard normal
# curve(dnorm(x), -3, 3)      # Plot bell curve

# Why important?
# Central Limit Theorem → many real data ≈ normal
# Foundation for t-tests, ANOVA, linear regression


# qnorm() - Standard Normal Quantiles

# qnorm(prob) = x where P(Z < x) = prob
# Finds x for given area LEFT of curve

# 10th percentile = qnorm(0.10)
qnorm(0.10)
# Returns ≈ -1.28

# Meaning: 10% of standard normal below -1.28
# 90% of standard normal above -1.28

# Examples:
qnorm(0.025)   # ≈ -1.96 (2.5th percentile)
qnorm(0.05)    # ≈ -1.64 (5th percentile)  
qnorm(0.50)    # = 0 (median)
qnorm(0.95)    # ≈ +1.64 (95th percentile)

# Defaults to standard normal N(0,1)


skip()

1

0

# 97.5th Percentile - Simple Symmetry

# Given: 2.5% area LEFT of -1.96

# Bell curve symmetric around 0:
# 2.5% LEFT of -1.96
# = 2.5% RIGHT of +1.96

# Total area LEFT of +1.96:
# 50% (left half) + 47.5% (right of 0, left of +1.96)
# = 97.5%

# Answer: +1.96

# Check: qnorm(0.975) = 1.96 ✓


1

# NORMAL to STANDARD 

# ===== STEP 1: Shrink ANY normal to standard bell =====
# Subtract average, divide by spread
# New_value = (old_value - average) / spread

# ===== STEP 2: Grow standard back to ANY normal =====  
# Add average, multiply by spread
# New_value = average + spread * standard_value

# ===== Example (mean=3, spread=2) =====
# Want 97.5th percentile?
# 1. Standard 97.5th = +1.96 
# 2. 3 + 2*1.96 = 6.92 ✓

# Always works both ways!

# we can use R's qnorm function and simply specify the mean and
# standard deviation (the square root of the variance)

?qnorm

qnorm(.975, mean = 3, sd = 2)

skip()

pnorm(1200, mean = 1020, sd = 50, lower.tail = FALSE)

pnorm((1200-1020)/50,lower.tail=FALSE)

#finding 75 quartile

qnorm(.75, mean = 1020, sd = 50, lower.tail = TRUE)

pnorm(qnorm(.53))

qnorm(pnorm(.53))


# POISSON DISTRIBUTION - Counts of Rare Events

# What it models:
# - # emails/hour
# - # typos/page  
# - # customers/minute
# - # defects/meter

# Key conditions:
# 1. Fixed time/space interval
# 2. Average rate λ (lambda) stays constant
# 3. Events independent (one doesn't cause next)
# 4. Events don't happen simultaneously

# λ = average # events per interval
# Examples:
# λ=2 → expect 2 emails/hour on average
# λ=0.5 → expect 0.5 typos/page (half a typo!)

# In R:
# dpois(2, lambda=3)    # P(exactly 2 events | λ=3)
# ppois(5, lambda=3)    # P(≤5 events | λ=3)

# Mean = Variance = λ ✓


# POISSON PMF Formula

# P(X=x) = (λ^x * e^(-λ)) / x!

# Where:
# λ = average rate (only parameter)
# x = 0, 1, 2, 3, ... (to infinity)
# e = 2.718 (math constant)
# x! = factorial (1*2*3*...*x)

# Examples:
# λ=2, x=0: (2^0 * e^(-2)) / 0! = 0.135
# λ=2, x=1: (2^1 * e^(-2)) / 1! = 0.271
# λ=2, x=2: (2^2 * e^(-2)) / 2! = 0.271

# In R: dpois(x, lambda)
dpois(2, lambda=2)  # = 0.271 ✓


#The mean and variance of the Poisson distribution are both lambda.

# POISSON - Scaling by Time

# Rate scales with time interval
# X ~ Poisson(λ * t)

# λ = rate per unit time
# t = total time monitored

# Example: 
# λ = 2.5 people/hour
# t = 4 hours  
# Expected = 2.5 * 4 = 10 people

# P(≤3 people in 4 hours):
ppois(3, lambda = 2.5 * 4)
# = ppois(3, 10)

# Very low probability (way below expected 10!)


pbinom(5, 1000, .01, lower.tail = TRUE, log.p = FALSE)

ppois(5,1000*.01,lower.tail = TRUE, log.p = FALSE)

1

0

)
swirl()

2
3

# 8: Asymptotics 

# ASYMPTOTICS - "What happens with HUGE samples?"

# Core idea:
# Imagine sample size n → ∞ (infinite data)
# How do statistics behave?

# Why useful?
# - Makes math simple (normal approximations)
# - Explains why t-tests → z-tests as n grows
# - Justifies p-values, confidence intervals

# Examples:
# Sample mean → exactly true mean (Law of Large Numbers)
# Sample mean distribution → perfect normal (Central Limit Theorem)

# Reality check:
# n=30+ often "large enough" for approximations
# Exact for infinite data, approximate for finite data

# Key phrase: "as n → ∞"


3

# The mean of the sample mean estimates population mean


# LAW OF LARGE NUMBERS (LLN)

# Core idea:
# Sample average → true average as n → ∞

# Coin example:
# Fair coin: true P(heads) = 0.5
# n=10 flips: might get 7 heads (70%)
# n=1000 flips: gets closer to 50%
# n=1,000,000 flips: almost exactly 50%

# Math:
# Sample mean ¯x → population mean μ
# Bigger n = better estimate

# Why it works:
# Random ups/downs cancel out over many trials

# Simulations show:
# Small n → wiggly averages
# Large n → stable at true value

# Key phrase: "average approaches what it's estimating"


skip()

coinPlot(10)

coinPlot(10000)


1


# CENTRAL LIMIT THEOREM (CLT) - Statistics Superpower!

# What it says:
# Sample averages → normal distribution when n is large

# "Properly normalized" = shrink & center:
# Z = (sample_average - true_average) / (spread / sqrt(n))

# Result: Z looks like standard normal N(0,1)

# Key requirements:
# - Large sample size (n ≥ 30 usually works)
# - IID data (independent, same distribution)

# Why amazing?
# - Population can be ANY shape (skewed, weird, etc.)
# - Sample means always normal for big n!

# Examples:
# - Average height → normal regardless of population shape
# - Average speech errors → normal 
# - ¯x distribution → N(μ, σ/√n)

# Foundation for:
# t-tests, confidence intervals, p-values



1

# CLT + EMPIRICAL RULE - Sample Means

# Sample mean distribution (large n):
# Normal with mean = μ, std dev = σ/√n

# 68-95-99.7 Rule applies:
# 68% sample means within 1 * (σ/√n) of true μ
# 95% sample means within 2 * (σ/√n) of true μ  
# 99.7% within 3 * (σ/√n)

# Standard normal picture (μ=0, σ=1):
# Dark shade: ±1 = 68%
# Light shade: ±2 = 95% total
# Almost all: ±3 = 99.7%

# Why shrinking std dev?
# Bigger n → sample means cluster tighter around true μ
# σ/√n gets smaller as n grows


# 95% CONFIDENCE INTERVAL - Simple Breakdown

# CLT says: sample averages ~ Normal(μ, σ/√n)

# 95% Rule: Normal curve → 95% between ±2 std devs
# Sample means: 95% between μ ± 2*(σ/√n)

# Flip it around:
# ¯x ± 2*(σ/√n) contains true μ 95% of the time

# Math picture:
# 2.5% sample means < μ - 2SE
# 47.5% between μ-2SE and μ  
# 47.5% between μ and μ+2SE
# 2.5% sample means > μ + 2SE
# Total inside interval: 95%

# "95% interval" = sample_mean ± 2 * (σ/√n)
# Repeat 100 times → 95 intervals catch true μ

# Key: SE = σ/√n shrinks with bigger n!



# Common Stats Greek Symbols

# α (alpha) = significance level
# Usually 0.05 → 5% chance of wrong "significant" result
# Controls Type I error (false positive)

# β (beta) = Type II error rate
# Probability of missing real effect (false negative)
# Usually want β < 0.2 (20%)

# 1 - β = power (ability to detect real effects)

# Other common ones:
# μ = population mean
# σ = population std dev
# σ² = population variance

# In confidence intervals:
# 1 - α = confidence level (e.g., 0.95)


?qnorm

qnorm(0.95, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)


1/sqrt(100)



# WALD CONFIDENCE INTERVAL - Binomial Proportions

# Formula:
# p' ± z * sqrt( p'(1-p') / n )

# Where:
# p' = sample proportion (your estimate)
# z = normal quantile (qnorm(0.975) ≈ 1.96)
# n = sample size

# Why replace p with p'?
# Don't know true p → use sample estimate p'

# More precise than "2":
qnorm(0.975)  # 1.95996 (vs rough 2)

# Example:
# 60 heads in 100 flips → p' = 0.60
# 95% CI: 0.60 ± 1.96 * sqrt(0.60*0.40/100)
#        = 0.60 ± 0.096 = [0.504, 0.696]

# R function:
prop.test(60, 100, conf.level=0.95)


skip()
p'+/- qnorm(.975)*sqrt(p'(1-p')/100)
.6 + c(-1,1)*qnorm(.975)*sqrt(.6*.4/100)



# EXACT BINOMIAL CONFIDENCE INTERVAL

# binom.test() = exact (no CLT approximation)
# Guarantees coverage, computationally heavy

# Syntax:

binom_result <- binom.test(60, 100) # successes=60, trials=100
binom_result$conf.int     # Returns: [0.5000, 0.6945] 95% CI

# Compare to Wald (approximate):
prop.test(60, 100)$conf.int  
# [0.5038, 0.6962]

# When to use:
# binom.test: small n (<30), want exact
# prop.test: large n, fast approximation

# Key difference:
# Exact → true coverage guaranteed
# Wald → CLT approximation (good for large n)



binom.test(60,100)$conf.int

mywald(.2)

# AGRESTI/COULL INTERVAL - Small Sample Fix

# Problem: Wald intervals bad for small n
# Solution: Add 2 fake successes + 2 fake failures

# Original: p' = X/n
                          # Adjusted: p' = (X + 2)/(n + 4)
                          
                          # Example (20 flips):
                          # 12 heads → p' = 12/20 = 0.60
                          # Agresti-Coull: p' = (12+2)/(20+4) = 14/24 ≈ 0.583
                          
                          # Then use normal CI formula on adjusted p':
                          # 0.583 ± 1.96 * sqrt(0.583*0.417/24)
                          
                          # Note: Keep original n=20 for SE calculation
                          # Only adjust proportion estimate
                          
                          # Better coverage for small samples!




# this might make the CI too wide.

ACCompar(20)


# POISSON CONFIDENCE INTERVALS - Rates

# Counts scale with time:
# X ~ Poisson(λ * t)

# λ = rate per unit time
# t = observation time
# Expected count = λ * t

# Example:
# λ = 2.5 defects/hour
# t = 4 hours → expected = 10 defects
# X ~ Poisson(10)

# Confidence intervals:
# For observed count x → interval for λ * t
# Divide by t → interval for rate λ

# R: poisson.test(x, T=1)  # T=observation time


lamb <- 5/94.32


# So lamb is our estimated mean and lamb/t is our estimated variance. The formula we've used to calculate a 95% confidence 
# interval is est mean + c(-1,1)*qnorm(.975)*sqrt(est var). 



lamb + c(-1,1)*qnorm(.975)*sqrt(lamb/94.32)


poisson.test(5, 94.32)$conf


#  the coverage improves as lambda gets larger, and it's quite off for small lambda values


# Recall the size of the confidence interval positively depends on standard error which is sqrt(var/n). 
# If variance is smaller then so is variability and the interval

# QUIZ REVIEW - Key Stats Concepts

# ===== LLN vs CLT =====
# LLN: sample averages → true population mean (convergence)
# CLT: sample averages → NORMAL distribution (shape) for large n

# ===== CLT Details =====
# Sample averages ~ Normal(μ, σ/√n)
# - Center: population mean μ
# - Spread: standard error = σ/√n  
# - Needs: large n (≥30), iid data
# - NOT always normal (fails for tiny n)

# ===== CONFIDENCE INTERVALS =====
# Formula: ¯x ± z * SE
# 95% CI: ¯x ± 2 * SE (or 1.96 * SE exactly)
# SE = s/√n (sample std dev)

# CI gets:
# - SMALLER with bigger n
# - SMALLER with less variability
# - BIGGER for higher coverage (99% > 95%)

# ===== SMALL SAMPLE BINOMIAL FIX =====
# Agresti-Coull: add 2 successes + 2 failures
# p' = (X+2)/(n+4)
# Better coverage than plain Wald for small n

# Common mistakes:
# - LLN ≠ CLT (convergence ≠ normality)
# - CLT needs large n (not "always")
# - CI uses standard error, not variance
# - 95% = ±2 SE (not 4, 6, 8)


# 9  T Confidence Intervals

2
3

# the formula = t=(X'-mu)/(s/sqrt(n))
# t is centered around 0

# distribution of the t statistic is independent of the population mean and variance
# it depends on the sample size n

# the formula is Est +/- t-quantile *std error(Est) 


2



# it has one parameter = df - degree of freedom

# As df increases, the t distribution gets more like a standard normal, so it's centered around 0. 
# the t assumes that the underlying data are iid Gaussian so the statistic (X' - mu)/(s/sqrt(n)) has n-1 degrees of freedom.


2

myplot(2)


myplot(20)

myplot2(2)


qt(.975, 2)

myplot2(20)

# quantiles are closer with higher df

4

# for skewed dist T is not always applicable.
# gotta go sum like logs or using different summary like median



mn + c(-1,1)*qt(.975,9)*s/sqrt(10)

skip()

t.test(difference)$conf.int





































































































































































































        













































































































































































































































































