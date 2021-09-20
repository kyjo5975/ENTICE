function plot_ground_track(n_curves,RA,Dec,ra,dec,n_forward_curves,forwardRA,forwardDec,forwardra,forwarddec,n_side_curves,sideRA,sideDec,sidera,sidedec,n_cone_curves,coneRA,coneDec,conera,conedec,orbittime,long1,lat1,long2,lat2)
% ~~~~~~~~~~~~~~~~~~~~~~~~
figure('Name','Ground Tracks')
tiledlayout(2,2)
nexttile
% tile 1 - plots the nadir ground tracks
earth = imread('equirectangular3.png'); %provide an earth map to plot on
image('CData',earth,'XData',[0 360],'YData',[90 -90])
hold on
xlabel('East longitude (degrees)')
ylabel('Latitude (degrees)')
axis equal
grid on
for i = 1:n_curves
    plot(RA{i}, Dec{i}, '.c')
end

axis ([0 360 -90 90])
text( ra(1), dec(1), 'o Start','Color','w')
text(ra(end), dec(end), 'o Finish','Color','w')
line([0 360],[0 0], 'Color','w') %the equator
%box around sampling area
line([long1 long1],[lat1 lat2], 'Color','g')
line([long1 long2],[lat2 lat2], 'Color','g')
line([long2 long2],[lat1 lat2], 'Color','g')
line([long1 long2],[lat1 lat1], 'Color','g')
title('Nadir Ground Track')
set(gca,'FontSize',16)
hold off

nexttile
% tile 2 - plots the sideways scan ground tracks
earth = imread('equirectangular3.png'); %provide an earth map to plot on
image('CData',earth,'XData',[0 360],'YData',[90 -90])
hold on
xlabel('East longitude (degrees)')
ylabel('Latitude (degrees)')
axis equal
grid on
for i = 1:n_side_curves
    plot(sideRA{i}, sideDec{i}, '.y')
end

axis ([0 360 -90 90])
text( sidera(1), sidedec(1), 'o Start','Color','w')
text(sidera(end), sidedec(end), 'o Finish','Color','w')
line([0 360],[0 0], 'Color','w') %the equator
%box around sampling area
line([long1 long1],[lat1 lat2], 'Color','g')
line([long1 long2],[lat2 lat2], 'Color','g')
line([long2 long2],[lat1 lat2], 'Color','g')
line([long1 long2],[lat1 lat1], 'Color','g')
title('Sideways Scan Ground Track')
set(gca,'FontSize',16)
hold off

nexttile
% tile 3 - plots the forward scan ground tracks
earth = imread('equirectangular3.png'); %provide an earth map to plot on
image('CData',earth,'XData',[0 360],'YData',[90 -90])
hold on
xlabel('East longitude (degrees)')
ylabel('Latitude (degrees)')
axis equal
grid on
for i = 1:n_forward_curves
    plot(forwardRA{i}, forwardDec{i}, '.m')
end

axis ([0 360 -90 90])
text( forwardra(1), forwarddec(1), 'o Start','Color','w')
text(forwardra(end), forwarddec(end), 'o Finish','Color','w')
line([0 360],[0 0], 'Color','w') %the equator
%box around sampling area
line([long1 long1],[lat1 lat2], 'Color','g')
line([long1 long2],[lat2 lat2], 'Color','g')
line([long2 long2],[lat1 lat2], 'Color','g')
line([long1 long2],[lat1 lat1], 'Color','g')
title('Forward Pointing Ground Track')
set(gca,'FontSize',16)
hold off

nexttile
% tile 4 - plots the cone scan ground tracks
earth = imread('equirectangular3.png'); %provide an earth map to plot on
image('CData',earth,'XData',[0 360],'YData',[90 -90])
hold on
xlabel('East longitude (degrees)')
ylabel('Latitude (degrees)')
axis equal
grid on
for i = 1:n_cone_curves
    plot(coneRA{i}, coneDec{i}, '.r')
end

axis ([0 360 -90 90])
text(conera(1), conedec(1), 'o Start','Color','w')
text(conera(end), conedec(end), 'o Finish','Color','w')
line([0 360],[0 0], 'Color','w') %the equator
%box around sampling area
line([long1 long1],[lat1 lat2], 'Color','g')
line([long1 long2],[lat2 lat2], 'Color','g')
line([long2 long2],[lat1 lat2], 'Color','g')
line([long1 long2],[lat1 lat1], 'Color','g')
title('Cone Scan Ground Track')
set(gca,'FontSize',16)
hold off

% figure('Name','All Scan Tracks')
% %plots all ground tracks
% earth = imread('equirectangular3.png'); %provide an earth map to plot on
% image('CData',earth,'XData',[0 360],'YData',[90 -90])
% hold on
% xlabel('East longitude (degrees)')
% ylabel('Latitude (degrees)')
% axis equal
% grid on
% for i = 1:n_curves
%     plot(RA{i}, Dec{i},'c','LineWidth',5)
% end
% for i = 1:n_forward_curves
%     plot(forwardRA{i}, forwardDec{i},'m','LineWidth',5)
% end
% for i = 1:n_side_curves
%     plot(sideRA{i}, sideDec{i}, '. y')
% end
% for i = 1:n_cone_curves
%     plot(coneRA{i}, coneDec{i}, '. r')
% end
% axis ([0 360 -90 90])
% legend('Nadir','Forward','Side','Cone')
% legend('boxoff')
% legend('TextColor','w')
% 
% title('Ground Tracks Comparison for each Scanning Mode')
% set(gca,'FontSize',16)
% hold off
end %plot_ground_track
% ~~~~~~~~~~~~~~~~~~~~~~