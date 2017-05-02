%%
% function batch_sort_file_multiple_position
%
% Example:
% p = 'E:/sof/fluocell/data/migration/07_01_2010/';
% sub_dir = {'FN5/2_2/', 'FN5/2_3/', 'FN5/2_FBS10/', 'FN10/1/', 'FN20/1/'};
% batch_sort_file_multiple_position(p, sub_dir)
%
% If the number of positions is greater than 100, specify the
% max_number_position as following
% batch_sort_file_multiple_position(p, sub_dir)

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function batch_sort_file_multiple_position(path, sub_dir,varargin)
parameter_name = {'max_num_position'};
default_value = {100};
max_num_position = parse_parameter(parameter_name, ...
    default_value, varargin);
for i = 1:length(sub_dir)
    sort_file_multiple_position(strcat(path, sub_dir{i}),'max_num_position',max_num_position);
end
return;
