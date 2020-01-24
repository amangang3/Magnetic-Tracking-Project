close all;
clear all;
%setup the power supply
specan = VISA_Instrument('COM8'); %this needs to be done once in the script to setup the power supply 
%initialize the MPU 
sparkfun_MPU = initialize_MPU();

%turn on channel 2 to provide negative voltage
Power_supply_code(specan, 4, 10, 2, 1)

%test hypothesis on not being able to use 2 things at the same time
