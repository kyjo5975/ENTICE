function [y,z] = scan_radiometer_v2(w,x,plev,thold)
y = nan(1,size(w,2));
z = nan(1,size(w,2));
for i = 1:size(w,2)
    if sum(isnan(w(:,i))) ~= size(w,1) && sum(x(:,i) > thold) ~= 0  
        y(i) = find(x(:,i) > thold,1);
        z(i) = plev(y(i));
    end
end