% function qs_function = quantify_screen()
% Quantify the single-cell fluorescence intensity or ratio values
% in high thoughput. 
% Example: See the function test_quantify_screen

% Author: Shaoying Lu, shaoying.lu@gmail.com
function qs_function = quantify_screen()

qs_function.quantify_multiple_cell = @quantify_ratio_multiple_cell;
qs_function.collect_simple_repeat = @collect_simple_repeat;
qs_function.group_compare = @group_compare; 

return

function [intensity, ratio] = collect_simple_repeat(repeat_data)
    exp_name = repeat_data.exp_name;
    num_repeat = repeat_data.num_repeat; 
    init_data_function = repeat_data.init_data_function;
    load_result = repeat_data.load_result;
    
    value = cell(num_repeat,2);
    column_head = {'intensity', 'ratio'};
    qs_func = quantify_screen();
    for i = 1:num_repeat
        exp_name_i = strcat(exp_name, num2str(i));
%         [~, value{i,1}, value{i,2}] = quantify_screen('quantify', ...
%             'exp_name', exp_name_i, 'init_data_function', init_data_function, ...
%             'load_result', load_result, 'save_result', 1);
        data = init_data_function(exp_name_i, 'type', 'quantify');
        [value{i, 1}, value{i, 2}] = qs_func.quantify_multiple_cell(data, ... 
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

