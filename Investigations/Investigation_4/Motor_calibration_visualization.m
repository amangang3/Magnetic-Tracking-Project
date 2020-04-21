%this is just a visualization for the report, results were written down in
%my notebook and copied here for the report
close all;
clear all;
expected_distance = [10, 20, 30, 50, 100, 200]
measured_distance = [10.2, 20.4, 30.3, 50.1, 100.1, 200.5]
figure;
scatter(expected_distance, measured_distance);
