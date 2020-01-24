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
%turn on channel 3 to drive the coil forwards
Power_supply_code(specan, 3, 12, 2, 1)

%move the motor, take readings, assuming -ve takes motor away from coil, +ve takes motor towards coil (change later as needed)
for reading = 1:25
    disp(reading))
    %if it's the 1st coil, just take the reading
    if reading = 1
        incoming_mag_data = collect_5_second_reading();
        magnetometer_data_averaged(reading,:) = mean(incoming_mag_data,1);
    end

    %for 1<reading<=13 move the thing 20mm away from coil and take reading
    if (reading>1) && (reading<=13)
        program_motor(-20)
        incoming_mag_data = collect_5_second_reading();
        magnetometer_data_averaged(reading,:) = mean(incoming_mag_data,1);
    end

    %for reading > 13 move the thing 20mm toward the coil and take reading 
    if reading > 13
        program_motor(20)
        incoming_mag_data = collect_5_second_reading();
        magnetometer_data_averaged(reading,:) = mean(incoming_mag_data,1);
    end
end

disp('Experiment is complete')




