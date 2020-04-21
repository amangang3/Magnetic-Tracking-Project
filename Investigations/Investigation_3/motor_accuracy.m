%results were recorded in my notebook and transferred to here
distances = 10:20:300;
errors = [0.21, 0.22, 0.21, 0.18, 0.19, 0.20, 0.20, 0.19, 0.21, 0.21, 0.19, 0.22, 0.18, 0.20, 0.20]
mean = mean(errors);
figure;
bar(distances, errors);
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',23)
xlabel("Distance (mm)");
ylabel("Error (mm)");
title("Motor calibration testing"); 