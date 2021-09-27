function [w,y,z] = scan_radar(a,b,threshold,plev)
    if isempty(a) == true
        w = nan(length(plev),1);
        y = nan(length(plev),1);
    else
        w = b((a > threshold));
        y = plev(w);
        z = a(w);
    end
end