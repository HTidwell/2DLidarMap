#include <RPLidar.h>
#define RPLIDAR_MOTOR 3 // The PWM pin for control the speed of RPLIDAR's motor (MOTOCTRL).

RPLidar lidar;
                      
void setup() {
  Serial.begin(115200);
  Serial1.begin(115200);  // For RPLidar
  lidar.begin(Serial1);
  pinMode(RPLIDAR_MOTOR, OUTPUT);  // set pin modes
}

float maxDistance = 12000; //in mm
float minDistance = 100; //in mm
float count = 0;
int startBit = 0;
int decimationValue = 2; //collect data every other data recording


void loop() {
  if (IS_OK(lidar.waitPoint())) {
    //perform data processing here... 
    float distance = lidar.getCurrentPoint().distance; //disntance in mm
    float angle = lidar.getCurrentPoint().angle;  // 0-360 deg
    int startBit = lidar.getCurrentPoint().startBit; //start of new scan bit
    
    if (count < decimationValue) {
      count = count + 1;
    } else {
        if ((distance > minDistance) && (distance < maxDistance)) {
        printData(angle, distance, startBit); // this only outputs angle, distance, startBit if the data point is aboove minDistance and below maxDistance and decimates 
        count = count + 1; 
        } else {
          count = count + 1;
        }
    }
  }
  
  else {
    analogWrite(RPLIDAR_MOTOR, 0); //stop the rplidar motor
    // Try to detect RPLIDAR
    rplidar_response_device_info_t info;
    if (IS_OK(lidar.getDeviceInfo(info, 100))) {
       // Detected
       lidar.startScan();
       analogWrite(RPLIDAR_MOTOR, 255);
       delay(1000);
    }
  }
}

void printData(float angle, float distance, int startBit)
//output data points through printing to serial
{
  Serial.print(distance);
  Serial.print(",");
  Serial.print(angle);
  Serial.print(",");
  Serial.println(startBit);
}