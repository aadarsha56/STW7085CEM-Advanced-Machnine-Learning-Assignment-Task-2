opt = evalfisOptions('EmptyOutputFuzzySetMessage',"none");
warning('off','all')

% heat_flow from outside to inside or vice-versa
heat_flow = evalfis(heat_flow_fis, [size_of_home, weather_outside, inside_preference], opt);

opt = evalfisOptions('EmptyOutputFuzzySetMessage',"none");

% unit_production from renewable energy source (photovoltaic cell)
unit_production = evalfis(renewable_energy_fis, [climate_outside, size_of_panel], opt);

% total_production from solar panel
total_production = unit_production * no_of_panels; 

% net_energy required for the home
energy_difference = abs(heat_flow) - total_production;
fprintf("The energy difference is %d\n", energy_difference);
enough_energy_difference = -100;

% bill and use_hours
if (energy_difference < enough_energy_difference)
    bill = 0;
    hours_to_be_used = 0;
else
    if (energy_difference > 0)
        opt = evalfisOptions('EmptyOutputFuzzySetMessage',"none");

        bill_hours = evalfis(bill_hours_fis, [energy_difference, cost_optimization], opt); 
    else
        opt = evalfisOptions('EmptyOutputFuzzySetMessage',"none");

        bill_hours = evalfis(bill_hours_fis, [0, cost_optimization], opt);
    end
   
end

% cost_optimization_deviation from the estimated cost
opt = evalfisOptions('EmptyOutputFuzzySetMessage',"none");
cost_optimization_deviation = evalfis(cost_optimization_fis, bill_expectation_deviation, opt);

% thermal_preference_deviation from the estimated preference
opt = evalfisOptions('EmptyOutputFuzzySetMessage',"none");

thermal_preference_deviation = evalfis(thermal_preference_fis, thermal_expectation_deviation, opt);
