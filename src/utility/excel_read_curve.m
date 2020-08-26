% function exp = excel_read_curve(file_name)
% parameter_name = {'method'};
% default_value = {[1]};
%
% Methods 1
% Input: A Single Excel file
% 1. Each sheet include a groups of experiments. The sheet names are
% descriptative.
% 2. The data contains repeatitive pairs of columns (time and ratio)
% Time     Cell1     Time     Cell2     Time      Cell3
%  0        1         0         1         0         1
%  1        1.3       1         1.1       1         1.2
% ......
%
% Output: A cell of structure called exp
% exp = cell(num_sheet,1)
% exp{i}.num_cell
% exp{i}.name
% exp{i}.cell(j).time
% exp{i}.cell(j).value 
%
% Method 2
% Input in the format
% Time Ratio Ratio Ratio...
% Output :
% exp{i}.name
% exp{i}.time
% exp{i}.ratio

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function exp=excel_read_curve(file_name, varargin)
parameter_name = {'method', 'sheet_name'};
default_value = {1, ''};
[method, sheet_name] = parse_parameter(parameter_name, default_value, varargin);

% The Name of the sheets describes the types of experiments
if isempty(sheet_name)
    [~, sheet_name] = xlsfinfo(file_name); 
    num_sheet = length(sheet_name);
else
    num_sheet = 1; 
    temp = {sheet_name}; clear sheet_name;
    sheet_name = temp;
end
exp = cell(num_sheet, 1);
for i = 1:num_sheet   
    % only reads the numerical values
    data = xlsread(file_name, sheet_name{i});
    switch method
    case 1 % read the format: time ratio time ratio etc.
        num_cell = size(data,2)/2;
        exp{i}.num_cell = num_cell;
        exp{i}.name = sheet_name{i};
        temp_cell = cell(num_cell,2);
         for j =1:num_cell  
             % find the last non-nan entry
            num_row = find(~isnan(data(:,j*2-1)),1, 'last');
            if isempty(num_row)
                temp_cell{j,1} = data(:, j*2-1);
                temp_cell{j,2} = data(:,j*2);
            else
                temp_cell{j,1} = data(1:num_row, j*2-1);
                temp_cell{j,2} = data(1:num_row, j*2);
            end
            clear time value;
         end
         exp{i}.cell = cell2struct(temp_cell, {'time', 'value'}, 2);
         clear temp_cell;

    case 2 % read the format: time ratio ratio ratio
        exp{i}.name = sheet_name{i};
        exp{i}.time = data(:,1);
        exp{i}.ratio = data(:,2:end);  
    % case 3, read the format: time ratio time ratio ratio ratio time ratio
    end % switch method
end % for i = 1:num_sheet,

fprintf('Output: exp, disp(exp{1})\n'); 
disp(exp{1}); 
return;
