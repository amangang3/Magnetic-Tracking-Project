close all;
clear all; 
load('calibration_curve_experiment_dump.mat','-mat')
load('distance')

%deal with cells - reduce them all down to the same size
min_length_back = min(cellfun('length', backward_readings_all));
min_length_forward = min(cellfun('length', forward_readings_all));
min_length = min(min_length_back, min_length_forward);
magnetometer_readings = {};
for i = 1:23
    backward_readings_all{i} = backward_readings_all{i}(1:min_length,:);
    forward_readings_all{i} = forward_readings_all{i}(1:min_length,:);
    magnetometer_readings{i} = backward_subtraction(backward_readings_all{i}, forward_readings_all{i});
    sd(i) = std(magnetometer_readings{i}(:,1));
end



mag_readings_averaged = backward_subtraction(backward_readings_averaged, forward_readings_averaged);

figure;
hold on; 
errorbar(distance, mag_readings_averaged(:,1), sd);
xlabel('Distance (cm)');
ylabel('Magnetometer readings uT');
title('Calibration curve measurements, SD plotted as error bar');
hold off;

figure; 
plot(distance, sd);
xlabel('Distance (cm)');
ylabel('SD');
title('Variation of SD');




% figure;
% hold on; 
% for i = 1:23
%     for len = 1:min_length 
%         plot(distance, magnetometer_readings{i}(len,1))
%     end
% end
