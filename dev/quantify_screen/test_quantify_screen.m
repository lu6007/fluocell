% test_quantify_screen
%% Sample
qs_func = quantify_screen('get_function');

% Quantify a simple experiment
exp_name = 'ac7'; 
load_result = 0; 
init_data_function = @quantify_init_data;
data = init_data_function(exp_name, 'type', 'quantify');
qs_func.quantify_multiple_cell(data, 'load_result', load_result, ...
    'save_result', 1); 

%% Quantify multiple repeats
exp_name = 'AC7';
repeat_data.exp_name = exp_name; 
repeat_data.num_repeat = 1;
repeat_data.init_data_function = init_data_function;
repeat_data.load_result = 1; 
[~, ratio] = qs_func.collect_simple_repeat(repeat_data);
%
my_figure; histogram(ratio);
% aa = axis;
% axis([0 10000 aa(3) aa(4)]);
title(qs_func.get_latex_string(exp_name));

%% Compare different quantification results
group_name = 'sample';
group_data =init_data_function(group_name, 'type', 'group_compare');
group_data.init_data_function = init_data_function;
group_data.load_result = 1; 
[intensity, ratio] = qs_func.group_compare(group_data);
% statistical test
my_fun = my_function;
my_fun.multiple_compare(ratio, group_data.name_string);

