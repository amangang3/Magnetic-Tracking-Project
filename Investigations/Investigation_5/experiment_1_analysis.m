close all;
clear all;

%load the data and remove 0s 
load('script_1_forward_readings.mat','-mat');
forward_readings = magnetometer_data_averaged;
forward_readings = forward_readings(any(forward_readings,2),:);
load('script_1_backward_readings.mat','-mat');
backward_readings = magnetometer_data_averaged;
backward_readings = backward_readings(any(backward_readings,2),:);

%eliminate final reading on both vectors
backward_readings = backward_readings(1:21, :);
forward_readings = forward_readings(1:21, :);

%create distance vector
distance_1 = 10:2:30;
distance_2 = 28:-2:10;
distance = [distance_1, distance_2];


%subtract readings
magnetometer_readings = forward_readings - backward_readings;
magnetometer_readings = backward_subtraction(backward_readings, forward_readings);
%Bookkeeping crap for plot
distance_plot = distance;
midpoint = ceil(length(distance)/2);
distance_plot = [10:2:30 32:2:50];

figure;
%plot(distance_plot,magnetometer_readings);
plot(distance_plot, forward_readings(:,1));
set(gca,'XTick',distance_plot,'XTickLabel',distance);
xlabel('Distance (cm)')
ylabel('Magnetometer values (uT)')
legend('X direction', 'Y direction', 'Z direction');

normMag = sqrt(sum(magnetometer_readings.^2,2));


