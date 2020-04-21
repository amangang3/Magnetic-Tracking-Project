clear all
load('magnetometer_data_coil','-mat');
magnetometer_data = magnetometer_data_coil; 
%dimension information
% dim1 = p7, dim2 = p5, dim3 = p4 

%vector for coil values only
distance = 10:5:70;

%counters are to ensure that the values are saved properly 
ambient_counter = 1; 
active_counter = 1; 

%for loop to seperate readings into active and ambient 
for i = 1:26
    if rem(i,2) == 1 %then odd so coil off therefore readings are ambient 
        ambient_readings(ambient_counter,:,:) = magnetometer_data(i,:,:);
        ambient_counter = ambient_counter + 1;
    end
    
    if rem(i,2) == 0 %then even so coil on 
        active_readings(active_counter,:,:) = magnetometer_data(i,:,:);
        active_counter = active_counter + 1;
    end
end

%subtract ambient readings from active readings 
for coil = 1:3 
    background_corrected_readings(:,:,coil) = (active_readings(:,:,coil) - ambient_readings(:,:,coil))/4;
end

%make all readings positive
background_corrected_readings = abs(background_corrected_readings);
%generate the ascension coil datasheet values 
datasheet_distance = 4:28; %this is in inches
datasheet_distance = datasheet_distance.* 2.54; %this converts it to cm 
datasheet_values_uT = [286.68, 183.07, 123.76, 87.47, 64.05, 48.29, 37.29, 29.39, 23.56, 19.19, 15.82, 13.20, 11.13, 9.47, 8.13, 7.02, 6.11, 5.35, 4.71, 4.17, 3.71, 3.31, 2.97, 2.67, 2.41];

%plot over 3 coils and datasheet values 
figure; 
hold on; 
subplot(4,1,1)
plot(distance, background_corrected_readings(:,:,1));
title("Coil 1, Pin 7");
legend('X direction', 'Y direction', 'Z direction');
xlabel('Distance (cm)');
ylabel('Magnetic flux (uT)');
ylim([0 550]);
subplot(4,1,2)
plot(distance, background_corrected_readings(:,:,2));
legend('X direction', 'Y direction', 'Z direction');
xlabel('Distance (cm)');
ylabel('Magnetic flux (uT)');
ylim([0 550]);
title("Coil 2, Pin 5");
subplot(4,1,3)
plot(distance, background_corrected_readings(:,:,3)); 
legend('X direction', 'Y direction', 'Z direction');
xlabel('Distance (cm)');
ylabel('Magnetic flux (uT)');
ylim([0 550]);
title("Coil 3, Pin 4");
subplot(4,1,4)
plot(datasheet_distance, datasheet_values_uT);
title("Ascension Datasheet values, X coil");
xlabel('Distance (cm)');
ylabel('Magnetic flux (uT)');
ylim([0 550]);
xlim([10 70]);
hold off; 

%average the coil 3 values 
% average_coil_3 = mean(background_corrected_readings(:,:,3),2); 
average_coil_3 = rssq(background_corrected_readings(:,:,3),2);
figure;
subplot(2,1,1)
plot(datasheet_distance, datasheet_values_uT, 'LineWidth', 5);
title("Ascension Datasheet values, X coil");
xlabel('Distance (cm)');
ylabel('Magnetic flux (uT)');
ylim([0 600]);
xlim([10 70]);
subplot(2,1,2)
plot(distance, average_coil_3, 'LineWidth', 5); 
title("Coil 3 total magnitude values");
xlabel('Distance (cm)');
ylabel('Magnetic flux (uT)');
ylim([0 600]); 
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',23)
%plot over 3 coils for presentation
figure; 
hold on; 
subplot(4,1,1)
plot(distance, background_corrected_readings(:,:,1), 'LineWidth',5);
title("A) Coil 1, Pin 7");
legend('X direction', 'Y direction', 'Z direction');
xlabel('Distance (cm)');
ylabel('Magnetic flux (uT)');
ylim([0 300]);
xlim([10 35]);
subplot(4,1,2)
plot(distance, background_corrected_readings(:,:,2), 'LineWidth',5);
legend('X direction', 'Y direction', 'Z direction');
xlabel('Distance (cm)');
ylabel('Magnetic flux (uT)');
ylim([0 300]);
xlim([10 35]);
title("B) Coil 2, Pin 5");
subplot(4,1,3)
plot(distance, background_corrected_readings(:,:,3), 'LineWidth',5); 
legend('X direction', 'Y direction', 'Z direction');
xlabel('Distance (cm)');
ylabel('Magnetic flux (uT)');
ylim([0 300]);
xlim([10 35]);
title("C) Coil 3, Pin 4");
subplot(4,1,4)
plot(datasheet_distance, datasheet_values_uT, 'LineWidth',5);
title("D) Ascension Datasheet values, X coil");
xlabel('Distance (cm)');
ylabel('Magnetic flux (uT)');
ylim([0 300]);
xlim([10 35]);
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',23)

