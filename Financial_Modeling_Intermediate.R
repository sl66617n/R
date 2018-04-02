Financial Modeling, Summer 2017
Daniel Lee
Intermediate R for Finance
Chapter 1: Dates
1.1 What day is it?
1.2 From char to date
1.3 Many dates
1.4 Date formats (1)
1.5 Date formats (2)
1.6 Subtraction of dates
1.7 months() and weekdays() and quarters(), oh my!
Chapter 2: If Statements and Operators
2.1 Relational practice
2.2 Vectorized operations
2.3 And / Or
2.4 Not!
2.5 Logicals and subset()
2.6 All together now!
2.7 If this
2.8 If this, Else that
2.9 If this, Else If that, Else that other thing
2.10 Can you If inside an If?
2.11 ifelse()
Chapter 3: Loops
3.1 Repeat, repeat, repeat
3.2 When to break?
3.3 While with a print
3.4 While with a plot
3.5 Break it
3.6 Loop over a vector
3.7 Loop over data frame rows
3.8 Loop over matrix elements
3.9 Break and next
Chapter 4: Functions
4.1 Function help and documentation
4.2 Optional arguments
4.3 Functions in functions
4.4 Your first function
4.5 Multiple arguments (1)
4.6 Multiple arguments (2)
4.7 Function scope (1)
4.8 Function scope (2)
4.9 tidyquant package
Chapater 5: Apply
5.1 lapply() on a list
5.2 lapply() on a data frame
5.3 FUN arguments
5.4 sapply() VS lapply()
5.5 Failing to simplify
5.6 vapply() VS sapply()
5.7 More vapply()
5.8 Anonymous functions
Disclaimer: The content of this RMarkdown note came from a course called Intermediate R for Finance in datacamp.

Intermediate R for Finance
In this course, you will learn:

the basics about how dates work in R,
to explore the world of if statements, loops, and functions,
the family of apply functions as a vectorized alternative to loops.
Chapter 1: Dates
1.1 What day is it?
Date is used for calendar date objects like "2015-01-22".
POSIXct is a way to represent datetime objects like "2015-01-22 08:39:40 EST".
# What is the current date?
Sys.Date()
## [1] "2017-06-19"

# What is the current date and time?
Sys.time()
## [1] "2017-06-19 21:55:18 UTC"

# Create the variable today
today <- Sys.Date() 


# Confirm the class of today
class(today)
## [1] "Date"
1.2 From char to date
Create dates from character strings by using as.Date(). The date is given in the format of "yyyy-mm-dd".

# Create crash
crash <- as.Date("2008-09-29")

# Print crash
crash
## [1] "2008-09-29"

# crash as a numeric
as.numeric(crash)  # to see the current day in number of days since January 1, 1970.
## [1] 14151

# Current time as a numeric
as.numeric(Sys.time())  # to see the current time in number of seconds since January 1, 1970.
## [1] 1497909318

# Incorrect date format
#as.Date("09/29/2008")  # Gives "Error: character string is not in a standard unambiguous format"
1.3 Many dates
# Create dates from "2017-02-05" to "2017-02-08" inclusive.
dates <- c("2017-02-05", "2017-02-06", "2017-02-07", "2017-02-08")

# Add names to dates
names(dates) <- c("Sunday", "Monday", "Tuesday", "Wednesday")

# Subset dates to only return the date for Monday
dates["Monday"]
##       Monday 
## "2017-02-06"
1.4 Date formats (1)
Explicitly specify the format you are using through the format argument:  as.Date("09/28/2008", format = "%m / %d / %Y")

There are a number of different formats you can specify, here are a few of them:

%Y: 4-digit year (1982)
%y: 2-digit year (82)
%m: 2-digit month (01)
%d: 2-digit day of the month (13)
%A: weekday (Wednesday)
%a: abbreviated weekday (Wed)
%B: month (January)
%b: abbreviated month (Jan)
# "08,30,30"
as.Date("08,30,1930", format = "%m,%d,%Y")
## [1] "1930-08-30"

# "Aug 30,1930"
as.Date("Aug 30,1930", format = "%b %d,%Y")
## [1] "1930-08-30"

# "30aug1930"
as.Date("30aug1930", format = "%d%b%Y")
## [1] "1930-08-30"
1.5 Date formats (2)
You can convert objects that are already dates to differently formatted dates using format():

# char_dates
char_dates <- c("1jan17", "2jan17", "3jan17", "4jan17", "5jan17")

# Create dates using as.Date() and the correct format 
dates <- as.Date(char_dates, format = "%d%b%y")

# Use format() to go from "2017-01-04" -> "Jan 04, 17"
format(dates, format = "%b %d, %y")
## [1] "Jan 01, 17" "Jan 02, 17" "Jan 03, 17" "Jan 04, 17" "Jan 05, 17"

# Use format() to go from "2017-01-04" -> "01,04,2017"
format(dates, format = "%m,%d,%Y")
## [1] "01,01,2017" "01,02,2017" "01,03,2017" "01,04,2017" "01,05,2017"
1.6 Subtraction of dates
Just like with numerics, arithmetic can be done on dates. You can also find the time interval by using the  difftime() function.

# Dates
dates <- as.Date(c("2017-01-01", "2017-01-02", "2017-01-03"))

# Create the origin
origin <- as.Date("1970-01-01")

# Use as.numeric() on dates
as.numeric(dates)
## [1] 17167 17168 17169

# Find the difference between dates and origin
difftime(dates, origin)
## Time differences in days
## [1] 17167 17168 17169
1.7 months() and weekdays() and quarters(), oh my!
There are functions that are useful for extracting date components: weekdays(), months(), and quarters().

# dates
dates <- as.Date(c("2017-01-02", "2017-05-03", "2017-08-04", "2017-10-17"))

# Extract the months
months(dates)
## [1] "January" "May"     "August"  "October"

# Extract the quarters
quarters(dates)
## [1] "Q1" "Q2" "Q3" "Q4"

# dates2
dates2 <- as.Date(c("2017-01-02", "2017-01-03", "2017-01-04", "2017-01-05"))

# Assign the weekdays() of dates2 as the names()
names(dates2) <- weekdays(dates2)

# Print dates2
dates2
##       Monday      Tuesday    Wednesday     Thursday 
## "2017-01-02" "2017-01-03" "2017-01-04" "2017-01-05"
Chapter 2: If Statements and Operators
Imagine you own stock in a company. If the stock goes above a certain price, you might want to sell. If the stock drops below a certain price, you might want to buy it while it’s cheap! This kind of thinking can be implemented using operators and if statements. In this chapter, you will learn all about them, and create a program that tells you to buy or sell a stock.

2.1 Relational practice
# Stock prices
apple <- 48.99
micr <- 77.93

# Apple vs Microsoft
apple > micr
## [1] FALSE

# Not equals
apple != micr
## [1] TRUE

# Dates - today and tomorrow
today <- as.Date(Sys.Date())
tomorrow <- as.Date(Sys.Date() + 1)

# Today vs Tomorrow
tomorrow < today
## [1] FALSE
2.2 Vectorized operations
Compare two vectors using > to get a logical vector back of the same length. Comparing a vector and a single number works as well.

# Define stocks
date <- as.Date(c("2017-01-20", "2017-01-23", "2017-01-24", "2017-01-25"))
ibm <- c(170.55, 171.03, 175.90, 178.29)
panera <- c(216.65, 216.06, 213.55, 212.22)
stocks <- data.frame(date = date, ibm = ibm, panera = panera)
stocks
##         date    ibm panera
## 1 2017-01-20 170.55 216.65
## 2 2017-01-23 171.03 216.06
## 3 2017-01-24 175.90 213.55
## 4 2017-01-25 178.29 212.22

# Print stocks
stocks
##         date    ibm panera
## 1 2017-01-20 170.55 216.65
## 2 2017-01-23 171.03 216.06
## 3 2017-01-24 175.90 213.55
## 4 2017-01-25 178.29 212.22

# IBM range
stocks$ibm_buy <- stocks$ibm < 175

# Panera range
stocks$panera_sell <- stocks$panera > 213

# IBM vs Panera
stocks$ibm_vs_panera <- stocks$ibm > stocks$panera

# Print stocks
stocks
##         date    ibm panera ibm_buy panera_sell ibm_vs_panera
## 1 2017-01-20 170.55 216.65    TRUE        TRUE         FALSE
## 2 2017-01-23 171.03 216.06    TRUE        TRUE         FALSE
## 3 2017-01-24 175.90 213.55   FALSE        TRUE         FALSE
## 4 2017-01-25 178.29 212.22   FALSE       FALSE         FALSE
2.3 And / Or
logical operators:

& and
| or
! not
# Restore stocks
stocks[, 4:6] <- NULL

# IBM buy range
stocks$ibm_buy_range <- stocks$ibm > 171 & stocks$ibm < 176

# Panera spikes
stocks$panera_spike <- stocks$panera < 213.20 | stocks$panera > 216.50

# Date range
stocks$good_dates <- stocks$date > as.Date("2017-01-21") & stocks$date < as.Date("2017-01-25")

# Print stocks
stocks
##         date    ibm panera ibm_buy_range panera_spike good_dates
## 1 2017-01-20 170.55 216.65         FALSE         TRUE      FALSE
## 2 2017-01-23 171.03 216.06          TRUE        FALSE       TRUE
## 3 2017-01-24 175.90 213.55          TRUE        FALSE       TRUE
## 4 2017-01-25 178.29 212.22         FALSE         TRUE      FALSE
2.4 Not!
# IBM range
!(stocks$ibm > 176)
## [1]  TRUE  TRUE  TRUE FALSE

# Missing data
missing <- c(24.5, 25.7, NA, 28, 28.6, NA)

# Is missing?
is.na(missing)
## [1] FALSE FALSE  TRUE FALSE FALSE  TRUE

# Not missing?
!is.na(missing)
## [1]  TRUE  TRUE FALSE  TRUE  TRUE FALSE
2.5 Logicals and subset()
# Restore stocks
stocks[, 4:6] <- NULL

# Panera range
subset(stocks, panera > 216)
##         date    ibm panera
## 1 2017-01-20 170.55 216.65
## 2 2017-01-23 171.03 216.06

# Specific date
subset(stocks, date == as.Date("2017-01-23"))
##         date    ibm panera
## 2 2017-01-23 171.03 216.06

# IBM and Panera joint range
subset(stocks, ibm < 175 & panera < 216.50)
##         date    ibm panera
## 2 2017-01-23 171.03 216.06
2.6 All together now!
# Define stocks
date <- seq(from = as.Date("2016-12-01"), to = as.Date("2016-12-30"), by = "days")
date <- date[-26]
apple <- c(109.49, 109.90, NA, NA, 109.11, 109.95, 111.03, 112.12, 113.95, NA, NA, 113.30,
           115.19, 115.19, 115.82, 115.97, NA, NA, 116.64, 116.95, 117.06, 116.29, 116.52,
           NA, NA, 117.26, 116.76, 116.73, 115.82)
micr <- c(59.20, 59.25, NA, NA, 60.22, 59.95, 61.37, 61.01, 61.97, NA,  NA, 62.17, 62.98,
          62.68, 62.58, 62.30, NA, NA, 63.62, 63.54, 63.54, 63.55, 63.24, NA, NA, 63.28,
          62.99, 62.90, 62.14)
stocks <- data.frame(date = date, apple = apple, micr = micr) 

# View stocks
stocks
##          date  apple  micr
## 1  2016-12-01 109.49 59.20
## 2  2016-12-02 109.90 59.25
## 3  2016-12-03     NA    NA
## 4  2016-12-04     NA    NA
## 5  2016-12-05 109.11 60.22
## 6  2016-12-06 109.95 59.95
## 7  2016-12-07 111.03 61.37
## 8  2016-12-08 112.12 61.01
## 9  2016-12-09 113.95 61.97
## 10 2016-12-10     NA    NA
## 11 2016-12-11     NA    NA
## 12 2016-12-12 113.30 62.17
## 13 2016-12-13 115.19 62.98
## 14 2016-12-14 115.19 62.68
## 15 2016-12-15 115.82 62.58
## 16 2016-12-16 115.97 62.30
## 17 2016-12-17     NA    NA
## 18 2016-12-18     NA    NA
## 19 2016-12-19 116.64 63.62
## 20 2016-12-20 116.95 63.54
## 21 2016-12-21 117.06 63.54
## 22 2016-12-22 116.29 63.55
## 23 2016-12-23 116.52 63.24
## 24 2016-12-24     NA    NA
## 25 2016-12-25     NA    NA
## 26 2016-12-27 117.26 63.28
## 27 2016-12-28 116.76 62.99
## 28 2016-12-29 116.73 62.90
## 29 2016-12-30 115.82 62.14

# Weekday investigation
stocks$weekday <- weekdays(stocks$date)

# View stocks again
stocks
##          date  apple  micr   weekday
## 1  2016-12-01 109.49 59.20  Thursday
## 2  2016-12-02 109.90 59.25    Friday
## 3  2016-12-03     NA    NA  Saturday
## 4  2016-12-04     NA    NA    Sunday
## 5  2016-12-05 109.11 60.22    Monday
## 6  2016-12-06 109.95 59.95   Tuesday
## 7  2016-12-07 111.03 61.37 Wednesday
## 8  2016-12-08 112.12 61.01  Thursday
## 9  2016-12-09 113.95 61.97    Friday
## 10 2016-12-10     NA    NA  Saturday
## 11 2016-12-11     NA    NA    Sunday
## 12 2016-12-12 113.30 62.17    Monday
## 13 2016-12-13 115.19 62.98   Tuesday
## 14 2016-12-14 115.19 62.68 Wednesday
## 15 2016-12-15 115.82 62.58  Thursday
## 16 2016-12-16 115.97 62.30    Friday
## 17 2016-12-17     NA    NA  Saturday
## 18 2016-12-18     NA    NA    Sunday
## 19 2016-12-19 116.64 63.62    Monday
## 20 2016-12-20 116.95 63.54   Tuesday
## 21 2016-12-21 117.06 63.54 Wednesday
## 22 2016-12-22 116.29 63.55  Thursday
## 23 2016-12-23 116.52 63.24    Friday
## 24 2016-12-24     NA    NA  Saturday
## 25 2016-12-25     NA    NA    Sunday
## 26 2016-12-27 117.26 63.28   Tuesday
## 27 2016-12-28 116.76 62.99 Wednesday
## 28 2016-12-29 116.73 62.90  Thursday
## 29 2016-12-30 115.82 62.14    Friday

# Remove missing data
stocks_no_NA <- subset(stocks, !is.na(apple))

# Apple and Microsoft joint range
subset(stocks_no_NA, apple > 117 | micr > 63)
##          date  apple  micr   weekday
## 19 2016-12-19 116.64 63.62    Monday
## 20 2016-12-20 116.95 63.54   Tuesday
## 21 2016-12-21 117.06 63.54 Wednesday
## 22 2016-12-22 116.29 63.55  Thursday
## 23 2016-12-23 116.52 63.24    Friday
## 26 2016-12-27 117.26 63.28   Tuesday
2.7 If this
# micr
micr <- 48.55

# Fill in the blanks
if( micr < 55 ) {
    print("Buy!")
}
## [1] "Buy!"
2.8 If this, Else that
# micr
micr <- 57.44

# Fill in the blanks
if( micr < 55 ) {
    print("Buy!")
} else {
    print("Do nothing!")
}
## [1] "Do nothing!"
2.9 If this, Else If that, Else that other thing
# micr
micr <- 105.67

# Fill in the blanks
if( micr < 55 ) {
    print("Buy!")
} else if( micr >= 55 & micr < 75 ){
    print("Do nothing!")
} else { 
    print("Sell!")
}
## [1] "Sell!"
2.10 Can you If inside an If?
# micr
micr <- 105.67
shares <- 1

# Fill in the blanks
if( micr < 55 ) {
    print("Buy!")
} else if( micr >= 55 & micr < 75 ) {
    print("Do nothing!")
} else { 
    if( shares >= 1 ) {
        print("Sell!")
    } else {
        print("Not enough shares to sell!")
    }
}
## [1] "Sell!"
2.11 ifelse()
Create an if statement that works for an entire vector by using ifelse().

# Define stocks
date <- seq(from = as.Date("2016-12-01"), to = as.Date("2016-12-30"), by = "days")
date <- date[-c(3,4,10,11,17,18,24,25,26)]
apple <- c(109.49, 109.90, 109.11, 109.95, 111.03, 112.12, 113.95, 113.30,
           115.19, 115.19, 115.82, 115.97, 116.64, 116.95, 117.06, 116.29, 116.52,
           117.26, 116.76, 116.73, 115.82)
micr <- c(59.20, 59.25, 60.22, 59.95, 61.37, 61.01, 61.97, 62.17, 62.98,
          62.68, 62.58, 62.30, 63.62, 63.54, 63.54, 63.55, 63.24, 63.28,
          62.99, 62.90, 62.14)
stocks <- data.frame(date = date, apple = apple, micr = micr) 

# Microsoft test
stocks$micr_buy <- ifelse(test = stocks$micr > 60 & stocks$micr < 62, yes = 1, no = 0)

# Apple test
stocks$apple_date <- ifelse(test = stocks$apple > 117, yes = stocks$date, no = NA)

# Print stocks
stocks
##          date  apple  micr micr_buy apple_date
## 1  2016-12-01 109.49 59.20        0         NA
## 2  2016-12-02 109.90 59.25        0         NA
## 3  2016-12-05 109.11 60.22        1         NA
## 4  2016-12-06 109.95 59.95        0         NA
## 5  2016-12-07 111.03 61.37        1         NA
## 6  2016-12-08 112.12 61.01        1         NA
## 7  2016-12-09 113.95 61.97        1         NA
## 8  2016-12-12 113.30 62.17        0         NA
## 9  2016-12-13 115.19 62.98        0         NA
## 10 2016-12-14 115.19 62.68        0         NA
## 11 2016-12-15 115.82 62.58        0         NA
## 12 2016-12-16 115.97 62.30        0         NA
## 13 2016-12-19 116.64 63.62        0         NA
## 14 2016-12-20 116.95 63.54        0         NA
## 15 2016-12-21 117.06 63.54        0      17156
## 16 2016-12-22 116.29 63.55        0         NA
## 17 2016-12-23 116.52 63.24        0         NA
## 18 2016-12-27 117.26 63.28        0      17162
## 19 2016-12-28 116.76 62.99        0         NA
## 20 2016-12-29 116.73 62.90        0         NA
## 21 2016-12-30 115.82 62.14        0         NA

# Change the class() of apple_date.
class(stocks$apple_date) <- "Date"

# Print stocks again
stocks
##          date  apple  micr micr_buy apple_date
## 1  2016-12-01 109.49 59.20        0       <NA>
## 2  2016-12-02 109.90 59.25        0       <NA>
## 3  2016-12-05 109.11 60.22        1       <NA>
## 4  2016-12-06 109.95 59.95        0       <NA>
## 5  2016-12-07 111.03 61.37        1       <NA>
## 6  2016-12-08 112.12 61.01        1       <NA>
## 7  2016-12-09 113.95 61.97        1       <NA>
## 8  2016-12-12 113.30 62.17        0       <NA>
## 9  2016-12-13 115.19 62.98        0       <NA>
## 10 2016-12-14 115.19 62.68        0       <NA>
## 11 2016-12-15 115.82 62.58        0       <NA>
## 12 2016-12-16 115.97 62.30        0       <NA>
## 13 2016-12-19 116.64 63.62        0       <NA>
## 14 2016-12-20 116.95 63.54        0       <NA>
## 15 2016-12-21 117.06 63.54        0 2016-12-21
## 16 2016-12-22 116.29 63.55        0       <NA>
## 17 2016-12-23 116.52 63.24        0       <NA>
## 18 2016-12-27 117.26 63.28        0 2016-12-27
## 19 2016-12-28 116.76 62.99        0       <NA>
## 20 2016-12-29 116.73 62.90        0       <NA>
## 21 2016-12-30 115.82 62.14        0       <NA>
Chapter 3: Loops
Loops can be useful for doing the same operation to each element of your data structure. In this chapter you will learn all about repeat, while, and for loops!

3.1 Repeat, repeat, repeat
# Stock price
stock_price <- 126.34

repeat {
  # New stock price
  stock_price <- stock_price * runif(1, .985, 1.01)
  print(stock_price)
  
  # Check
  if(stock_price < 125) {
    print("Stock price is below 124.5! Buy it while it's cheap!")
    break
  }
}
## [1] 126.2027
## [1] 124.3106
## [1] "Stock price is below 124.5! Buy it while it's cheap!"
3.2 When to break?
# Stock price
stock_price <- 67.55

repeat {
  # New stock price
  stock_price <- stock_price * .995
  print(stock_price)
  
  # Check
  if(stock_price < 66) {
    print("Stock price is below 66! Buy it while it's cheap!")
    break
  }
  
}
## [1] 67.21225
## [1] 66.87619
## [1] 66.54181
## [1] 66.2091
## [1] 65.87805
## [1] "Stock price is below 66! Buy it while it's cheap!"
3.3 While with a print
While loops versus Repeat loops

They both do the same thing.
The while loop does it with less code.
The repeat loop may be used when you want run the loop forever.
The while loop is great when you don’t know the exact number of iterations you need to perform. Instead, it breaks when the condition is met.
# Initial debt
debt <- 5000

# While loop to pay off your debt
while (debt > 0) {
  debt <- debt - 500
  print(paste("Debt remaining", debt))
}
## [1] "Debt remaining 4500"
## [1] "Debt remaining 4000"
## [1] "Debt remaining 3500"
## [1] "Debt remaining 3000"
## [1] "Debt remaining 2500"
## [1] "Debt remaining 2000"
## [1] "Debt remaining 1500"
## [1] "Debt remaining 1000"
## [1] "Debt remaining 500"
## [1] "Debt remaining 0"
3.4 While with a plot
debt <- 5000    # initial debt
i <- 0          # x axis counter
x_axis <- i     # x axis
y_axis <- debt  # y axis

# Initial plot
plot(x_axis, y_axis, xlim = c(0,10), ylim = c(0,5000))



# Graph your debt
while (debt > 0) {

  # Updating variables
  debt <- debt - 500
  i <- i + 1
  x_axis <- c(x_axis, i)
  print(x_axis)
  y_axis <- c(y_axis, debt)
  print(y_axis) 
  
  # Next plot
  plot(x_axis, y_axis, xlim = c(0,10), ylim = c(0,5000))
}
## [1] 0 1
## [1] 5000 4500


## [1] 0 1 2
## [1] 5000 4500 4000


## [1] 0 1 2 3
## [1] 5000 4500 4000 3500


## [1] 0 1 2 3 4
## [1] 5000 4500 4000 3500 3000


## [1] 0 1 2 3 4 5
## [1] 5000 4500 4000 3500 3000 2500


## [1] 0 1 2 3 4 5 6
## [1] 5000 4500 4000 3500 3000 2500 2000


## [1] 0 1 2 3 4 5 6 7
## [1] 5000 4500 4000 3500 3000 2500 2000 1500


## [1] 0 1 2 3 4 5 6 7 8
## [1] 5000 4500 4000 3500 3000 2500 2000 1500 1000


##  [1] 0 1 2 3 4 5 6 7 8 9
##  [1] 5000 4500 4000 3500 3000 2500 2000 1500 1000  500


##  [1]  0  1  2  3  4  5  6  7  8  9 10
##  [1] 5000 4500 4000 3500 3000 2500 2000 1500 1000  500    0


3.5 Break it
Sometimes, you have to end your while loop early. With the debt example, if you don’t have enough cash to pay off all of your debt, you won’t be able to continuing paying it down.

# debt and cash
debt <- 5000
cash <- 4000

# Pay off your debt...if you can!
while (debt > 0) {
  debt <- debt - 500
  cash <- cash - 500
  print(paste("Debt remaining:", debt, "and Cash remaining:", cash))

  if (cash == 0) {
   print("You ran out of cash!")
   break
  }
}
## [1] "Debt remaining: 4500 and Cash remaining: 3500"
## [1] "Debt remaining: 4000 and Cash remaining: 3000"
## [1] "Debt remaining: 3500 and Cash remaining: 2500"
## [1] "Debt remaining: 3000 and Cash remaining: 2000"
## [1] "Debt remaining: 2500 and Cash remaining: 1500"
## [1] "Debt remaining: 2000 and Cash remaining: 1000"
## [1] "Debt remaining: 1500 and Cash remaining: 500"
## [1] "Debt remaining: 1000 and Cash remaining: 0"
## [1] "You ran out of cash!"
3.6 Loop over a vector
When you know how many times you want to repeat an action, a for loop is a good option. The idea of the for loop is that you are stepping through a sequence, one at a time, and performing an action at each step along the way. That sequence is commonly a vector of numbers (such as the sequence from 1:10), but could also be numbers that are not in any order like c(2, 5, 4, 6), or even a sequence of characters! for (value in sequence) {     code } In words this is saying, “for each value in my sequence, run this code.”

# Sequence
seq <- c(1:10)

# Print loop
for (value in seq) {
    print(value)
}
## [1] 1
## [1] 2
## [1] 3
## [1] 4
## [1] 5
## [1] 6
## [1] 7
## [1] 8
## [1] 9
## [1] 10

# A sum variable
sum <- 0

# Sum loop
for (value in seq) {
    sum <- sum + value
    print(sum)
}
## [1] 1
## [1] 3
## [1] 6
## [1] 10
## [1] 15
## [1] 21
## [1] 28
## [1] 36
## [1] 45
## [1] 55
3.7 Loop over data frame rows
Imagine that you are interested in the days where the stock price of Apple rises above 117. If it goes above this value, you want to print out the current date and stock price.

# Define stock
date <- seq(from = as.Date("2016-12-01"), to = as.Date("2016-12-30"), by = "days")
date <- date[-c(3,4,10,11,17,18,24,25,26)]
apple <- c(109.49, 109.90, 109.11, 109.95, 111.03, 112.12, 113.95, 113.30,
           115.19, 115.19, 115.82, 115.97, 116.64, 116.95, 117.06, 116.29, 116.52,
           117.26, 116.76, 116.73, 115.82)
stock <- data.frame(date = date, apple = apple)

# Loop over stock rows
for (row in 1:nrow(stock)) {
    price <- stock[row, "apple"]
    date  <- stock[row, "date"]

    if(price > 116) {
        print(paste("On", date, 
                    "the stock price was", price))
    } else {
        print(paste("The date:", date, 
                    "is not an important day!"))
    }
}
## [1] "The date: 2016-12-01 is not an important day!"
## [1] "The date: 2016-12-02 is not an important day!"
## [1] "The date: 2016-12-05 is not an important day!"
## [1] "The date: 2016-12-06 is not an important day!"
## [1] "The date: 2016-12-07 is not an important day!"
## [1] "The date: 2016-12-08 is not an important day!"
## [1] "The date: 2016-12-09 is not an important day!"
## [1] "The date: 2016-12-12 is not an important day!"
## [1] "The date: 2016-12-13 is not an important day!"
## [1] "The date: 2016-12-14 is not an important day!"
## [1] "The date: 2016-12-15 is not an important day!"
## [1] "The date: 2016-12-16 is not an important day!"
## [1] "On 2016-12-19 the stock price was 116.64"
## [1] "On 2016-12-20 the stock price was 116.95"
## [1] "On 2016-12-21 the stock price was 117.06"
## [1] "On 2016-12-22 the stock price was 116.29"
## [1] "On 2016-12-23 the stock price was 116.52"
## [1] "On 2016-12-27 the stock price was 117.26"
## [1] "On 2016-12-28 the stock price was 116.76"
## [1] "On 2016-12-29 the stock price was 116.73"
## [1] "The date: 2016-12-30 is not an important day!"
3.8 Loop over matrix elements
If you want to loop over elements in a matrix (columns and rows), then you will have to use nested loops.

# Define corr
corr <- matrix(c(1.00, 0.96, 0.88, 0.96, 1.00, 0.74, 0.88, 0.74, 1.00), 3, 3)
row.names(corr) <- c("apple", "ibm", "micr")
colnames(corr) <- c("apple", "ibm", "micr")

# Print out corr
corr
##       apple  ibm micr
## apple  1.00 0.96 0.88
## ibm    0.96 1.00 0.74
## micr   0.88 0.74 1.00

# Create a nested loop
for(row in 1:nrow(corr)) {
    for(col in 1:ncol(corr)) {
        print(paste(colnames(corr)[col], "and", rownames(corr)[row], 
                    "have a correlation of", corr[row,col]))
    }
}
## [1] "apple and apple have a correlation of 1"
## [1] "ibm and apple have a correlation of 0.96"
## [1] "micr and apple have a correlation of 0.88"
## [1] "apple and ibm have a correlation of 0.96"
## [1] "ibm and ibm have a correlation of 1"
## [1] "micr and ibm have a correlation of 0.74"
## [1] "apple and micr have a correlation of 0.88"
## [1] "ibm and micr have a correlation of 0.74"
## [1] "micr and micr have a correlation of 1"
3.9 Break and next
break: to break out of a loop completely
next: to skip the current iteration, and continue the loop
# Define apple
apple <- c(109.49, 109.90, NA, NA, 109.11, 109.95, 111.03, 112.12, 113.95, NA, NA,
           113.30, 115.19, 115.19, 115.82, 115.97, NA, NA, 116.64, 116.95, 117.06,
           116.29, 116.52, NA, NA, 117.26, 116.76, 116.73, 115.82)

# Print apple
apple
##  [1] 109.49 109.90     NA     NA 109.11 109.95 111.03 112.12 113.95     NA
## [11]     NA 113.30 115.19 115.19 115.82 115.97     NA     NA 116.64 116.95
## [21] 117.06 116.29 116.52     NA     NA 117.26 116.76 116.73 115.82

# Loop through apple. Next if NA. Break if above 117.
for (value in apple) {
    if(is.na(value)) {
        print("Skipping NA")
        next
    }
    
    if(value > 117) {
        print("Time to sell!")
        break
    } else {
        print("Nothing to do here!")
    }
}
## [1] "Nothing to do here!"
## [1] "Nothing to do here!"
## [1] "Skipping NA"
## [1] "Skipping NA"
## [1] "Nothing to do here!"
## [1] "Nothing to do here!"
## [1] "Nothing to do here!"
## [1] "Nothing to do here!"
## [1] "Nothing to do here!"
## [1] "Skipping NA"
## [1] "Skipping NA"
## [1] "Nothing to do here!"
## [1] "Nothing to do here!"
## [1] "Nothing to do here!"
## [1] "Nothing to do here!"
## [1] "Nothing to do here!"
## [1] "Skipping NA"
## [1] "Skipping NA"
## [1] "Nothing to do here!"
## [1] "Nothing to do here!"
## [1] "Time to sell!"
Chapter 4: Functions
If data structures like data frames and vectors are how you hold your data, functions are how you tell R what to do with your data. In this chapter, you will learn about using built-in functions, creating your own unique functions, and you will finish off with a brief introduction to packages.

4.1 Function help and documentation
To get help for the names() function, type:

?names
?names()
help(names)
# subset help
?subset

# Sys.time help
?Sys.time
4.2 Optional arguments
# Round 5.4
round(5.4)
## [1] 5

# Round 5.4 with 1 decimal place
round(5.4, digits = 1)
## [1] 5.4

# numbers
numbers <- c(.002623, pi, 812.33345)

# Round numbers to 3 decimal places
round(numbers, digits = 3)
## [1]   0.003   3.142 812.333
4.3 Functions in functions
To write clean code, sometimes it is useful to use functions inside of other functions. This let’s you use the result of one function directly in another one, without having to create an intermediate variable.

# Define apple, ibm, micr
apple <- c(109.49, 109.90, 109.11, 109.95, 111.03, 112.12, 113.95, 113.30, 115.19,
           115.19, 115.82, 115.97, 116.64, 116.95, 117.06, 116.29, 116.52, 117.26,
           116.76, 116.73, 115.82)
ibm <- c(159.82, 160.02, 159.84, 160.35, 164.79, 165.36, 166.52, 165.50, 168.29, 168.51,
         168.02, 166.73, 166.68, 167.60, 167.33, 167.06, 166.71, 167.14, 166.19, 166.60,
         165.99)
micr <- c(59.20, 59.25, 60.22, 59.95, 61.37, 61.01, 61.97, 62.17, 62.98, 62.68, 62.58,
          62.30, 63.62, 63.54, 63.54, 63.55, 63.24, 63.28, 62.99, 62.90, 62.14)

# cbind() the stocks
stocks <- cbind(apple, ibm, micr)

# cor() to create the correlation matrix
cor(stocks)
##           apple       ibm      micr
## apple 1.0000000 0.8872467 0.9477010
## ibm   0.8872467 1.0000000 0.9126597
## micr  0.9477010 0.9126597 1.0000000

# All at once! Nest cbind() inside of cor()
cor(cbind(apple, ibm, micr))
##           apple       ibm      micr
## apple 1.0000000 0.8872467 0.9477010
## ibm   0.8872467 1.0000000 0.9126597
## micr  0.9477010 0.9126597 1.0000000
4.4 Your first function
# Percent to decimal function
percent_to_decimal <- function(percent) {
  percent / 100
}

# Use percent_to_decimal() on 6
percent_to_decimal(6)
## [1] 0.06

# Example percentage
pct <- 8

# Use percent_to_decimal() on pct
percent_to_decimal(pct)
## [1] 0.08
4.5 Multiple arguments (1)
There are two types of arguments:

mandatory: without which function doesn’t perform
optional: comes with a defaulty value but can be changed
# Percent to decimal function
percent_to_decimal <- function(percent, digits = 2) {
    decimal <- percent / 100
    
    round(decimal, digits)
}

# percents
percents <- c(25.88, 9.045, 6.23)

# percent_to_decimal() with default digits
percent_to_decimal(percents)
## [1] 0.26 0.09 0.06

# percent_to_decimal() with digits = 4
percent_to_decimal(percents, digits = 4)
## [1] 0.2588 0.0904 0.0623
4.6 Multiple arguments (2)
# Present value function
pv <- function(cash_flow, i, year) {
    
    # Discount multiplier
    mult <- 1 + 0.01*(i)
    
    # Present value calculation
    cash_flow * mult ^ -year
}

# Calculate a present value
pv(1200, 7, 3)
## [1] 979.5575
4.7 Function scope (1)
Scoping is the process of how R looks a variable’s value when given a name. For example, given x <- 5, scoping is how R knows where to look to find that the value of x is 5.

percent_to_decimal <- function(percent) {
    decimal <- percent / 100
    decimal
}

percent_to_decimal(6)
## [1] 0.06

#decimal #This will return an error.
Interpretation

decimal was defined to live only inside the percent_to_decimal() function. If you try to access decimal outside of the scope of that function, you will get an error because it does not exist!
4.8 Function scope (2)
hundred is defined outside of the function scope, but is used inside of the function.

hundred <- 100

percent_to_decimal <- function(percent) {
    percent / hundred
}

percent_to_decimal(6)
## [1] 0.06
Interpretation

hundred was defined outside of the percent_to_decimal() function. When the percent_to_decimal function came across hundred, it first looked inside the scope of the function for hundred, and when it couldn’t find it, it looked up one level to find where it was defined in the global scope.
4.9 tidyquant package
# Library tidquant
library(tidyquant)

# Pull Apple stock data
apple <- tq_get("AAPL", get = "stock.prices", 
                from = "2007-01-03", to = "2017-06-05")

# Take a look at what it returned
head(apple)
## # A tibble: 6 x 7
##         date  open  high   low    close    volume adjusted
##       <date> <dbl> <dbl> <dbl>    <dbl>     <dbl>    <dbl>
## 1 2007-01-03 86.29 86.58 81.90 83.80000 309579900 10.81246
## 2 2007-01-04 84.05 85.95 83.82 85.66000 211815100 11.05245
## 3 2007-01-05 85.77 86.20 84.40 85.04999 208685400 10.97374
## 4 2007-01-08 85.96 86.53 85.28 85.47000 199276700 11.02793
## 5 2007-01-09 86.45 92.98 85.15 92.57000 837324600 11.94403
## 6 2007-01-10 94.75 97.80 93.45 97.00000 738220000 12.51562

# Plot the stock price over time
plot(apple$date, apple$adjusted, type = "l")



# Calculate daily stock returns for the adjusted price
apple <- tq_mutate(data = apple,
                   ohlc_fun = Ad,
                   mutate_fun = dailyReturn)

# Sort the returns from least to greatest
sorted_returns <- sort(apple$daily.returns)

# Plot them
plot(sorted_returns)


Chapater 5: Apply
A popular alternative to loops in R are the apply functions. Why? Apply functions are:

more readable than loops
much faster.
Apply family:

apply: apply functions over array margins
lapply: apply functions over a list or vector
eapply: apply functions over values in an environment
mapply: apply functions over multiple lists or vector arguments
rapply: apply functions over a list recursively
tapply: apply functions over a ragged array
sapply: simplify the result from lapply
vapply: strictly simplify the result from lapply
5.1 lapply() on a list
lapply() is short for “list apply.” It applies the same function to each element of the list and always returns another list.

# Define stock_return
apple <- c(0.37446342, -0.71883530,  0.76986527,  0.98226467,  0.98171665,  1.63217981,
           -0.57042563,  1.66813769,  0.00000000,  0.54692248,  0.12951131,  0.57773562,
           0.26577503,  0.09405729, -0.65778233,  0.19778141,  0.63508411, -0.42640287,
           -0.02569373, -0.77957680)
ibm <- c(0.1251408, -0.1124859,  0.3190691,  2.7689429,  0.3458948,  0.7014998,
         -0.6125390,  1.6858006,  0.1307267, -0.2907839, -0.7677657, -0.0299886,
         0.5519558, -0.1610979, -0.1613578, -0.2095056,  0.2579329, -0.5683858,
         0.2467056, -0.3661465)
micr <- c(0.08445946,  1.63713080, -0.44835603,  2.36864053, -0.58660583,  1.57351254,
          0.32273681,  1.30287920, -0.47634170, -0.15954052, -0.44742729,  2.11878010,
          -0.12574662,  0.00000000,  0.01573812, -0.48780488,  0.06325111, -0.45828066,
          -0.14287982, -1.20826709)
stock_return <- list(apple = apple, ibm = ibm, micr = micr)

# Define percent_to_decimal
percent_to_decimal <- function(percent, digits = 2) {
    decimal <- percent / 100
    
    round(decimal, digits)
}

# Print stock_return
stock_return
## $apple
##  [1]  0.37446342 -0.71883530  0.76986527  0.98226467  0.98171665
##  [6]  1.63217981 -0.57042563  1.66813769  0.00000000  0.54692248
## [11]  0.12951131  0.57773562  0.26577503  0.09405729 -0.65778233
## [16]  0.19778141  0.63508411 -0.42640287 -0.02569373 -0.77957680
## 
## $ibm
##  [1]  0.1251408 -0.1124859  0.3190691  2.7689429  0.3458948  0.7014998
##  [7] -0.6125390  1.6858006  0.1307267 -0.2907839 -0.7677657 -0.0299886
## [13]  0.5519558 -0.1610979 -0.1613578 -0.2095056  0.2579329 -0.5683858
## [19]  0.2467056 -0.3661465
## 
## $micr
##  [1]  0.08445946  1.63713080 -0.44835603  2.36864053 -0.58660583
##  [6]  1.57351254  0.32273681  1.30287920 -0.47634170 -0.15954052
## [11] -0.44742729  2.11878010 -0.12574662  0.00000000  0.01573812
## [16] -0.48780488  0.06325111 -0.45828066 -0.14287982 -1.20826709

# lapply to change percents to decimal
lapply(stock_return, FUN = percent_to_decimal)
## $apple
##  [1]  0.00 -0.01  0.01  0.01  0.01  0.02 -0.01  0.02  0.00  0.01  0.00
## [12]  0.01  0.00  0.00 -0.01  0.00  0.01  0.00  0.00 -0.01
## 
## $ibm
##  [1]  0.00  0.00  0.00  0.03  0.00  0.01 -0.01  0.02  0.00  0.00 -0.01
## [12]  0.00  0.01  0.00  0.00  0.00  0.00 -0.01  0.00  0.00
## 
## $micr
##  [1]  0.00  0.02  0.00  0.02 -0.01  0.02  0.00  0.01  0.00  0.00  0.00
## [12]  0.02  0.00  0.00  0.00  0.00  0.00  0.00  0.00 -0.01
5.2 lapply() on a data frame
lapply() also works on a data frame. It applies the function to each column of the data frame.

# Define stock_return
stock_return <- lapply(stock_return, function(x) {x/100})
stock_return <- data.frame(stock_return)

# Print stock_return
stock_return
##            apple          ibm          micr
## 1   0.0037446342  0.001251408  0.0008445946
## 2  -0.0071883530 -0.001124859  0.0163713080
## 3   0.0076986527  0.003190691 -0.0044835603
## 4   0.0098226467  0.027689429  0.0236864053
## 5   0.0098171665  0.003458948 -0.0058660583
## 6   0.0163217981  0.007014998  0.0157351254
## 7  -0.0057042563 -0.006125390  0.0032273681
## 8   0.0166813769  0.016858006  0.0130287920
## 9   0.0000000000  0.001307267 -0.0047634170
## 10  0.0054692248 -0.002907839 -0.0015954052
## 11  0.0012951131 -0.007677657 -0.0044742729
## 12  0.0057773562 -0.000299886  0.0211878010
## 13  0.0026577503  0.005519558 -0.0012574662
## 14  0.0009405729 -0.001610979  0.0000000000
## 15 -0.0065778233 -0.001613578  0.0001573812
## 16  0.0019778141 -0.002095056 -0.0048780488
## 17  0.0063508411  0.002579329  0.0006325111
## 18 -0.0042640287 -0.005683858 -0.0045828066
## 19 -0.0002569373  0.002467056 -0.0014287982
## 20 -0.0077957680 -0.003661465 -0.0120826709

# lapply to get the average returns
lapply(stock_return, mean)
## $apple
## [1] 0.002838389
## 
## $ibm
## [1] 0.001926806
## 
## $micr
## [1] 0.002472939

# Sharpe ratio
sharpe <- function(returns) {
    (mean(returns) - .0003) / sd(returns)
}

# lapply to get the sharpe ratio
lapply(stock_return, sharpe)
## $apple
## [1] 0.3546496
## 
## $ibm
## [1] 0.2000819
## 
## $micr
## [1] 0.218519
5.3 FUN arguments
In the call to lapply() you can specify the named optional arguments after the FUN argument.

# sharpe
sharpe <- function(returns, rf = .0003) {
    (mean(returns) - rf) / sd(returns)
}

# First lapply()
lapply(stock_return, sharpe, rf = .0004)
## $apple
## [1] 0.3406781
## 
## $ibm
## [1] 0.1877828
## 
## $micr
## [1] 0.2084626

# Second lapply()
lapply(stock_return, sharpe, rf = .0009)
## $apple
## [1] 0.2708209
## 
## $ibm
## [1] 0.1262875
## 
## $micr
## [1] 0.1581807
5.4 sapply() VS lapply()
sapply() does the same thing that lapply() does, but:

lapply() returns a list.
sapply() returns a vector.
# lapply() on stock_return
lapply(stock_return, sharpe)
## $apple
## [1] 0.3546496
## 
## $ibm
## [1] 0.2000819
## 
## $micr
## [1] 0.218519

# sapply() on stock_return
sapply(stock_return, sharpe)
##     apple       ibm      micr 
## 0.3546496 0.2000819 0.2185190

# sapply() on stock_return with optional arguments
sapply(stock_return, sharpe, simplify = FALSE, USE.NAMES = FALSE)
## $apple
## [1] 0.3546496
## 
## $ibm
## [1] 0.2000819
## 
## $micr
## [1] 0.218519
5.5 Failing to simplify
sapply() guesses the output type so that it can simplify. If sapply() cannot simplify your output, then it will default to returning a list just like lapply().

# Market crash with as.Date()
market_crash <- list(dow_jones_drop = 777.68, 
                     date = as.Date("2008-09-28"))
                     
# Find the classes with sapply()
sapply(market_crash, class)
## dow_jones_drop           date 
##      "numeric"         "Date"

# Market crash with as.POSIXct()
market_crash2 <- list(dow_jones_drop = 777.68, 
                      date = as.POSIXct("2008-09-28"))

# Find the classes with lapply()
lapply(market_crash2, class)
## $dow_jones_drop
## [1] "numeric"
## 
## $date
## [1] "POSIXct" "POSIXt"

# Find the classes with sapply()
sapply(market_crash2, class)
## $dow_jones_drop
## [1] "numeric"
## 
## $date
## [1] "POSIXct" "POSIXt"
5.6 vapply() VS sapply()
When sapply() fails to simplify, it returns a list and no error is thrown! If a function you wrote expect a simplified vector to be returned by sapply(), this would be confusing.

To account for this, there is a more strict apply function called vapply(), which contains an extra argument  FUN.VALUE where you can specify the type and length of the output that should be returned.

# Market crash with as.POSIXct()
market_crash2 <- list(dow_jones_drop = 777.68, 
                      date = as.POSIXct("2008-09-28"))

# Find the classes with sapply()
sapply(market_crash2, class)
## $dow_jones_drop
## [1] "numeric"
## 
## $date
## [1] "POSIXct" "POSIXt"

# Find the classes with vapply()
#vapply(market_crash2, class, FUN.VALUE = character(1)) # This code would give the following error. Error: values must be length 1, but FUN(X[[2]]) result is length 2
5.7 More vapply()
When there are no errors, vapply() returns a simplified result according to the FUN.VALUE argument.

# Sharpe ratio for all stocks
vapply(stock_return, sharpe, FUN.VALUE = numeric(1)) #length of 1 b/c only one number (Sharpe ratio) per stock
##     apple       ibm      micr 
## 0.3546496 0.2000819 0.2185190

# Summarize Apple
summary(stock_return$apple)
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
## -0.007796 -0.001259  0.002318  0.002838  0.006688  0.016680

# Summarize all stocks
vapply(stock_return, summary, FUN.VALUE = numeric(6)) #length of 6 b/c six-metric summary per stock
##             apple        ibm       micr
## Min.    -0.007796 -0.0076780 -0.0120800
## 1st Qu. -0.001259 -0.0022980 -0.0045080
## Median   0.002318  0.0004758 -0.0006287
## Mean     0.002838  0.0019270  0.0024730
## 3rd Qu.  0.006688  0.0032580  0.0056780
## Max.     0.016680  0.0276900  0.0236900
5.8 Anonymous functions
When calling an apply function, there is no need to create a function just for that purpose. One can pass in an annonymous function.

# Max and min
vapply(stock_return, 
       FUN = function(x) { c(max(x), min(x)) }, #c() when you have more than one function
       FUN.VALUE = numeric(2))
##             apple          ibm        micr
## [1,]  0.016681377  0.027689429  0.02368641
## [2,] -0.007795768 -0.007677657 -0.01208267