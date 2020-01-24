load('magnetometer_data','-mat');
magnetometer_data = magnetoemeter_data;
%vector for coil values only
distance = 10:5:70;
coil_values_only = magnetometer_data([2 3 5 6 8 9 11 12 14 15 17 18 20],:);

%vector for ambient values only 
ambient_values_only = magnetometer_data([1 4 7 10 13 16 19],:);
distance_ambient = (10:10:70);

figure;
plot(distance, coil_values_only);

figure; 
plot(distance_ambient, ambient_values_only);



%ambient subtracted readings - figure out a looped solution to this 
ambient_subtracted_reading(1,:) = coil_values_only(1,:) - ambient_values_only(1,:);
ambient_subtracted_reading(2,:) = coil_values_only(2,:) - ambient_values_only(1,:); 

ambient_subtracted_reading(3,:) = coil_values_only(3,:) - ambient_values_only(2,:); 
ambient_subtracted_reading(4,:) = coil_values_only(4,:) - ambient_values_only(2,:); 

ambient_subtracted_reading(5,:) = coil_values_only(5,:) - ambient_values_only(3,:); 
ambient_subtracted_reading(6,:) = coil_values_only(6,:) - ambient_values_only(3,:); 

ambient_subtracted_reading(7,:) = coil_values_only(7,:) - ambient_values_only(4,:);
ambient_subtracted_reading(8,:) = coil_values_only(8,:) - ambient_values_only(4,:); 

ambient_subtracted_reading(9,:) = coil_values_only(9,:) - ambient_values_only(5,:); 
ambient_subtracted_reading(10,:) = coil_values_only(10,:) - ambient_values_only(5,:); 

ambient_subtracted_reading(11,:) = coil_values_only(11,:) - ambient_values_only(6,:); 
ambient_subtracted_reading(12,:) = coil_values_only(12,:) - ambient_values_only(6,:); 
    
ambient_subtracted_reading(13,:) = coil_values_only(13,:) - ambient_values_only(7,:); 

figure;
subplot(3,1,1)
plot(distance, coil_values_only);
title('Coil on');
xlabel('Distance (cm)');
ylabel('Magnetic flux (uT)');
legend('X Coil', 'Y Coil', 'Z Coil');
subplot(3,1,2)
plot(distance_ambient, ambient_values_only);
title('Coil off, ambient readings');
legend('X Coil', 'Y Coil', 'Z Coil');
xlabel('Distance (cm)');
ylabel('Magnetic flux (uT)');
subplot(3,1,3)
plot(distance, ambient_subtracted_reading);
title('Coil on, values have been normalized to ambient readings');
xlabel('Distance (cm)');
ylabel('Magnetic flux (uT)');
legend('X Coil', 'Y Coil', 'Z Coil');


