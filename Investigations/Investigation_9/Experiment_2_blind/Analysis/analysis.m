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
plot(distance, magnetometer_readings_real, 'LineWidth',2)
plot(distance, mag_predicted, 'LineWidth', 2)
xlabel('Distance (cm)');
ylabel('Magnetometer readings (uT)');
title('Experiment 1 - Predicted readings compared to actual reading');
legend('Real readings','Predicted readings');
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',20)
hold off;

%plot errors
errors = abs(distance - sorted_predicted_distance); %abs to turn negative values into positive ones 
figure;
plot(distance, errors, 'LineWidth', 2);
xlabel('Distance (cm)');
ylabel('Error in distance (cm)');
title('Experiment 1 - Error in distance prediction over distance');
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',20)



