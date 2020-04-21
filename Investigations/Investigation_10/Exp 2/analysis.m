
%run back subtraction
magnetometer_readings_avg = backward_subtraction(backward_readings_averaged, forward_readings_averaged);

%create distance vector
distance = [10:1:90]; %measurements points in mm
 
%deal with cells - reduce them all down to the same size
min_length_back = min(cellfun('length', backward_readings_all));
min_length_forward = min(cellfun('length', forward_readings_all));
min_length = min(min_length_back, min_length_forward);
magnetometer_readings = {};

for i = 1:length(magnetometer_readings_avg)
    backward_readings_all{i} = backward_readings_all{i}(1:min_length,:);
    forward_readings_all{i} = forward_readings_all{i}(1:min_length,:);
    magnetometer_readings{i} = backward_subtraction(backward_readings_all{i}, forward_readings_all{i});
    sd(i) = std(magnetometer_readings{i}(:,1));
%     scatter(distance(i), magnetometer_readings{i}(1:min_length,1));
end

% PLOT THIS ON A MORE POWERFUL MACHINE
% figure;
% hold on; 
% for i = 1:length(magnetometer_readings_avg)
%     for a = 1:length(magnetometer_readings{i})
%        scatter(distance(i),magnetometer_readings{i}(a,1),'*');
%     end
% end
% hold off;

figure;
hold on;
plot(distance, magnetometer_readings_avg(:,1));
errorbar(distance, magnetometer_readings_avg(:,1), sd);
plot(distance, magnetometer_readings_avg(:,2));
plot(distance, magnetometer_readings_avg(:,3));
title('Readings with the big rod');
xlabel('Distance (cm)');
ylabel('Magnetometer readings (uT)');
hold off;

