#include "HX711.h"

// HX711 circuit wiring
const int SCK_PIN_1 =   4;
const int DOUT_PIN_1 = A3;
const int SCK_PIN_2 = 4;
const int DOUT_PIN_2 = 5;
//const int DOUT_PIN_3 = 6;


HX711 scale1;
HX711 scale2;
//HX711 scale3;

void setup() {
  Serial.begin(9600);
  scale1.begin(DOUT_PIN_1, SCK_PIN_1);
  scale1.set_gain(128);
  scale2.begin(DOUT_PIN_2, SCK_PIN_2);
  scale2.set_gain(128);
  //scale3.begin(DOUT_PIN_3, SCK_PIN);
  //scale3.set_gain(32);
 
}

void loop() {

  if (scale1.is_ready()) {
    long read1 = scale1.read();
    long read2 = scale2.read();
   // long read3 = scale3.read();
    //Serial.println("HX711 reading: ");
    Serial.println(read1+100);
    Serial.println(read2);
    //Serial.println(read3);
  } else {
    //Serial.println("HX711 not found.");
  }

  delay(50);
  
}
