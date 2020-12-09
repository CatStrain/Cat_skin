rm(list = ls()); # clear workspace variables
cat("\014") # it means ctrl+L. clear window
library(rgl)

load("simple_zmp_locations_exp_2.Rda")
zmp.class <- simple_zmp_locations_exp_2.data[,c("ZMP_location")] #Actual classes
simple_zmp_locations_exp_2.data <- simple_zmp_locations_exp_2.data[,c("LC_1","LC_2","LC_3","LC_4")]

zmp.class <- as.data.frame(zmp.class)

set.seed(99) # required to reproduce the results
rnum<- sample(rep(1:250)) # randomly generate numbers from 1 to 150
id.training <- rnum[1:200] #Choose training set
id.test <- rnum[201:250] #Choose test set

zmp.train<- simple_zmp_locations_exp_2.data[id.training,]
zmp.train.target<- zmp.class[id.training,]
zmp.test<- simple_zmp_locations_exp_2.data[id.test,]
zmp.test.target<- zmp.class[id.test,]

library(class)

model1<- knn(train=zmp.train, test=zmp.test, cl=zmp.train.target, k=22)
tb <- table(zmp.test.target, model1)
tb
accuracy <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}
accuracy(tb)

k.neighbor.values <- c(2,4,6,8,10,12,14,16,18,20) #which is better?

accuracy.k <- rep(0,length(k.neighbor.values))
count <-1
for (val in k.neighbor.values) {
  model1<- knn(train=zmp.train, test=zmp.test, cl=zmp.train.target, k=val)
  tb <- table(zmp.test.target, model1)
  
  accuracy.k[count]<-accuracy(tb)
  count<-count+1
}

graphics.off() # close all plots
plot(k.neighbor.values, accuracy.k,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of nearest neighbors K",
     ylab="Model Accuracy")
