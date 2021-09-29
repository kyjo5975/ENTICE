% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function ground_tracks_v8
% ~~~~~~~~~~~~~~~~
%{
    This program plots the ground track of an earth satellite
    for which the orbital elements are specified.
    
    mu - gravitational parameter (km^3/s^2)
    deg - factor that converts degrees to radians
    J2 - second zonal harmonic 
    Re - earth's radius (km)
    we - earth's angular velocity (rad/s)
    rP - perigee of orbit (km)
    rA - apogee of orbit (km)
    TA, TAo - true anomaly, initial true anomaly of satellite (rad)
    RA, RAo - right ascension, initial right ascension of the node (rad)
    forwardra - vector of right ascenion for the 45 degree forward scan
    forwarddec - vector of declination for the 45 degree forward scan
    incl - orbit inclination (rad)
    wp, wpo - argument of perigee, initial argument of perigee (rad)
    n_periods - number of periods for which ground track is to be plotted
    a - semimajor axis of orbit (km)
    T - period of orbit (s)
    e - eccentricity of orbit
    h - angular momentum of orbit (km^2/s)
    E, Eo - eccentric anomaly, initial eccentric anomaly (rad)
    M, Mo - mean anomaly, initial mean anomaly (rad)
    to, tf - initial and final times for the ground track (s)
    fac - common factor
    RAdot - rate of regression of the node (rad/s)
    wpdot - rate of advance of perigee (rad/s)
    times - times at which ground track is plotted (s)
     
    

    User M-functions required: kepler_E, ra_and_dec_from_r, 
                               forward_ra_and_dec_from_r
%}
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clear all; close all; clc

% Constants
% deg = pi/180;                       % convert rad 2 deg
% mu = 398600;                        % Gravitational Parameter
% J2 = 0.00108263;                    % J2 effect
% Re = 6378;                          % Radius of Earth
% we = (2*pi+2*pi/365.26)/(24*3600);  % Rate of Orbit

%% Data Declaration
orbittime = 24*3600;  % how long the satellite is in orbit
lat1 = -12;          % first latitude of the area of interest
lat2 = 12;          % second latitue of the area of interest
long1 = 150+180;         % first longitude of the area of interest
long2 = 170+180;        % second longitude of the area of interest
% orbit = 'GPM';      % specific orbit model
% numsamp = 10;       % number of samples per second
% numsamp_s = 10*numsamp;

% % Specific Orbit Models
% if strcmp(orbit, 'ISS') == true
%     rP = 409+Re;        % radius of perigee
%     rA = 419+Re;        % radius of apogee
%     incl = 51.6384*deg; % inclination
%     Wo = 247.4627*deg;  % RAAN
%     wpo = 120.3202*deg; % argument of periapsis
% elseif strcmp(orbit, 'Earthcare') == true
%     rP = 393.14+Re;     % radius of perigee
%     rA = 393.14+Re;     % radius of apogee
%     incl = 97.05*deg;   % inclination
%     Wo = 0*deg;         % RAAN
%     wpo = 0*deg;        % argument of periapsis
% elseif strcmp(orbit, 'GPM') == true
%     rP = 393+Re;        % radius of perigee
%     rA = 408+Re;        % radius of apogee
%     incl = 65*deg;      % inclination
%     Wo = 340*deg;       % RAAN
%     wpo = 0*deg;      % argument of periapsis
% elseif strcmp(orbit, 'Testorbit') == true
%     rP = 395+Re;        % radius of perigee
%     rA = 405+Re;        % radius of apogee
%     incl = 80*deg;      % inclination
%     Wo = 236*deg;       % RAAN
%     wpo = 282*deg;      % argument of periapsis
% else
%     fprintf('Goodbye!\n')
% end
% TAo = (0)*deg;              % initial True Anomaly
% a = (rA + rP)/2;            % semi major axis
% T = 2*pi/sqrt(mu)*a^(3/2);  % period
% n_periods = orbittime/T;    % number of periods

%% Calculated Orbit Information
%Compute the initial time (since perigee) and the rates of node regression and perigee advance
% e = (rA - rP)/(rA + rP);                        % Eccentricity 
% h = sqrt(mu*a*(1 - e^2));                       % Angular Momentum
% Eo = 2*atan(tan(TAo/2)*sqrt((1-e)/(1+e)));      % Initial Eccentric Anomaly
% Mo = Eo - e*sin(Eo);                            % Initial Mean Anomaly 
% to = Mo*(T/2/pi);                               % Initial Time
% tf = to + n_periods*T;                          % Final Time
% fac = -3/2*sqrt(mu)*J2*Re^2/(1-e^2)^2/a^(7/2);  % J2 Factor
% Wdot = fac*cos(incl);                           % Change in RAAN
%wpdot = fac*(5/2*sin(incl)^2 - 2);              % Change in Argument of Periapsis

%% Simulation
load('simstart.mat');

% Find the right ascension and declination for nadir, forward, side, and cone scanning methods
[ra,dec] = find_ra_and_dec_n(to,tf,orbittime,numsamp,numsamp_s,T,e,h,mu,Wo,Wdot,wpo,wpdot,incl,we);
[fra,fdec,fpath] = find_ra_and_dec_f(to,tf,orbittime,numsamp,numsamp_s,T,e,h,mu,Wo,Wdot,wpo,wpdot,incl,we);
[sra,sdec,spath] = find_ra_and_dec_s(to,tf,orbittime,numsamp,numsamp_s,T,e,h,mu,Wo,Wdot,wpo,wpdot,incl,we,Re);
[cra,cdec,cpath] = find_ra_and_dec_c(to,tf,orbittime,numsamp,numsamp_s,T,e,h,mu,Wo,Wdot,wpo,wpdot,incl,we);

% save one_month
% Get the right ascension and declination in plotting form
[RA,Dec,n_curves] = form_separate_curves_v1(ra,dec);
[fRA,fDec,n_f_curves] = form_separate_curves_v1(fra,fdec);
[sRA,sDec,n_s_curves] = form_separate_curves_v1(sra,sdec);
[cRA,cDec,n_c_curves] = form_separate_curves_v1(cra,cdec);

% Plot the Ground Tracks of all the scanning methods
plot_ground_track(n_curves,RA,Dec,ra,dec,n_f_curves,fRA,fDec,fra,fdec,n_s_curves,sRA,sDec,sra,sdec,n_c_curves,cRA,cDec,cra,cdec,orbittime,long1,lat1,long2,lat2)

% Track how many times and at what local time the satellite passes over the area of interest
[atn,at_ice] = sampling_area_v1_4(numsamp,ra,dec,lat1,long1,lat2,long2);
atf = sampling_area_v1_4(numsamp,fra,fdec,lat1,long1,lat2,long2);
ats = sampling_area_v1_4(numsamp_s,sra,sdec,lat1,long1,lat2,long2);
atc = sampling_area_v1_4(numsamp_s,cra,cdec,lat1,long1,lat2,long2);
[iwp,iwpnum] = sampling_area_iwp(ra,dec,at_ice,numsamp);
sampling_area_fig_v2(atn,atf,ats,atc,at_ice,iwp,iwpnum,lat1,long1,lat2,long2);

% Run the scanning methods through the geos5 atmosphere
clouddatageos_v7_6(numsamp,numsamp_s,ra,dec,fra,fdec,fpath,sra,sdec,spath,cra,cdec,cpath)

% % Save all the generated figures in a directory and Finished Data
% save_all_figures_to_directory('C:\Users\kbayj\Documents\MATLAB\JPL Work\Figures_2021_09_01')
save('simfin',to,tf,orbittime,numsamp,numsamp_s,T,e,h,mu,Wo,Wdot,wpo,wpdot,incl,we);

end %ground_track
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~