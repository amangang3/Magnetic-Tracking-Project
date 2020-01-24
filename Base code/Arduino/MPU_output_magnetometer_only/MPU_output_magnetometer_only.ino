//Written by Aman Pishu Ganglani 2018 
// MPU-9250 Digital Motion Processing (DMP) Library
#include <SparkFunMPU9250-DMP.h>
// SD Library manages file and hardware control
#include <SD.h>
#define SerialPort SerialUSB 
MPU9250_DMP imu; // Create an instance of the MPU9250_DMP class
void setup() {
  // put your setup code here, to run once:
  SerialPort.begin(115200);
  imu.begin();
  imu.setSensors(INV_XYZ_COMPASS); //enable magnetometer sensors
  imu.setCompassSampleRate(50); //sample rate of the magnetometer 
  pinMode(LED_BUILTIN,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
{
  // dataReady() checks to see if new accel/gyro data
  // is available. It will return a boolean true or false
  if ( imu.dataReady() )
  {
    imu.update(UPDATE_COMPASS);
    printIMUData();
  }
  
}
}

void printIMUData(void)
{
  //convert units into micro teslas 
  float magX = imu.calcMag(imu.mx);
  float magY = imu.calcMag(imu.my);
  float magZ = imu.calcMag(imu.mz); 
  SerialPort.println(String(magX) + ", " + String(magY) + ", " + String(magZ));
}
