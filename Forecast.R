Forecast = read.csv("Forecast.csv")
summary(Forecast)
install.packages("caTools")
library(caTools)
set.seed(99)
head(Forecast)
Forecast_Revenue = glm(Revenue ~ ., data = Forecast)
summary(Forecast_Revenue)
prediction = predict(Forecast_Revenue, type = "response", data = Forecast)
summary(prediction)
plot(Forecast)
library(ggplot2)
scatter = ggplot(Forecast, aes(Year, Revenue))
scatter + geom_point() + geom_smooth() + labs(x = "Year", y = "Revenue")

histogram = histogram(Forecast)
model <- lm(formula= Revenue ~ ., data = Forecast)
summary(model)
library(forecast)
a=ts(c(3006,3658,3712,3575,3228,3845,4362), 
     frequency = 1, 
     start = c(2008, 2)) 

plot(forecast(a,h=5,level=c(80,95)),
     main="XY 5 Year Forecast")

b = lm(Forecast, x = Forecast$Year, y = Forecast$Revenue)

a = c(1,2,3,4)
hist(a)


