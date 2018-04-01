#Question1
# read the csv data and name the dataset "Quiz1"
Quiz1=read.csv("/Users/sijialiang/Desktop/Eclipse/R/bones.csv")

# compute X bar
colMeans(Quiz1[,2:7])

# compute corvariance for all variables excluding 1st column
# since 1st column only indicates subject column
cov(Quiz1[,2:7])

# compute corvariance for all variables excluding 1 column
cor(Quiz1[,2:7])

# interpret pairwise correlations:
# different bones with the same (non)dominance have higher correlation than same pair of bones but different (non)dominance

#Question2
# access data from R
data(EuStockMarkets)

# read the head of the EuStockMarkets dataset
head(EuStockMarkets)

# using either boxplot.Matrix() or boxplot() to compute side by side boxplots
boxplot.matrix(EuStockMarkets)
boxplot(EuStockMarkets)

# plot scatterplot matrix, getting times series chart instead
plot(EuStockMarkets)

# plot scatterplot using paris()
pairs(EuStockMarkets)

# interpret pattern show:
# 
