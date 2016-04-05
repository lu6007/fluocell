% function time = get_time(input, varargin)
% Get the time information from a .INF file or an image file
% Unit: minute

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function time = get_time(input, varargin)
    % Initialize input
    p_name = {'ref_time', 'method'};
    default_v = {0, 1};
    [ref_time, method] = parse_parameter(p_name, default_v, varargin);
    switch method,
        case 1
            % method 1 -> get time information (min) from .INF or time.data
            time = get_time_1(input, ref_time);
        case 2
            % method 2 -> get time information (min) from one file
            time = get_time_2(input);
    end;
return

% function time = get_time_1(data, ref_time)
% Get the time information from the .INF or the time.data file

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function time = get_time_1(data, ref_time)
    % convert time log to time.data file
    data_file = strcat(data.output_path, 'time.data');
    if ~exist(data_file, 'file'),
        log_file = strcat(data.path, data.prefix, 'D.INF');
        src_id = fopen(log_file, 'r');
        dest_id = fopen(data_file, 'w');
        while feof(src_id) == 0,
            this_line = fgetl(src_id);
            if strcmp(this_line(1), '*'),
                this_line = strcat('% ', this_line);
            end;
            fprintf(dest_id, '%s\n', this_line);
        end;
        fclose(src_id);
        fclose(dest_id);
    end
    temp = load(data_file);
    time = (temp(:,2)-ref_time)/100/60; % minutes
    clear temp; 
return;
