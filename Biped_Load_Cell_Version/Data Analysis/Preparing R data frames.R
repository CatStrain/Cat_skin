#KNN to leg movement data
rm(list = ls()); # clear workspace variables
cat("\014") # it means ctrl+L. clear window

zmp_posotion <- 1
flag_distance <- 25
distance <- 1

mypath_1 <- "~/Github/Cat_skin/Biped_Load_Cell_Version/Data Analysis/CSV files/test_120420_4.csv"
zmp_locations.data <- read.csv(mypath_1)

simple_zmp_locations.data <- as.data.frame(matrix(0, ncol = 5, nrow = (nrow(zmp_locations.data)/25)))
simple_zmp_row <-1

x = replicate(nrow(zmp_locations.data), 0)

for (i in 1:nrow(zmp_locations.data)) {         # Going through all the rows
  zmp_locations.data[i,5] <- zmp_posotion
  if(distance == flag_distance){                      # To determine change of position label
    zmp_posotion <- zmp_posotion+1
    if (zmp_posotion == 10){
      zmp_posotion <- 1
    }
  }
  if(distance == (12)){                   #To pick only one line of data recorded per position
    for (j in 1:ncol(zmp_locations.data)){
      simple_zmp_locations.data[simple_zmp_row,j] <- zmp_locations.data[i,j]
    }
    simple_zmp_row <- simple_zmp_row+1
  }
  distance <- distance+1
  if (distance == 26){
    distance <- 1
  }
    
}

newheaders <- c("LC_1", "LC_2", "LC_3", "LC_4","ZMP_location")
colnames(simple_zmp_locations.data) <- newheaders

save(simple_zmp_locations.data,file="simple_zmp_locations_exp_4.Rda")



##################################################################################################


