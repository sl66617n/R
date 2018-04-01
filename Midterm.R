# 2.2
series <- function(j) {
  result <- c()
  for (i in 1:j) {
    result <- c(result, seq(i))
  }
  return(result)
}
series(10)

# 2.5
OECD <- read.table("/Users/sijialiang/Desktop/Supp_2/OECD PISA.txt", header=TRUE,row.names=1)
OECD

#2.8
x <- seq(0, 1, by=0.05)
f <- function(x) {
  return(1/(2+sin(5*pi*x)))
}

y <- f(x)
plot(x, y, type="l")

integrate(f, 0, 1)

#  minimum value
nlm(f, 0.9)$minimum

g <- function(x) {
  return(0-f(x))
}
#maximum value
-nlm(g, 0.2)$minimum

nlm(g, 0.1)
nlm(g, 0.2)
nlm(g, 0.9)
# indenpent on starting value since the local max are all the same


#2.12
x <- 1:3
x[-2]
x[-5]

x[0]

x[7] <- 9
x
x[]
x
x[] <- 3
x


#5.1
# Loading packages
install.packages("fBasics")
library(fBasics)
install.packages("akima")
library(akima)

# Loading housing dataset and plot
housing <- read.table("/Users/sijialiang/Desktop/Supp_2/housing.txt", header=TRUE,row.names=1)
housing$Apartment
hist(housing$Apartment)
log(housing$Apartment)
hist(log(housing$Apartment))

# Loading CD4 dataset
require(boot)
cd4
# stem and leaf plot for small dataset
hist(cd4$baseline, breaks=20)
stem(cd4$baseline)


# assuming statistical signifiance = 5%, 0.05

# jb Test for housing$Apartment
jbTest(housing$Apartment,
       title="Original apartment rents")
# p value = 0.043 reject null hypotheis, housing$Apartment is not normal distributed, therefore, perform box-cox transformation

# jb Test for cd4
jbTest(cd4$baseline)
# p value 0.79 can't reject null hypothesis


# One-sample Kolmgorov-Smirnov test for housing$Apartment
z1 <- housing$Apartment
z1 <- (z1-mean(z1)) / sd(z1)
ksnormTest(z1)# two-sided = 0.1484 =p-value > 0.05 = can't reject null hypothesis

z2 <- -(housing$Apartment)^(-1/2)
z2 <- (z-mean(z2)) / sd(z2)
ksnormTest(z2) 

z3 <- log(housing$Apartment)
z3 <- (z-mean(z3)) / sd(z3)
ksnormTest(z3)#

z4 <- (housing$Apartment)^(1/2)
z4 <- (z-mean(z4)) / sd(z4)
ksnormTest(z4)# two-sided = < 2.2e-16 = too small < 0.05

# One-sample Kolmgorov-Smirnov test for cd4
cdks <- cd4$baseline
cdks <- (cdks-mean(cdks)) / sd(cdks)
ksnormTest(cdks)# two-sided=0.9884> 0.05 = not reject null hypothesis

# Shapiro test for housing$Apartment
shapiro.test(housing$Apartment) #0.007472 < 0.05 = reject, not normal, cox-box transformation
shapiro.test(-housing$Apartment^(-1/2)) # lambda=-1/2, p=0.3136>0.05, (-1/2) is better than take log
shapiro.test(log(housing$Apartment)) # when lambda=0, take log, p= 0.1481 >0.05, obey normal
shapiro.test((housing$Apartment)^(1/2)) # when lambda=1/2 >0, p=0.0414 < 0.05, failed

# Shapiro test for cd4$baseline
shapiro.test(cd4$baseline) # p=0.9434 >0.05



# 6
V_half <- diag(c(5,2,3),3,3)
R <- matrix(c(1,-1/5.0,4/15.,-1/5.,1,1/6.,4/15., 1/6.,1 ), nrow=3)
V_half %*% R %*% V_half

# 7
b <- c(-4,3)
d <- c(1,1)
B <- matrix(c(2,-2,-2,5), nrow=2)
b%*%d
b %*% B %*% b
d %*% solve(B) %*% d
(b%*%d)^2 <= (b %*% B %*% b)*(d %*% solve(B) %*% d)

# 8
X <- matrix(c(1,2,3,3,4,5,6,8,9,10,18.95,19.00,17.95,15.54,14.00,12.95,8.94,7.49,6.00,3.99), nrow=10)
Sigma <- cov(X)
X_bar <- colMeans(X)
X_demean <- X - matrix(rep(X_bar,each=10),nrow=10)
diag(X_demean %*% solve(Sigma) %*% t(X_demean))
qchisq(.5, df=2)
# TRUEs are the data falling in the 50% prob contour
diag(X_demean %*% solve(Sigma) %*% t(X_demean)) <= qchisq(.5, df=2)
