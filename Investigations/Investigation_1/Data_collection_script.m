clear all;
close all; 
incoming_magnetometer_data = collect_reading(); 

%collect ambient reading at the start 
%start the loop 
disp('collection loop has started');
magnetoemeter_data = zeros(20,3); 

for i = 1:20
    input("Press to collect reading number: " + i);
    incoming_magnetometer_data = collect_reading();
    average_mag = mean(incoming_magnetometer_data,1); 
    magnetoemeter_data(i,:) = average_mag; 
end