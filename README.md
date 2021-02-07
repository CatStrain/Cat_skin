# CatSkin

This repository contains the code to calculate the Center of Pressure (CoP) of a biped based on skin strain signals. The included code: 

  - Data acqusitions (GitHub: [DAQ])
  
        -Record data from strain gauges on a skin using C++ and MATLAB code
        
  - Data Analysis (GitHub: [DAnalysis])
  
        -K-Nearest-Neighbor (KNN) approach to train and test the biped's CoP preciction accuracy
        -5-Fold Cross-Validation to assess the validity of our estimator 


#### Clone the repositoy in your computer by typing in the command line:


```sh
git clone https://github.com/CatStrain/Cat_skin.git
```

   [DAQ]: <https://github.com/CatStrain/Cat_skin/tree/master/Code/Sensor_Calibration_and_DAQ_Arduino>
   [DAnalysis]: <https://github.com/CatStrain/Cat_skin/tree/master/Code/Data%20Analys>
   
