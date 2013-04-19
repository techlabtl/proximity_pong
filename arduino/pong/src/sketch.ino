const int numReadings = 25;                   // number of readings to take/ items in the array

int index = 0;                            // arrayIndex of the current item in the array

int first_total = 0;                      // store the current sum of all readings
int first_average_distance = 0;           // stores the average value

int second_total = 0;
int second_average_distance = 0;            

// setup pins and variables for SRF05 sonar device

int first_readings[numReadings];          // stores the distance readings in an array
int first_echoPin = 2;                    // SRF05 echo pin (digital 2)
int first_initPin = 3;                    // SRF05 trigger pin (digital 3)
unsigned long firstPulseTime = 0;         // stores the pulse in Micro Seconds

int second_readings[numReadings];
int second_echoPin = 5;
int second_initPin = 6;
unsigned long secondPulseTime = 0;

unsigned long distance = 0;                     // variable for storing the distance (cm)

//setup

void setup() {

  // pinMode(redLEDPin, OUTPUT);                   // sets pin 9 as output
  pinMode(first_initPin, OUTPUT);                  // set init pin 3 as output
  pinMode(second_initPin, OUTPUT);                 // set init pin 3 as output
  pinMode(first_echoPin, INPUT);                   // set echo pin 2 as input
  pinMode(second_echoPin, INPUT);                  // set echo pin 2 as input

  // create array loop to iterate over every item in the array

  for (int i = 0; i < numReadings; i++) {
    first_readings[i] = 0;
    second_readings[i] = 0;
  }
  // initialize the serial port, lets you view the distances being pinged if connected to computer
  Serial.begin(9600);
} 


// execute
void loop() {
  firstPulseTime = get_pulse(first_initPin, first_echoPin);
  secondPulseTime = get_pulse(second_initPin, second_echoPin);

  first_total = smooth(firstPulseTime, first_total, first_readings);
  second_total = smooth(secondPulseTime, second_total, second_readings);
  // advance to the next position in the array
  index = index + 1;                    

  // if we're at the end of the array wrap around to the beginning
  if (index >= numReadings) index = 0;                           

  // calculate the average
  first_average_distance = mean(first_total);    
  second_average_distance = mean(second_total);    
  // constrain value to ignore values too near to the sensor ( becomes 0 ) and to far from it ( become maximum )
  first_average_distance = constrain(first_average_distance, 30, 100);
  second_average_distance = constrain(second_average_distance, 30, 100);

  // map values for transmission ( <= 128 : first readings average, >128 <= 255 : second readings average )
  byte first_byte = map(first_average_distance, 30, 100, 0, 127);
  byte second_byte = map(second_average_distance, 30, 100, 128, 255);

  // debug print
  /*Serial.print("first_average_distance: ");
  Serial.print(first_average_distance);
  Serial.print(" - ");
  Serial.print("second_average_distance: ");
  Serial.println(second_average_distance);
  Serial.println("----------------");*/

  // send it to the computer as bytes
  Serial.write(first_byte);
  Serial.write(second_byte);
  
  delay(1);        // delay in between reads for stability
}



long get_pulse(int init_pin, int echo_pin) {
  digitalWrite(init_pin, HIGH);      // send 10 microsecond pulse
  delayMicroseconds(100);            // wait 10 microseconds before turning off
  digitalWrite(init_pin, LOW);       // stop sending the pulse
  
  return pulseIn(echo_pin, HIGH);    // Look for a return pulse, it should be high as the pulse goes low-high-low
}

// http://arduino.cc/en/Tutorial/Smoothing
int smooth(long pulse, int total, int data[]) {
  // subtract the last reading:
  total = total - data[index];         
  // read from the sensor:  
  data[index] = pulse_to_cm(pulse); 
  // add the reading to the total:
  total = total + data[index]; 

  return total;   
}

float pulse_to_cm(long pulse) {
  return (float)pulse/58;            // sound speed to cm, easy way
}

int mean(int total) {
  return total / numReadings;
}
