% p = 'E:/sof/fluocell/data/migration/07_01_2010/FN1/2_2/';
% Note the '\' at the end of the line is necessary.
% function sort_file_multiple_position(p)
% move the files with the patteren *sx* into the folder sx/

% Copyright: Shaoying Lu and Yingxiao Wang 2011 
% Email: shaoying.lu@gmail.com
function sort_file_multiple_position(path, varargin)
parameter_name = {'max_num_position'};
default_value = {30};
max_num_position = parse_parameter(parameter_name, ...
    default_value, varargin);
for i = 1:max_num_position
    % The dir_pattern needs to be different from 
    % the file_pattern to avoid error in movefile().
%    dir_pattern = strcat(path,sprintf('p%d\\', i));
    dir_pattern = strcat(path,sprintf('p%d/', i));
    file_pattern = strcat(path, sprintf('*_s%d_*',i));
    files = dir(file_pattern);
    if ~isempty(files)
        if ~exist(dir_pattern, 'dir')
            mkdir(dir_pattern);
        end
        movefile(file_pattern, dir_pattern);
    end
    clear files dir_pattern file_pattern;
end
return;