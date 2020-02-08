%function will wait for 5 seconds, collect X seconds of reading 
%function inputs is the time in seconds and the sparkfun object
function[raw_magnetometer_data] = collect_5_second_reading(reading_time,sparkfun_MPU)
    formatSpec = '%f,%f,%f';
    incoming_serial_length = 0;
    fopen(sparkfun_MPU)
    %collect readings
    tic;
    while (toc < reading_time)
        incoming_serial_length = incoming_serial_length + 1;
        raw_magnetometer_data(incoming_serial_length,(1:3)) = fscanf(sparkfun_MPU, formatSpec);
    end
    fclose(sparkfun_MPU)
    %delay for 5 more seconds
end