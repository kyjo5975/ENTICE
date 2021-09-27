function z = scan_radar3(w,x,plev,thold)
z = nan(size(w,1),size(w,2));

for i = 1:size(w,2)
    if sum(isnan(w(:,i))) ~= size(w,1) && sum(x(:,i) > thold) ~= 0
        p_index = rmmissing(x(:,i));
        z(p_index,i) = plev(p_index);
    end
end
end