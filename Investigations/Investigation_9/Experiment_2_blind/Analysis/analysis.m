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
xlabel('Distance (cm)');
ylabel('Magnetometer readings (uT)');
title('Predicted vs actual experiment 2');
legend('Real readings','Predicted readings');
hold off;

%plot errors
errors = abs(distance - sorted_predicted_distance); %abs to turn negative values into positive ones 
figure;
plot(distance, errors);
xlabel('Distance (cm)');
ylabel('Error in distance (cm)');
title('Error in distance prediction over real distance');



