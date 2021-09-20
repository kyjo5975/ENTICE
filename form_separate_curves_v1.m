function [RA,Dec,n_curves] = form_separate_curves_v1(ra,dec)
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Breaks the ground track up into separate curves which start
% and terminate at right ascensions in the range [0,360 deg].

% n_curves - number of curves comprising the ground track plot
%     n_forward_curves - number of curves comprising the ground track plot
%                        for a 45 degree forward scan
%     RA - cell array containing the right ascensions for each of the curves 
%          comprising the ground track plot
%     Dec - cell array containing the declinations for each of the curves 
%           comprising the ground track plot
%     forwardRA - cell array containing the right ascensions for each of the
%                 curves comprising the ground track plot for a 45 degree 
%                 forward scan
%     forwardDec - cell array containing the declinations for each of the
%                  curves comprising the ground track plot for a 45 degree 
%                  forward scan
% ---------------------------
tol = 100;
curve_no = 1;
n_curves = 1;
ra_prev = ra(1);

k = 0;
for i = 1:length(ra)
    if abs(ra(i) - ra_prev) > tol
        curve_no = curve_no + 1;
        n_curves = n_curves + 1;
        k = 0;
    end
    k = k + 1;
    RA{curve_no}(k) = ra(i);
    Dec{curve_no}(k) = dec(i);
    ra_prev = ra(i);
end

end %form_separate_curves