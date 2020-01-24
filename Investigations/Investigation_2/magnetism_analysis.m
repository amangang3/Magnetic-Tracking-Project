%this is honestly a fucking mess of a script. Do this again properly and
%collect readings again. This was rushed, unstructured and dumb. 
close all; 
clear all;
%load data so that you have distance and average_coil_3
load('data_x_coil','-mat');
%load('distance_x_coil','-mat');
load('intial_readings','-mat');
coil_values = average_coil_3; 

%average initial readings 
average_initial = mean(initial_readings,2); 
complete_readings = [average_initial; coil_values];
distance = 0:5:70;

%equation: b=u*n*I 
%objective is to plot different values for n and fit them to the b curve
%for initial and dropoff values 

%find the curve which best fits the data (where n is a whole number) 
u = 4*pi*10^-7; 
%need reading value at the base of the coil 
complete_readings_tesla = complete_readings.*10^-6;
number_of_turns = complete_readings_tesla(1) / (u*4);

%for n turns
%n_turns = 227;
%n_turns = 20000000;
%b_sim_initial = u*n_turns*4; 
%d_sim = linspace(0,70,1000);
for n_turns = 1:1*10^5
    b_sim_initial = u*n_turns*4; 
    for i = 1:length(distance)
        if i == 1
            b_sim(i,n_turns) = b_sim_initial;
        else
            b_sim(i,n_turns) = b_sim_initial * ((distance(i))^-3);
        end
    end
end

% %plot all values
% subplot(2,1,1)
% plot(distance,b_sim(:,227))
% subplot(2,1,2)
% plot(distance,complete_readings_tesla)

figure;
hold on;
plot(distance(2:15), b_sim(2:15,227))
plot(distance(2:15), complete_readings_tesla(2:15));
xlabel('Distance (cm)');
ylabel('Magnetic flux (T)');
legend('Simulated', 'Actual');
hold off; 

figure;
hold on;
plot(distance, b_sim(:,227))
plot(distance, complete_readings_tesla(:));
xlabel('Distance (cm)');
ylabel('Magnetic flux (T)');
legend('Simulated', 'Actual');
hold off; 


%only plot values after 10
subplot(2,1,1)
plot(distance(2:15), b_sim(2:15,227))
xlabel('Distance (cm)');
ylabel('Magnetic flux (T)');
title('Simulated readings')
subplot(2,1,2)
plot(distance(2:15), complete_readings_tesla(2:15))
xlabel('Distance (cm)');
ylabel('Magnetic flux (T)');
title('Actual readings');

figure;
hold on; 
plot(distance(2:15), complete_readings_tesla(2:15))
for i = 1:length(n_turns)
    plot(distance(2:15), b_sim(2:15,i))
end
hold off; 

