# CatSkin

This repository contains the code to calculate the Center of Pressure (CoP) of a biped based on skin strain signals. The included code: 

  ## Amplifier(HX711+ads1015)
  this folder contains Arduino code for [skin project]
  ### ADS1015+loadcell
<Amplifier__calibration.ino> + <Amplifier_calibration_0210.ino>  are for the LC and band calibration

<Amplifier_band_0105_band_and_LC.ino> band(with strain gauge) + spring ligament

![image](https://user-images.githubusercontent.com/65510682/116017132-975ca800-a5f3-11eb-927f-e97a5043c751.png)

<Amplifier_band_0219_single_16.ino> + <Amplifier_band_0208_biped.ino> are for single leg and biped legs (skin version and band version)

For experiment and testing, please check the 'code' folder



  ### Flex sensor+gloves
this folder contains Arduino code for [Hand project]

Those are for flex sensor attached to the glove:

<Flex_sensor_circuit>

<Flex_sensor_circuit_5.5_>

<Flex_sensor_circuit_5.5_testing>

<Flex_sensor_circuit_single_glove>

<Flex_sensor_circuit_single_glove_extra_sensor>

<Flex_sensor_circuit_single_glove_right_hand> ** sensors attached to gloves with foam hand


#### Clone the repositoy in your computer by typing in the command line:


```sh
git clone https://github.com/CatStrain/Cat_skin.git
```

   [DAQ]: <https://github.com/CatStrain/Cat_skin/tree/master/Code/Sensor_Calibration_and_DAQ_Arduino>
   [DAnalysis]: <https://github.com/CatStrain/Cat_skin/tree/master/Code/Data%20Analys>
   
