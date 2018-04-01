data.train <- read.csv("train.csv", header=T)
data.test <- read.csv("test.csv", header=T)
data.test$SalePrice <- 0 #Make test prices 0 for now a single data table can be created
data <- rbind(data.train, data.test)

#Data Preprocessing

varsWithNA = names(which(colSums(is.na(data))>0))

#data["MiscFeature"] <- NULL # Missing value in 96.4% of observations
#data["Alley"] <- NULL # Missing value in 93.2% of observations
#data["PoolQC"] <- NULL # Missing value in 99.7% of observations

missingObs = c("MSZoning", "MasVnrType", "Utilities", "Exterior1st", "Exterior2nd", "SaleType")
effZero = c("LotFrontage", "MasVnrArea", "BsmtFinSF1", "BsmtFinSF2", "BsmtUnfSF", "TotalBsmtSF","GarageCars", "GarageArea", "BsmtFullBath", "BsmtHalfBath")

# Get Effectively Absent category by excluding other categories from varsWithNA
effAbsent = varsWithNA[!varsWithNA %in% missingObs]
effAbsent = effAbsent[!effAbsent %in% effZero]
effAbsent = effAbsent[!effAbsent %in% c("Functional", "GarageYrBlt")]

# Function for replacing NAs in nominal and ordinal variables
replaceNAfactor = function(data.col, factorString){
  char.col <- as.character(data.col)
  char.col[which(is.na(data.col))] <- factorString
  as.factor(char.col)
}
# Replace NAs with None in Effectively Absent category
for (i in 1:ncol(data)){
  if(names(data[i]) %in% effAbsent){
    data[,i] <- replaceNAfactor(data[,i], "None")}
}
# Replace NAs with MissingObs in Missing Observations category
for (i in 1:ncol(data)){
  if(names(data[i]) %in% missingObs){
    data[,i] <- replaceNAfactor(data[,i], "MissingObs")}
}
# Replace NAs with 0 in Effectively Zero category
for (i in 1:ncol(data)){
  if(names(data[i]) %in% effZero)
    data[is.na(data[,i]),i] <- 0
}
# Replace NA with -1 in Missing Numerical Observations category
data$GarageYrBlt[is.na(data$GarageYrBlt)] <- -1

data$Functional <- replaceNAfactor(data$Functional, "Typ")


names(which(colSums(is.na(data))>0))

# Encoding Variables to Correct Types

#data$MSSubClass <- as.factor(data$MSSubClass)

#There are 23 ordinal variables in the dataset. Manually specify the order of factor levels for each variable.
data$LotShape <- ordered(data$LotShape, levels=c("IR3", "IR2", "IR1", "Reg"))
data$Utilities <- ordered(data$Utilities, levels=c("MissingObs", "NoSeWa", "NoSewr", "AllPub"))
data$LandSlope <- ordered(data$LandSlope, levels=c("Gtl", "Mod", "Sev"))
data$OverallQual <- ordered(data$OverallQual)
data$OverallCond <- ordered(data$OverallCond)
data$ExterQual <- ordered(data$ExterQual, levels=c("Po", "Fa", "TA", "Gd", "Ex"))
data$ExterCond <- ordered(data$ExterCond, levels=c("Po", "Fa", "TA", "Gd", "Ex"))
data$BsmtQual <- ordered(data$BsmtQual, levels=c("None", "Po", "Fa", "TA", "Gd", "Ex"))
data$BsmtCond <- ordered(data$BsmtCond, levels=c("None", "Po", "Fa", "TA", "Gd", "Ex"))
data$BsmtExposure <- ordered(data$BsmtExposure, levels=c("None", "No", "Mn", "Av", "Gd"))
data$BsmtFinType1 <- ordered(data$BsmtFinType1, levels=c("None", "Unf", "LwQ", "Rec", "BLQ", "ALQ", "GLQ"))
data$BsmtFinType2 <- ordered(data$BsmtFinType2, levels=c("None", "Unf", "LwQ", "Rec", "BLQ", "ALQ", "GLQ"))
data$KitchenQual <- ordered(data$KitchenQual, levels=c("None", "Po", "Fa", "TA", "Gd", "Ex"))
data$Functional <- ordered(data$Functional, levels=c("Sal", "Sev", "Maj2", "Maj1", "Mod", "Min2", "Min1", "Typ"))
data$FireplaceQu <- ordered(data$FireplaceQu, levels=c("None", "Po", "Fa", "TA", "Gd", "Ex"))
data$GarageFinish <- ordered(data$GarageFinish, levels=c("None", "Unf", "RFn", "Fin"))
data$GarageQual <- ordered(data$GarageQual, levels=c("None", "Po", "Fa", "TA", "Gd", "Ex"))
data$GarageCond <- ordered(data$GarageCond, levels=c("None", "Po", "Fa", "TA", "Gd", "Ex"))
data$PavedDrive <- ordered(data$PavedDrive, levels=c("N", "P", "Y"))
data$Fence <- ordered(data$Fence, levels=c("None", "MnWw", "GdWo", "MnPrv", "GdPrv"))
data$HeatingQC <- ordered(data$HeatingQC, levels=c("None", "Po", "Fa", "TA", "Gd", "Ex"))
data$Electrical <- ordered(data$Electrical, levels=c("None", "Mix", "FuseP", "FuseF", "FuseA", "SBrkr"))
data$PoolQC <- ordered(data$PoolQC, levels=c("None", "Fa", "Gd", "Ex"))
data$Alley <- ordered(data$Alley, levels=c("None", "Grvl", "Pave"))

outliers = numeric()
if (F){
  train.true <- 1:nrow(data.train)
  # Find outliers in train subset
  mod <- lm(SalePrice~.,data=data[train.true,-9]) # Model without Utilities, since they are all the same for train subset
  cooksd <- cooks.distance(mod)
  plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")  # plot cook's distance
  abline(h = 8*mean(cooksd, na.rm=T), col="red")  # add cutoff line
  text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>8*mean(cooksd, na.rm=T),names(cooksd),""), col="red")  # add labels
  outliers <- c(524,826,198,692,589,1183,899,1045,1047)
  keepRows <- rep(T,nrow(data))
  keepRows[outliers] <-F
  data <- data[keepRows,]
}
################
#Model Training#
################

set.seed(4)

# Use for testing
train.index <- sample(nrow(data.train)-length(outliers), nrow(data.train)*0.8-length(outliers))
train <- rep(F,nrow(data))
train[train.index] <- T
val <- rep(F,nrow(data))
val[1:(nrow(data.train)-length(outliers))] <- !train[1:(nrow(data.train)-length(outliers))]
train.true <- train | val
test <- !train.true

x=model.matrix(SalePrice~.,data)[,-1] # Exclude Id column
y=data$SalePrice
dim(x)

library(glmnet)
lambda.seq=seq(2000,1600,length=200) #may take some time to run; results in better plot resolution

MSEs <- NULL
lambdas = rep(0,10)
for (j in 1:10){
  for (i in 1:10){
    cv.mod <- cv.glmnet(x, y, alpha=1, lambda=lambda.seq, nfolds=10) 
    if(length(lambda.seq) != length(cv.mod$cvm))
      print("ERROR")
    MSEs <- cbind(MSEs, cv.mod$cvm)
  }
  rownames(MSEs) <- cv.mod$lambda
  lambda.min <- as.numeric(names(which.min(rowMeans(MSEs))))
  lambdas[j] <- lambda.min
}
lambda.min <- mean(lambdas)

cv.pred <- predict(cv.mod,s=lambda.min,newx=x[val,], exact=T, x=x[train,], y=y[train])
print(mean((cv.pred-y[val])^2))



#Model Submission
test.pred <- predict(cv.mod,s=lambda.min ,newx=x[test,], exact=T, x=x[train,], y=y[train])



data[test,"SalePrice"] <- test.pred
pred <- data[test,c("Id", "SalePrice")]

# Save the predictions out to a CSV file
write.csv(pred, file="predictions.csv", quote=F, row.names=F)