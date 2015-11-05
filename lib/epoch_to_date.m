%% epoch_to_date(time_micros): Convert epoch time in micros to string
% 
% Input: time_micros, the number of micro seconds between date-time and 1. Jan 1979
%
% Output: String containing the date-time on the format 'day month year hour:minute:seconds 
%
function [time_string] = epoch_to_date(time_micros)
	epoch_time = time_micros / 1000;
	time_reference = datenum('1970', 'yyyy');
	time_matlab = time_reference + epoch_time / 8.64e7;
	time_string = datestr(time_matlab, 'dd mmm yyyy HH:MM:SS.FFF');
