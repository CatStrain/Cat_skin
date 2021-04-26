
#include "HX711.h"

#define CLK A0      // clock pin to the load cell amp(or seperate)
#define DOUT1 A1    // data pin to the first lca
#define DOUT2 A2    // data pin to the second lca
#define DOUT3 A3    // data pin to the third lca

HX711 scale(A2,A3); // pin2 is sck and pin3 is DT
long int values = 0; 
void setup()
{
  Serial.begin(9600); 
  scale.set_gain(32);
}
 
void loop()
{
 //values = scale.read(); 
//Serial.println(values); 
Serial.println(scale.read());
delay(500); 
}
