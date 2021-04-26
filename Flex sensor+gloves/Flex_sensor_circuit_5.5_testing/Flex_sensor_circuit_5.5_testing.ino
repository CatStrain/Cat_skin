///https://learn.sparkfun.com/tutorials/flex-sensor-hookup-guide/all#example-circuit
//https://forum.arduino.cc/index.php?topic=89941.0
/******************************************************************************
Flex_Sensor_Example.ino
Example sketch for SparkFun's flex sensors
  (https://www.sparkfun.com/products/10264)
Jim Lindblom @ SparkFun Electronics
April 28, 2016

Create a voltage divider circuit combining a flex sensor with a 47k resistor.
- The resistor should connect from A0 to GND.
- The flex sensor should connect from A0 to 3.3V
As the resistance of the flex sensor increases (meaning it's being bent), the
voltage at A0 should decrease.

Development environment specifics:
Arduino 1.6.7
******************************************************************************/


/******************************************************************************
 * 
 * For glove project:
 * resistor for 3.3" sensor [0 degree 33.5K, 90 degree 90K] Circuit use R =43K
 * resistor for 5.4" sensor [0 degree 8.5K, 90 degree 13K] Circuit use R =10K
 */

const int FLEX_PIN_1 = A0; // Pin connected to voltage divider output
const int FLEX_PIN_2 = A1;
const int FLEX_PIN_3 = A2;
const int FLEX_PIN[] = {FLEX_PIN_1,FLEX_PIN_2,FLEX_PIN_3};

// Measure the voltage at 5V and the actual resistance of your
// 47k resistor, and enter them below:
const float VCC = 4.98; // Measured voltage of Ardunio 5V line/// could be replaced by external power with 4.98V

//set the R0
const float R_DIV[] = {10000.0,10000.0,10000.0}; // Measured resistance of 3.3" f sensor

//Thumb//Index//Middle//Ring//Little

const float STRAIGHT_RESISTANCE[] = {8500.0, 8500.0,8500.0} ; // resistance when straight
const float BEND_RESISTANCE[] = {13000.0, 13000.0,13000.0} ;  // resistance at 90 deg



void setup() 
{
  Serial.begin(9600);
  for (int i=0; i<3; i++)
  {
    pinMode(FLEX_PIN[i], INPUT);
  }
}
void loop() 
{
  // Read the ADC, and calculate voltage and resistance from it
  //int ADCs = FLEX_PIN;
  int flexADC[] = {0,0,0};
  float flexV[] = {0.0,0.0,0.0};
  float angle[] = {0.0,0.0,0.0};
  
//  for (int i=0; i<3; i++)
//  {
//    flexADC[i] = analogRead(FLEX_PIN[i]);
//    flexV[i] = flexADC[i] * VCC / 1023.0;
//    float flexR[i] = {R_DIV[i] * (VCC / flexV[i] - 1.0)};
//    angle[i] = map(flexADC[i], 572, 225,
//                   0, 180.0);
//  }
    //Serial.println("Thumb-Index-Middle-Ring-Little");
   Serial.println("Bend: " + String(angle[0]) + " degrees");
   Serial.println("Bend: " + String(flexADC[0]) + " degrees");
   // Serial.println("Bend: " + String(angle[1]) + " degrees");
  //  Serial.println("Bend: " + String(angle[2]) + " degrees");
    Serial.println();

    delay(100);
}


//  int flexADC[] = analogRead(FLEX_PIN[]);
  //int flexADC_2 = analogRead(FLEX_PIN_2);
  
 // float flexV = flexADC * VCC / 1023.0;
 // float flexR = R_DIV * (VCC / flexV - 1.0);

 
 // float flexR = R_DIV * (1023/flexADC - 1.0);







  
  //Serial.println("Resistance: " + String(flexR) + " ohms");
  //Serial.println("Resistance: " + String(flexR) + " ohms");
  // Use the calculated resistance to estimate the sensor's
  // bend angle:












/*
 * int leds[] = {12,11,10};

void setup()
{
  for (int i=0; i<3; i++)
  {
    pinMode(leds[i], OUTPUT);
  }

}
