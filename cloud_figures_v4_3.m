function cloud_figures_v4_3(c_n,c_f,c_s,c_c,plev)

%% Set Up
threshold = 1e-6; %kg/kg

p_n = linspace(1,length(c_n),length(c_n));

plev_cell1 = cell(1,length(c_n));
plev_cell2 = cell(1,length(c_s));
thold_cell1 = cell(1,length(c_n));
thold_cell2 = cell(1,length(c_s));
truth_threshold_cell1 = cell(1,length(c_n));
zero_cell2 = cell(1,length(c_s));
plevf_cell = cell(1,length(c_n));
plevs_cell = cell(1,length(c_s));
plevc_cell = cell(1,length(c_s));

catnames = categorical({'Nadir' 'Forward Pointing' 'Side' 'Cone' 'Radar'});
catnames = reordercats(catnames,{'Nadir' 'Forward Pointing' 'Side' 'Cone' 'Radar'});

hours = linspace(0,21,8);
cloudnum_n = zeros(1,length(hours)); cloudnum_f = zeros(1,length(hours));
cloudnum_s = zeros(1,length(hours)); cloudnum_c = zeros(1,length(hours));
cloudnum_r = zeros(1,length(hours)); 
cloudnum_nt = zeros(1,length(hours)); cloudnum_ft = zeros(1,length(hours));
cloudnum_st = zeros(1,length(hours)); cloudnum_ct = zeros(1,length(hours));
iwpnum = zeros(4,length(hours));

%% Truth
% Set Up
plev_f = plev(c_f{2,1})+linspace(1e-2,1e-1,length(c_f{2,1}))';

[s_len,s_len_i] = max(cell2mat(cellfun(@length,c_s(1,:),'UniformOutput',false)));
plev_s = plev(c_s{2,s_len_i})+linspace(1e-2,1e-1,length(c_s{2,s_len_i}))';
s_len_cell = cell(1,length(c_s(1,:)));
for i = 1:length(s_len_cell)
    s_len_cell{1,i} = s_len;
end

[c_len,c_len_i] = max(cell2mat(cellfun(@length,c_c(1,:),'UniformOutput',false)));
plev_c = plev(c_c{2,c_len_i})+linspace(1e-2,1e-1,length(c_c{2,c_len_i}))';
c_len_cell = cell(1,length(c_c(1,:)));
for i = 1:length(c_len_cell)
    c_len_cell{1,i} = c_len;
end

for i = 1:length(c_n)
    plev_cell1{i} = plev;
    thold_cell1{i} = threshold;
    truth_threshold_cell1{i} = 0;
    plevf_cell{i} = plev_f;
end

for i = 1:length(c_s)
    plev_cell2{i} = plev;
    thold_cell2{i} = threshold;
    zero_cell2{i} = 0;
    plevs_cell{i} = plev_s;
    plevc_cell{i} = plev_c;
end

% Nadir
scan_truth_n = log10(squeeze(cell2mat(c_n(1,:))))';
scan_truth_n(isinf(abs(scan_truth_n))) = NaN;

[scan_truth_count_n,scan_truth_count_2] = cellfun(@scan_radar,c_n(1,:),c_n(2,:),truth_threshold_cell1,plev_cell1,'UniformOutput',false);
[scan_truth_count_n,~] = cellfun(@scan_radar2,scan_truth_count_n,scan_truth_count_2,plev_cell1,'UniformOutput',false);
scan_truth_count_n = cell2mat(scan_truth_count_n);
scan_truth_count_n = rmmissing(scan_truth_count_n,2);
scan_truth_count_n(scan_truth_count_n == 0) = NaN;
scan_truth_count_n(scan_truth_n < log10(1e-8)) = NaN;
scan_truth_n(scan_truth_n < log10(1e-8)) = NaN;

scan_truth_iwp = log10(cell2mat(squeeze(c_n(3,:)))*1e3);
scan_truth_iwp(isinf(abs(scan_truth_iwp))) = NaN;

% Forward
scan_truth_f = log10(squeeze(cell2mat(c_f(1,:))));
scan_truth_f(isinf(abs(scan_truth_f))) = NaN;

[scan_truth_count_f,scan_truth_count_2] = cellfun(@scan_radar,c_f(1,:),c_f(2,:),truth_threshold_cell1,plevf_cell,'UniformOutput',false);
[scan_truth_count_f,~] = cellfun(@scan_radar2,scan_truth_count_f,scan_truth_count_2,plevf_cell,'UniformOutput',false);
scan_truth_count_f = cell2mat(scan_truth_count_f);
scan_truth_count_f = rmmissing(scan_truth_count_f,2);
scan_truth_count_f(scan_truth_count_f == 0) = NaN;
scan_truth_count_f(scan_truth_f < log10(1e-8)) = NaN;
scan_truth_f(scan_truth_f < log10(1e-8)) = NaN;

% Side
scan_truth_s = (cell2mat(cellfun(@scan_truth3_v1,c_s(1,:),s_len_cell,'UniformOutput',false)));
scan_truth_s = rmmissing(scan_truth_s,2,'MinNumMissing',size(scan_truth_s,1));
scan_truth_s = log10(scan_truth_s);
scan_truth_s(isinf(abs(scan_truth_s)))=NaN;

[scan_truth_count_s,scan_truth_count_2] = cellfun(@scan_radar,c_s(1,:),c_s(2,:),zero_cell2,plevs_cell,'UniformOutput',false);
[scan_truth_count_s,~] = cellfun(@scan_radar2,scan_truth_count_s,scan_truth_count_2,plevs_cell,'UniformOutput',false);
scan_truth_count_s = cell2mat(scan_truth_count_s);
scan_truth_count_s = rmmissing(scan_truth_count_s,2);
scan_truth_count_s(scan_truth_count_s == 0) = NaN;
scan_truth_count_s(scan_truth_s < log10(1e-8)) = NaN;
scan_truth_s(scan_truth_s < log10(1e-8)) = NaN;

% Cone
scan_truth_c = (cell2mat(cellfun(@scan_truth3_v1,c_c(1,:),c_len_cell,'UniformOutput',false)));
scan_truth_c = rmmissing(scan_truth_c,2,'MinNumMissing',size(scan_truth_c,1));
scan_truth_c = log10(scan_truth_c);
scan_truth_c(isinf(abs(scan_truth_c)))=NaN;

[scan_truth_count_c,scan_truth_count_2] = cellfun(@scan_radar,c_c(1,:),c_c(2,:),zero_cell2,plevc_cell,'UniformOutput',false);
[scan_truth_count_c,~] = cellfun(@scan_radar2,scan_truth_count_c,scan_truth_count_2,plevc_cell,'UniformOutput',false);
scan_truth_count_c = cell2mat(scan_truth_count_c);
scan_truth_count_c = rmmissing(scan_truth_count_c,2);
scan_truth_count_c(scan_truth_count_c == 0) = NaN;
scan_truth_count_c(scan_truth_c < log10(1e-8)) = NaN;
scan_truth_c(scan_truth_c < log10(1e-8)) = NaN;

%% Radar
IWC = (0.0765*(10.^(-20/10)).^(0.5414))/1000;
% Nadir
radar_n = scan_truth_n;
radar_count_n = scan_truth_count_n;
radar_count_n(radar_n < log10(IWC)) = NaN;
radar3 = scan_radar3(radar_n,radar_count_n,plev,log10(0));
Cloudtype_r(1,1) = sum(all(isnan(radar_count_n)));
Cloudtype_r(2,1) = sum(sum(radar_count_n > find(plev >= 680,1)));
Cloudtype_r(3,1) = sum(sum((find(plev >= 680,1) > radar_count_n)&(radar_count_n > find(plev >= 440,1))));
Cloudtype_r(4,1) = sum(sum(radar_count_n < find(plev >= 440,1)));
Cloudtype_r = 10*Cloudtype_r;

%% Radiometer

% Nadir
rm_n1 = scan_truth_count_n;
rm_n2 = scan_truth_n;
[rm_n1,rm_n3] = scan_radiometer_v2(rm_n1,rm_n2,plev,log10(threshold));
Cloudtype_n(1,1) = sum(isnan(rm_n1) == true);
Cloudtype_n(2,1) = sum(rm_n1 > find(plev >= 680,1));
Cloudtype_n(3,1) = sum((find(plev >=680,1) > rm_n1)&(rm_n1 > find(plev >= 440,1)));
Cloudtype_n(4,1) = sum(rm_n1 < find(plev >= 440,1));
Cloudtype_n = 10*Cloudtype_n;

% Forward
rm_f1 = scan_truth_count_f;
rm_f2 = scan_truth_f;
[rm_f1,~] = scan_radiometer_v2(rm_f1,rm_f2,plev_f,log10(threshold));
Cloudtype_f(1,1) = sum(isnan(rm_f1) == true);
Cloudtype_f(2,1) = sum(rm_f1 > find(plev_f >= 680,1));
Cloudtype_f(3,1) = sum((rm_f1 < find(plev_f >= 680,1))&(rm_f1 > find(plev_f >= 440,1)));
Cloudtype_f(4,1) = sum(rm_f1 < find(plev_f >= 440,1));
Cloudtype_f = 10*Cloudtype_f;

% Side
rm_s1 = scan_truth_count_s;
rm_s2 = scan_truth_s;
[rm_s1,~] = scan_radiometer_v2(rm_s1,rm_s2,plev_s,log10(threshold));
Cloudtype_s(1,1) = sum(isnan(rm_s1) == true);
Cloudtype_s(2,1) = sum(rm_s1 > find(plev_s >= 680,1));
Cloudtype_s(3,1) = sum((rm_s1 < find(plev_s >= 680,1))&(rm_s1 > find(plev_s >= 440,1)));
Cloudtype_s(4,1) = sum(rm_s1 < find(plev_s >= 440,1));
Cloudtype_s = 100*Cloudtype_s;

% Cone
rm_c1 = scan_truth_count_c;
rm_c2 = scan_truth_c;
[rm_c1,~] = scan_radiometer_v2(rm_c1,rm_c2,plev_c,log10(threshold));
Cloudtype_c(1,1) = sum(isnan(rm_c1) == true);
Cloudtype_c(2,1) = sum(rm_c1 > find(plev_c >= 680,1));
Cloudtype_c(3,1) = sum((rm_c1 < find(plev_c >= 680,1))&(rm_c1 > find(plev_c >= 440,1)));
Cloudtype_c(4,1) = sum(rm_c1 < find(plev_c > 440,1));
Cloudtype_c = 100*Cloudtype_c;

%% Sum Up Clouds
highclouds = [Cloudtype_n(4,1) Cloudtype_f(4,1) Cloudtype_s(4,1) Cloudtype_c(4,1) Cloudtype_r(4,1)];

clouds = [ Cloudtype_n(1,1) Cloudtype_n(2,1) Cloudtype_n(3,1) Cloudtype_n(4,1); 
           Cloudtype_f(1,1) Cloudtype_f(2,1) Cloudtype_f(3,1) Cloudtype_f(4,1); 
           Cloudtype_s(1,1) Cloudtype_s(2,1) Cloudtype_s(3,1) Cloudtype_s(4,1);
           Cloudtype_c(1,1) Cloudtype_c(2,1) Cloudtype_c(3,1) Cloudtype_c(4,1);
           Cloudtype_r(1,1) Cloudtype_r(2,1) Cloudtype_r(3,1) Cloudtype_r(4,1)];

for i = 1:length(rm_n1)
    j = ceil((floor((i-1)/3600)+1)/3);
    cloudnum_n(j) = (rm_n1(i) < find(plev >=440,1))+cloudnum_n(j);
    cloudnum_f(j) = (rm_f1(i) < find(plev_f >= 440,1))+cloudnum_f(j);
    cloudnum_r(j) = sum(radar_count_n(:,i) < 48)+cloudnum_r(j);
    cloudnum_nt(j) = sum(scan_truth_count_n(:,i) < find(plev >= 440,1))+cloudnum_nt(j);
    cloudnum_ft(j) = sum(scan_truth_count_f(:,i) < find(plev_f >= 440,1))+cloudnum_ft(j);
    cloudnum_s(j) = (rm_s1(i) < find(plev_s >= 440,1))+cloudnum_s(j);
    cloudnum_c(j) = (rm_c1(i) < find(plev_c >= 440,1))+cloudnum_c(j);
    cloudnum_st(j) = sum(scan_truth_count_s(:,i) < find(plev_s >= 440,1))+cloudnum_st(j);
    cloudnum_ct(j) = sum(scan_truth_count_c(:,i) < find(plev_c >= 440,1))+cloudnum_ct(j);
    iwpnum(1,j) = ((log10(0.01) <= scan_truth_iwp(i))&&(scan_truth_iwp(i) < log10(1)))+iwpnum(1,j);
    iwpnum(2,j) = ((log10(1) <= scan_truth_iwp(i))&&(scan_truth_iwp(i) < log10(10)))+iwpnum(2,j);
    iwpnum(3,j) = ((log10(10) <= scan_truth_iwp(i))&&(scan_truth_iwp(i) < log10(100)))+iwpnum(3,j);
    iwpnum(4,j) = (log10(100) <= scan_truth_iwp(i))+iwpnum(4,j);
end  
cloudnum = [10*cloudnum_n' 10*cloudnum_f' 100*cloudnum_s' 100*cloudnum_c' 10*cloudnum_r'];
iwpnum = 10*iwpnum;
%% Save the Data
% cloud_files_v1(clouds',cloudnum,iwpnum')
%% Figures
figure('Name','Month High Clouds, Geos5')
%This graph is for the nadir scan from the top. It looks at the highest
%cloud and determines cloud type from that
bar(catnames,highclouds)
ylabel('Number of Clouds Seen')
xlabel('Scan Type')
title('Month High Clouds, Geos5')
set(gca,'FontSize',16)

figure('Name','Month All Clouds, Geos5')
%This graph is for the nadir scan from the top. It looks at the highest
%cloud and determines cloud type from that
bar(catnames,clouds)
ylabel('Number of Clouds Seen')
xlabel('Scan Type')
legend('Clear','Low','Medium','High')
title('All Clouds, Geos5')
set(gca,'FontSize',16)

figure('Name','Nadir Radiometer and Radar Comparison')
semilogy(hours,cloudnum_n*10,'LineWidth',5)
hold on
semilogy(hours,cloudnum_r*10,'LineWidth',5)
% semilogy(hours,cloudnum_nt*10,'LineWidth',5)
hold off
title('Nadir Radiometer and Radar')
legend('Radiometer','Radar')
xlabel('Time (hr)')
ylabel('Frequency')
set(gca,'FontSize',20)

figure('Name','Radiometer Cloud Count Comparison')
semilogy(hours,cloudnum_n*10,'Color','c','LineWidth',5)
hold on
semilogy(hours,cloudnum_s*100,'Color','y','LineWidth',5)
semilogy(hours,cloudnum_f*10,'Color','m','LineWidth',5)
semilogy(hours,cloudnum_c*100,'Color','r','LineWidth',5)
hold off
title('High Clouds over 24 hours by Radiometer')
legend('Nadir','Side','Forward','Cone')
xlabel('Time (hr)')
ylabel('Frequency')
set(gca,'FontSize',20)

% figure('Name','IWP over the Day')
% semilogy(hours,iwpnum(1,:),'LineWidth',5)
% hold on
% semilogy(hours,iwpnum(2,:),'LineWidth',5)
% semilogy(hours,iwpnum(3,:),'LineWidth',5)
% semilogy(hours,iwpnum(4,:),'LineWidth',5)
% hold off
% xlabel('Time (hr)')
% ylabel('Frequency')
% title('IWP Over 24 hours')
% legend('-2 < log_{10}(IWP) < 0','0 < log_{10}(IWP) < 1','1 < log_{10}(IWP) < 2','2 < log_{10}(IWP)')
% set(gca,'FontSize',16)

figure('Name','Nadir Curtain Plot')
hold on
contourf(p_n,plev,scan_truth_n)
scatter(p_n,rm_n3,'r','+')
for i = 1:size(radar3,1)
    scatter(p_n,radar3(i,:),'g','x')
end
plot(p_n,plev(55)*ones(1,length(p_n)),'k')
plot(p_n,plev(48)*ones(1,length(p_n)),'k')
text(p_n(1),plev(55),'Low Cloud')
text(p_n(1),plev(48),'Medium Cloud')
hold off
xlabel('Count')
ylabel('Pressure [hPa]')
xlim([0 p_n(end)])
if p_n(end) > 10e3
    xlim([8e3 10e3])
end
title('Height of Cloud Seen Nadir Scan')
legend('Truth','Radiometer','Radar')
set(gca,'FontSize',16)
set(gca,'ydir','reverse')
colormap('cool')
h = colorbar;
ylabel(h,'log_{10}(IWC)')

% figure('Name','IWP Histogram')
% histogram(scan_truth_iwp)
% title('IWP in the Nadir View')
% xlabel('IWP Value [g-m^2]')
% ylabel('Frequency')
% set(gca,'FontSize',20)

end