%function will wait for 5 seconds, collect 5 seconds of reading, and then pause for 5 seconds afterwords 
function[raw_magnetometer_data] = collect_5_second_reading(sparkfun_MPU)
    formatSpec = '%f,%f,%f';
    incoming_serial_length = 0;
    fopen(sparkfun_MPU)
    %delay for 5 seconds
    pause(5)
    %collect readings
    tic;
    while (toc < 5)
        incoming_serial_length = incoming_serial_length + 1;
        raw_magnetometer_data(incoming_serial_length,(1:3)) = fscanf(sparkfun_MPU, formatSpec);
    end
    fclose(sparkfun_MPU)
    %delay for 5 more seconds
    pause(5)
end
