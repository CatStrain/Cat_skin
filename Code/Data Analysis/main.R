#Initialization:
rm(list = ls());              # clear workspace variables
cat("\014")                   # clear window
library(rgl)                  # loading libraries
library(class)
library(ggplot2)
library(caret)                # "R package that provides general interface to +- 150 ML alg"
library("lattice")
mypath_1 <- "C:/Users/dario/Documents/Github/Cat_skin/Data/Backup/ZMP_9points_ElasticBands(Mat1)_and_Spring_COMBINATION_PLANT/test_0111_800g+black_random_2.txt"   
data.raw <- read.csv(mypath_1)                                                   # Creating data frame from data csv file

########

#setwd("~/Github/Cat_skin/Data/Backup/ZMP_9points_SkinMat2_BlackMass")
#load("constant_force_2_skin.Rda")

#Change this line to analyze different files:
#data.raw <-constant_force_2_skin.data
########


#DOWNSAMPLING DATA:
zmp_posotions_all = rep(c(1:9), times = ceiling(nrow(data.raw)/(25*9)))          #  generating label patterns
data.downsampled = data.raw[seq(12,nrow(data.raw),25),]                          # down sampling data seq.int(from, to, by, length.out, along.with, ...)
data.downsampled[,5] = zmp_posotions_all[1:250]                                  # selecting labels to fit the data size
newheaders <- c("LC_1", "LC_2", "LC_3", "LC_4","ZMP_location")                   # To Add headers to the downsampled data
colnames(data.downsampled) <- newheaders
# KNN
set.seed(99)                                                                     # required to reproduce the results
data.downsampled['ZMP_location'] = factor(data.downsampled[,'ZMP_location'])
trControl <- trainControl(method  = "cv", number  = 5)                           # 5 fold Cross-Validation
fit <- train(ZMP_location ~ .,
      method     = "knn",
      tuneGrid   = expand.grid(k = 1:20),
      trControl  = trControl,
      metric     = "Accuracy",
      data       = data.downsampled)                  # test KNN for K values: 1:20
print(fit)                                            # print results    
print(confusionMatrix(fit))
levelplot(confusionMatrix(fit)$table)                 # print the confusion matrix


min_max_norm <- function(x) {
   (x - min(x)) / (max(x) - min(x))
}

data.downsampled_norm <- as.data.frame(lapply(data.downsampled[1:4], min_max_norm))
data.downsampled_norm_sd<-lapply(data.downsampled_norm[1:4], sd)

mean_normal_sd<-mean(unlist(data.downsampled_norm_sd))
mean_normal_sd

