rm(list = ls()); # clear workspace variables
cat("\014") # it means ctrl+L. clear window
library(rgl)

load("simple_zmp_locations_exp_2.Rda")
simple_zmp_locations_exp_2.data <- simple_zmp_locations_exp_2.data[,c("LC_1","LC_2","LC_3","LC_4")]
zmp.class <- simple_zmp_locations_exp_2.data[,c("ZMP_location")] #Actual classes

zmp.class<-as.data.frame(zmp.class)

