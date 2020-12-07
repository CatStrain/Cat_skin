#KNN to leg movement data
rm(list = ls()); # clear workspace variables
cat("\014") # it means ctrl+L. clear window

mypath_1 <- "~/Github/Cat_skin/Biped_Load_Cell_Version/Data Analysis/CSV files/test_120420_1.csv"
zmp_locations_exp_1.data <- read.csv(mypath_1)


x = replicate(nrow(zmp_locations_exp_1.data), 0)
count <- 1

for (i in 1:nrow(zmp_locations_exp_1.data)) {
  zmp_locations_exp_1.data[i,5] <- count
  
  count<-count+1
  if (count == 10){
    count <- 1
  }
    
}

newheaders <- c("LC_1", "LC_2", "LC_3", "LC_4","ZMP_location")
colnames(zmp_locations_exp_1.data) <- newheaders

#zmp_locations_exp_1.data$label <- c(x)


#zmp_locations_exp_1.data$label=label


##################################################################################################




#Separate class and data
iris.class <- iris.data[,c("species")] #Actual classes
iris.data <- iris.data[,c("sepal_length","sepal_width","petal_length","petal_width")]

head(iris.data)
#View(iris.data)

par(mfrow=c(2,3), mar=c(5,4,2,2))
plot(iris.data[c("sepal_length","sepal_width")])# Plot to see how Sepal.Length and Sepal.Width data points have been distributed in clusters
plot(iris.data[c("petal_length","petal_width")])# Plot to see how Petal.Length and Petal.Width data points have been distributed in clusters
plot(iris.data[c("sepal_length","petal_length")])
plot(iris.data[c("sepal_length","petal_width")])
plot(iris.data[c("sepal_width","petal_length")])
plot(iris.data[c("sepal_width","petal_width")])

#Example visualize the data first on two dimension

#Create a function
normalize <- function(x){
  return ((x-min(x))/(max(x)-min(x)))
}

#Normalization
iris.data$sepal_length <- normalize(iris.data$sepal_length)
iris.data$sepal_width <- normalize(iris.data$sepal_width)
iris.data$petal_length <- normalize(iris.data$petal_length)
iris.data$petal_width <- normalize(iris.data$petal_width)
head(iris.data) #normalize the values to be within (0-1)

summary(iris.data)  #Summary of normalized iris.data 

k <- 3 #No. clusters
result<- kmeans(iris.data,k,iter.max=10,nstart=1)
str(result) #Compactly Display the Structure of an Arbitrary R Object
result$size
result$centers #4 dimensions
result$cluster

#Plot results, use scatter plot
# 4 attributes, 6 combinations
par(mfrow=c(2,3), mar=c(5,4,2,2))
plot(iris.data[c("sepal_length","sepal_width")], col=result$cluster)# Plot to see how Sepal.Length and Sepal.Width data points have been distributed in clusters
plot(iris.data[c("petal_length","petal_width")], col=result$cluster)# Plot to see how Petal.Length and Petal.Width data points have been distributed in clusters
plot(iris.data[c("sepal_length","petal_length")], col=result$cluster)
plot(iris.data[c("sepal_length","petal_width")], col=result$cluster)
plot(iris.data[c("sepal_width","petal_length")], col=result$cluster)
plot(iris.data[c("sepal_width","petal_width")], col=result$cluster)


# Choose the number of clusters k= 1-5
k.values <- 1:10
#Do for loops for different k-values
tot.withinss.k <- rep(0,length(k.values))
count <-1
for (val in k.values) {
  result<-kmeans(iris.data,val,iter.max=10,nstart=1)
  
  tot.withinss.k[count]<-result$tot.withinss #calculating the within sum of sqrs
  count<-count+1
}

graphics.off() # close all plots
plot(k.values, tot.withinss.k,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")

#Accuracy (Correction)

#In class exercise #############################################################

#Knn
#
set.seed(99) # required to reproduce the results
rnum<- sample(rep(1:150)) # randomly generate numbers from 1 to 150
id.training <- rnum[1:130] #Choose training set
id.test <- rnum[131:150] #Choose test set



#Training & test sets
iris.train<- iris.data[id.training,]
iris.train.target<- iris.class[id.training]
iris.test<- iris.data[id.test,]
iris.test.target<- iris.class[id.test]


#Use knn function
#?knn
#install.packages("class")
library(class)

# Use this line if R cannot find knn (?knn shows nothing)
#.rs.restartR()


model1<- knn(train=iris.train, test=iris.test, cl=iris.train.target, k=16)

#Model accuracy : create the confucion matrix
tb <- table(iris.test.target, model1)
tb
accuracy <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}
accuracy(tb)

#Determine k using accuracy function

k.neighbor.values <- c(2,4,6,8,10,12,14,16,18,20) #which is better?

accuracy.k <- rep(0,length(k.neighbor.values))
count <-1
for (val in k.neighbor.values) {
  model1<- knn(train=iris.train, test=iris.test, cl=iris.train.target, k=val)
  tb <- table(iris.test.target, model1)
  
  accuracy.k[count]<-accuracy(tb)
  count<-count+1
}

graphics.off() # close all plots
plot(k.neighbor.values, accuracy.k,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of nearest neighbors K",
     ylab="Model Accuracy")





