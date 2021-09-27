function [y,z] = scan_radar2(x,w,plev)
if isnan(x) == true
    y = nan(length(plev),1);
    z = nan(length(plev),1);
    return
elseif sum(x) == 0
    y = zeros(length(plev),1);
    z = zeros(length(plev),1);
else
    y = zeros(length(plev),1);
    z = zeros(length(plev),1);
    for i = 1:length(x)
        y(x(i)) = x(i);
        z(plev == w(i)) = w(i);
    end
end
end