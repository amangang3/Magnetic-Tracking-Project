close all;
clear all; 
load('data_dump_blind.mat','-mat')

%first run back subtraction
magnetometer_readings_real = backward_subtraction(backward_readings_averaged, forward_readings_averaged);

%then scramble the order of the readings
magnetometer_readings_scrambled = magnetometer_readings_real(randperm(length(magnetometer_readings_real)));

%prediction equation setup
distance = 10:1:32; 
a = 9135;
b = -2.047;
c = -2.281;
mag_predicted = (a * distance.^b) + c;

