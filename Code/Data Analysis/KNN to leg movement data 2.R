#KNN for leg movement data
#Initialization:
#####
rm(list = ls()); # clear workspace variables
cat("\014") # it means ctrl+L. clear window
library(rgl)
library(class)
library(ggplot2)
library("lattice")

setwd("~/Github/Cat_skin/Data/Backup/Data collection_0106")
load("test_0106_random_3.Rda")

#Change this line to analyze different files:
simple_zmp_locations.data <-test_0106_random_3.data
#####
#Creating training and testing classes:
#####
zmp.class <- simple_zmp_locations.data[,c("ZMP_location")]                              # Actual classes ZMP locations
simple_zmp_locations.data <- simple_zmp_locations.data[,c("LC_1","LC_2","LC_3","LC_4")] # Data without class

zmp.class <- as.data.frame(zmp.class)

set.seed(99)                  # required to reproduce the results
rnum<- sample(rep(1:250))     # randomly generate numbers from 1 to 250
id.training <- rnum[1:200]    #Choose training set
id.test <- rnum[201:250]      #Choose test set

#Select data rows depending on the previously randomly generated arrays:

zmp.train<- simple_zmp_locations.data[id.training,]
zmp.train.target<- zmp.class[id.training,]
zmp.test<- simple_zmp_locations.data[id.test,]
zmp.test.target<- zmp.class[id.test,]
#####
#K Means
#####
model1<- knn(train=zmp.train, test=zmp.test, cl=zmp.train.target, k=3)     #Running KNN
tb <- table(zmp.test.target, model1)                                        #confusion matrix (only numbers)
tb                                                                          #display confusion matrix
accuracy <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}               #Prediction accuracy
accuracy(tb)

tb= as.matrix(tb)
#####
#Normalizing confusion matrix and generating colored one: 
#####
normalize <- function(x){                                                 #Normalize funtion
  return ((x-min(x))/(max(x)-min(x)))
}

for (i in 1:nrow(tb)){                                                    #Normalizing tb matrix
  tb[,c(i)]<-normalize(tb[,c(i)])
}

levelplot( t(tb[c(nrow(tb):1) , ]),
           col.regions=rev(heat.colors(100)))                             #Colored confusion Matirx

#####
#Testing for different values of k:
#####
k.neighbor.values <- c(2,4,6,8,10,12,14,16,18,20)                         #array for testing different k values

accuracy.k <- rep(0,length(k.neighbor.values))                            #to store accuracy values for k different values
count <-1
for (val in k.neighbor.values) {                                          #Testing knn for different k values 
  model1<- knn(train=zmp.train, test=zmp.test, cl=zmp.train.target, k=val)
  tb <- table(zmp.test.target, model1)
  
  accuracy.k[count]<-accuracy(tb)
  count<-count+1
}

#graphics.off() # close all plots

plot(k.neighbor.values, accuracy.k,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of nearest neighbors K",
     ylab="Model Accuracy")
#####

