% function time = get_time_2(file)
% Get the time information in minutes from the beginning of the data 
% when the file was created
% time = -1 if file not exists
% time = 0 if the file exists but does not supply time info

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function time = get_time_2(file)
    if ~exist(file, 'file'),
        time = -1; % file not exist
        return;
    end;
    info = imfinfo(file);
    if isfield(info, 'DateTime'),
        date_time = info.DateTime;
        % this time string prototype assumes one of the following two
        % formats of date time string
        % 20100820 13:20:17.42
        % or
        % 2010:10:28 18:23:55
        % We look for the format ' xx:xx:xx', where 'x' is
        % a number between 0 and 9.
        % after start_i and end_i are found, start_i was 
        % incremented by 1 to accomodate for the space 
        % at the beginning.
        time_str_pro = ' [0-9][0-9]:[0-9][0-9]:[0-9][0-9]';
        [start_i end_i] = regexp(date_time, time_str_pro);
        time_str = date_time(start_i+1:end_i);
        hr = str2double(time_str(1:2));
        mn = str2double(time_str(4:5));
        sc = str2double(time_str(7:8));
        time = (hr*3600+mn*60+sc)/60.0;
    else
        time = 0;
    end;
return;