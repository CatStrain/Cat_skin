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
const int FLEX_PIN_4 = A3;
const int FLEX_PIN_5 = A4;
const int FLEX_PIN_6 = A5;
const int FLEX_PIN[] = {FLEX_PIN_1, FLEX_PIN_2, FLEX_PIN_3, FLEX_PIN_4, FLEX_PIN_5, FLEX_PIN_6};

// Measure the voltage at 5V and the actual resistance of your
// 47k resistor, and enter them below:
const float VCC = 4.98; // Measured voltage of Ardunio 5V line/// could be replaced by external power with 4.98V

const float R_DIV_1 = 43000.0; // Measured resistance of 3.3" f sensor
const float R_DIV_2 = 10000.0; // Measured resistance of 5.5" f sensor ** resistor does not affect much of the result


// Upload the code, then try to adjust these values to more
// accurately calculate bend degree.
/* STRAIGHT_RESISTANCE = SR
 * BEND_RESISTANCE = BR
 */
//const float STRAIGHT_RESISTANCE = 8500.0; // resistance when straight [5.5" flex sensor]
//const float BEND_RESISTANCE = 13000.0; // resistance at 90 deg [5.5" flex sensor]
//const float STRAIGHT_RESISTANCE = 335000.0; // resistance when straight [3.3" flex sensor]
//const float BEND_RESISTANCE = 90000.0; // resistance at 90 deg [3.3" flex sensor]

void setup() 
{
  Serial.begin(9600);
  for (int i=0; i<8; i++)
  {
    pinMode(FLEX_PIN[i], INPUT);
  }
}

void loop() 
{
    
  // 1.Read the ADC, and calculate voltage and resistance from it
  int flexADC[] = {0,0,0,0,0,0};
  float angle[] = {0.0,0.0,0.0,0.0,0.0,0.0};

  //int ADCs = FLEX_PIN; using for loop:
  for (int i=0; i<8; i++)
  {
    flexADC[i] = analogRead(FLEX_PIN[i]);
  }
  
  // 2. set and adjust the angle setting by the reading results: angle[i] = map(flexADC[i], 'flat ADC', '180//90 degree ADC', 0, 180.0);
  // need to calibrate every time before testing  
    angle[0] = map(flexADC[0], 516, 466, 0, 90.0);
    angle[1] = map(flexADC[1], 536, 438, 0, 90.0);
    angle[2] = map(flexADC[2], 546, 407, 0, 90.0);
    angle[3] = map(flexADC[3], 535, 440, 0, 90.0);
    angle[4] = map(flexADC[4], 544, 469, 0, 90.0);
    angle[5] = map(flexADC[5], 603, 560, 0, 90.0);
  
  //Serial.println("Resistance: " + String(flexR) + " ohms");
  //Serial.println("Resistance: " + String(flexR) + " ohms");
  // Use the calculated resistance to estimate the sensor's
  // bend angle:
//  //3. testing the bend angle:
//  Serial.println(String(flexADC[0]));
//  Serial.println(String(flexADC[1]));
//  Serial.println(String(flexADC[2]));
//  Serial.println(String(flexADC[3]));
//  Serial.println(String(flexADC[4]));
//  Serial.println(String(flexADC[5]));
//  
//  Serial.println("Bend: " + String(angle[0]) + " degrees");
//  Serial.println("Bend: " + String(angle[1]) + " degrees");
//  Serial.println("Bend: " + String(angle[2]) + " degrees");
//  Serial.println("Bend: " + String(angle[3]) + " degrees");
//  Serial.println("Bend: " + String(angle[4]) + " degrees");
//  Serial.println("Bend: " + String(angle[5]) + " degrees");
//  Serial.println();

  //4. recording the data:
  //Thumb[1]//Index//Middle//Ring//Little//Thumb[2]
  Serial.println(String(angle[0]));
  Serial.println(String(angle[1]));
  Serial.println(String(angle[2]));
  Serial.println(String(angle[3]));
  Serial.println(String(angle[4]));
  Serial.println(String(angle[5]));

  
  delay(100);
}
