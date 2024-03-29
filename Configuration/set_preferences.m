
% Reading inputs from excel sheet
numRows = readmatrix('Data/preferences.xlsx', 'Range', 'B2:B2');

preferenceRows = readmatrix('Data/preferences.xlsx', 'Range', strcat('A5:I', int2str(numRows + 4)) );

no_of_households = readmatrix('Data/preferences.xlsx', 'Range', 'A2:A2');

tolerance = readmatrix('Data/tolerance.xlsx', 'Range', 'A2:B2');

cost_tolerance = tolerance(1);
heat_tolerance = tolerance(2);

[rows, columns] = size(preferenceRows);

household = 1;
i = 1;
while 1
    if (i > rows)
            break;
       end;
    fprintf("\n\nHousehold %d\n", household);

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

    displayPreferences;

    calculate;
    
    display;
    
    while 1
        
       if (abs(thermal_expectation_deviation) > heat_tolerance)
           disp("thermal expecation isn't matched");
           new_preference = thermal_preference_deviation + inside_preference;
           if (new_preference > 14)
               new_preference = 14;
           elseif (new_preference < 0)
                   new_preference  = 0;
           end
           inside_preference = new_preference;
           thermal_preference_deviation = evalfis(thermal_preference_fis, [thermal_expectation_deviation]);
           disp('thermal preference deviation');
           disp(thermal_preference_deviation);
       end

% %        disp(bill_expectation_deviation);
% %        disp(thermal_expectation_deviation)

       if (bill_expectation_deviation > cost_tolerance)
           disp("cost expectation isn't matched.");
           new_optimization = cost_optimization + cost_optimization_deviation;
           if (new_optimization > 7)
               new_optimization = 7;
           end
           cost_optimization = new_optimization;
           cost_optimization_deviation = evalfis(cost_optimization_fis, [bill_expectation_deviation]);
       end
       i = i + 1;

       if (bill_expectation_deviation <= cost_tolerance) && (abs(thermal_expectation_deviation) <= heat_tolerance)
           disp("both expectations are matched\n");
           household = household + 1;
           break;
       end

       calculate;
       display;
       
       if (i > rows)
            break;
       end;

       preference = preferenceRows(i,:);
        bill_expectation_deviation = preference(8);
        thermal_expectation_deviation = preference(9);
% %         disp('thermal expectation dev');
% %         disp(thermal_expectation_deviation);
% %         disp("bill expectation dev");
% %         disp(bill_expectation_deviation);
        displayPreferences;
        
    end
    if (household == no_of_households +1)
        break;
    end
end
