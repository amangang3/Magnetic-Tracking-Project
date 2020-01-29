close all;
clear all;
%setup the power supply
specan = VISA_Instrument('COM8'); %this needs to be done once in the script to setup the power supply 
%initialize the MPU 
sparkfun_MPU = initialize_MPU();

%turn on channel 2 to provide negative voltage 
Power_supply_code(specan, 2, 10, 4, 1)
%turn on channel 4 to power motor driver
Power_supply_code(specan, 4, 12, 2, 1)

%initialize magnetometer reading matrix
forward_readings_averaged = zeros(21,3);
backward_readings_averaged = zeros(21,3);

reading_time = 5; 

%move the motor, take readings, assuming -ve takes motor towards coil
for reading = 1:21
    disp(reading);
    %if it's the 1st coil, just take the reading
    if reading == 1
        pause(5)
        %turn forward coil on
        Power_supply_code(specan, 3, 10, 4, 1)
        %collect readings
        incoming_mag_data = collect_x_second_reading(reading_time, sparkfun_MPU);
        forward_readings_averaged(reading,:) = mean(incoming_mag_data,1);
        %turn forward coil off
        Power_supply_code(specan, 3, 10, 4, 0)
        %turn backward coil on 
        Power_supply_code(specan, 1, 10, 4, 1)
        %wait 5 seconds
        pause(5)
        %collect reading
        incoming_mag_data = collect_x_second_reading(reading_time, sparkfun_MPU);
        backward_readings_averaged(reading,:) = mean(incoming_mag_data,1);
        %turn backward coil off
        Power_supply_code(specan, 1, 10, 4, 0)
    end

    %for 1<reading<=11 move the thing 20mm away from coil and take reading
    if (reading>1) && (reading<=11)
        program_motor(20)
        pause(5)
        %turn forward coil on
        Power_supply_code(specan, 3, 10, 4, 1)
        %collect readings
        incoming_mag_data = collect_x_second_reading(reading_time, sparkfun_MPU);
        forward_readings_averaged(reading,:) = mean(incoming_mag_data,1);
        %turn forward coil off
        Power_supply_code(specan, 3, 10, 4, 0)
        %turn backward coil on 
        Power_supply_code(specan, 1, 10, 4, 1)
        %wait 5 seconds
        pause(5)
        %collect reading
        incoming_mag_data = collect_x_second_reading(reading_time, sparkfun_MPU);
        backward_readings_averaged(reading,:) = mean(incoming_mag_data,1);
        %turn backward coil off
        Power_supply_code(specan, 1, 10, 4, 0)
    end

    %for reading > 11 move the thing 20mm toward the coil and take reading 
    if reading > 11
        program_motor(-20)
        pause(5)
        %turn forward coil on
        Power_supply_code(specan, 3, 10, 4, 1)
        %collect readings
        incoming_mag_data = collect_x_second_reading(reading_time, sparkfun_MPU);
        forward_readings_averaged(reading,:) = mean(incoming_mag_data,1);
        %turn forward coil off
        Power_supply_code(specan, 3, 10, 4, 0)
        %turn backward coil on 
        Power_supply_code(specan, 1, 10, 4, 1)
        %wait 5 seconds
        pause(5)
        %collect reading
        incoming_mag_data = collect_x_second_reading(reading_time, sparkfun_MPU);
        backward_readings_averaged(reading,:) = mean(incoming_mag_data,1);
        %turn backward coil off
        Power_supply_code(specan, 1, 10, 4, 0)
    end
end

disp('Experiment is complete')

%turn power supply outputs off 
Power_supply_code(specan, 1, 10, 4, 0)
Power_supply_code(specan, 2, 10, 4, 0)
Power_supply_code(specan, 3, 10, 4, 0)
Power_supply_code(specan, 4, 10, 4, 0)