clc
close all
clear

% Reading fis files
heat_flow_file = readfis('./FIS/heat_flow.fis');
renewable_energy_file = readfis('./FIS/renewable_energy_unit.fis');
bill_hours_file = readfis('./FIS/bill_hours.fis');
cost_optimization_file = readfis('./FIS/cost_optimization.fis');
thermal_preference_file = readfis('./FIS/thermal_preference.fis');

heat_flow_fis = getFISCodeGenerationData(heat_flow_file);
renewable_energy_fis = getFISCodeGenerationData(renewable_energy_file);
bill_hours_fis = getFISCodeGenerationData(bill_hours_file);
cost_optimization_fis = getFISCodeGenerationData(cost_optimization_file);
thermal_preference_fis = getFISCodeGenerationData(thermal_preference_file);

% Reading inputs from excel sheet
preference_rows = readmatrix('Data/preferences.xlsx', 'Range', 'A5:I17');
% preference_rows = preference_rows(5:end, :);
no_of_households = readmatrix('Data/preferences.xlsx', 'Range', 'A2:A2');
tolerance = readmatrix('Data/tolerance.xlsx', 'Range', 'A2:B2');

% Tolerable deviations 
tolerable_deviation_in_estimated_cost = tolerance(1);
tolerable_deviation_in_estimated_heat = tolerance(2);
