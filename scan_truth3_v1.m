function y = scan_truth3_v1(a,b)
    if isempty(a) == true
        c = nan(b-length(a),1);
        y = [c;a];
    else
        c = zeros(b-length(a),1);
        y = [c;a];
    end
end