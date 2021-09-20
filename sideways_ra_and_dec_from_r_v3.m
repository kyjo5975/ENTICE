
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function  [sidealpha, sidedelta, spath] = sideways_ra_and_dec_from_r_v3(r,v,sscan,time,numsamp)
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    %{
        This function calculates the right ascension and the
        declination from the geocentric equatorial position vector for a 45
        degree sideward scan. All measurements are in km, seconds, and
        radians
    %}
    % ----------------------------------------------
    
    %Constants
    Re = 6378;
    
    %The first step is to change the angle from the scan angle to a 
    %geocentric angle. We also need to figure out the angle for the scan.
    if time == 1
        scanangle = sscan/numsamp*time-sscan/2;
    elseif mod(floor((time-1)/numsamp),2) == 0
        if time > 2*numsamp
            time = mod(time,2*numsamp);
        end
        scanangle = sscan/numsamp*time-sscan/2;
    elseif mod(floor((time-1)/numsamp),2) == 1
       if time > 2*numsamp
            time = mod(time,2*numsamp);
       end
       scanangle = (-sscan/numsamp*time+3/2*sscan);
       if time == 0
           scanangle = -sscan/2;
       end
    end
    scanangle = deg2rad(scanangle);                     % convert to radians
    middleangle = pi-asin(sin(scanangle)/Re*norm(r));   % find the middle angle
    secondangle = pi-middleangle-scanangle;             % find the angle to rotate
    
    %The second step is to find the axis about which we are rotating.
    fdir = v/norm(v);   % unit vector of velocity
    
    %The third step is to calculate the rotation matrix   
    T = [cos(secondangle)+fdir(1)^2*(1-cos(secondangle)) fdir(1)*fdir(2)*(1-cos(secondangle))-fdir(3)*sin(secondangle) fdir(1)*fdir(3)*(1-cos(secondangle))+fdir(2)*sin(secondangle)
         fdir(2)*fdir(1)*(1-cos(secondangle))+fdir(3)*sin(secondangle) cos(secondangle)+fdir(2)^2*(1-cos(secondangle)) fdir(2)*fdir(3)*(1-cos(secondangle))-fdir(1)*sin(secondangle)
         fdir(3)*fdir(1)*(1-cos(secondangle))-fdir(2)*sin(secondangle) fdir(3)*fdir(2)*(1-cos(secondangle))+fdir(1)*sin(secondangle) cos(secondangle)+fdir(3)^2*(1-cos(secondangle))];
    
    % The fourth step is to find the r vector
    scanr = T*r;    % scan radius that we use to find ra and dec of the side scan
    
    % Find and scale the path length
    unit_scan = scanr./norm(scanr); % unit vector of scan radius
    spath = norm(r-Re*unit_scan);   % calculate path from original radius to scan radius intersection of Earth
    spath = 72/(norm(r)-Re)*spath;  % scaled down path length that passes through the model atmosphere
    
    %Then just get the new right ascension and declination from
    %find_ra_dec_from_r
    [sidealpha, sidedelta] = ra_and_dec_from_r(scanr);
    
end
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~