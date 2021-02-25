#Initialization:
rm(list = ls());              # clear workspace variables
cat("\014")                   # clear window
library(rgl)                  
library(class)
library(ggplot2)
library(caret)                # "R package that provides general interface to +- 150 ML alg"
library("lattice")


####### 
# loading RAW files:

mypath_1 <- "C:/Users/dario/Documents/Github/Cat_skin/Data/Backup/Biped/4_points_5V_Sensors_in_Center_V2/initial_force_plate_data_2_021321.txt"   
forceplate_trainingdata <- read.csv(mypath_1)                                                   # Creating dataframe from csv file

mypath_2 <- "C:/Users/dario/Documents/Github/Cat_skin/Data/Backup/Biped/4_points_5V_Sensors_in_Center_V2/force_plate_with_biped_data_2_021321.txt"   
labels_CoP <- read.csv(mypath_2)                                                   

mypath_3 <- "C:/Users/dario/Documents/Github/Cat_skin/Data/Backup/Biped/4_points_5V_Sensors_in_Center_V2/biped_leg_test_simut_0213_2.txt" 
features_strainin_signals <- read.csv(mypath_3)

########
#DOWNSAMPLING data, and adding column names

downsample_with_labels <- function(x){                                           # downsampling funtion
   CoP_posotions_all = rep(c(1:4), times = ceiling(nrow(x)/(25*3)))              # generating label patterns
   data.downsampled = x[seq(12,nrow(x),25),]                                     # down sampling prebiped_data seq.int(from, to, by, length.out, along.with, ...)
   data.downsampled[,5] = CoP_posotions_all[1:250]                               # selecting labels to fit the prebiped_data size
   return (data.downsampled)
}

downsample_no_labels <- function(x){                                             # downsampling funtion
   data.downsampled = x[seq(12,nrow(x),25),]                                     # down sampling prebiped_data seq.int(from, to, by, length.out, along.with, ...)
   return (data.downsampled)
}

forceplate_trainingdata <- downsample_with_labels(forceplate_trainingdata)                       #Downsampling with labels for Force Plate Data
labels_CoP <- downsample_no_labels(labels_CoP)                   #Downsampling with no labels for using as ground truth provided by Force Plate 
features_strainin_signals <- downsample_no_labels(features_strainin_signals)                       #Downsampling with no labels for left foot biped

newheaders <- c("LC_1", "LC_2", "LC_3", "LC_4","CoP_location")                   
colnames(forceplate_trainingdata) <- newheaders
newheaders <- c("LC_1", "LC_2", "LC_3", "LC_4")                                  
colnames(labels_CoP) <- newheaders
biped_data <- features_strainin_signals
newheaders <- c("SL_1", "SL_2", "SL_3", "SL_4","SL_5", "SL_6", "SL_7", "SL_8")
colnames(biped_data) <- newheaders

########
#Reprocessing (normalizing)
trans_1 <- preProcess(forceplate_trainingdata, method = c("range"))
forceplate_trainingdata = predict(trans_1, forceplate_trainingdata[,1:5])
trans_2 <- preProcess(labels_CoP, method = c("range"))
labels_CoP = predict(trans_2, labels_CoP[,1:4])
trans_3 <- preProcess(biped_data, method = c("range"))
biped_data = predict(trans_3, biped_data[,1:8])

######
# Training force plate (with KNN):
set.seed(99)                                                                     # required to reproduce the results
forceplate_trainingdata['CoP_location'] = factor(forceplate_trainingdata[,'CoP_location'])
trControl <- trainControl(method  = "cv", number  = 5)                           # 5 fold Cross-Validation
fit <- train(CoP_location ~ .,
      method     = "knn",
      tuneGrid   = expand.grid(k = 1:20),
      trControl  = trControl,
      metric     = "Accuracy",
      data       = forceplate_trainingdata)                                      # test KNN for K values: 1:20
print(fit)                                                                       # print results
print(confusionMatrix(fit))
levelplot(confusionMatrix(fit)$table)                                            # show the confusion matrix

######### 
#Using force plate as ground truth for the incoming biped data
test_pred <- predict(fit, newdata = labels_CoP)                                  #Labels for biped sensory data (GROUND TRUTH)
#test_pred
print(test_pred)
biped_data[,9] =  test_pred                                                      # adding labels to biped data
newheaders <- c("SL_1", "SL_2", "SL_3", "SL_4","SL_5", "SL_6", "SL_7", "SL_8","CoP_location")
colnames(biped_data) <- newheaders

#########
# Training and testing biped
set.seed(99)                                                                     
biped_data['CoP_location'] = factor(biped_data[,'CoP_location'])
trControl <- trainControl(method  = "cv", number  = 5)                           
fit <- train(CoP_location ~ .,
             method     = "knn",
             tuneGrid   = expand.grid(k = 1:20),
             trControl  = trControl,
             metric     = "Accuracy",
             data       = biped_data)                                            
print(fit)                                                                       
print(confusionMatrix(fit))
levelplot(confusionMatrix(fit)$table) 

