clear all;
close all;
load('magnetometer_data_coil.mat','-mat')

%distance vector 
distance = 10:5:70; 

%counters to ensure readings are spaced appropriatetly
forward_counter = 1; 
backward_counter = 1; 

%for loop to seperate readings into forward and backward readings 
for i = 1:26 
    if rem(i,2) == 1 %then odd so backward reading 
        backward_readings(backward_counter,:) = magnetometer_data_coil(i,:);
        backward_counter = backward_counter + 1; 
    end

    if rem(i,2) == 0 %then even so forward reading
        forward_readings(forward_counter,:) = magnetometer_data_coil(i,:); 
        forward_counter = forward_counter + 1; 
    end
end

%plot just to look at the differences - presentation
figure; 
subplot(2,1,1)
plot(distance, forward_readings, 'LineWidth', 5)
title("Forward readings")
xlabel("Distance (cm)")
ylabel("Magnetic flux (uT)")
legend('X direction', 'Y direction', 'Z direction')
ylim([-80 80]);
xlim([10 50]);
subplot(2,1,2)
plot(distance, backward_readings, 'LineWidth',5)
title("Backward readings")
xlabel("Distance (cm")
ylabel("Magnetic flux (uT)")
legend('X direction', 'Y direction', 'Z direction')
ylim([-80 80])
xlim([10 50]);
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',23)


%forward readings - backward readings 
forward_minus_backward = backward_subtraction(backward_readings, forward_readings);
%forward_minus_backward = forward_readings - backward_readings; 
figure;
plot(distance, forward_minus_backward, 'LineWidth', 5);
title("Forward readings - Backward readings")
xlabel("Distance (cm)")
ylabel("Magnetic flux (uT)")
legend('X direction', 'Y direction', 'Z direction')
xlim([10 50]);
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',23)

