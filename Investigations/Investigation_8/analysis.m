close all; 
clear all; 

load('backward.mat');
load('forward.mat');


%subtract readings
magnetometer_readings = backward_subtraction(backward_readings_averaged, forward_readings_averaged);
magnetometer_readings = magnetometer_readings(2:end,:);
%create distance vector
distance_1 = 11:1:31;
distance_2 = 30:-1:11;
distance = [distance_1, distance_2];

%Bookkeeping crap for plot
midpoint = ceil(length(distance)/2);
distance_plot = [11:1:31 32:1:51];

figure;
plot(distance_plot,magnetometer_readings);
set(gca,'XTick',distance_plot,'XTickLabel',distance);

normMag = sqrt(sum(magnetometer_readings.^2,2));

figure;
plot(distance, magnetometer_readings);
xlabel('Distance (cm)')
ylabel('Magnetometer values (uT)')
title('Investigation 7 - 1s integration time')

normalized = norm(magnetometer_readings);
figure;
plot(distance, normMag);

a = 6318;
b = -1.911;
c = -4.029;
mag_predicted = (a * distance.^-1.911) + c;


mag_real = magnetometer_readings;

figure; 
hold on; 
plot(distance, mag_real, 'b');
plot(distance, mag_predicted, 'r');

figure;
hold on;
plot(distance_plot,mag_real);
plot(distance_plot, mag_predicted, 'r');
set(gca,'XTick',distance_plot,'XTickLabel',distance);
xlabel('Distance (cm)');
ylabel('Magnetometer values (uT)');
title('Predicted output vs real output');
hold off;