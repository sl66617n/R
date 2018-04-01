#install.packages("stats")
library(stats)
par(mfrow=c(3,2))
x=seq(0,1,by=o.1)
alpha=c(0,2,10,20,50,500)
beta=c(0,2,8,11,27,232)
for(i in 1:length(alpha)){
  y<-beta(x,shape1=alpha[i],shape2=beta[i])
  plot(x,y,type="l")
}



citation(package = "TSTutorial")
