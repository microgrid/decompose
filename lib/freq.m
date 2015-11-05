%% freq: Assume 50 Hz. Gives back frequency spectrum
function [f, X_f, Fs] = freq(signal)
	L = length(signal);
	num_of_periods = period_count(signal);
	Fs = L / ((1/50) * num_of_periods) ; 	% Calculate sampling frequency

	dt = 1/Fs; 										% seconds per sample
	dF = Fs / L;						% Herz

	X_f = fft(signal);
	X_f = abs(X_f/L);
	X_f = X_f(1:L/2);
	X_f(2:end-1) = 2*X_f(2:end-1); % Hz

	f = 0 : dF : Fs/2 - dF;

	
