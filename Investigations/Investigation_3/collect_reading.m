%function input wll be the reading time you want 
function[raw_magnetometer_data] = collect_reading(reading_time)
incoming_serial_length = 0;
comPort = ("com9");
sparkfun_MPU_object = serial(comPort,'baudrate', 115200);
formatSpec = '%f,%f,%f';
fopen(sparkfun_MPU_object);
tic; 
%stream below will collect the data 
while (toc < reading_time) 
    incoming_serial_length = incoming_serial_length + 1;
    raw_magnetometer_data(incoming_serial_length,(1:3)) = fscanf(sparkfun_MPU_object, formatSpec);
end        

fclose(sparkfun_MPU_object);
end
