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
% forward_readings_averaged = zeros(21,3);
% backward_readings_averaged = zeros(21,3);

%create cells to save the complete data
complete_forward_readings = {};

%measurement parameters:
reading_time = 5; %this should be in seconds 
measurement_dists = [0:10:800]; %measurements points in mm
switch_interval = 2; %seconds


%move the motor, take readings, assuming -ve takes motor towards coil
total_travel = 0;
for reading = 1:length(measurement_dists)
     
        %turn forward coil on
        Power_supply_code(specan, 3, 10, 4, 1)
        
        pause(switch_interval)
        
        %collect readings
        incoming_mag_data = collect_x_second_reading(reading_time, sparkfun_MPU);
        forward_readings_all{reading} = incoming_mag_data;
        forward_readings_averaged(reading,:) = mean(incoming_mag_data,1);
        
        %turn forward coil off
        Power_supply_code(specan, 3, 10, 4, 0)
        %turn backward coil on 
        Power_supply_code(specan, 1, 10, 4, 1)
        
        %wait X seconds
        pause(switch_interval)
        
        %collect reading
        incoming_mag_data = collect_x_second_reading(reading_time, sparkfun_MPU);
        backward_readings_all{reading}= incoming_mag_data;
        backward_readings_averaged(reading,:) = mean(incoming_mag_data,1);
        
        %turn backward coil off
        Power_supply_code(specan, 1, 10, 4, 0)
    
        if reading<length(measurement_dists)
            travel = measurement_dists(reading+1)-measurement_dists(reading);
            total_travel = total_travel+travel;
            program_motor(measurement_dists(reading+1)-measurement_dists(reading));%mm
        end
end

program_motor(-total_travel);
        
disp('Experiment is complete')

%turn power supply outputs off 
Power_supply_code(specan, 1, 10, 4, 0)
Power_supply_code(specan, 2, 10, 4, 0)
Power_supply_code(specan, 3, 10, 4, 0)
Power_supply_code(specan, 4, 10, 4, 0)

