% ~~~~~~~~~~~~~~~~~~~~~~
function [fra,fdec,fpath] = find_ra_and_dec_f(to,tf,orbittime,numsamp,numsamp_s,T,e,h,mu,Wo,Wdot,wpo,wpdot,incl,we)
% ~~~~~~~~~~~~~~~~~~~~~~
% Propagates the orbit over the specified time interval, transforming
% the position vector into the earth-fixed frame and, from that,
% computing the right ascension and declination histories. It also calls a
% function that computes the right ascension and declination histories for
% a 45 degree forward scan.

% ra - vector of right ascensions of the spacecraft (deg)
% dec - vector of declinations of the spacecraft (deg)
% r - perifocal position vector of satellite (km)
% R - geocentric equatorial position vector (km)
% R1 - DCM for rotation about z through RA
% R2 - DCM for rotation about x through incl
% R3 - DCM for rotation about z through wp
% QxX - DCM for rotation from perifocal to geocentric equatorial
% Q - DCM for rotation from geocentric equatorial into earth-fixed frame
% r_rel - position vector in earth-fixed frame (km)
% alpha - satellite right ascension (deg)
% delta - satellite declination (deg)
% forwardalpha - satellite right ascension (deg) for a 45 degree forward
%                scan
% forwarddelta - satellite declination (deg)
% ------------------------------------------------------------------------

%% Pre allocate arrays
times = linspace(to,tf,numsamp_s*orbittime);

fra = nan(1,numsamp*orbittime);
fdec = nan(1,numsamp*orbittime);
fpath = nan(1,numsamp*orbittime);
samplingdiff = nan(1,numsamp*orbittime);

%% Calculate Latitude and Longitude of Satellite for All Scanning Modes
for i = 1:length(times)
    t = times(i);                                           % time
    M = 2*pi/T*t;                                           % mean anomaly   
    E = kepler_E(e, M);                                     % eccentric anomaly
    TA = 2*atan(tan(E/2)*sqrt((1+e)/(1-e)));                % true anomaly
    r = h^2/mu/(1 + e*cos(TA))*[cos(TA) sin(TA) 0]';        % radius
    vp = (mu/h)*(-sin(TA)*[1;0;0]+(e + cos(TA))*[0;1;0]);   % periapsis velocity
    
    % Update RAAN and argument of periapsis
    W = Wo + Wdot*t;                                        % RAAN
    wp = wpo + wpdot*t;                                     % Argument of Periapsis
    % 1-3-1 Rotation
    R1 = [ cos(W) sin(W) 0                                  % RAAN Rotation
          -sin(W) cos(W) 0
            0       0    1];

    R2 = [1     0         0                                 % incl Rotation
          0  cos(incl) sin(incl)
          0 -sin(incl) cos(incl)];

    R3 = [ cos(wp) sin(wp) 0                                % Argument of Periapsis Rotation
          -sin(wp) cos(wp) 0
              0       0    1];

    QxX = (R3*R2*R1)';                                      % final rotation matrix
    R = QxX*r;                                              % 3d radius
    V = QxX*vp;                                             % 3d velocity
    
    theta = we*(t-to);                                      % change in angle of Earth
    Q = [ cos(theta) sin(theta) 0                           % Earth Rotation
         -sin(theta) cos(theta) 0
             0          0       1];
    r_rel = Q*R;                                            % Relative Radius
    v_rel = Q*V;                                            % Relative Velocity
    
    % Find Right Ascension and Declination (Forward)
    [forwardalpha, forwarddelta, timediff, flen] = forward_ra_and_dec_from_r_v3(r_rel,v_rel,pi/4);
    
    % Store Data for Output
    if i == 1
        fra(1) = forwardalpha;    % Forward
        fdec(1) = forwarddelta;   % Forward
        samplingdiff(1) = timediff;     % Forward
        fpath(1) = flen;                % Forward
    elseif mod(i-1,numsamp) == 0
        fra(((i-1)/numsamp)+1) = forwardalpha;    % Forward
        fdec(((i-1)/numsamp)+1) = forwarddelta;   % Forward
        samplingdiff(((i-1)/numsamp)+1) = timediff;     % Forward
        fpath(((i-1)/numsamp)+1) = flen;                % Forward
    end
end

%% Calculate time difference between forward and nadir scans
for ii= 1:length(times)/numsamp_s
    samplingdiff(ii) = samplingdiff(ii)/60; % convert to minutes
end
samplingdiffavg = mean(samplingdiff);       % find the average
fprintf('\n ----------------------------------------------------\n')
fprintf('\n The average time between the forward and nadir scan is %g minutes',samplingdiffavg)

end %find_ra_and_dec_f