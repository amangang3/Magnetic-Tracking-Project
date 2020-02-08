clear all;
close all;

load('distance.mat');
load('mag_predicted_exp_2.mat');
load('mag_scrambled.mat');
load('mag_real.mat');

magnetometer_readings_real = magnetometer_readings_real(:,1);
%unscramble and fit the data 
a = 9135;
b = -2.047;
c = -2.281;
predicted_distance = (((magnetometer_readings_scrambled - c) ./ a)).^(1/b);

%data bookkeeping
sorted_predicted_distance = sort(predicted_distance,'ascend');

%basic plot
figure;
hold on; 
plot(distance, magnetometer_readings_real)
plot(distance, mag_predicted)
hold off;

%plot errors
errors = distance - sorted_predicted_distance;
figure;
plot(distance, errors);


