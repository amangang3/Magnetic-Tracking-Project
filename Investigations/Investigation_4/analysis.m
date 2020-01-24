%this script is to be used with the curve fitting toolbox 

clear all;
load('distance.mat','-mat');
load('tesla_readings.mat','-mat');
load('average_coil_3.mat','-mat');
distance_close_to_coil = 5:5:75;
distance_investigation_2_perfomance_range = 10:5:70;

%generate the ascension coil datasheet values 
datasheet_distance = 4:28; %this is in inches
datasheet_distance = datasheet_distance.* 2.54; %this converts it to cm 
datasheet_values_uT = [286.68, 183.07, 123.76, 87.47, 64.05, 48.29, 37.29, 29.39, 23.56, 19.19, 15.82, 13.20, 11.13, 9.47, 8.13, 7.02, 6.11, 5.35, 4.71, 4.17, 3.71, 3.31, 2.97, 2.67, 2.41];

datasheet_values_uT = datasheet_values_uT(5:end);
datasheet_distance = datasheet_distance(5:end);
