%function will initialize the MPU, this only needs to be run once
function[sparkfun_MPU] = initialize_MPU()
    comPort = ("com9")
    sparkfun_MPU = serial(comPort,'baudrate',115200);
end
