function [file_iwc,file_iwp] = filefinder(i,n)
    % put together new file
    % note: this is bad code and should be replaced
    filepart1 = "E:\Ice Water Content\03\c1440_NR.inst30mn_3d_QI_Nv.20060315_";
    filepartA = "E:\Ice Water Path\03\c1440_NR.inst30mn_2d_met1_Nx.20060315_";
    hour = floor((i-1)/3600/n);  % calculate hour # in simulation
    filepart2 = num2str(hour);  % convert to string
    if length(filepart2) == 1
        filepart2 = strcat('0',filepart2);
    end
    if mod((i-1)/1800/n,2) == 1
        filepart3 = '3';
    else
        filepart3 = '0';
    end
    filepart4 = '0z.nc4';
    file_iwc = strcat(filepart1,filepart2,filepart3,filepart4);
    file_iwp = strcat(filepartA,filepart2,filepart3,filepart4);
end