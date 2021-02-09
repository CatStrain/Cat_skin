#Code to test accuracy of the CoP Force Plate 

#Initialization:
rm(list = ls());              # clear workspace variables
cat("\014")                   # clear window
library(rgl)                  # loading libraries
library(class)
library(ggplot2)
library(caret)                # "R package that provides general interface to +- 150 ML alg"
library("lattice")

correct_predictions = 0;
incorrect_predictions = 0;

####### 
# loading RAW files:

mypath_1 <- "C:/Users/dario/Documents/Github/Cat_skin/Code/Data Analysis/Test_files for_biped_analyses/CoP_plate_1_prebiped_provitional.txt"   
initial_force_plate <- read.csv(mypath_1)                                                   # Creating prebiped_data frame from prebiped_data csv file

mypath_2 <- "C:/Users/dario/Documents/Github/Cat_skin/Code/Data Analysis/Test_files for_biped_analyses/CoP_plate_2_postbiped_provitional.txt"   
secondary_force_plate <- read.csv(mypath_2)                                                   # Creating prebiped_data frame from prebiped_data csv file

########
#DOWNSAMPLING data, and adding column names

downsample_with_labels <- function(x){                                          # downsampling funtion
  zmp_posotions_all = rep(c(1:9), times = ceiling(nrow(x)/(25*9)))              # generating label patterns
  data.downsampled = x[seq(12,nrow(x),25),]                                     # down sampling prebiped_data seq.int(from, to, by, length.out, along.with, ...)
  data.downsampled[,5] = zmp_posotions_all[1:250]                               # selecting labels to fit the prebiped_data size
  return (data.downsampled)
}

downsample_no_labels <- function(x){                                            # downsampling funtion
  data.downsampled = x[seq(12,nrow(x),25),]                                     # down sampling prebiped_data seq.int(from, to, by, length.out, along.with, ...)
  return (data.downsampled)
}

initial_force_plate <- downsample_with_labels(initial_force_plate)                   #Downsampling with labels for Force Plate Data
secondary_force_plate <- downsample_no_labels(secondary_force_plate)                   #Downsampling with no labels for using as grounth truth provided by Force Plate 

newheaders <- c("LC_1", "LC_2", "LC_3", "LC_4","ZMP_location")                   # 
colnames(initial_force_plate) <- newheaders

newheaders <- c("LC_1", "LC_2", "LC_3", "LC_4")                                  # 
colnames(secondary_force_plate) <- newheaders


######
# Training force plate (with KNN):
set.seed(99)                                                                     # required to reproduce the results
initial_force_plate['ZMP_location'] = factor(initial_force_plate[,'ZMP_location'])
trControl <- trainControl(method  = "cv", number  = 5)                           # 5 fold Cross-Validation
fit <- train(ZMP_location ~ .,
             method     = "knn",
             tuneGrid   = expand.grid(k = 1:20),
             trControl  = trControl,
             metric     = "Accuracy",
             data       = initial_force_plate)                                            # test KNN for K values: 1:20
print(fit)                                                                       # print results
print(confusionMatrix(fit))
levelplot(confusionMatrix(fit)$table)                                            # show the confusion matrix

######### 
#Using force plate as ground truth for the incoming biped data
test_pred <- predict(fit, newdata = secondary_force_plate)                          #Labels for biped sensory data (GROUND TRUTH)
#test_pred
#print(test_pred)

for(i in 1:length(initial_force_plate$ZMP_location)) {
  if (initial_force_plate[i,5] == test_pred[i]){
    correct_predictions = correct_predictions + 1 
  }
  else{
    incorrect_predictions = incorrect_predictions + 1 
  }
    
  different
}

force_plate_prediction_accuracy = correct_predictions/length(initial_force_plate$ZMP_location);
