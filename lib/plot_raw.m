%% plot_raw: function description
function plot_raw(signal, time, subject, fig_title)
	hold on
	plot(signal, 'b')
	rms_val = max(signal) / sqrt(2);
	tmp(1:length(signal)) = rms_val;
	plot(1:length(signal), tmp, 'r')

	hold off
	xlabel('time [s]')
	ylabel(subject)
	title(fig_title)
