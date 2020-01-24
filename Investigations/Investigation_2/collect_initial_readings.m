close all;
clear all;
specan = VISA_Instrument('COM8'); %this needs to be done once in the script 

magnetometer_readings_initial = zeros(4,3);

for i = 1:4
        if rem(i,2) == 1 %then odd so coil off 
            Power_supply_code(specan, 1, 10, 4, 0)
            pause(5)
            input("Press to collect ambient reading, reading number is: " + i); 
            incoming_magnetometer_data = collect_reading(10);
            pause(12)
            average_mag = mean(incoming_magnetometer_data,1);
            magnetometer_readings_initial(i,:) = average_mag; 
        end
        
        if rem(i,2) == 0 %then even so coil on 
            Power_supply_code(specan, 1, 10, 4, 1) 
            pause(5)
            input("Press to collect active reading, reading number is: " + i); 
            incoming_magnetometer_data = collect_reading(10); 
            pause(12)
            Power_supply_code(specan, 1, 10, 4, 0) %turn it off again  
            average_mag = mean(incoming_magnetometer_data,1); 
            magnetometer_readings_initial(i,:) = average_mag; 
        end
end

%subtract background values 
reading_1 = magnetometer_readings_initial(2,:) - magnetometer_readings_initial(1,:);
reading_2 = magnetometer_readings_initial(4,:) - magnetometer_readings_initial(3,:);
initial_readings = [reading_1; reading_2]; 