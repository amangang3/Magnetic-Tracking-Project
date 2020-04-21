close all;
clear all;
load('exp_1_dump')

%run back subtraction
magnetometer_readings_avg = backward_subtraction(backward_readings_averaged, forward_readings_averaged);

%create distance vector
distance = [10:1:90]; %measurements points in mm
 
%deal with cells - reduce them all down to the same size
min_length_back = min(cellfun('length', backward_readings_all));
min_length_forward = min(cellfun('length', forward_readings_all));
min_length = min(min_length_back, min_length_forward);
magnetometer_readings = {};

% for i = 1:length(magnetometer_readings_avg)
%     backward_readings_all{i} = backward_readings_all{i}(1:min_length,:);
%     forward_readings_all{i} = forward_readings_all{i}(1:min_length,:);
%     magnetometer_readings{i} = backward_subtraction(backward_readings_all{i}, forward_readings_all{i});
%     sd(i) = std(magnetometer_readings{i}(:,1));
% %     scatter(distance(i), magnetometer_readings{i}(1:min_length,1));
% end

% PLOT THIS ON A MORE POWERFUL MACHINE
% figure;
% hold on; 
% for i = 1:length(magnetometer_readings_avg)
%     for a = 1:length(magnetometer_readings{i})
%        scatter(distance(i),magnetometer_readings{i}(a,1),'*');
%     end
% end
% hold off;


%predicted readings
%unscramble and fit the data 
mag_readings_x = magnetometer_readings_avg(:,1);
a = 1.924e+04;
b = -2.403;
c =  -0.3389;
predicted_distance = (((magnetometer_readings_avg(:,1) - c) ./ a)).^(1/b);



figure;
hold on;
plot(distance, magnetometer_readings_avg(:,1), 'LineWidth', 2);
plot(predicted_distance, magnetometer_readings_avg(:,1), 'LineWidth', 2)
% plot(distance, magnetometer_readings_avg(:,2));
% plot(distance, magnetometer_readings_avg(:,3));
title('Experiment 2 - Predicted readings compared to actual reading');
legend('Real readings','Predicted readings');
xlabel('Distance (cm)');
ylabel('Magnetometer readings (uT)');
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',20)
hold off;

errors = abs(distance - (predicted_distance')); %abs to turn negative values into positive ones 
figure;
plot(distance, errors, 'LineWidth', 2);
xlabel('Distance (cm)');
ylabel('Error in distance (cm)');
title('Experiment 2 - Error in distance prediction over distance');
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',20)

