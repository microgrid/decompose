%% plot_harmonics: function description
function plot_harmonics(f, X_f, Fs)
	
	hold on
	X_f = X_f ./ max(X_f); % Normalize
	X_f = 20 * log10 (X_f);
	% semilogy(f, X_f, 'b')
	plot(f, X_f, 'b')

	[pks locs] = findpeaks(X_f, f);
	% axis([locs(2)-50 Fs/2 0 pks(2)+1])
	axis([0 Fs/2 min(X_f(end/2:end)) max(X_f)+2])

	% for i = 1:length(pks)
	% 	x = locs(i);
	% 	plot([x x], [0 pks(i)], 'r')
	% end

	% line([50 50], [0 500],[-100 100],'Color','b','LineWidth',1,'LineStyle','-')
	
	% loc_harm = locs(1);
	% first_harm = loc_harm;
	% for i = 1:1:Fs 
	% 	loc_harm = i * first_harm;
	% 	if loc_harm > max(f)
	% 	 	break;
	% 	end
	% 	line([loc_harm loc_harm],[-100 100],'Color','r','LineWidth',1,'LineStyle','-')	
	% end

	xlabel('Frequency (Hz)')
	% ylabel('Amplitude [% of standing wave]')
	ylabel('Amplitude relative to standing wave [dB]')
	title('Frequency spectrum of harmonics')