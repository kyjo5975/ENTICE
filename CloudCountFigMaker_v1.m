clc
clear all
close all 

%% Import Files and Scale
% January
day_total_jan = 'total-cloud-jan.txt';
day_time_jan  = 'time-cloud-jan.txt';
%day_iwp_jan = 'time-iwp-jan.txt';

T1 = readmatrix(day_total_jan);
t1 = readmatrix(day_time_jan);
%I1 = readmatrix(day_iwp_jan);

T1 = 31*T1(:,2:6);
t1 = 31*sum(t1)';
%I1 = 31*sum(I1)';

% February
day_total_feb = 'total-cloud-feb.txt';
day_time_feb  = 'time-cloud-feb.txt';
%day_iwp_feb = 'time-iwp-feb.txt';

T2 = readmatrix(day_total_feb);
t2 = readmatrix(day_time_feb);
%I2 = readmatrix(day_iwp_feb);

T2 = 28*T2(:,2:6);
t2 = 28*sum(t2)';
%I2 = 28*sum(I2)';

% March
day_total_mar = 'total-cloud-mar.txt';
day_time_mar  = 'time-cloud-mar.txt';
%day_iwp_mar = 'time-iwp-mar.txt';

T3 = readmatrix(day_total_mar);
t3 = readmatrix(day_time_mar);
%I3 = readmatrix(day_iwp_mar);

T3 = 31*T3(:,2:6);
t3 = 31*sum(t3)';
%I3 = 31*sum(I3)';

% April
day_total_apr = 'total-cloud-apr.txt';
day_time_apr  = 'time-cloud-apr.txt';
%day_iwp_apr = 'time-iwp-apr.txt';

T4 = readmatrix(day_total_apr);
t4 = readmatrix(day_time_apr);
%I4 = readmatrix(day_iwp_apr);

T4 = 30*T4(:,2:6);
t4 = 30*sum(t4)';
%I4 = 30*sum(I4)';

% May
day_total_may = 'total-cloud-may.txt';
day_time_may  = 'time-cloud-may.txt';
%day_iwp_may = 'time-iwp-may.txt';

T5 = readmatrix(day_total_may);
t5 = readmatrix(day_time_may);
%I5 = readmatrix(day_iwp_may);

T5 = 31*T5(:,2:6);
t5 = 31*sum(t5)';
%I5 = 31*sum(I5)';

% June
day_total_jun = 'total-cloud-jun.txt';
day_time_jun  = 'time-cloud-jun.txt';
%day_iwp_jun = 'time-iwp-jun.txt';

T6 = readmatrix(day_total_jun);
t6 = readmatrix(day_time_jun);
%I6 = readmatrix(day_iwp_jun);

T6 = 30*T6(:,2:6);
t6 = 30*sum(t6)';
%I6 = 30*sum(I6)';

% July
day_total_jul = 'total-cloud-jul.txt';
day_time_jul  = 'time-cloud-jul.txt';
%day_iwp_jul = 'time-iwp-jul.txt';

T7 = readmatrix(day_total_jul);
t7 = readmatrix(day_time_jul);
%I7 = readmatrix(day_iwp_jul);

T7 = 31*T7(:,2:6);
t7 = 31*sum(t7)';
%I7 = 31*sum(I7)';

% August
day_total_aug = 'total-cloud-aug.txt';
day_time_aug  = 'time-cloud-aug.txt';
%day_iwp_aug = 'time-iwp-aug.txt';

T8 = readmatrix(day_total_aug);
t8 = readmatrix(day_time_aug);
%I8 = readmatrix(day_iwp_aug);

T8 = 31*T8(:,2:6);
t8 = 31*sum(t8)';
%I8 = 31*sum(I8)';

% September
day_total_sep = 'total-cloud-sep.txt';
day_time_sep  = 'time-cloud-sep.txt';
%day_iwp_sep = 'time-iwp-sep.txt';

T9 = readmatrix(day_total_sep);
t9 = readmatrix(day_time_sep);
%I9 = readmatrix(day_iwp_sep);

T9 = 30*T9(:,2:6);
t9 = 30*sum(t9)';
%I9 = 30*sum(I9)';

% October
day_total_oct = 'total-cloud-oct.txt';
day_time_oct  = 'time-cloud-oct.txt';
%day_iwp_oct = 'time-iwp-oct.txt';

T10 = readmatrix(day_total_oct);
t10 = readmatrix(day_time_oct);
%I10 = readmatrix(day_iwp_oct);

T10 = 31*T10(:,2:6);
t10 = 31*sum(t10)';
%I10 = 31*sum(I10)';

% November
day_total_nov = 'total-cloud-nov.txt';
day_time_nov  = 'time-cloud-nov.txt';
%day_iwp_nov = 'time-iwp-nov.txt';

T11 = readmatrix(day_total_nov);
t11 = readmatrix(day_time_nov);
%I11 = readmatrix(day_iwp_nov);

T11 = 30*T11(:,2:6);
t11 = 30*sum(t11)';
%I11 = 30*sum(I11)';

% December
day_total_dec = 'total-cloud-dec.txt';
day_time_dec  = 'time-cloud-dec.txt';
%day_iwp_dec = 'time-iwp-dec.txt';

T12 = readmatrix(day_total_dec);
t12 = readmatrix(day_time_dec);
%I12 = readmatrix(day_iwp_dec);

T12 = 31*T12(:,2:6);
t12 = 31*sum(t12)';
%I12 = 31*sum(I12)';

%% Put it all Together
T = T1+T2+T3+T4+T5+T6+T7+T8+T9+T10+T11+T12;
t = [t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12];
%I = [I1 I2 I3 I4 I5 I6 I7 I8 I9 I10 I11 I12];

%% Plots and Figures

catnames = categorical({'Nadir' 'Forward Pointing' 'Side' 'Cone' 'Radar'});
catnames = reordercats(catnames,{'Nadir' 'Forward Pointing' 'Side' 'Cone' 'Radar'});
months = linspace(1,12,12);

figure('Name','All Clouds 1 Year, Geos5')
%This graph is for the nadir scan from the top. It looks at the highest
%cloud and determines cloud type from that
bar(catnames,T)
ylabel('Number of Clouds Seen')
xlabel('Scan Type')
legend('Clear','Low','Medium','High')
title('1 Year All Clouds, Geos5')
set(gca,'FontSize',16)
set(gca,'Yscale','log')

figure('Name','Nadir Radiometer and Radar Comparison')
semilogy(months,t(1,:),'LineWidth',5)
hold on
semilogy(months,t(5,:),'LineWidth',5)
hold off
title('Nadir Radiometer and Radar')
legend('Radiometer','Radar')
xlabel('Months')
ylim([9e6 Inf])
ylabel('# of Samples')
ylim([9e6 2.4e7])
set(gca,'FontSize',16)

figure('Name','Radiometer Cloud Count Comparison')
semilogy(months,t(1,:),'Color','c','LineWidth',5)
hold on
semilogy(months,t(3,:),'Color','y','LineWidth',5)
semilogy(months,t(2,:),'Color','m','LineWidth',5)
semilogy(months,t(4,:),'Color','r','LineWidth',5)
hold off
title('High Clouds over 1 Year by Radiometer')
legend('Nadir','Side','Forward','Cone')
xlabel('Months')
ylabel('Frequency')
set(gca,'FontSize',20)

% figure('Name','IWP over 1 year')
% semilogy(months,I(1,:),'LineWidth',5)
% hold on
% semilogy(months,I(2,:),'LineWidth',5)
% semilogy(months,I(3,:),'LineWidth',5)
% semilogy(months,I(4,:),'LineWidth',5)
% hold off
% xlabel('Months')
% ylabel('Frequency')
% title('IWP Over 1 Year')
% legend('-2 < log_{10}(IWP) < 0','0 < log_{10}(IWP) < 1','1 < log_{10}(IWP) < 2','2 < log_{10}(IWP)')
% set(gca,'FontSize',16)
