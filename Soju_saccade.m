% Script for saccade task

tld = 'Z:\UserFolders\ToriArriola\Soju_training';
file_list = dir(fullfile(tld, "Saccade", '*.rsp')); 
data = struct(); ii = 1;

for i = length(file_list)
    fsplit = strsplit(file_list(i).name, '_');
    data(ii).Monkey = fsplit{2};
    t_idx = find(fsplit{4} == 'T');
    % data(ii).Date = datestr(datenum)
    ii = ii+ 1;
end %sac_fld