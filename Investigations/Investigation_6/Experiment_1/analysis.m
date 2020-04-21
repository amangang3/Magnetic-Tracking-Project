close all;
clear all;

%load the data
load('forward_readings.mat','-mat');
load('backward_readings.mat','-mat');

%subtract readings
magnetometer_readings = backward_subtraction(backward_readings_averaged, forward_readings_averaged);

%create distance vector
distance_1 = 10:2:30;
distance_2 = 28:-2:10;
distance = [distance_1, distance_2];

%Bookkeeping crap for plot
distance_plot = distance;
midpoint = ceil(length(distance)/2);
distance_plot = [10:2:30 32:2:50];

figure;
plot(distance_plot,magnetometer_readings, 'LineWidth', 3);
set(gca,'XTick',distance_plot,'XTickLabel',distance);
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',20);
xlabel('Distance (cm)')
ylabel('Magnetometer values (uT)')
legend('X direction', 'Y direction', 'Z direction');

normMag = sqrt(sum(magnetometer_readings.^2,2));

figure;
plot(distance, magnetometer_readings, 'LineWidth', 2);
xlabel('Distance (cm)')
ylabel('Magnetometer values (uT)')
title('Coils swapped an hour apart')
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',20)


normalized = norm(magnetometer_readings);
figure;
plot(distance, normMag);
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',14)

sample_1 = normMag(1:11,:);
sample_2 = normMag(11:end,:);
sample_2 = flip(sample_2);
[h, p] = ttest2(sample_1,sample_2)
means_subtraction = sample_1 - sample_2;
mean_subtraction = mean(means_subtraction);