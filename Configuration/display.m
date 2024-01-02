outFile = './data/genBill.xlsx';

fprintf("The heat flow over the month is %.2f KWh.\n", heat_flow);
fprintf("Total production: %.2f KWh.\n", total_production);
fprintf("The net energy requirement is %.2f KWh.\n", energy_difference);
fprintf("The bill for the month is %.2f $ and the hours should be %.2f (peak to non-peak from 0 to 7).\n", bill_hours(1), bill_hours(2));
fprintf("The cost optimization deviation is %.2f.\n", cost_optimization_deviation);
fprintf("The thermal optimization deviation is %.2f.\n\n", thermal_preference_deviation);

writematrix(bill_hours, outFile, 'WriteMode','append')