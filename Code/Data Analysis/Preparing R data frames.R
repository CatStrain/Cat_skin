#Initialization:
#####
rm(list = ls());              # clear workspace variables
cat("\014")                   #clear window

                              # ZMP positions will be added to blocks of rows, each block can be called "step"

zmp_posotion <- 1             #used to add label to data, every "step" consists on the block of data lines correspondent to one position of the ZMP
zmp_posotion_limit = 9        #up to what label will it be added to data
flag_distance <- 25           #STEP SIZE (the flag moves through each step)
distance <- 1                 #to count lines of every step 

#CHANGE Following line to process another file  (file name), also lines #2(file name) and #3 (file name) 
#1 (file name):
setwd("~/Github/Cat_skin/Data/Backup/Data collection_0106")
mypath_1 <- "~/Github/Cat_skin/Data/Backup/Data collection_0106/test_0106_random_3.csv"   
zmp_locations.data <- read.csv(mypath_1)              #Creating data frame from data csv file
#####
#DOWNSAMPLING DATA:
######
simple_zmp_locations.data <- as.data.frame(matrix(0, ncol = 5, nrow = (nrow(zmp_locations.data)/25)))   #creating matrix with 0s for downsampled data
simple_zmp_row <-1            #counter

for (i in 1:nrow(zmp_locations.data)) {               # Going through all the rows of the data fram
  zmp_locations.data[i,5] <- zmp_posotion             # Adding label to the fifth column of the data file
  #assigning zmp position to block of rows (STEPS):
  if(distance == flag_distance){                      # To determine change of zmp position, each zmp position need to be hold 25 steps
    zmp_posotion <- zmp_posotion+1                    # Change the ZMP position
    if (zmp_posotion == (zmp_posotion_limit+1)){      # If ZMP has reached the limit value: reset the zmp position
      zmp_posotion <- 1
    }
  }
  #filling downsampled data frame:
  if(distance == (12)){                               # To pick only one line of data recorded per zmp position
    for (j in 1:ncol(zmp_locations.data)){            # Picking every single column of the selected row
      simple_zmp_locations.data[simple_zmp_row,j] <- zmp_locations.data[i,j]
    }
    simple_zmp_row <- simple_zmp_row+1                #increasing the value of the downsampled data row
  }
  
  distance <- distance+1
  if (distance == 26){                                #Resetting distance
    distance <- 1
  }
    
}

newheaders <- c("LC_1", "LC_2", "LC_3", "LC_4","ZMP_location")   #To Add headers to the downslampled data
colnames(simple_zmp_locations.data) <- newheaders
######
# Creating new data frames and Rda files with downsampled data
######
#2(file name): 
test_0106_random_3.data <- simple_zmp_locations.data                #CHANGE THIS FOR NEW FILE (data frame name)
#3 (file name):
save(test_0106_random_3.data,file="test_0106_random_3.Rda") #CHANGE THIS FOR NEW FILE  (data frame and file name)


##################################################################################################

