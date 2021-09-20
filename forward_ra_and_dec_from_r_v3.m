% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function  [falpha, fdelta, timediff, fpath] = forward_ra_and_dec_from_r_v3(r,v,fscan)
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    %{
        This function calculates the right ascension and the
        declination from the geocentric equatorial position vector for a 45
        degree forward scan. All measurements are in km, seconds, and
        radians
    %}
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    % Constants
    Re = 6378;  % Radius of Earth
    
    % The first step is to change the angle from the scan angle to a 
    %geocentric angle. We also need to figure out the angle for the scan.

    middleangle = pi-asin(sin(fscan)/Re*norm(r));    % angle you don't need but can easily calculate with law of sines
    angle2 = pi-middleangle-fscan;                              % angle you do need and get assuming a euclidean triangle
    %fpath =norm(r)/sin(middleangle)*sin(angle2);         % path length of the scan using law of sines
    %fpath = 72/(norm(r)-Re)*fpath;                   % scaled down path length that passes through the model atmosphere
    
    % The second step is to find the axis about which we are rotating.
    fdir = cross(r,v)/norm(cross(r,v));
    
    % The third step is to calculate the rotation matrix   
    T = [cos(angle2)+fdir(1)^2*(1-cos(angle2)) fdir(1)*fdir(2)*(1-cos(angle2))-fdir(3)*sin(angle2) fdir(1)*fdir(3)*(1-cos(angle2))+fdir(2)*sin(angle2)
         fdir(2)*fdir(1)*(1-cos(angle2))+fdir(3)*sin(angle2) cos(angle2)+fdir(2)^2*(1-cos(angle2)) fdir(2)*fdir(3)*(1-cos(angle2))-fdir(1)*sin(angle2)
         fdir(3)*fdir(1)*(1-cos(angle2))-fdir(2)*sin(angle2) fdir(3)*fdir(2)*(1-cos(angle2))+fdir(1)*sin(angle2) cos(angle2)+fdir(3)^2*(1-cos(angle2))];
    
    % The fourth step is to find the r vector
    scanr = T*r;
    unit_scan = scanr./norm(scanr);
    
    fpath = norm(r-Re*unit_scan);
    fpath = 72/(norm(r)-Re)*fpath;  % scaled down path length that passes through the model atmosphere
    
    %Then just get the new right ascension and declination from
    %find_ra_dec_from_r and the time difference
    [falpha, fdelta] = ra_and_dec_from_r(scanr);    % Latitude and Longitue of the forward scan
    timediff = norm(r)*angle2/norm(v);              % Difference in time between the nadir and forward scan
end
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~