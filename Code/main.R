#Initialization:
rm(list = ls());              # clear workspace variables
cat("\014")                   #clear window
library(rgl)                  # loading libraries
library(class)
library(ggplot2)
library(caret)
library("lattice")
mypath_1 <- "~/Desktop/test_121720_2_elasticBands_blackMass_randomF.txt"   
data.raw <- read.csv(mypath_1)              #Creating data frame from data csv file
#DOWNSAMPLING DATA:
zmp_posotions_all=rep(c(1:9), times = ceiling(nrow(data.raw)/(25*9))) # generating label patterns
data.downsampled=data.raw[seq(12,nrow(data.raw),25),]
data.downsampled[,5]=zmp_posotions_all[1:250] # selecting labels to fit the data size
newheaders <- c("LC_1", "LC_2", "LC_3", "LC_4","ZMP_location")   #To Add headers to the downsampled data
colnames(data.downsampled) <- newheaders
# KNN
set.seed(99)                  # required to reproduce the results
data.downsampled['ZMP_location']=factor(data.downsampled[,'ZMP_location'])
trControl <- trainControl(method  = "cv", number  = 5) # 5 fold Cross-Validation
fit <-train(ZMP_location ~ .,
      method     = "knn",
      tuneGrid   = expand.grid(k = 1:20),
      trControl  = trControl,
      metric     = "Accuracy",
      data       = data.downsampled)                  # test KNN for K values: 1:20
print(fit)                                            # print results    
print(confusionMatrix(fit))
levelplot(confusionMatrix(fit)$table)                 # print the confusion matrix