%inputs backward readings, forward readings
%outputs magnetometer_values 
function[magnetometer_values] = backward_subtraction(backward_readings, forward_readings)
magnetometer_values = forward_readings - backward_readings; 
magnetometer_values = magnetometer_values./2; 
end