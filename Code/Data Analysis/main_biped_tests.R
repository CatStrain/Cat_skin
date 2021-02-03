#Initialization:
rm(list = ls());              # clear workspace variables
cat("\014")                   # clear window
library(rgl)                  # loading libraries
library(class)
library(ggplot2)
library(caret)                # "R package that provides general interface to +- 150 ML alg"
library("lattice")

mypath_1 <- "C:/Users/dario/Documents/Github/Cat_skin/Code/Data Analysis/Test_files for_biped_analyses/CoP_plate_1_prebiped_provitional.txt"   
prebiped_data.raw <- read.csv(mypath_1)                                                   # Creating prebiped_data frame from prebiped_data csv file

mypath_2 <- "C:/Users/dario/Documents/Github/Cat_skin/Code/Data Analysis/Test_files for_biped_analyses/CoP_plate_2_postbiped_provitional.txt"   
postbiped_data.raw <- read.csv(mypath_2)                                                   # Creating prebiped_data frame from prebiped_data csv file

mypath_3 <- "C:/Users/dario/Documents/Github/Cat_skin/Code/Data Analysis/Test_files for_biped_analyses/left_foot_skin.txt" 
leftleg_data.raw <- read.csv(mypath_3)

mypath_4 <- "C:/Users/dario/Documents/Github/Cat_skin/Code/Data Analysis/Test_files for_biped_analyses/right_foot_skin.txt" 
rightleg_data.raw <- read.csv(mypath_4)

biped_data <- leftleg_data.raw[,c(1,2,3,4)]
biped_data[,c(5,6,7,8)] <- rightleg_data.raw[,c(1,2,3,4)]

########

#DOWNSAMPLING prebiped_data:

zmp_posotions_all = rep(c(1:9), times = ceiling(nrow(prebiped_data.raw)/(25*9)))          #  generating label patterns
prebiped_data.downsampled = prebiped_data.raw[seq(12,nrow(prebiped_data.raw),25),]                          # down sampling prebiped_data seq.int(from, to, by, length.out, along.with, ...)
prebiped_data.downsampled[,5] = zmp_posotions_all[1:250]                                  # selecting labels to fit the prebiped_data size
newheaders <- c("LC_1", "LC_2", "LC_3", "LC_4","ZMP_location")                   # To Add headers to the downsampled prebiped_data
colnames(prebiped_data.downsampled) <- newheaders
# KNN
#

#
#
#
#
#

zmp.class <- prebiped_data.downsampled[,c("ZMP_location")]                              # Actual classes ZMP locations
zmp_features <- prebiped_data.downsampled[,c("LC_1","LC_2","LC_3","LC_4")] # Data without class

zmp.class <- as.data.frame(zmp.class)

set.seed(99)                  # required to reproduce the results
rnum<- sample(rep(1:250))     # randomly generate numbers from 1 to 250
id.training <- rnum[1:200]    #Choose training set
id.test <- rnum[201:250]      #Choose test set

#Select data rows depending on the previously randomly generated arrays:

zmp.train <- prebiped_data.downsampled[id.training,]
zmp.train.target <- zmp.class[id.training,]
zmp.test <- prebiped_data.downsampled[id.test,]
zmp.test.target <- zmp.class[id.test,]
#####
#K Means
#####
model1<- knn(train=zmp.train, test=zmp.test, cl=zmp.train.target, k=3)     #Running KNN
tb <- table(zmp.test.target, model1)                                        #confusion matrix (only numbers)
tb                                                                          #display confusion matrix
accuracy <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}               #Prediction accuracy
accuracy(tb)

tb= as.matrix(tb)
#
#
#
#
#
#
#

############
# set.seed(99)                                                                     # required to reproduce the results
# prebiped_data.downsampled['ZMP_location'] = factor(prebiped_data.downsampled[,'ZMP_location'])
# trControl <- trainControl(method  = "cv", number  = 5)                           # 5 fold Cross-Validation
# fit <- train(ZMP_location ~ .,
#       method     = "knn",
#       tuneGrid   = expand.grid(k = 1:20),
#       trControl  = trControl,
#       metric     = "Accuracy",
#       prebiped_data       = prebiped_data.downsampled)                  # test KNN for K values: 1:20
# print(fit)                                            # print results    
# print(confusionMatrix(fit))
# levelplot(confusionMatrix(fit)$table)                 # print the confusion matrix
# 
# 
# min_max_norm <- function(x) {
#    (x - min(x)) / (max(x) - min(x))
# }
# 
# prebiped_data.downsampled_norm <- as.prebiped_data.frame(lapply(prebiped_data.downsampled[1:4], min_max_norm))
# prebiped_data.downsampled_norm_sd<-lapply(prebiped_data.downsampled_norm[1:4], sd)
# 
# mean_normal_sd<-mean(unlist(prebiped_data.downsampled_norm_sd))
# mean_normal_sd

