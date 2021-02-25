//Code for Calibrating LoadCells
//Inspiration from : https://www.youtube.com/watch?v=nGUpzwEa4vg
//Use: 8V

#include <Wire.h>
#include <Adafruit_ADS1015.h>
Adafruit_ADS1015 ads1015(0x48);      //  GND     create four amplfiers using different address
Adafruit_ADS1015 ads1015_2(0x49);  //  VDD
Adafruit_ADS1015 ads1015_3(0x4A); // SDA       
Adafruit_ADS1015 ads1015_4(0x4B); //scl


void setup() {
  Serial.begin(9600);
  ads1015.begin();    //initializing amplifiers
  ads1015_2.begin();  
  ads1015_3.begin();  
  ads1015_4.begin(); 

}

int16_t adc0, adc1, adc2, adc3, adc4, adc5, adc6, adc7;
float count = 0;                  //it is important that this value is a float to avoid roundig problems 
float val = 0;                    // it is important that this value is a float to avoid roundig problems 

void loop() {
  count = count + 1 ; 
  ads1015.setGain(GAIN_SIXTEEN); 
  ads1015_2.setGain(GAIN_SIXTEEN);
  ads1015_3.setGain(GAIN_SIXTEEN);
  ads1015_4.setGain(GAIN_SIXTEEN);
  
  adc0 = ads1015.readADC_Differential_0_1();                  //read difference between 0 and 1 input on first amplifier
  Serial.println(adc0);

  adc1=ads1015.readADC_Differential_2_3(); 
  Serial.println(adc1);
   
  adc2=ads1015_2.readADC_Differential_0_1(); 
  Serial.println(adc2);
  
  adc3=ads1015_2.readADC_Differential_2_3(); 
  Serial.println(adc3);  

  adc4=ads1015_3.readADC_Differential_0_1(); 
  Serial.println(adc4);
 
  adc5=ads1015_3.readADC_Differential_2_3();
  Serial.println(adc5);
  
  adc6=ads1015_4.readADC_Differential_0_1(); 
  Serial.println(adc6);  
  
  adc7=ads1015_4.readADC_Differential_2_3(); 
  Serial.println(adc7);  

  /**/
  
  delay(100);


}
