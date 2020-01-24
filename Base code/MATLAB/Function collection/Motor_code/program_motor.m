function[] = program_motor(movement_length)
%movement length must be specified in mm 
steps = movement_length*100;
arduino_uno = arduino();
shield = addon(arduino_uno,'Adafruit/MotorShieldV2');
sm = stepper(shield,2,200,'RPM',50,'StepType','Double');
move(sm, steps);
clear all;
end
