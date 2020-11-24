//Code for Calibrating LoadCells
//Inspiration from : https://www.youtube.com/watch?v=nGUpzwEa4vg
//Use: 8V

#include <Wire.h>
#include <Adafruit_ADS1015.h>
Adafruit_ADS1015 ads1015(0x48);      //create four amplfiers using different address
Adafruit_ADS1015 ads1015_2(0x49);  
Adafruit_ADS1015 ads1015_3(0x4A);  //Adafruit_ADS1015 ads1015_4(0x4B);


void setup() {
  Serial.begin(9600);
  ads1015.begin();    //initializing amplifiers
  ads1015_2.begin();  
  ads1015_3.begin();  

}

int16_t adc0_1, adc0_2, adc1, adc2, adc3, adc4, adc5; // adc6, adc7;
int extra_gain = 5;
float count = 0;                  //it is important that this value is a float to avoid roundig problems 
float val = 0;                    // it is important that this value is a float to avoid roundig problems 

void loop() {
  count = count + 1 ; 
  ads1015.setGain(GAIN_SIXTEEN); 
  ads1015_2.setGain(GAIN_SIXTEEN);
  ads1015_3.setGain(GAIN_SIXTEEN);

  /*
  adc0 = ads1015.readADC_Differential_0_1();                  //read difference between 0 and 1 input on first amplifier
  //val = ((count-1)/count) * val + (1/count)*adc0;           // to get average reading value when no load
  adc0=adc0-1;
  val=(adc0/1.0f)*70.0f;
  Serial.println(val);
  */
  
  adc0_1 = ads1015_3.readADC_Differential_0_1();                  
  //val = ((count-1)/count) * val + (1/count)*adc0_1;           
  //adc0=adc0_1-1;
  //val=(adc0_1/1.0f)*70.0f;
  adc0_1 = adc0_1 * extra_gain;
  Serial.println(adc0_1);
 
 
  adc0_2 = ads1015_3.readADC_Differential_2_3();                  
  //val = ((count-1)/count) * val + (1/count)*adc0;           
  //adc0_2=adc0_2-1;
  //val=(adc0_2/1.0f)*70.0f;
  adc0_2 = adc0_2 * extra_gain;
  Serial.println(adc0_2);
  
  adc1=ads1015.readADC_Differential_2_3(); 
  //val = ((count-1)/count) * val + (1/count)*adc1; 
  adc1=adc1+4;
  val=(adc1/1.0f)*50.0f;
  Serial.println(val);
   
  adc2=ads1015_2.readADC_Differential_0_1(); 
  //val = ((count-1)/count) * val + (1/count)*adc2; 
  adc2=adc2-.8f;
  val=(adc2/1.0f)*70.0f;
  Serial.println(val);
 
  adc3=ads1015_2.readADC_Differential_2_3();
  //val = ((count-1)/count) * val + (1/count)*adc3;
  adc3=adc3+4.0f; 
  val=(adc3/1.0f)*60.0f;
  Serial.println(val);
  /**/
  delay(100);


}
