close all;
clear all;
%setup the power supply
specan = VISA_Instrument('COM8'); %this needs to be done once in the script to setup the power supply 

%turn on channel 2 to provide negative voltagae 
Power_supply_code(specan, 2, 10, 4, 1)

%collect continious readings for the coil going forwards


