house = read.csv(file="/Users/sijialiang/Desktop/Eclipse/MultiVarStats/AmesHousing_Training.csv")
str(house)
#install.packages("Hmisc")
#install.packages("psych")
#install.packages("car")
library(Hmisc)
library(psych)
library(car)
set.seed(2018)
split <- sample(seq_len(nrow(house)), size = floor(0.75 * nrow(house)))
train <- house[split, ]
test <- house[-split, ]
dim(train)

train <- subset(train, select=c(SalePrice, Lot.Area, Pool.Area, Garage.Cars, TotRms.AbvGrd, Kitchen.AbvGr, Gr.Liv.Area, Bedroom.AbvGr, Year.Remod.Add, Year.Built, Overall.Cond))
head(train)
sapply(train, function(x) sum(is.na(x)))
summary(train)
pairs.panels(train, col='red')


fit <-  lm(SalePrice ~ Lot.Area + Pool.Area + Garage.Cars + TotRms.AbvGrd + Kitchen.AbvGr + Gr.Liv.Area + Bedroom.AbvGr + Year.Remod.Add + Year.Built + Overall.Cond, data=train)
summary(fit)

fit <-  lm(SalePrice ~ Lot.Area + Garage.Cars + TotRms.AbvGrd + Kitchen.AbvGr + Gr.Liv.Area + Bedroom.AbvGr + Year.Remod.Add + Year.Built + Overall.Cond, data=train)
summary(fit)
attach(train)
cor(Gr.Liv.Area, TotRms.AbvGrd, method='pearson')
confint(fit, conf.level=0.95)
plot(fit)
test <- subset(test, select=c(SalePrice, Lot.Area, Garage.Cars, TotRms.AbvGrd, Kitchen.AbvGr, Gr.Liv.Area, Bedroom.AbvGr, Year.Remod.Add, Year.Built, Overall.Cond))
prediction <- predict(fit, newdata = test)
head(prediction)
head(test$SalePrice)
SSE <- sum((test$SalePrice - prediction) ^ 2)
SST <- sum((test$SalePrice - mean(test$SalePrice)) ^ 2)
1 - SSE/SST

