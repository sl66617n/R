Financial Modeling, Summer 2017
Daniel Lee
Introduction to R for Finance
Chapter 1: The Basics
1.1 Your first R script
1.2 Arithmetic in R (1)
1.3 Arithmetic in R (2)
1.4 Assignment and variables (1)
1.5 Assignment and variables (2)
1.6 Financial returns (1)
1.7 Financial returns (2)
1.8 Data type exploration
1.9 What’s that data type?
Chapter 2: Vectors and Matrices
2.1 c()ombine
2.2 Coerce it
2.3 Vector names()
2.4 Visualize your vector
2.5 Weighted average (1)
2.6 Weighted average (2)
2.7 Weighted average (3)
2.8 Vector subsetting
2.9 Create a matrix!
2.10 Matrix <- bind vectors
2.11 Visualize your matrix
2.12 cor()relation
2.13 Matrix subsetting
Chapter 3: Data Frames
3.1 Create your first data.frame()
3.2 Making head()s and tail()s of your data with some str()ucture
3.3 Naming your columns / rows
3.4 Accessing and subsetting data frames (1)
3.5 Accessing and subsetting data frames (2)
3.6 Accessing and subsetting data frames (3)
3.7 Adding new columns
3.8 Present value of projected cash flows (1)
3.9 Present value of projected cash flows (2)
Chapter 4: Factors
4.1 Create a factor
4.2 Factor levels
4.3 Factor summary
4.4 Visualize your factor
4.5 Bucketing a numeric variable into a factor
4.6 Create an ordered factor
4.7 Subsetting a factor
4.8 stringsAsFactors
Chapter 5: Lists
5.1 Create a list
5.2 Named lists
5.3 Access elements in a list
5.4 Adding to a list
5.5 Removing from a list
5.6 Split it
5.7 Split-Apply-Combine
5.8 Attributes
Disclaimer: The content of this RMarkdown note came from a course called Introduction to R for Finance in datacamp.

Introduction to R for Finance
Chapter 1: The Basics
1.1 Your first R script
# Addition!
3 + 5
## [1] 8

# Subtraction!
6-4
## [1] 2
1.2 Arithmetic in R (1)
# Addition 
2 + 2
## [1] 4

# Subtraction
4 - 1
## [1] 3

# Multiplication
3 * 4
## [1] 12

# Division
4 / 2
## [1] 2

# Exponentiation
2^4
## [1] 16

# Modulo
7 %% 3  # The modulo returns the remainder of the division of the number to the left by the number on the right.
## [1] 1
1.3 Arithmetic in R (2)
The correct sequence of “order of operation” is:

Parenthesis, Exponentiation, Multiplication and Division, Addition and Subtraction

1.4 Assignment and variables (1)
A variable allows you to store a value or an object in R. You can then later use this variable’s name to easily access the value or the object that is stored within this variable. You use <- to assign a variable.

# Assign 200 to savings
savings <- 200

# Print the value of savings to the console
savings
## [1] 200
1.5 Assignment and variables (2)
# Assign 100 to my_money
my_money <- 100

# Assign 200 to dans_money
dans_money <- 200

# Add my_money and dans_money
my_money + dans_money
## [1] 300

# Add my_money and dans_money again, save the result to our_money
our_money <- my_money + dans_money
1.6 Financial returns (1)
multiplier = 1 + (return / 100)

# Variables for starting_cash and 5% return during January
starting_cash <- 200
jan_ret <- 5   # 5% interest rate
jan_mult <- 1 + (jan_ret / 100)

# How much money do you have at the end of January?
post_jan_cash <- starting_cash * jan_mult

# Print post_jan_cash
post_jan_cash
## [1] 210

# January 10% return multiplier
jan_ret_10 <- 10
jan_mult_10 <- 1 + 10 / 100 

# How much money do you have at the end of January now?
post_jan_cash_10 <- starting_cash * jan_mult_10 

# Print post_jan_cash_10
post_jan_cash_10
## [1] 220
1.7 Financial returns (2)
# Starting cash and returns 
starting_cash <- 200
jan_ret <- 4   # 4% interest rate
feb_ret <- 5

# Multipliers
jan_mult <- 1 + 4 / 100
feb_mult <- 1 + 5 / 100

# Total cash at the end of the two months
total_cash <- starting_cash * jan_mult * feb_mult

# Print total_cash
total_cash
## [1] 218.4
1.8 Data type exploration
R’s most basic data types:

Numerics are decimal numbers like 4.5. A special type of numeric is an integer, which is a numeric without a decimal piece. Integers must be specified like 4L.
Logicals are the boolean values TRUE and FALSE. Capital letters are important here; true and false are not valid.
Characters are text values like “hello world”.
# Apple's stock price is a numeric
apple_stock <- 150.45 

# Bond credit ratings are characters
credit_rating <- "AAA"

# You like the stock market. TRUE or FALSE?
my_answer <- TRUE

# Print my_answer
my_answer
## [1] TRUE
1.9 What’s that data type?
A way to find what data type a variable is: class(my_var)

a <- TRUE
class(a)
## [1] "logical"

b <- 5.5
class(b)
## [1] "numeric"

c <- "Hello World"
class(c)
## [1] "character"
Chapter 2: Vectors and Matrices
2.1 c()ombine
# Another numeric vector
ibm_stock <- c(159.82, 160.02, 159.84)

# Another character vector
finance <- c("stocks", "bonds", "investments")

# A logical vector
logic <- c(TRUE, FALSE, TRUE)
2.2 Coerce it
A vector can only be composed of one data type. This means that you cannot have both a numeric and a character in the same vector. If you attempt to do this, the lower ranking type will be coerced into the higher ranking type.

For example: c(1.5, “hello”) results in c(“1.5”, “hello”) where the numeric 1.5 has been coerced into the character data type.

The hierarchy for coercion is:

logical < integer < numeric < character

Logicals are coerced a bit differently depending on what the highest data type is. c(TRUE, 1.5) will return c(1, 1.5) where TRUE is coerced to the numeric 1 (FALSE would be converted to a 0). On the other hand, c(TRUE, “this_char”) is converted to c(“TRUE”, “this_char”).

2.3 Vector names()
# Vectors of 12 months of returns, and month names
ret <- c(5, 2, 3, 7, 8, 3, 5, 9, 1, 4, 6, 3)
months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

# Add names to ret
names(ret) <- months

# Print out ret to see the new names!
ret
## Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec 
##   5   2   3   7   8   3   5   9   1   4   6   3
2.4 Visualize your vector
# Look at the data
apple_stock <- c(109.49, 109.90, 109.11, 109.95, 111.03, 112.12, 113.95, 113.30, 115.19, 115.19, 115.82, 115.97, 116.64, 116.95, 117.06, 116.29, 116.52, 117.26, 116.76, 116.73, 115.82)

# Plot the data points
plot(apple_stock)   # The default is "p" for points



# Plot the data as a line graph
plot(apple_stock, type = "l")


2.5 Weighted average (1)
The weighted average allows you to calculate your portfolio return over a time period. Consider the following example:

Assume you have 20% of your cash in Microsoft stock, and 80% of your cash in Sony stock. If, in January, Microsoft earned 5% and Sony earned 7%, what was your total portfolio return?

# Weights and returns
micr_ret <- 7
sony_ret <- 9
micr_weight <- .2
sony_weight <- .8

# Portfolio return
portf_ret <- micr_ret * micr_weight + sony_ret * sony_weight
2.6 Weighted average (2)
R does arithmetic with vectors! Take advantage of this fact to calculate the portfolio return more efficiently.

# Weights, returns, and company names
ret <- c(7, 9)
weight <- c(.2, .8)
companies <- c("Microsoft", "Sony")

# Assign company names to your vectors
names(ret) <- companies
names(weight) <- companies

# Multiply the returns and weights together 
ret_X_weight <- ret * weight

# Print ret_X_weight
ret_X_weight
## Microsoft      Sony 
##       1.4       7.2

# Sum to get the total portfolio return
portf_ret <- sum(ret_X_weight)

# Print portf_ret
portf_ret
## [1] 8.6
2.7 Weighted average (3)
What if you wanted to give equal weight to your Microsoft and Sony stock returns? That is, you want to be invested 50% in Microsoft and 50% in Sony.

# Print ret
ret
## Microsoft      Sony 
##         7         9

# Assign 1/3 to weight
weight <- 1/3

# Create ret_X_weight
ret_X_weight <- ret * weight
ret_X_weight
## Microsoft      Sony 
##  2.333333  3.000000

# Calculate your portfolio return
portf_ret <- sum(ret_X_weight)
portf_ret
## [1] 5.333333

# Vector of length 3 * Vector of length 2?
ret * c(.2, .6) # R reuses the 1st value of the vector of length 2, but notice the warning!
## Microsoft      Sony 
##       1.4       5.4
2.8 Vector subsetting
What if you only wanted the first month of returns from the vector of 12 months of returns?

# Define ret
ret <- c(5, 2, 3, 7, 8, 3, 5, 9, 1, 4, 6, 3)
names(ret) <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
ret
## Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec 
##   5   2   3   7   8   3   5   9   1   4   6   3

# First 6 months of returns
ret[1:6]
## Jan Feb Mar Apr May Jun 
##   5   2   3   7   8   3

# Just March and May
ret[c("Mar", "May")]
## Mar May 
##   3   8

# Omit the first month of returns
ret[-1]
## Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec 
##   2   3   7   8   3   5   9   1   4   6   3
2.9 Create a matrix!
Matrices are similar to vectors, except they are in 2 dimensions!

# A vector of 9 numbers
my_vector <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)

# 3x3 matrix
my_matrix <- matrix(data = my_vector, nrow = 3, ncol = 3)

# Print my_matrix
my_matrix
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9

# Filling across using byrow = TRUE
matrix(data = c(2, 3, 4, 5), nrow = 2, ncol = 2, byrow = TRUE)
##      [,1] [,2]
## [1,]    2    3
## [2,]    4    5
2.10 Matrix <- bind vectors
Create them from multiple vectors that you want to combine together.

# Define vectors
apple <- c(109.49, 109.90, 109.11, 109.95, 111.03, 112.12, 113.95, 113.30, 115.19, 115.19,
           115.82, 115.97, 116.64, 116.95, 117.06, 116.29, 116.52, 117.26, 116.76, 116.73,
           115.82)
ibm <- c(159.82, 160.02, 159.84, 160.35, 164.79, 165.36, 166.52, 165.50, 168.29, 168.51, 
         168.02, 166.73, 166.68, 167.60, 167.33, 167.06, 166.71, 167.14, 166.19, 166.60, 
         165.99)
micr <- c(59.20, 59.25, 60.22, 59.95, 61.37, 61.01, 61.97, 62.17, 62.98, 62.68, 62.58,
          62.30, 63.62, 63.54, 63.54, 63.55, 63.24, 63.28, 62.99, 62.90, 62.14)

# cbind the vectors together
cbind_stocks <- cbind(apple, ibm, micr)

# Print cbind_stocks
cbind_stocks
##        apple    ibm  micr
##  [1,] 109.49 159.82 59.20
##  [2,] 109.90 160.02 59.25
##  [3,] 109.11 159.84 60.22
##  [4,] 109.95 160.35 59.95
##  [5,] 111.03 164.79 61.37
##  [6,] 112.12 165.36 61.01
##  [7,] 113.95 166.52 61.97
##  [8,] 113.30 165.50 62.17
##  [9,] 115.19 168.29 62.98
## [10,] 115.19 168.51 62.68
## [11,] 115.82 168.02 62.58
## [12,] 115.97 166.73 62.30
## [13,] 116.64 166.68 63.62
## [14,] 116.95 167.60 63.54
## [15,] 117.06 167.33 63.54
## [16,] 116.29 167.06 63.55
## [17,] 116.52 166.71 63.24
## [18,] 117.26 167.14 63.28
## [19,] 116.76 166.19 62.99
## [20,] 116.73 166.60 62.90
## [21,] 115.82 165.99 62.14

# rbind the vectors together
rbind_stocks <- rbind(apple, ibm, micr) 

# Print rbind_stocks
rbind_stocks
##         [,1]   [,2]   [,3]   [,4]   [,5]   [,6]   [,7]   [,8]   [,9]
## apple 109.49 109.90 109.11 109.95 111.03 112.12 113.95 113.30 115.19
## ibm   159.82 160.02 159.84 160.35 164.79 165.36 166.52 165.50 168.29
## micr   59.20  59.25  60.22  59.95  61.37  61.01  61.97  62.17  62.98
##        [,10]  [,11]  [,12]  [,13]  [,14]  [,15]  [,16]  [,17]  [,18]
## apple 115.19 115.82 115.97 116.64 116.95 117.06 116.29 116.52 117.26
## ibm   168.51 168.02 166.73 166.68 167.60 167.33 167.06 166.71 167.14
## micr   62.68  62.58  62.30  63.62  63.54  63.54  63.55  63.24  63.28
##        [,19]  [,20]  [,21]
## apple 116.76 116.73 115.82
## ibm   166.19 166.60 165.99
## micr   62.99  62.90  62.14
2.11 Visualize your matrix
# Define matrix
apple_micr_matrix <- cbind(apple, micr)

# View the data
apple_micr_matrix
##        apple  micr
##  [1,] 109.49 59.20
##  [2,] 109.90 59.25
##  [3,] 109.11 60.22
##  [4,] 109.95 59.95
##  [5,] 111.03 61.37
##  [6,] 112.12 61.01
##  [7,] 113.95 61.97
##  [8,] 113.30 62.17
##  [9,] 115.19 62.98
## [10,] 115.19 62.68
## [11,] 115.82 62.58
## [12,] 115.97 62.30
## [13,] 116.64 63.62
## [14,] 116.95 63.54
## [15,] 117.06 63.54
## [16,] 116.29 63.55
## [17,] 116.52 63.24
## [18,] 117.26 63.28
## [19,] 116.76 62.99
## [20,] 116.73 62.90
## [21,] 115.82 62.14

# Scatter plot of Microsoft vs Apple
plot(apple_micr_matrix)


2.12 cor()relation
Correlation is a measure of association between two things, here, stock prices, and is represented by a number from -1 to 1.

1 represents perfect positive correlation,
-1 represents perfect negative correlation, and
0 means that the stocks move independently of each other.
The cor() function will calculate the correlation between two vectors, or will create a correlation matrix when given a matrix.

# Correlation of Apple and IBM
cor(apple, ibm)
## [1] 0.8872467

# stock matrix
stocks <- cbind(apple, micr, ibm)

# cor() of all three
cor(stocks) 
##           apple      micr       ibm
## apple 1.0000000 0.9477010 0.8872467
## micr  0.9477010 1.0000000 0.9126597
## ibm   0.8872467 0.9126597 1.0000000

# Note how it fails when using more than 2 vectors! Try to run the code for the correlation of all three stocks.
#cor(apple, micr, ibm)
2.13 Matrix subsetting
The basic structure is:

my_matrix[row, col]

To select the first row and first column of stocks from the last example: stocks[1,1]
To select the entire first row, leave the col empty: stocks[1, ]
To select the first two rows: stocks[1:2, ] or stocks[c(1,2), ]
To select an entire column, leave the row empty: stocks[, 1] or stocks[, "apple"]
# Third row
stocks[3, ]
##  apple   micr    ibm 
## 109.11  60.22 159.84

# Fourth and fifth row of the ibm column
stocks[4:5, "ibm"]
## [1] 160.35 164.79

# apple and micr columns
stocks[, c("apple", "micr")]
##        apple  micr
##  [1,] 109.49 59.20
##  [2,] 109.90 59.25
##  [3,] 109.11 60.22
##  [4,] 109.95 59.95
##  [5,] 111.03 61.37
##  [6,] 112.12 61.01
##  [7,] 113.95 61.97
##  [8,] 113.30 62.17
##  [9,] 115.19 62.98
## [10,] 115.19 62.68
## [11,] 115.82 62.58
## [12,] 115.97 62.30
## [13,] 116.64 63.62
## [14,] 116.95 63.54
## [15,] 117.06 63.54
## [16,] 116.29 63.55
## [17,] 116.52 63.24
## [18,] 117.26 63.28
## [19,] 116.76 62.99
## [20,] 116.73 62.90
## [21,] 115.82 62.14
Chapter 3: Data Frames
The data frame combines the structure of a matrix with the flexibility of having different types of data in each column. The data frame is a powerful tool and the most important data structure in R.

3.1 Create your first data.frame()
Create a data frame of your business’s future cash flows, using the data.frame() function.

# Variables
company <- c("A", "A", "A", "B", "B", "B", "B")
cash_flow <- c(1000, 4000, 550, 1500, 1100, 750, 6000)
year <- c(1, 3, 4, 1, 2, 4, 5)

# Data frame
cash <- data.frame(company, cash_flow, year)

# Print cash
cash
##   company cash_flow year
## 1       A      1000    1
## 2       A      4000    3
## 3       A       550    4
## 4       B      1500    1
## 5       B      1100    2
## 6       B       750    4
## 7       B      6000    5
3.2 Making head()s and tail()s of your data with some str()ucture
A few very useful functions:

head() - Returns the first few rows of a data frame. By default, 6. To change this, use head(cash, n = ___)
tail() - Returns the last few rows of a data frame. By default, 6. To change this, use tail(cash, n = ___)
str() - Check the structure of an object. This fantastic function will show you the data type of the object you pass in (here, data.frame), and will list each column variable along with its data type.
# Call head() for the first 4 rows
head(cash, n = 4)
##   company cash_flow year
## 1       A      1000    1
## 2       A      4000    3
## 3       A       550    4
## 4       B      1500    1

# Call tail() for the last 3 rows
tail(cash, n= 3)
##   company cash_flow year
## 5       B      1100    2
## 6       B       750    4
## 7       B      6000    5

# Call str()
str(cash)
## 'data.frame':    7 obs. of  3 variables:
##  $ company  : Factor w/ 2 levels "A","B": 1 1 1 2 2 2 2
##  $ cash_flow: num  1000 4000 550 1500 1100 750 6000
##  $ year     : num  1 3 4 1 2 4 5
3.3 Naming your columns / rows
Change your column names with the colnames() function and row names with the rownames() function.

# Fix your column names
colnames(cash) <- c("company", "cash_flow", "year")

# Print out the column names of cash
colnames(cash)
## [1] "company"   "cash_flow" "year"
3.4 Accessing and subsetting data frames (1)
# Third row, second column
cash[3, 2]
## [1] 550

# Fifth row of the "year" column
cash[5, "year"]
## [1] 2
3.5 Accessing and subsetting data frames (2)
# Select the year column
cash$year
## [1] 1 3 4 1 2 4 5

# Select the cash_flow column and multiply by 2
cash$cash_flow * 2
## [1]  2000  8000  1100  3000  2200  1500 12000

# Delete the company column
cash$company <- NULL

# Print cash again
cash
##   cash_flow year
## 1      1000    1
## 2      4000    3
## 3       550    4
## 4      1500    1
## 5      1100    2
## 6       750    4
## 7      6000    5
3.6 Accessing and subsetting data frames (3)
What if you are only interested in the cash flows from company A? For more flexibility, try

subset(cash, company == "A")

The first argument is the name of your data frame, cash.
You shouldn’t put company in quotes!
The == is the equality operator. It tests to find where two things are equal, and returns a logical vector.
# Restore cash
company <- c("A", "A", "A", "B", "B", "B", "B")
cash_flow <- c(1000, 4000, 550, 1500, 1100, 750, 6000)
year <- c(1, 3, 4, 1, 2, 4, 5)

cash <- data.frame(company, cash_flow, year)

# Rows about company B
subset(cash, company == "B")
##   company cash_flow year
## 4       B      1500    1
## 5       B      1100    2
## 6       B       750    4
## 7       B      6000    5

# Rows with cash flows due in 1 year
subset(cash, year == 1)
##   company cash_flow year
## 1       A      1000    1
## 4       B      1500    1
3.7 Adding new columns
Create a new column in your data frame using data_frame$new_column.

# Quarter cash flow scenario
cash$quarter_cash <- cash$cash_flow * 0.25
cash 
##   company cash_flow year quarter_cash
## 1       A      1000    1        250.0
## 2       A      4000    3       1000.0
## 3       A       550    4        137.5
## 4       B      1500    1        375.0
## 5       B      1100    2        275.0
## 6       B       750    4        187.5
## 7       B      6000    5       1500.0

# Double year scenario
cash$double_year <- cash$year * 2
cash
##   company cash_flow year quarter_cash double_year
## 1       A      1000    1        250.0           2
## 2       A      4000    3       1000.0           6
## 3       A       550    4        137.5           8
## 4       B      1500    1        375.0           2
## 5       B      1100    2        275.0           4
## 6       B       750    4        187.5           8
## 7       B      6000    5       1500.0          10
3.8 Present value of projected cash flows (1)
Calculate the present value of $100 to be received 1 year from now at a 5% interest rate.

present_value <- cash_flow * (1 + interest / 100) ^ -year

# Restore cash
cash$quarter_cash <- NULL
cash$double_year <- NULL

# Present value of $4000, in 3 years, at 5%
present_value_4k <- 4000 * (1+0.05)^(-3)

# Present value of all cash flows
cash$present_value <- cash$cash_flow * (1+0.05)^(-cash$year)

# Print out cash
cash
##   company cash_flow year present_value
## 1       A      1000    1      952.3810
## 2       A      4000    3     3455.3504
## 3       A       550    4      452.4864
## 4       B      1500    1     1428.5714
## 5       B      1100    2      997.7324
## 6       B       750    4      617.0269
## 7       B      6000    5     4701.1570
3.9 Present value of projected cash flows (2)
Calculate how much company A and company B individually contribute to the total present value.

# Total present value of cash
total_pv <- sum(cash$present_value)
total_pv
## [1] 12604.71

# Company B information
cash_B <- subset(cash, company == "B")
cash_B
##   company cash_flow year present_value
## 4       B      1500    1     1428.5714
## 5       B      1100    2      997.7324
## 6       B       750    4      617.0269
## 7       B      6000    5     4701.1570

# Total present value of cash_B
total_pv_B <- sum(cash_B$present_value)
total_pv_B
## [1] 7744.488
Chapter 4: Factors
Are you a male or female? On a scale of 1-10, how are you feeling? These are questions with answers that fall into a limited number of categories. These types of data can be classified as factors. In this chapter, you will use bond credit ratings to learn all about creating, ordering, and subsetting factors!

4.1 Create a factor
Create a factor by using the factor() function.

# credit_rating character vector
credit_rating <- c("BB", "AAA", "AA", "CCC", "AA", "AAA", "B", "BB")

# Create a factor from credit_rating
credit_factor <- factor(credit_rating)

# Print out your new factor
credit_factor
## [1] BB  AAA AA  CCC AA  AAA B   BB 
## Levels: AA AAA B BB CCC

# Call str() on credit_rating
str(credit_rating)
##  chr [1:8] "BB" "AAA" "AA" "CCC" "AA" "AAA" "B" "BB"

# Call str() on credit_factor
str(credit_factor)
##  Factor w/ 5 levels "AA","AAA","B",..: 4 2 1 5 1 2 3 4
4.2 Factor levels
Access the unique levels of your factor by using the levels() function.

# Identify unique levels
levels(credit_factor)
## [1] "AA"  "AAA" "B"   "BB"  "CCC"

# Rename the levels of credit_factor
levels(credit_factor)
## [1] "AA"  "AAA" "B"   "BB"  "CCC"
levels(credit_factor) <- c("2A", "3A", "1B", "2B", "3C")

# Print credit_factor
credit_factor
## [1] 2B 3A 2A 3C 2A 3A 1B 2B
## Levels: 2A 3A 1B 2B 3C
4.3 Factor summary
Present a table of the counts of each bond credit rating by using the summary() function.

# Restore credit_factor
levels(credit_factor)
## [1] "2A" "3A" "1B" "2B" "3C"
levels(credit_factor) <- c("AA", "AAA", "B", "BB", "CCC")

# Summarize the character vector, credit_rating
summary(credit_rating)
##    Length     Class      Mode 
##         8 character character

# Summarize the factor, credit_factor
summary(credit_factor)
##  AA AAA   B  BB CCC 
##   2   2   1   2   1
4.4 Visualize your factor
Visualize a table by using the plot() function.

# Visualize your factor!
plot(credit_factor)


4.5 Bucketing a numeric variable into a factor
Create a factor from a numeric vector by using the cut() function.

# Define AAA_rank.
AAA_rank <- c(31,  48, 100, 53, 85, 73, 62, 74, 42, 38, 97, 61, 48, 86, 44, 9, 43, 18,  62,
              38, 23, 37, 54, 80, 78, 93, 47, 100, 22,  22, 18, 26, 81, 17, 98, 4,  83, 5,
              6,  52, 29, 44, 50, 2,  25, 19, 15, 42, 30, 27)

# Create 4 buckets for AAA_rank using cut()
AAA_factor <- cut(x = AAA_rank, breaks = c(0, 25, 50, 75, 100))

# Rename the levels 
levels(AAA_factor)
## [1] "(0,25]"   "(25,50]"  "(50,75]"  "(75,100]"
levels(AAA_factor) <- c("low", "medium", "high", "very_high")

# Print AAA_factor
AAA_factor
##  [1] medium    medium    very_high high      very_high high      high     
##  [8] high      medium    medium    very_high high      medium    very_high
## [15] medium    low       medium    low       high      medium    low      
## [22] medium    high      very_high very_high very_high medium    very_high
## [29] low       low       low       medium    very_high low       very_high
## [36] low       very_high low       low       high      medium    medium   
## [43] medium    low       low       low       low       medium    medium   
## [50] medium   
## Levels: low medium high very_high

# Plot AAA_factor
plot(AAA_factor)


4.6 Create an ordered factor
To order your factor, there are two options.

When creating a factor,
credit_rating <- c("AAA", "AA", "A", "BBB", "AA", "BBB", "A")
credit_factor_ordered <- factor(credit_rating, ordered = TRUE, levels = c("AAA", "AA", "A", "BBB"))
For an existing unordered factor
ordered(credit_factor, levels = c("AAA", "AA", "A", "BBB"))
# Use unique() to find unique words
unique(credit_rating)
## [1] "BB"  "AAA" "AA"  "CCC" "B"

# Create an ordered factor
credit_factor_ordered <- factor(credit_rating, ordered = TRUE, levels = c("AAA", "AA", "BB", "B", "CCC"))

# Plot credit_factor_ordered
plot(credit_factor_ordered)


4.7 Subsetting a factor
Removing AAA from credit_factor doesn’t remove the AAA level. To remove the AAA level entirely, add  drop = TRUE.

# Define credit_factor
credit_factor <- factor(c("AAA", "AA", "A", "BBB", "AA", "BBB", "A"),
                        ordered = TRUE,
                        levels = c("BBB", "A", "AA", "AAA"))

# Remove the A bonds at positions 3 and 7. Don't drop the A level.
keep_level <- credit_factor[-c(3, 7)]

# Plot keep_level
plot(keep_level)



# Remove the A bonds at positions 3 and 7. Drop the A level.
drop_level <- droplevels(keep_level)

# Plot drop_level
plot(drop_level)


4.8 stringsAsFactors
R’s default behavior when creating data frames is to convert all characters into factors. You can turn off this behavior by adding stringsAsFactors = FALSE.

# Variables
credit_rating <- c("AAA", "A", "BB")
bond_owners <- c("Dan", "Tom", "Joe")

# Create the data frame of character vectors, bonds
bonds <- data.frame(credit_rating, bond_owners, stringsAsFactors = FALSE)
bonds
##   credit_rating bond_owners
## 1           AAA         Dan
## 2             A         Tom
## 3            BB         Joe

# Use str() on bonds
str(bonds)
## 'data.frame':    3 obs. of  2 variables:
##  $ credit_rating: chr  "AAA" "A" "BB"
##  $ bond_owners  : chr  "Dan" "Tom" "Joe"

# Create a factor column in bonds called credit_factor from credit_rating
bonds$credit_factor <- factor(bonds$credit_rating, ordered = TRUE, levels = c("AAA", "A", "BB"))

# Use str() on bonds again
str(bonds)
## 'data.frame':    3 obs. of  3 variables:
##  $ credit_rating: chr  "AAA" "A" "BB"
##  $ bond_owners  : chr  "Dan" "Tom" "Joe"
##  $ credit_factor: Ord.factor w/ 3 levels "AAA"<"A"<"BB": 1 2 3
Chapter 5: Lists
Think about your grocery list for a second. Apples, pizza, milk, and whatever else you might have on there. These are very different items right? Wouldn’t it be nice if there was a way to hold related vectors, matrices, or data frames together in R? Enter, the list! In this final chapter, you will explore lists and many of their interesting features by building a small portfolio of stocks, and even come to realize that you have seen some of this already!

5.1 Create a list
Creat a list by using the list() function.

# List components
name <- "Apple and IBM"
apple <- c(109.49, 109.90, 109.11, 109.95, 111.03)
ibm <- c(159.82, 160.02, 159.84, 160.35, 164.79)
cor_matrix <- cor(cbind(apple, ibm))

# Create a list
portfolio <- list(name, apple, ibm, cor_matrix)

# View your first list
portfolio
## [[1]]
## [1] "Apple and IBM"
## 
## [[2]]
## [1] 109.49 109.90 109.11 109.95 111.03
## 
## [[3]]
## [1] 159.82 160.02 159.84 160.35 164.79
## 
## [[4]]
##           apple       ibm
## apple 1.0000000 0.9131575
## ibm   0.9131575 1.0000000
5.2 Named lists
There are two ways to name your list:

When creating a list
my_list <- list(my_words = words, my_numbers = numbers)
When naming a lsit that already exists
my_list <- list(words, numbers)
names(my_list) <- c("my_words", "my_numbers")
# Add names to your portfolio
names(portfolio) <- c("portfolio_name", "apple", "ibm", "correlation")

# Print portfolio
portfolio
## $portfolio_name
## [1] "Apple and IBM"
## 
## $apple
## [1] 109.49 109.90 109.11 109.95 111.03
## 
## $ibm
## [1] 159.82 160.02 159.84 160.35 164.79
## 
## $correlation
##           apple       ibm
## apple 1.0000000 0.9131575
## ibm   0.9131575 1.0000000
5.3 Access elements in a list
To access the elements in the list, use [ ].
To pull out the data inside each element of your list, use [[ ]].
If your list is named, you can use the $ operator: my_list$my_words. This is the same as using [[ ]] to return the inner data.
# Second and third elements of portfolio
portfolio[c(2,3)]
## $apple
## [1] 109.49 109.90 109.11 109.95 111.03
## 
## $ibm
## [1] 159.82 160.02 159.84 160.35 164.79

# Use $ to get the correlation data
portfolio$correlation
##           apple       ibm
## apple 1.0000000 0.9131575
## ibm   0.9131575 1.0000000

# Third item of the second element of portfolio
portfolio[[c(2,3)]]
## [1] 109.11
5.4 Adding to a list
Add new elements to an exiting list by using existingList$newElement or c(existingList, newElement).

# Add weight: 20% Apple, 80% IBM
portfolio$weight <- c(apple = 0.2, ibm = 0.8)

# Print portfolio
portfolio
## $portfolio_name
## [1] "Apple and IBM"
## 
## $apple
## [1] 109.49 109.90 109.11 109.95 111.03
## 
## $ibm
## [1] 159.82 160.02 159.84 160.35 164.79
## 
## $correlation
##           apple       ibm
## apple 1.0000000 0.9131575
## ibm   0.9131575 1.0000000
## 
## $weight
## apple   ibm 
##   0.2   0.8

# Change the weight variable: 30% Apple, 70% IBM
portfolio$weight <- c(apple = 0.3, ibm = 0.7)

# Print portfolio to see the changes
portfolio
## $portfolio_name
## [1] "Apple and IBM"
## 
## $apple
## [1] 109.49 109.90 109.11 109.95 111.03
## 
## $ibm
## [1] 159.82 160.02 159.84 160.35 164.79
## 
## $correlation
##           apple       ibm
## apple 1.0000000 0.9131575
## ibm   0.9131575 1.0000000
## 
## $weight
## apple   ibm 
##   0.3   0.7
5.5 Removing from a list
Remove elements from a list by using $, [], or [[]].

# Define portfolio
portfolio_name <- "Apple and IBM"
apple <- c(109.49, 109.90, 109.11, 109.95, 111.03)
ibm <- c(159.82, 160.02, 159.84, 160.35, 164.79)
microsoft <- c(150.0, 152.0, 154.0, 154.5)
correlation <- cor(cbind(apple, ibm))

portfolio <- list(portfolio_name = portfolio_name, 
                  apple = apple, 
                  ibm = ibm, 
                  microsoft = microsoft, 
                  correlation = correlation)

# Take a look at portfolio
portfolio
## $portfolio_name
## [1] "Apple and IBM"
## 
## $apple
## [1] 109.49 109.90 109.11 109.95 111.03
## 
## $ibm
## [1] 159.82 160.02 159.84 160.35 164.79
## 
## $microsoft
## [1] 150.0 152.0 154.0 154.5
## 
## $correlation
##           apple       ibm
## apple 1.0000000 0.9131575
## ibm   0.9131575 1.0000000

# Remove the microsoft stock prices from your portfolio
portfolio$microsoft <- NULL
portfolio
## $portfolio_name
## [1] "Apple and IBM"
## 
## $apple
## [1] 109.49 109.90 109.11 109.95 111.03
## 
## $ibm
## [1] 159.82 160.02 159.84 160.35 164.79
## 
## $correlation
##           apple       ibm
## apple 1.0000000 0.9131575
## ibm   0.9131575 1.0000000
5.6 Split it
Split a dataframe by group using split(). And get your original data frame back by using unsplit().

# Define cash
cash$present_value <- NULL

# Define grouping from year
grouping <- cash$year

# Split cash on your new grouping
split_cash <- split(cash, grouping)

# Look at your split_cash list
split_cash
## $`1`
##   company cash_flow year
## 1       A      1000    1
## 4       B      1500    1
## 
## $`2`
##   company cash_flow year
## 5       B      1100    2
## 
## $`3`
##   company cash_flow year
## 2       A      4000    3
## 
## $`4`
##   company cash_flow year
## 3       A       550    4
## 6       B       750    4
## 
## $`5`
##   company cash_flow year
## 7       B      6000    5
str(split_cash)
## List of 5
##  $ 1:'data.frame':   2 obs. of  3 variables:
##   ..$ company  : Factor w/ 2 levels "A","B": 1 2
##   ..$ cash_flow: num [1:2] 1000 1500
##   ..$ year     : num [1:2] 1 1
##  $ 2:'data.frame':   1 obs. of  3 variables:
##   ..$ company  : Factor w/ 2 levels "A","B": 2
##   ..$ cash_flow: num 1100
##   ..$ year     : num 2
##  $ 3:'data.frame':   1 obs. of  3 variables:
##   ..$ company  : Factor w/ 2 levels "A","B": 1
##   ..$ cash_flow: num 4000
##   ..$ year     : num 3
##  $ 4:'data.frame':   2 obs. of  3 variables:
##   ..$ company  : Factor w/ 2 levels "A","B": 1 2
##   ..$ cash_flow: num [1:2] 550 750
##   ..$ year     : num [1:2] 4 4
##  $ 5:'data.frame':   1 obs. of  3 variables:
##   ..$ company  : Factor w/ 2 levels "A","B": 2
##   ..$ cash_flow: num 6000
##   ..$ year     : num 5

# Unsplit split_cash to get the original data back.
original_cash <- unsplit(split_cash, grouping)

# Print original_cash
cash
##   company cash_flow year
## 1       A      1000    1
## 2       A      4000    3
## 3       A       550    4
## 4       B      1500    1
## 5       B      1100    2
## 6       B       750    4
## 7       B      6000    5
5.7 Split-Apply-Combine
A common data science problem is to split your data frame by a grouping, apply some transformation to each group, and then recombine those pieces back into one data frame. This is such a common class of problems in R that it has been given the name split-apply-combine.

# Define split_cash and grouping
split_cash <- split(cash, company)
grouping <- company

# Print split_cash
split_cash
## $A
##   company cash_flow year
## 1       A      1000    1
## 2       A      4000    3
## 3       A       550    4
## 
## $B
##   company cash_flow year
## 4       B      1500    1
## 5       B      1100    2
## 6       B       750    4
## 7       B      6000    5

# Print the cash_flow column of B in split_cash
split_cash$B$cash_flow
## [1] 1500 1100  750 6000

# Set the cash_flow column of company A in split_cash to 0
split_cash$A$cash_flow <- 0

# Use the grouping to unsplit split_cash
cash_no_A <- unsplit(split_cash, grouping)

# Print cash_no_A
cash_no_A
##   company cash_flow year
## 1       A         0    1
## 2       A         0    3
## 3       A         0    4
## 4       B      1500    1
## 5       B      1100    2
## 6       B       750    4
## 7       B      6000    5
5.8 Attributes
Return a list of attributes about the object you pass in by using attributes(). Access a specific attribute by using  attr().

# my_matrix and my_factor
my_matrix <- matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3)
rownames(my_matrix) <- c("Row1", "Row2")
colnames(my_matrix) <- c("Col1", "Col2", "Col3")

my_factor <- factor(c("A", "A", "B"), ordered = T, levels = c("A", "B"))

# attributes of my_matrix
attributes(my_matrix)
## $dim
## [1] 2 3
## 
## $dimnames
## $dimnames[[1]]
## [1] "Row1" "Row2"
## 
## $dimnames[[2]]
## [1] "Col1" "Col2" "Col3"

# Just the dim attribute of my_matrix
attr(my_matrix, which = "dim")
## [1] 2 3

# attributes of my_factor
attributes(my_factor)
## $levels
## [1] "A" "B"
## 
## $class
## [1] "ordered" "factor"