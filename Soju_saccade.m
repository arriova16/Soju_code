% Script for saccade task

tld = 'Z:\UserFolders\ToriArriola\Soju_training';

%% loading rsp files

data = struct();

sac_fld = dir(fullfile(tld, "Saccade"));

for i = length(sac_fld)
    sac_files = fullfile(sac_fld, '*rsp');

end %sac_fld