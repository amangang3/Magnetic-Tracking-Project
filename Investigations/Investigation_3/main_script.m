%this script is designed to collect readings from investigation 3 which explores driving the coils in different directions
close all; 
clear all;

specan = VISA_Instrument('COM8'); %done once for initialization 

magnetometer_data_coil = zeros(26,3); 

%channel 2 needs to be kept on for the duration of the experiment since it provides the negative voltage needed for channel 1 
Power_supply_code(specan, 2, 10, 4, 1) %turn this off at the end of the experiment 

for i = 1:26 %number of readings 
    
    if rem(i,2) == 1 %then odd so drive backwards 
        Power_supply_code(specan, 1, 10, 4, 1) %turn channel 1 on
        pause(5) %delay to allow field to settle 
        input("Press to collect backward reading, reading number is: " + i);
        incoming_magnetometer_data = collect_reading(10); 
        pause(12) %allow for collection 
        average_mag = mean(incoming_magnetometer_data,1);
        magnetometer_data_coil(i,:) = average_mag; 
        Power_supply_code(specan, 1, 10, 4, 0) %turn channel 1 off 
    end

    if rem(i,2) == 0 %then even so drive forward 
        Power_supply_code(specan, 3, 10, 4, 1) %turn channel 3 on 
        pause(5) 
        input("Press to collect forward reading, reading number is: " + i );
        incoming_magnetometer_data = collect_reading(10);
        pause(12) %allow for collection
        average_mag = mean(incoming_magnetometer_data, 1);
        magnetometer_data_coil(i,:) = average_mag; 
        Power_supply_code(specan, 3, 10, 4, 0) %turn channel 3 off 
    end 
    
end

Power_supply_code(specan, 2, 10, 4, 0) %turns channel 2 off since don't need it anymore 