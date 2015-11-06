%% big_data_analysis: function description
function big_data_analysis(arg)
	addpath('../lib')
	fig = 0;
	date_time = 1444294922616993;
	% date_time = 1444043021895000;
	raw = fileread(['../raw/' num2str(date_time) '.txt']);

	raw = strsplit(raw, '\n');
	tmp = [];
	proc.t = [];
	proc.voltage = [];
	proc.current = [];

	i = 0;
	for x = raw(150:end)
		tmp = char(x);
		tmp = strrep(tmp, '\n', '');
		tmp = str2num(tmp);
		if length(tmp) == 3
			t 		= tmp(1);
			voltage = tmp(2);
			current = tmp(3);

			proc.t(end + 1) = t;
			proc.voltage(end + 1) = voltage;
			proc.current(end + 1) = current;
			i = i + 1;
		end
	end

	proc.voltage(:) = proc.voltage(:) - mean(proc.voltage);
	proc.current(:) = proc.current(:) - mean(proc.current);

	fig = fig + 1;
	figure(fig)
	clf(fig)
	hold on

	r = 1500:1500+2*20;

	proc.current(r) = proc.current(r) ./ (max(proc.current(r)));
	proc.voltage(r) = proc.voltage(r) ./ max(proc.voltage(r));

	plot(proc.t(r), proc.voltage(r), 'k')
	plot(proc.t(r), proc.current(r), 'k--')
	power = proc.voltage(r) .* proc.current(r);
	% power = power - mean(power);
	plot(proc.t(r), power, 'b')

	plot(proc.t(r), zeros(1, length(proc.t(r))), 'k')

	legend('Voltage', 'Current', 'Power')
	title('Voltage and current measurments on offgrid')
	xlabel('time [\mus]')
	ylabel('Normalized amplitude')

	axis([proc.t(r(1)) proc.t(r(end)) -1.1 1.1])
	saveas(fig, '../fig/volt_current_together.png', 'png')
	hold off

	disp(epoch_to_date(date_time));
	phs = detect_phase_shift(proc);
	disp(['Phase shift: ' num2str(100 * phs) ' %']);
