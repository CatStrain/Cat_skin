#include "HX711.h"

HX711 scale0(A1, A0);
//HX711 scale1(A2, A0);
//HX711 scale2(A3, A0);

#define SENSORCNT 3
HX711 *scale[SENSORCNT];

void setup()
{
  Serial.begin(9600); 
  scale.set_gain(32);
  scale[0] = &scale0;
  scale[1] = &scale1;
  scale[2] = &scale2;
}

void loop()
{
for (uint8_t i = 0; i < SENSORCNT; i++)
{
long read = scale[i]->read();
value[i] = (read - scale[i]->get_offset()) / scale[i]->get_scale();
Serial.println(" ");
Serial.println(read);
Serial.println(" ");
Serial.println(value[i], 1);
}
...
}
