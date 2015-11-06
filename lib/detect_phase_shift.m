%% detect_phase_shift: 
% 
% input: data struct containting time, voltage and current
% 
% output: phase shift in % of total period
% 
function phs = detect_phase_shift(data)
	t0 = 0;
	t = 0;
	v_cross_0 = 0;
	for i = 2:length(data.t)
		if (data.voltage(i-1) > 0) && (data.voltage(i) <= 0)
			t0 = data.t(i);
			v_cross_0 = 1;
		end
		if v_cross_0 && (data.current(i-1) > 0) && (data.current(i) <= 0)
			t = data.t(i);
			break;
		end
	end

	if t0 > t
		disp('uflaks: t0 > t')
		phs = -1;
	else
		num_of_periods = period_count(data.voltage);
		T = (data.t(end)-data.t(1))/num_of_periods;
		phs = (t - t0)/T;
	end


	
