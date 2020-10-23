//This code is used to receive data from eight strain gauges which are connected to four amplfiers, and then print them to the serial port for further use.

#include <Wire.h>
#include <Adafruit_ADS1015.h>
Adafruit_ADS1015 ads1015(0x48);      //create four amplfiers using different address
Adafruit_ADS1015 ads1015_2(0x49);  Adafruit_ADS1015 ads1015_3(0x4A);  Adafruit_ADS1015 ads1015_4(0x4B);


void setup() {
  Serial.begin(9600);
  Serial.println("Hello");
  Serial.println("Getting diferential readings");
  Serial.println("ADC Range: +/- 6.144V (1 bit = 3mV)");
  
  ads1015.begin();    //start four amplfiers
  ads1015_2.begin();    
  //ads1015_3.begin();   ads1015_4.begin();
}

void loop() {
  int16_t adc0, adc1, adc2, adc3;  //, adc4, adc5, adc6, adc7;
  ads1015.setGain(GAIN_SIXTEEN);  //set gain. default is twothirds. 
  ads1015_2.setGain(GAIN_SIXTEEN);

  
  //adc0 = ads1015.readADC_SingleEnded(0);
  //adc1 = ads1015.readADC_SingleEnded(1);
  //adc2 = ads1015.readADC_SingleEnded(2);
  //adc3 = ads1015.readADC_SingleEnded(3);
  //Serial.print("AIN0: "); Serial.println(adc0);
  //Serial.print("AIN1: "); Serial.println(adc1);
  //Serial.print("AIN2: "); Serial.println(adc2);
  //Serial.print("AIN3: "); Serial.println(adc3);
  //Serial.println(" ");
  
  
  adc0=ads1015.readADC_Differential_0_1(); //read difference between 0 and 1 input on first amplifier
  Serial.println(adc0);
  adc1=ads1015.readADC_Differential_2_3(); //read difference between 2 and 3 input on first amplifier
  Serial.println(adc1);

  adc2=ads1015_2.readADC_Differential_0_1(); //read difference between 0 and 1 input on first amplifier
  Serial.println(adc2);
  adc3=ads1015_2.readADC_Differential_2_3(); //read difference between 2 and 3 input on first amplifier
  Serial.println(adc3);
  
//  adc2=ads1015_2.readADC_Differential_0_1();// second amplifier
//  Serial.println(adc2);
//  adc3=ads1015_2.readADC_Differential_2_3();
//  Serial.println(adc3);
//
//  adc4=ads1015_3.readADC_Differential_0_1();
//  Serial.println(adc4);
//  adc5=ads1015_3.readADC_Differential_2_3();
//  Serial.println(adc5);
//
//  adc6=ads1015_4.readADC_Differential_0_1();
//  Serial.println(adc6);
//  adc7=ads1015_4.readADC_Differential_2_3();
//  Serial.println(adc7);

  
  delay(100);


}
