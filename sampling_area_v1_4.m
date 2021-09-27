function [at,at_ice] = sampling_area_v1_4(numsamp,ra,dec,lat1,long1,lat2,long2)
% ~~~~~~~~~~~~~~~~~~~~~~
% Finds out how many times and when the satellite is in a certain area, converts that time to a
% general hourly time and plots it on a histogram.

% lat1 - the lower latitude bound
%     long1 - the lower longitude bound
%     lat2 - the upper latitude bound
%     long2 - the upper longitude bound
%     orbittime the length in seconds of the simulation
%     earth - a equirectangular map of Earth
%     areatimes- a vector containing the times the satellite is in a 
%                specified area
%     areatimesforward- a vector containing the times the satellite is in a 
%                specified area for the forward scan

% ------------------------------------------------------------------------

%checks if the nadir satellite is in the given area and converts to local time
at = find(ra);
at = at((((ra <= long2) & (ra >= long1)) & ((dec >= lat1) & (dec <= lat2)))==true);
at_ice = at;
at = mod(at/3600/numsamp,24);

end %sampling_area
%~~~~~~~~~~~~~~~~~~~~~~~~