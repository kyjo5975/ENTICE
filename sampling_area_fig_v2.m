function sampling_area_fig_v2(atn,atf,ats,atc,at_ice,iwp,iwpnum,lat1,long1,lat2,long2)
% ~~~~~~~~~~~~~~~~~~~~~~
% Finds out how many times and when the satellite is in a certain area, converts that time to a
% general hourly time and plots it on a histogram.

% lat1 - the lower latitude bound
%     long1 - the lower longitude bound
%     lat2 - the upper latitude bound
%     long2 - the upper longitude bound
%     orbittime the length in seconds of the simulation
%     earth - a equirectangular map of Earth
%     areatimes- a vector containing the times the satellite is in a 
%                specified area
%     areatimesforward- a vector containing the times the satellite is in a 
%                specified area for the forward scan

% ------------------------------------------------------------------------

% fileID = fopen('Sample Area Cloud Count.txt','w');
% fprintf(fileID,'%6s %6s %6s %6s\r\n','Nadir','Forward','Side','Cone');
% fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f\r\n',atn',atf',ats',atc');
% fclose(fileID);
test = 2;

figure('Name','Scan Area')
tile = tiledlayout(2,2);
nexttile
% tile 1 - creates a histogram plotting the nadir data
edges = 0:3:24;
day = 0:3:23;
histogram(atn,edges)
axis([0 24 0 inf])
xticks(day)
title('Nadir View')
set(gca,'FontSize',20)

nexttile
% tile 2 - creates a histogram plotting the side data
histogram(ats,edges)
axis([0 24 0 inf])
xticks(day)
title('Side View')
set(gca,'FontSize',20)

nexttile
% tile 3 - creates a histogram plotting the forward data
histogram(atf,edges)
axis([0 24 0 inf])
xticks(day)
title('Forward Pointing View')
set(gca,'FontSize',20)

nexttile
% tile 4 - creates a histogram plotting the data
histogram(atc,edges)
axis([0 24 0 inf])
xticks(day)
title('Conical View')
set(gca,'FontSize',20)

xlabel(tile, 'Local Solar Time','FontSize',20)
ylabel(tile, 'Frequency','FontSize',20)
title(tile,[sprintf('%d',long1) char(176) sprintf(' to %d',long2) char(176) sprintf(' Longitude and %d',lat1) char(176) sprintf(' to %d',lat2) char(176) ' Latitude Sampling Frequency'],'FontSize',20)

figure('Name','IWP Histogram')
histogram(iwp)
title('IWP in the Nadir View')
xlabel('IWP Value [g-m^2]')
ylabel('Frequency')
set(gca,'FontSize',20)

catnames = categorical({'0-3' '3-6' '6-9' '9-12' '12-15' '15-18' '18-21' '21-24'});
catnames = reordercats(catnames,{'0-3' '3-6' '6-9' '9-12' '12-15' '15-18' '18-21' '21-24'});
figure('Name','IWP Bar Chart')
bar(catnames,iwpnum)
title('IWP at local times')
xlabel('Local Time (Hour)')
ylabel('Frequency')
hleg = legend('-2 to 0','0 to 1','1 to 2','2+');
htitle = get(hleg,'Title');
set(htitle,'String','Log 10 IWP')
set(gca,'FontSize',20)

end %sampling_area
%~~~~~~~~~~~~~~~~~~~~~~~~