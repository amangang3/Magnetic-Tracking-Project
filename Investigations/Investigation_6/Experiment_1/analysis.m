close all;
clear all;

%load the data
load('forward_readings.mat','-mat');
load('backward_readings.mat','-mat');

%subtract readings
magnetometer_readings = forward_readings_averaged - backward_readings_averaged;

%create distance vector
distance_1 = 10:2:30;
distance_2 = 28:-2:10;
distance = [distance_1, distance_2];

%Bookkeeping crap for plot
distance_plot = distance;
midpoint = ceil(length(distance)/2);
distance_plot = [10:2:30 32:2:50];

figure;
plot(distance_plot,magnetometer_readings);
set(gca,'XTick',distance_plot,'XTickLabel',distance);

normMag = sqrt(sum(magnetometer_readings.^2,2));

figure;
plot(distance, magnetometer_readings);

normalized = norm(magnetometer_readings);
figure;
plot(distance, normMag);

