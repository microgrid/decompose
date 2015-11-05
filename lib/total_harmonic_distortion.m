%% total_harmonic_distortion: function description
function thd = total_harmonic_distortion(X_f)
	thd = sqrt(sum(X_f.^2)) / max(X_f) - 1;
