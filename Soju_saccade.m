% Script for saccade task
%folder where .rsp files are help
tld = 'Z:\UserFolders\ToriArriola\Soju_training\Saccade';
file_dir = dir(tld);
%only taking .rsp folders
file_list = dir(fullfile(tld, '*.rsp'));
data = struct();
SetFont('Arial', 12)

%% Loading rsp - temp

ii = 1;
for i = 1:length(file_list)
    
    fsplit = strsplit(file_list(i).name, '_');
    t_idx = find(fsplit{4} == 'T');
    dt = datestr(datenum(fsplit{4}(1:t_idx-1), 'yyyymmdd'), 1);
    data(ii).Monkey = fsplit{2};
    data(ii).Date = dt;
    
    temp_data = readcell(fullfile(tld, file_list(i).name), 'FileType', 'text', 'NumHeaderLines',1);
    if size(temp_data, 2) == 10
        temp_data = temp_data(:, [1:3, 10]);
    elseif size(temp_data,2) == 12
        temp_data = temp_data(:, [1:3, 10]);
    end
    %removing 
    abort_idx = strcmpi(temp_data(:,4), 'no response') | strcmpi(temp_data(:,4), 'empty response');
    temp_data = temp_data(~abort_idx, :);

    response_table = cell2table(temp_data, 'VariableNames', {'Trial', 'CorrectInterval', 'CorrectAnswer', 'Response'});
    data(ii).ResponseTable = response_table;
    ii = ii + 1;

end %sac_fld

%% percent correct

for n = 1:length(data)

    tot_trial = max(data(n).ResponseTable.Trial);
    correct_first = false(tot_trial,1);
    trial_attempt = zeros(tot_trial,1);

    for t = 1:tot_trial
        idx = find(data(n).ResponseTable.Trial == t, 1, 'first');
        if (strcmp(data(n).ResponseTable.Response{idx}, 'correct'))
            correct_first(t) = true;
        end

     data(n).PercentCorrect = floor((sum(correct_first)/ tot_trial) *100);
    
    end %tot_trial

end %data

%% Plotting percent correct by day

figure; hold on


for i = 1:length(data)
    num_sess =1:[length(data)];
    plot(num_sess, [data.PercentCorrect], "LineWidth", 4)
    scatter(num_sess, [data.PercentCorrect], 50,'filled')
end

ax = gca;
ax.FontSize = 20;

xlabel('Session', 'FontSize', 20)
ylabel('Percent Correct', 'FontSize',20)
