%% period_count: Counts the number of periods in a given ca 50 Hz signal
function [num_of_periods] = period_count(signal)
	falling_zero_crossings = [];

	for i = 2:length(signal)
		if (signal(i-1) > 0) && (signal(i) <= 0)
			falling_zero_crossings(end+1) = i;
		end
		if length(falling_zero_crossings) > 2
			break;
		end
	end

	if falling_zero_crossings < 2
		num_of_periods = 0;
	else
		length_of_period = falling_zero_crossings(2) - falling_zero_crossings(1);
		num_of_periods = length(signal) / length_of_period;	
	end