#KNN to leg movement data
rm(list = ls()); # clear workspace variables
cat("\014") # it means ctrl+L. clear window

load("simple_zmp_locations_exp_1.Rda")
load("simple_zmp_locations_exp_2.Rda")
load("simple_zmp_locations_exp_3.Rda")
load("simple_zmp_locations_exp_4.Rda")

#View(simple_zmp_locations_exp_2.data)

##################################################################################################




#Separate class and data
zmp.class <- simple_zmp_locations_exp_2.data[,c("ZMP_location")] #Actual classes
simple_zmp_locations_exp_2.data <- simple_zmp_locations_exp_2.data[,c("LC_1","LC_2","LC_3","LC_4")]

head(simple_zmp_locations_exp_2.data)
#View(simple_zmp_locations_exp_2.data)

par(mfrow=c(2,3), mar=c(5,4,2,2))
plot(simple_zmp_locations_exp_2.data[c("LC_1","LC_2")])# Plot to see how LC_1 and LC_2 data points have been distributed in clusters
plot(simple_zmp_locations_exp_2.data[c("LC_3","LC_4")])
plot(simple_zmp_locations_exp_2.data[c("LC_1","LC_3")])
plot(simple_zmp_locations_exp_2.data[c("LC_1","LC_4")])
plot(simple_zmp_locations_exp_2.data[c("LC_2","LC_3")])
plot(simple_zmp_locations_exp_2.data[c("LC_2","LC_4")])

#Example visualize the data first on two dimension

#Create a function
normalize <- function(x){
  return ((x-min(x))/(max(x)-min(x)))
}

#Normalization
simple_zmp_locations_exp_2.data$LC_1 <- normalize(simple_zmp_locations_exp_2.data$LC_1)
simple_zmp_locations_exp_2.data$LC_2 <- normalize(simple_zmp_locations_exp_2.data$LC_2)
simple_zmp_locations_exp_2.data$LC_3 <- normalize(simple_zmp_locations_exp_2.data$LC_3)
simple_zmp_locations_exp_2.data$LC_4 <- normalize(simple_zmp_locations_exp_2.data$LC_4)
head(simple_zmp_locations_exp_2.data) #normalize the values to be within (0-1)

summary(simple_zmp_locations_exp_2.data)  #Summary of normalized simple_zmp_locations_exp_2.data 

k <- 9 #No. clusters
result<- kmeans(simple_zmp_locations_exp_2.data,k,iter.max=10,nstart=1)
str(result) #Compactly Display the Structure of an Arbitrary R Object
result$size
result$centers #4 dimensions
result$cluster

#Plot results, use scatter plot
# 4 attributes, 6 combinations
par(mfrow=c(2,3), mar=c(5,4,2,2))
plot(simple_zmp_locations_exp_2.data[c("LC_1","LC_2")], col=result$cluster)# Plot to see how Sepal.Length and Sepal.Width data points have been distributed in clusters
plot(simple_zmp_locations_exp_2.data[c("LC_3","LC_4")], col=result$cluster)# Plot to see how Petal.Length and Petal.Width data points have been distributed in clusters
plot(simple_zmp_locations_exp_2.data[c("LC_1","LC_3")], col=result$cluster)
plot(simple_zmp_locations_exp_2.data[c("LC_1","LC_4")], col=result$cluster)
plot(simple_zmp_locations_exp_2.data[c("LC_2","LC_3")], col=result$cluster)
plot(simple_zmp_locations_exp_2.data[c("LC_2","LC_4")], col=result$cluster)


# # Choose the number of clusters k= 1-5
# k.values <- 1:10
# #Do for loops for different k-values
# tot.withinss.k <- rep(0,length(k.values))
# count <-1
# for (val in k.values) {
#   result<-kmeans(simple_zmp_locations_exp_2.data,val,iter.max=10,nstart=1)
#   
#   tot.withinss.k[count]<-result$tot.withinss #calculating the within sum of sqrs
#   count<-count+1
# }
# 
# graphics.off() # close all plots
# plot(k.values, tot.withinss.k,
#      type="b", pch = 19, frame = FALSE, 
#      xlab="Number of clusters K",
#      ylab="Total within-clusters sum of squares")

#Accuracy (Correction)

#In class exercise #############################################################

#Knn
#
set.seed(99) # required to reproduce the results
rnum<- sample(rep(1:150)) # randomly generate numbers from 1 to 150
id.training <- rnum[1:130] #Choose training set
id.test <- rnum[131:150] #Choose test set



#Training & test sets
zmp.train<- simple_zmp_locations_exp_2.data[id.training,]
zmp.train.target<- zmp.class[id.training]
zmp.test<- simple_zmp_locations_exp_2.data[id.test,]
zmp.test.target<- zmp.class[id.test]


#Use knn function
#?knn
#install.packages("class")
library(class)

# Use this line if R cannot find knn (?knn shows nothing)
#.rs.restartR()


model1<- knn(train=zmp.train, test=zmp.test, cl=zmp.train.target, k=16)

#Model accuracy : create the confucion matrix
tb <- table(zmp.test.target, model1)
tb
accuracy <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}
accuracy(tb)

#Determine k using accuracy function

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





