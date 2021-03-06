% load data with backward compatibility function
% function data = load_data(p, varargin)
% para_name = {'need_clean','type'}; 
% default_value = {0, 'fluocell'};
% 'type': 'fluocell', 'quanty'

% Copyright: Shaoying Lu and Yingxiao Wang 2017 
% Email: shaoying.lu@gmail.com
function data = load_data(p, varargin)
para_name = {'need_clean','type'}; 
default_value = {0, 'fluocell'};
[need_clean, type] = parse_parameter(para_name, default_value, varargin);

data_file = strcat(p, 'output/data.mat');
res = load(data_file);
data = res.data;

data.output_path = strcat(p,'output/');

save_data = 0;
% backward compatibility, 8/30/2019
if isfield(data, 'cell_size') 
    if iscell(data.cell_size) && isrow(data.cell_size{1})
        num_object = length(data.cell_size);
        temp = cell(num_object, 1);
        for i = 1:num_object
            temp{i} = data.cell_size{i}';
        end
        data = rmfield(data, 'cell_size');
        data.cell_size = temp; clear temp
        %
        temp = data.channel1_bg';
        data = rmfield(data, 'channel1_bg');
        data.channel1_bg = temp; clear temp;
        % 
        temp = data. channel2_bg';
        data = rmfield(data, 'channel2_bg'); 
        data.channel2_bg = temp; clear temp;
        %
        save_data = 1;
    end
end

% backward compatibility, 6/23/2017 --- Kathy
if strcmp(data.protocol, 'FRET') && length(data.f) <3
  data.f(3) = figure; 
  data.num_figure = 3;
  save_data = 1;
end

% backward compatibility, 7/22/2017 --- Kathy
if isfield(data, 'image_index')
    [num_row, num_col] = size(data.image_index);
    if num_row<num_col
        temp = (data.image_index)';
        data = rmfield(data, 'image_index');
        data.image_index = temp; clear temp;
        save_data = 1;
    end
end

% backward compatibility, 7/22/2017 --- Kathy
if strcmp(type, 'quanty')
    p = strcat(p, 'p1/');
end
%
if ~strcmp(data.path, p)
    data.path = p; 
    data.output_path = strcat(data.path, 'output/');
    % For Windows Mac compatibility
    temp = regexprep(data.first_file, '\\', '\/');
    [~, name, ext] = fileparts(temp);
    data.first_file = strcat(data.path, name, ext);
    data.prefix = name;
    data.postfix = ext;
    save_data = 1;
end

if need_clean
    data = rmfield(data, 'num_layers');
    data = rmfield(data, 'num_figures');
end

if save_data
  disp('Save data file for backward compatibility.');
  save(data_file, 'data');
end
return