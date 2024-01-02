clc
close all
clear

% Reading inputs from excel sheet
preferenceRows = readmatrix('Data/preferences.xlsx', 'Range', 'A8:I16');
no_of_households = readmatrix('Data/preferences.xlsx', 'Range', 'A3:A3');
tolerance = readmatrix('Data/tolerance.xlsx', 'Range', 'A2:B2');

cost_tolerance = tolerance(1);
heat_tolerance = tolerance(2);

[rows columns] = size(preferenceRows);

disp(rows);
household = 1;
i = 1;
while 1
    preference = preferenceRows(i,:);
    size_of_home = preference(1);
    weather_outside = preference(2);
    inside_preference = preference(3);
    climate_outside = preference(4);
    size_of_panel = preference(5);
    no_of_panels = preference(6);
    cost_optimization = preference(7);
    bill_expectation_deviation = preference(8);
    thermal_expectation_deviation = preference(9);

    calculate;
    display;

    
    i = i + 1;
    while 1
       if (thermal_expectation_deviation > heat_tolerance)
           new_preference = thermal_expectation_deviation + heat_tolerance;
           if (new_preference > 7)
               new_preference = 7;
           elseif (new_preference < -7)
                   new_preference  = -7;
           end
           inside_preference = new_preference;
       end

       if (bill_expectation_deviation > cost_tolerance)
           new_optimization = cost_optimization + bill_expectation_deviation;
           if (new_optimization > 7)
               new_optimization = 7;
           end
           cost_optimization = new_optimization;
       end
       i = i + 1;

       if (preference(columns) <= heat_tolerance)&& (preference(columns - 1) <= thermal_tolerance)
           i = i + 1;
           household = household + 1;
           break;
       end
        
    end
    if (household == no_of_households)
        break;
    end
end
