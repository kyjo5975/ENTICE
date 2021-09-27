function save_all_figures_to_directory(dir_name)
figlist=findobj('type','figure');
for i=1:numel(figlist)
    fh = findobj('Type', 'Figure', 'Number', i );
    t = fh.Name;
    saveas(fh,fullfile(dir_name,[t '.fig']));
    saveas(fh,fullfile(dir_name,[t '.png']));
end
end