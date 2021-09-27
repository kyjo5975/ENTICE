function cloud_files_v1(clouds,cloudnum,iwpnum)

fileID = fopen('total-cloud-mar.txt','w');
fprintf(fileID,'%6s %6s %6s %6s %6s\r\n','Nadir','Forward','Side','Cone','Radar');
fprintf(fileID,'Clear %12.8f %12.8f %12.8f %12.8f %12.8f\r\n',clouds(1,:));
fprintf(fileID,'Low %12.8f %12.8f %12.8f %12.8f %12.8f\r\n',clouds(2,:));
fprintf(fileID,'Medium %12.8f %12.8f %12.8f %12.8f %12.8f\r\n',clouds(3,:));
fprintf(fileID,'High %12.8f %12.8f %12.8f %12.8f %12.8f\r\n',clouds(4,:));
fclose(fileID);

fileID = fopen('time-cloud-mar.txt','w');
fprintf(fileID,'%6s %6s %6s %6s %6s\r\n','Nadir','Forward','Side','Cone','Radar');
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f %12.8f\r\n',cloudnum(1,:));
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f %12.8f\r\n',cloudnum(2,:));
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f %12.8f\r\n',cloudnum(3,:));
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f %12.8f\r\n',cloudnum(4,:));
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f %12.8f\r\n',cloudnum(5,:));
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f %12.8f\r\n',cloudnum(6,:));
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f %12.8f\r\n',cloudnum(7,:));
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f %12.8f\r\n',cloudnum(8,:));
fclose(fileID);

fileID = fopen('time-iwp-mar.txt','w');
fprintf(fileID,'%6s %6s %6s %6s\r\n','-2--0','0--1','1--2','2+');
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f\r\n',iwpnum(1,:));
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f\r\n',iwpnum(2,:));
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f\r\n',iwpnum(3,:));
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f\r\n',iwpnum(4,:));
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f\r\n',iwpnum(5,:));
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f\r\n',iwpnum(6,:));
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f\r\n',iwpnum(7,:));
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f\r\n',iwpnum(8,:));
fclose(fileID);
end
