
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function  [conealpha, conedelta,cpath] = cone_ra_and_dec_from_r(r,v,fscan,sscan,time,numsamp)
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
    %rvalue = norm(initialr);
    intermediateangle = pi-asin(sin(fscan)/Re*norm(r));
    actualangle = pi-fscan-intermediateangle; % angle rotated forward
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
    scanangle = deg2rad(scanangle);
    middleangle = pi-asin(sin(scanangle)/Re*norm(r));
    secondangle = pi-middleangle-scanangle;
    
    %The second step is to find the axis about which we are rotating. We
    %also needed
    rotvector = cross(r,v);
    rotvector = rotvector/norm(rotvector);
    fdir = v/norm(v);
    
    %The third step is to calculate the rotation matrix
    R = [cos(actualangle)+rotvector(1)^2*(1-cos(actualangle)) rotvector(1)*rotvector(2)*(1-cos(actualangle))-rotvector(3)*sin(actualangle) rotvector(1)*rotvector(3)*(1-cos(actualangle))+rotvector(2)*sin(actualangle)
     rotvector(2)*rotvector(1)*(1-cos(actualangle))+rotvector(3)*sin(actualangle) cos(actualangle)+rotvector(2)^2*(1-cos(actualangle)) rotvector(2)*rotvector(3)*(1-cos(actualangle))-rotvector(1)*sin(actualangle)
     rotvector(3)*rotvector(1)*(1-cos(actualangle))-rotvector(2)*sin(actualangle) rotvector(3)*rotvector(2)*(1-cos(actualangle))+rotvector(1)*sin(actualangle) cos(actualangle)+rotvector(3)^2*(1-cos(actualangle))];
    
    T = [cos(secondangle)+fdir(1)^2*(1-cos(secondangle)) fdir(1)*fdir(2)*(1-cos(secondangle))-fdir(3)*sin(secondangle) fdir(1)*fdir(3)*(1-cos(secondangle))+fdir(2)*sin(secondangle)
      fdir(2)*fdir(1)*(1-cos(secondangle))+fdir(3)*sin(secondangle) cos(secondangle)+fdir(2)^2*(1-cos(secondangle)) fdir(2)*fdir(3)*(1-cos(secondangle))-fdir(1)*sin(secondangle)
      fdir(3)*fdir(1)*(1-cos(secondangle))-fdir(2)*sin(secondangle) fdir(3)*fdir(2)*(1-cos(secondangle))+fdir(1)*sin(secondangle) cos(secondangle)+fdir(3)^2*(1-cos(secondangle))];
    %The fourth step is to find the r vector
    scanr = T*R*r;
    unit_scan = scanr./norm(scanr);
    
    cpath = norm(r-Re*unit_scan);
    cpath = 72/(norm(r)-Re)*cpath;  % scaled down path length that passes through the model atmosphere
    
    %Then just get the new right ascension and declination from
    %find_ra_dec_from_r
    [conealpha, conedelta] = ra_and_dec_from_r(scanr);
    
%      figure(1)%This is a test figure to make sure that the vectors are
%      %right
%      hold on
%      quiver3(0,0,0,initialr(1)/norm(initialr),initialr(2)/norm(initialr),initialr(3)/norm(initialr))
%      quiver3(0,0,0,scanr(1)/norm(scanr),scanr(2)/norm(scanr),scanr(3)/norm(scanr))
%      quiver3(initialr(1)/norm(initialr),initialr(2)/norm(initialr),initialr(3)/norm(initialr),initialv(1)/norm(initialv),initialv(2)/norm(initialv),initialv(3)/norm(initialv))
%      hold off
end
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~