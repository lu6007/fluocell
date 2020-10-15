% function [test_function, intensity, ratio] = quantify_screen(varargin)
% para_name = {'exp_name', 'fun_type', 'num_repeat'};
% default_value = {'', 'copy_file', 1};
% 1. Quantify individual dataset (requires fluocell_dataset_2)
% >> [~, intensity, ratio] = quantify_screen();
% or, 
% >> exp_name = '0828_ac7';
% >> [~, intensity, ratio] = quantify_screen('exp_name', exp_name, 'fun_type', 'quantify', ...
% >>     'init_data_function', @quantify_init_data);
%
% 2. Collect_simple_repeat
% >> exp_name = 'AC7';
% >> [~, intensity, ratio] = quantify_screen('exp_name', exp_name, ...
% 'fun_type', 'collect_simple_repeat', 'num_repeat', 1, 'load_result', 1, ...
%     'init_data_function', @quantify_init_data);
%
% 3. Compare the results
% >> [~, intensity, ratio] = quantify_screen('fun_type', 'group_compare', ...
%     'init_data_function', @init_data_1008, 'load_result', 1);
%
% 4. Copy files: set fun_type = 'copy_file'

function [test_function, intensity, ratio] = quantify_screen(varargin)
para_name = {'exp_name', 'fun_type', 'num_repeat', 'init_data_function', 'load_result'};
default_value = {'0828_ac7', 'quantify', 1, @quantify_init_data, 0};
[exp_name, fun_type, num_repeat, init_data_function, load_result]= ...
    parse_parameter(para_name, default_value, varargin);

test_function.copy_file = @copy_file;
test_function.get_latex_string = @get_latex_string; 
test_function.quantify_multiple_cell = @quantify_ratio_multiple_cell;
test_function.collect_simple_repeat = @collect_simple_repeat;
test_function.group_compare = @group_compare; 
%
switch fun_type
%     case 'copy_file'
%         return;
    case 'quantify'
        data = init_data_function(exp_name);
        [intensity, ratio] = quantify_ratio_multiple_cell(data, ...
            'load_result', load_result, 'save_result', 1);
%     case 'collect_simple_repeat'
%         repeat_data.exp_name = exp_name;
%         repeat_data.num_repeat = num_repeat;
%         repeat_data.init_data_function = init_data_function;
%         repeat_data.load_result = load_result;
%         [intensity, ratio] = collect_simple_repeat(repeat_data); 
%         %
%         my_figure; hist(intensity(:,2), 100); 
%         aa = axis;
%         axis([0 10000 aa(3) aa(4)]);
%         title(get_latex_string(exp_name));
%         clear exp value;
    case 'group_compare'
        % group_name = 'Y394' or 'pLAT' 
        group_name = exp_name; clear exp_name; 
        group_data = init_data_function(group_name, 'type', fun_type);
        group_data.init_data_function = init_data_function;
        group_data.load_result = load_result; 
        [intensity, ratio] = group_compare(group_data); 
                
        % statistical test
        my_fun = my_function;
        my_fun.multiple_compare(intensity, group_data.name_string);     
end

return

function [intensity, ratio] = collect_simple_repeat(repeat_data)
    exp_name = repeat_data.exp_name;
    num_repeat = repeat_data.num_repeat; 
    init_data_function = repeat_data.init_data_function;
    load_result = repeat_data.load_result;
    
    value = cell(num_repeat,2);
    column_head = {'intensity', 'ratio'};
    for i = 1:num_repeat
        exp_name_i = strcat(exp_name, num2str(i));
        [~, value{i,1}, value{i,2}] = quantify_screen('exp_name', exp_name_i, ...
            'fun_type', 'quantify', 'init_data_function', init_data_function, ...
            'load_result', load_result, 'save_result', 1);
    end
    exp = cell2struct(value, column_head, 2);
    intensity = cat(1, exp.intensity);
    ratio = cat(1, exp.ratio); % for the format of output   
return

function [intensity, ratio] = group_compare(group_data)
    init_data_function = group_data.init_data_function;
    load_result = group_data.load_result; 
    %
    name_string = group_data.name_string;
    num_exp = group_data.num_exp;
    exp_index = group_data.exp_index;
    repeat = group_data.repeat; 
    exp_name = cell(num_exp, 1);
    intensity = cell(num_exp, 1);
    ratio = cell(num_exp, 1);
    num_repeat = zeros(num_exp, 1);

    for i = 1:num_exp
        ii = exp_index(i);
        exp_name{ii} = name_string{i};
        num_repeat(ii) = repeat(i);
    end

    for i = exp_index'
        repeat_data.exp_name = exp_name{i};
        repeat_data.num_repeat = num_repeat(i);
        repeat_data.init_data_function = init_data_function;
        repeat_data.load_result = load_result;
        [temp, temp2] = collect_simple_repeat(repeat_data);
        clear repeat_data;
        intensity{i} = temp(:,2); 
        ratio{i} = temp2; 
        clear temp;
    end
    % save('result.mat', 'intensity','name_string');
return

% cd /Volumes/KathyWD2TB/data/2017/charlotte_0814/0914/0823_pretreat/3
% copy_file('p%d/*t4*', (1:20)', 'output/time_point');
function copy_file(source_pattern, source_index, destination)
for i = source_index'
    source = sprintf(source_pattern, i);
    copyfile(source, destination);
end
return

% function new_str = get_latex_string(str)
% Convert a string to a latex-compatible format
% The input can be either a str or a cell of strings
% The output is the same type as the input
function new_str = get_latex_string(str)
new_str = regexprep(str, '\_', '\\_');
return