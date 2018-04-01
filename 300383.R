library(ggplot2)
install.packages("MASS")
library(MASS)
# pie chart with percentage
slices <- c(53.15, 30.12, 12.3, 4.43)
lbls <- c("云计算及相关服务",
          "IDC及其增值服务",
          "IDC运营管理服务",
          "互联网宽带接入服务")
pct <- round(slices/sum(sclices)*100) 
lbls <- paste(lbls, pct) #add percents to labels
lbls <- paste(lbls, "%", sep = "") # add % to labels
pie(slices, labels = lbls, col = cm.colors(slices)),main = "主营业务分布")
# 3D Exploded Pie Chart
library(plotrix)
rainbow(length(lbls)
        
        
        
        
        
        
        