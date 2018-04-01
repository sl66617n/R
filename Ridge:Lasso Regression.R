install.packages('Quandl')
install.packages('glmnet')
install.packages('dplyr')
library(Quandl)
library(glmnet)
library(dplyr)

Quandl.api_key('tAyfv1zpWnyhmDsp91yv')

# get data
aapl <- Quandl("WIKI/AAPL", start_date="2009-01-01")
aapl
plot(aapl)
colnames(aapl)
mean(aapl$AdjClose)
vix <- Quandl("CHRIS/CBOE_VX1", start_date="2009-01-01")
vix
spy <- Quandl("CHRIS/CME_SP1", start_date="2009-01-01")
spy
colnames(aapl)[12] <- "AdjClose"
# use lagged return as factor
aapl <- aapl[order(aapl$Date),]
aapl <- aapl %>% select(Date, AdjClose) %>% mutate(lpx = log(AdjClose), ret = c(NA,diff(lpx)),
        retLag1 = lag(ret, 1), retLag2 = lag(ret, 2), retLag3 = lag(ret, 3), retLag4 = lag(ret, 4), retLag5 = lag(ret, 5))
colnames(vix)[1] <- "Date"
vix <- vix[order(vix$Date), ]
vix <- vix %>% select(Date,Settle) %>% mutate(vixLpx = log(Settle), vixRet = c(NA,diff(vixLpx)),
        vixRetLag1 = lag(vixRet, 1), vixRetLag2 = lag(vixRet, 2), vixRetLag3 = lag(vixRet, 3), vixRetLag4 = lag(vixRet, 4), 
        vixRetLag5 = lag(vixRet, 5))
spy <- spy[order(spy$Date), ]
spy <- spy %>% select(Date,Settle) %>% mutate(spyLpx = log(Settle), spyRet = c(NA,diff(spyLpx)), spyRetLag1 = lag(spyRet, 1), 
        spyRetLag2 = lag(spyRet, 2), spyRetLag3 = lag(spyRet, 3), spyRetLag4 = lag(spyRet, 4), spyRetLag5 = lag(spyRet, 5))

# merge aapl, vix, spy
data <- left_join(aapl, vix, by="Date")
data <- left_join(data, spy, by="Date")
data <- na.omit(data)
data <- data[,c(4,5,6,7,8,9,13,14,15,16,17,21,22,23,24,25)]
y <- as.matrix(data[,4])
x <- as.matrix(data[ ,c(5,6,7,8,9,13,14,15,16,17,21,22,23,24,25)])

trainSize <- floor(0.8 * nrow(data))
data.train <- data[1:trainSize,]
x.train <- x[1:trainSize,]
x.test <- x[-(1:trainSize),]
y.train <- y[1:trainSize,]
y.test <- y[-(1:trainSize),]
scaledMeans <- colMeans(data.train)
scaledStd <- apply(data.train, 2, sd)

# model fit
par(mfrow=c(3,5))
plot(ret ~ retLag1, data=data.train)
plot(ret ~ retLag2, data=data.train)
plot(ret ~ retLag3, data=data.train)
plot(ret ~ retLag4, data=data.train)
plot(ret ~ retLag5, data=data.train)
plot(ret ~ vixRetLag1, data=data.train)
plot(ret ~ vixRetLag2, data=data.train)
plot(ret ~ vixRetLag3, data=data.train)
plot(ret ~ vixRetLag4, data=data.train)
plot(ret ~ vixRetLag5, data=data.train)
plot(ret ~ spyRetLag1, data=data.train)
plot(ret ~ spyRetLag2, data=data.train)
plot(ret ~ spyRetLag3, data=data.train)
plot(ret ~ spyRetLag4, data=data.train)
plot(ret ~ spyRetLag5, data=data.train)


aapl.formula <- ret ~ retLag1 + retLag2 + retLag3 + retLag4 + retLag5 + vixRetLag1 + vixRetLag2 + vixRetLag3 + vixRetLag4 + vixRetLag5 + spyRetLag1 + spyRetLag2 + spyRetLag3 + spyRetLag4 + spyRetLag5
train.lm <- lm(aapl.formula, data=data.train) 
summary(train.lm)
require(lmtest)
dwtest(train.lm)
aapl.resid <- residuals(train.lm)
aapl.fitted <- fitted(train.lm)

par(mfrow=c(3,5))
plot(aapl.resid ~ retLag1, data=data.train)
plot(aapl.resid ~ retLag2, data=data.train)
plot(aapl.resid ~ retLag3, data=data.train)
plot(aapl.resid ~ retLag4, data=data.train)
plot(aapl.resid ~ retLag5, data=data.train)
plot(aapl.resid ~ vixRetLag1, data=data.train)
plot(aapl.resid ~ vixRetLag2, data=data.train)
plot(aapl.resid ~ vixRetLag3, data=data.train)
plot(aapl.resid ~ vixRetLag4, data=data.train)
plot(aapl.resid ~ vixRetLag5, data=data.train)
plot(aapl.resid ~ spyRetLag1, data=data.train)
plot(aapl.resid ~ spyRetLag2, data=data.train)
plot(aapl.resid ~ spyRetLag3, data=data.train)
plot(aapl.resid ~ spyRetLag4, data=data.train)
plot(aapl.resid ~ spyRetLag5, data=data.train)


# Cook's Distance, value > 1 are suggestive that the corresponding observation 
#has undue influence on the estimated regression coefficient
par(mfrow=c(1,1))
plot(train.lm)
anova(train.lm)
#coef(summary(train.lm))
#head(predict(train.lm))


# almost no factor is significant

fit.lasso <- glmnet(x.train, y.train, family="gaussian", alpha=1)
fit.ridge <- glmnet(x.train, y.train, family="gaussian", alpha=0)
par(mfrow=c(1,1))

# lasso and ridge goodness fit
plot(fit.lasso, xvar="lambda")
plot(fit.ridge, xvar="lambda")

foreLength <- length(y.test)
trainLength <- length(y.train)

# calculate out of sample error
tot <- 0
for (d in 0:(foreLength-1)) {
  data.train <- data[(1+d):(trainLength+d), ]
  #train.lm <- lm(aapl.formula, data=data.train)
  train.lm <- glmnet(as.matrix(data.train[,c(2:16)]), as.matrix(data.train[,1]), family="gaussian", alpha=0, lambda=0.0005)
  #forecast <- predict(train.lm, (data[trainLength+d+1,c(2:16)]))
  forecast <- predict(train.lm, as.matrix(data[trainLength+d+1,c(2:16)]))
  sqrErr <- (forecast - data[trainLength+d+1,1])^2
  tot <- tot+sqrErr
}
tot/foreLength

