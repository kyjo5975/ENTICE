function [iwp,iwpnum] = sampling_area_iwp(ra,dec,at_ice,numsamp)
    ra = ra-180;
    ra_iwp = ra(at_ice);
    dec_iwp = dec(at_ice);
    file_iwp = 'https://opendap.nccs.nasa.gov/dods/OSSE/G5NR/Ganymed/7km/0.0625_deg/inst/inst30mn_2d_met1_Nx';
    cloudlon = ncread(file_iwp,'lon');                                  % longitude
    cloudlon((length(cloudlon))/2+1) = 0;
    cloudlat = ncread(file_iwp,'lat',305,2273);                         % latitude
    cloudlat((length(cloudlat)-1)/2+1) = 0;
    cloudtime = ncread(file_iwp,'time');
    daydiff = cloudtime(1) - (datenum([2005 05 15 21 30 00]) - datenum([0001 01 01 00 00 00]));
    start = datenum([2006 07 15 00 00 00])-datenum([0001 01 01 00 00 00])+daydiff;
    cloudpath = ncread(file_iwp,'iwp',[1 305 find(cloudtime == start,1)],[Inf 2273 1]);
    iwp = nan(1,length(at_ice));
    for i = 1:length(at_ice)
        if i~= at_ice(1)
            at_diff = at_ice(i)-at_ice(i-1);
            if at_diff ~= 1
                t = at_ice(i)/numsamp/3600/24+start;
                t = round(t*48)/48;
                clear cloudpath
                cloudpath = ncread(file_iwp,'iwp',[1 305 find(cloudtime == t,1)],[Inf 2273 1]);
            end
        end
        lon = round(ra_iwp(i)*16)/16;
        if lon > 179
            lon = 179;
        end
        lat = round(dec_iwp(i)*16)/16;
        iwp(i) = cloudpath(cloudlon==lon,cloudlat==lat);
    end
    iwp = log10(iwp*1e3);
    iwp(isinf(abs(iwp))) = NaN;
    iwpnum = zeros(8,4);
    for i = 1:length(iwp)
        j = floor((at_ice(i)-1)/36000)+1; % calculate hour
        if j > 24
            j = mod(j,24);  % get in 24 hour scale
            if j == 0
                j = 1;
            end
        end
        j = ceil(j/3);
        iwpnum(j,1) = ((log10(0.01)) <= iwp(i) && (iwp(i) < log10(1)))+iwpnum(j,1);
        iwpnum(j,2) = ((log10(1) <= iwp(i) && iwp(i) < log10(10)))+iwpnum(j,2);
        iwpnum(j,3) = ((log10(10) <= iwp(i) && iwp(i) < log10(100)))+iwpnum(j,3);
        iwpnum(j,4) = (log10(100) <= iwp(i))+iwpnum(j,4);
    end
end