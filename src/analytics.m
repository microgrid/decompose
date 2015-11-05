%% main: lab measurments OFFGRID. CST.
function analytics()
	addpath('../')
	fig = 0;

	%-------------------------- OFFGRID -------------------------
	offgrid = load('../mat/log6_voltage.mat');
	s = offgrid.log6.data;

	L = length(s);
	fig = fig + 1;
	figure(fig)
	clf(fig)

	subplot(2,1, 1)
	titl = [offgrid.log6.subject ' measuremnt - ' offgrid.log6.location];
	plot_raw(s, 1:length(s), offgrid.log6.subject, titl);

	disp(['Assume f = 50 Hz']);
	disp('=== OFFGRID ===')
	disp(['Location: ' offgrid.log6.location]);
	disp(['Time: ' offgrid.log6.time]);

	subplot(2, 1, 2)
	freq_const = 9;
	hold on
	[f, V_f, Fs] = freq(s);
	plot_harmonics(f, V_f, Fs)

	disp(['Sampling frequency: ' num2str(round(Fs)) ' Hz']);

	format short

	thd_f = total_harmonic_distortion(V_f);
	disp(['Total Harmonic Distortion: ' num2str(20 * log10(thd_f)) ' dBc'])
	disp(['Total Harmonic Distortion: ' num2str((100 * thd_f)) ' %'])
	disp(['Total Harmonic Distortion: ' num2st(rthd(s, Fs, 1000)) ' dBc'])

	saveas(fig, '../fig/log_6_freq_spec.png', 'png')
	saveas(fig, '../fig/log_6_freq_spec.eps', 'epsc')

	V_f_offgrid = V_f;
	f_offgrid = f;

	%--------------------------- ONGRID ------------------------
	clearvars -except fig V_f_offgrid f_offgrid
	ongrid = load('../mat/log4_voltage.mat');
	s = ongrid.log4.data;

	L = length(s);
	fig = fig + 1;
	figure(fig)
	clf(fig)

	subplot(2,1, 1)
	titl = [ongrid.log4.subject ' measuremnt - ' ongrid.log4.location];
	plot_raw(s, 1:length(s), ongrid.log4.subject, titl);

	disp('=== ONGRID ===')
	disp(['Location: ' ongrid.log4.location]);
	disp(['Time: ' ongrid.log4.time]);

	subplot(2, 1, 2)
	freq_const = 9;
	hold on
	[f, V_f, Fs] = freq(s);
	plot_harmonics(f, V_f, Fs)

	disp(['Sampling frequency: ' num2str(round(Fs)) ' Hz']);

	format short

	thd_f = total_harmonic_distortion(V_f);
	disp(['Total Harmonic Distortion: ' num2str(20 * log10(thd_f)) ' dBc'])
	disp(['Total Harmonic Distortion: ' num2str((100 * thd_f)) ' %'])
	disp(['Total Harmonic Distortion: ' num2str(thd(s, Fs, 1000)) ' dBc'])

	saveas(fig, '../fig/log_4_freq_spec.png', 'png')
	saveas(fig, '../fig/log_4_freq_spec.eps', 'epsc')


	%------------------- Plot both ------------------------

	V_f_offgrid = 20* log10(V_f_offgrid ./ max(V_f_offgrid));
	V_f = 20* log10(V_f ./ max(V_f));

	fig = fig + 1;
	figure(fig)
	clf(fig)

	hold on
	plot(f, V_f, 'r')
	plot(f_offgrid, V_f_offgrid, 'b')
	axis([0 Fs/2 min(V_f(end/2:end)) max(V_f)+2])
	title('Spectrum analysis of on and offgrid')
	xlabel('Frequency [Hz]')
	ylabel('Relative amplitude [dB]')
	legend('Ongrid', 'Offgrid')
	hold off