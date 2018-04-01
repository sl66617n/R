install.packages("car")

install.packages("reshape2")

library(car); library(reshape2)

data(Salaries)
install.packages(ggplot2)

library(ggplot2)
library(lm.beta)
summary(Salaries)
sum(Salaries)
39+358
ggplot(data=Salaries,aes(x=yrs.service,y=salary,color=rank)) +  geom_point() +  geom_smooth(method="lm",size=1.1,se=F)
model1 = lm(salary ~ sex, data = Salaries)
model1
summary(model1)
model2 = lm(salary ~., data = Salaries)
summary(model2)
anova(model1)
anova(model2)
11*535.1 + 10*535.1 +65955.2+45066.0+14417.6+4783.5
#############

head(Salaries)

Salaries2 = Salaries

Salaries2$salaryDi = cut(Salaries$salary,breaks = c(min(Salaries$salary,na.rm=T),median(Salaries$salary,na.rm=T),max(Salaries$salary,na.rm=T)),labels = c("low","high"))

names(Salaries2)

Salaries2 = Salaries2[,-c(2,6)]

head(Salaries2)
install.packages("rpart")
install.packages("rpart.plot")
library(rpart)
library(rpart.plot)

############

tree = rpart(salaryDi~.,method="class",data=Salaries2)

prp(tree)

