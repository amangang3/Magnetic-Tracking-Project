clear all;
close all; 

specan = VISA_Instrument('COM8'); %this needs to be done once in the script 

magnetometer_data_coil = zeros(20,3,3); 

for coil = 1: 3 %this is for coil 1, 2 and 3 
    disp("collection loop for coil: " + coil + " has started"); 
    
    for i = 1:26 %number of readings per coil 
        if rem(i,2) == 1 %then odd so coil off 
            Power_supply_code(specan, coil, 10, 4, 0)
            pause(5) %delay is to allow the field to settle 
            input("Press to collect ambient reading, reading number is: " + i); 
            incoming_magnetometer_data = collect_reading(10);
            pause(12) %this is to allow for the collection, it's the collection period + 2 seconds 
            average_mag = mean(incoming_magnetometer_data,1); 
            magnetometer_data_coil(i,:,coil) = average_mag; 
        end

        if rem(i,2) == 0 %then even so coil on 
            Power_supply_code(specan, coil, 10, 4, 1) 
            pause(5)
            input("Press to collect active reading, reading number is: " + i); 
            incoming_magnetometer_data = collect_reading(10); 
            pause(12)
            Power_supply_code(specan, coil, 10, 4, 0) %turn it off again  
            average_mag = mean(incoming_magnetometer_data,1); 
            magnetometer_data_coil(i,:,coil) = average_mag; 
        end
    end

end





