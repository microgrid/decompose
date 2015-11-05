%% plot_harmonics: function description
function plot_harmonics(f, X_f, Fs)
	
	hold on
	X_f = 100 .* X_f ./ max(X_f); % Normalize
	semilogy(f, X_f, 'b')

	[pks locs] = findpeaks(X_f, f);
	% axis([0 max(f) 0 max(X_f)+10])
	axis([locs(2)-50 Fs/2 0 pks(2)+1])

	% for i = 1:length(pks)
	% 	x = locs(i);
	% 	plot([x x], [0 pks(i)], 'r')
	% end

	% line([50 50], [0 500])

	xlabel('Frequency (Hz)')
	ylabel('Amplitude [% of standing wave]')
	title('Frequency spectrum of harmonics')
