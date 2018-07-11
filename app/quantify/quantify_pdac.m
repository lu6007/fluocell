% function [test_function, intensity, ratio] = quantify_pdac(varargin)
% para_name = {'exp_name', 'fun_type', 'num_repeat'};
% default_value = {'', 'copy_file', 1};
% 1. Quantify individual dataset (optional)
% >> exp_name = 'pdacr_pretreat_12151';
% >> my_init_data = @my_init_data; 
% >> [~, intensity, ratio] = quantify_pdac('exp_name', exp_name, 'fun_type', 'quantify', ...
%     'init_data_function', my_init_data);
%
% 2. Collect_simple_repeat
% >> exp_name = 'pdacr_pretreat_1215';
% >> my_init_data = @my_init_data; 
% >> [~, intensity, ratio] = quantify_pdac('exp_name', exp_name, ...
% 'fun_type', 'collect_simple_repeat', 'num_repeat', 4, ...
%     'init_data_function', my_init_data);
%
% 3. Compare the results
% >> my_init_data = @my_init_data; 
% >> [~, intensity, ratio] = quantify_pdac('exp_name', [], 'fun_type', 'pdac_compare', ...
%     'init_data_function', my_init_data);


function [test_function, intensity, ratio] = quantify_pdac(varargin)
para_name = {'exp_name', 'fun_type', 'num_repeat', 'init_data_function'};
default_value = {'', 'copy_file', 1, @quantify_pdac_init_data};
[exp_name, fun_type, num_repeat, init_data_function]= parse_parameter(para_name, default_value, varargin);
%
load_result = 1;
%
switch fun_type
    case 'copy_file'
        test_function.copy_file = @copy_file;
        return;
end
%
test_function = [];
switch fun_type
    case 'quantify'
        data = init_data_function(exp_name);
        [intensity, ratio] = quantify_ratio_multiple_cell(data, 'load_result', load_result, 'save_result', 1);
        index_array = (ratio>=0 & ratio<=10 & intensity(:,1)>1500);
        temp = ratio(index_array); clear ratio;
        ratio = temp; clear temp;
        temp = intensity(index_array, :); clear intensity;
        intensity = temp; clear temp;
        % figure; histogram(ratio, 20);
    case 'collect_simple_repeat'
        value = cell(num_repeat,2);
        column_head = {'intensity', 'ratio'};
        for i = 1:num_repeat
            exp_name_i = strcat(exp_name, num2str(i));
            [~, value{i,1}, value{i,2}] = quantify_pdac('exp_name', exp_name_i, ...
                'fun_type', 'quantify', 'init_data_function', init_data_function);
        end
        exp = cell2struct(value, column_head, 2);
        intensity = cat(1, exp.intensity);
        ratio = cat(1, exp.ratio);
        my_figure; hist(ratio(ratio<10), 100); 
        title(get_latex_string(exp_name));
        clear exp value;
    case 'pdac_compare'
        num_exp = 4;
        exp_name = cell(num_exp, 1);
        intensity = cell(num_exp, 1);
        ratio = cell(num_exp, 1);
        num_repeat = zeros(num_exp, 1);
        
%        exp_index = [1 2 3 4 5 6 7 8]';
%         name_string = {...
%             'pdacnr_pretreat_1215', 'pdacnr_24hr_1216', 'pdacnr_48hr_1217','pdacnr_72hr_1218',...
%             'pdacr_pretreat_1215', 'pdacr_24hr_1216', 'pdacr_48hr_1217', 'pdacr_72hr_1218'};
%        repeat = [4 4 4 5 4 4 4 6]';
        exp_index = [1 2 3 4]';
        name_string = {'0626_R250nM_0_', '0626_R250nM_24_', '0626_R250nM_48_', '0626_R250nM_72_'}; 
        repeat = [4 4 4 4]';
        for i = 1:size(exp_index,1)
            ii = exp_index(i);
            exp_name{ii} = name_string{i};
            num_repeat(ii) = repeat(i);
        end
        
        for i = exp_index'
            [~, intensity{i}, ratio{i}] = quantify_pdac('exp_name', exp_name{i}, ...
                'fun_type', 'collect_simple_repeat', 'num_repeat', num_repeat(i), ...
                'init_data_function', init_data_function);
        end
        save('data.mat', 'intensity', 'ratio');
        
        % Subplot 
        fs = 22; lw = 1.0; % font_size and line_width
        
        my_figure('font_size', fs, 'line_width', lw); 
        suptitle('PDAC Non-resistant')       
        for i = 1:4
            subplot(4,1,i)
            histogram(ratio{i},20)
            lim = axis;
            axis([0 4 0 lim(4)])
            set(gca, 'FontSize', fs, 'FontName','Arial', 'FontWeight', 'bold', ...
                'LineWidth', lw);
        end
        xlabel('H3K9me3 FRET/ECFP Ratio')
        ylabel('Number of Cells');

        if num_exp >=8
            my_figure('font_size', fs, 'line_width', lw); 
            suptitle('PDAC Resistant')       
            for i = 1:4
                subplot(4,1,i)
                histogram(ratio{4+i},20)
                lim = axis;
                axis([1 9 0 lim(4)])
                set(gca, 'FontSize', fs, 'FontName','Arial', 'FontWeight', 'bold', ...
                    'LineWidth', lw);
            end
            xlabel('H3K9me3 FRET/ECFP Ratio')
            ylabel('Number of Cells')
        end
end

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