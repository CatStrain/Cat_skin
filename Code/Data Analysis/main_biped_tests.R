#Initialization:
rm(list = ls());              # clear workspace variables
cat("\014")                   # clear window
library(rgl)                  # loading libraries
library(class)
library(ggplot2)
library(caret)                # "R package that provides general interface to +- 150 ML alg"
library("lattice")


####### 
# loading RAW files:

mypath_1 <- "C:/Users/dario/Documents/Github/Cat_skin/Code/Data Analysis/Test_files for_biped_analyses/CoP_plate_1_prebiped_provitional.txt"   
prebiped_data.raw <- read.csv(mypath_1)                                                   # Creating prebiped_data frame from prebiped_data csv file

mypath_2 <- "C:/Users/dario/Documents/Github/Cat_skin/Code/Data Analysis/Test_files for_biped_analyses/CoP_plate_2_postbiped_provitional.txt"   
postbiped_data.raw <- read.csv(mypath_2)                                                   # Creating prebiped_data frame from prebiped_data csv file

mypath_3 <- "C:/Users/dario/Documents/Github/Cat_skin/Code/Data Analysis/Test_files for_biped_analyses/left_foot_skin.txt" 
leftleg_data.raw <- read.csv(mypath_3)

mypath_4 <- "C:/Users/dario/Documents/Github/Cat_skin/Code/Data Analysis/Test_files for_biped_analyses/right_foot_skin.txt" 
rightleg_data.raw <- read.csv(mypath_4)

########
#DOWNSAMPLING data, and adding column names

downsample_with_labels <- function(x){                                           # downsampling funtion
   zmp_posotions_all = rep(c(1:9), times = ceiling(nrow(x)/(25*9)))              # generating label patterns
   data.downsampled = x[seq(12,nrow(x),25),]                                     # down sampling prebiped_data seq.int(from, to, by, length.out, along.with, ...)
   data.downsampled[,5] = zmp_posotions_all[1:250]                               # selecting labels to fit the prebiped_data size
   return (data.downsampled)
}

downsample_no_labels <- function(x){                                             # downsampling funtion
   data.downsampled = x[seq(12,nrow(x),25),]                                     # down sampling prebiped_data seq.int(from, to, by, length.out, along.with, ...)
   return (data.downsampled)
}

prebiped_data.raw <- downsample_with_labels(prebiped_data.raw)                   #Downsampling with labels for Force Plate Data
postbiped_data.raw <- downsample_no_labels(postbiped_data.raw)                   #Downsampling with no labels for using as grounth truth provided by Force Plate 
leftleg_data.raw <- downsample_no_labels(leftleg_data.raw)                       #Downsampling with no labels for left foot biped
rightleg_data.raw <- downsample_no_labels(rightleg_data.raw)                     #Downsampling with no labels for right foot biped


newheaders <- c("LC_1", "LC_2", "LC_3", "LC_4","ZMP_location")                   # 
colnames(prebiped_data.raw) <- newheaders

newheaders <- c("LC_1", "LC_2", "LC_3", "LC_4")                                  # 
colnames(postbiped_data.raw) <- newheaders

newheaders <- c("SL_1", "SL_2", "SL_3", "SL_4")                                  # 
colnames(leftleg_data.raw) <- newheaders

newheaders <- c("SL_5", "SL_6", "SL_7", "SL_8")                                  # 
colnames(rightleg_data.raw) <- newheaders
leftleg_data.raw[,5:8] = data.frame(rightleg_data.raw$SL_5,rightleg_data.raw$SL_6,rightleg_data.raw$SL_7,rightleg_data.raw$SL_8)                        #Joining the two feet
#leftleg_data.raw[,6] = data.frame(rightleg_data.raw$SL_6)
#leftleg_data.raw[,7] = data.frame(rightleg_data.raw$SL_7)
#leftleg_data.raw[,8] = data.frame(rightleg_data.raw$SL_8)

biped_data <- leftleg_data.raw
newheaders <- c("SL_1", "SL_2", "SL_3", "SL_4","SL_5", "SL_6", "SL_7", "SL_8")
colnames(biped_data) <- newheaders

######
# Training force plate (with KNN):
set.seed(99)                                                                     # required to reproduce the results
prebiped_data.raw['ZMP_location'] = factor(prebiped_data.raw[,'ZMP_location'])
trControl <- trainControl(method  = "cv", number  = 5)                           # 5 fold Cross-Validation
fit <- train(ZMP_location ~ .,
      method     = "knn",
      tuneGrid   = expand.grid(k = 1:20),
      trControl  = trControl,
      metric     = "Accuracy",
      data       = prebiped_data.raw)                                            # test KNN for K values: 1:20
print(fit)                                                                       # print results
print(confusionMatrix(fit))
levelplot(confusionMatrix(fit)$table)                                            # show the confusion matrix

######### 
#Using force plate as ground truth for the incoming biped data
test_pred <- predict(fit, newdata = postbiped_data.raw)                          #Labels for biped sensory data (GROUND TRUTH)
#test_pred
print(test_pred)
biped_data[,9] =  test_pred                                                      # adding labels to biped data
newheaders <- c("SL_1", "SL_2", "SL_3", "SL_4","SL_5", "SL_6", "SL_7", "SL_8","ZMP_location")
colnames(biped_data) <- newheaders

#########
# Training and testing biped

set.seed(99)                                                                     # required to reproduce the results
biped_data['ZMP_location'] = factor(biped_data[,'ZMP_location'])
trControl <- trainControl(method  = "cv", number  = 5)                           # 5 fold Cross-Validation
fit <- train(ZMP_location ~ .,
             method     = "knn",
             tuneGrid   = expand.grid(k = 1:20),
             trControl  = trControl,
             metric     = "Accuracy",
             data       = biped_data)                                            # test KNN for K values: 1:20
print(fit)                                                                       # print results
print(confusionMatrix(fit))
levelplot(confusionMatrix(fit)$table) 


# min_max_norm <- function(x) {
#    (x - min(x)) / (max(x) - min(x))
# }
# 
# prebiped_data.downsampled_norm <- as.prebiped_data.frame(lapply(prebiped_data.downsampled[1:4], min_max_norm))
# prebiped_data.downsampled_norm_sd<-lapply(prebiped_data.downsampled_norm[1:4], sd)
# 
# mean_normal_sd<-mean(unlist(prebiped_data.downsampled_norm_sd))
# mean_normal_sd

