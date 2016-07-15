% function test_plot_excel_file(p, file_name);
% 'plot_type' - 1 : plot the original data;
%             - 2 : plot the normalized data;
%             - 3 : plot the mean and standard error of the data.
% 'axis_limit' : the limits for the axis of the plot. If not sure about
%                   it, make a plot with the axis_limit and then repeat the
%                   plot with the estimated values.
% 'before_time'   : the cut-off time for normalization;
% 'time_limit'    : the range where the data is good for normalization.
%
% Example: 
% p = 'C:\Users\Administrator\Documents\doc\paper\MT1_MMP\yi\';
% file_name = 'Figure_6_SKBR3_EGF.xls';
% [interp_time mean_value std_error] = plot_excel_file(p, file_name,...
% 'num_sheets', 3);
% [interp_time mean_value std_error] = plot_excel_file(p, file_name,...
% 'num_sheets', 3, 'plot_type', 1, 'axis_limit', [0 80 0.4 1.4]);
% [interp_time mean_value std_error] = plot_excel_file(p, file_name,...
% 'num_sheets', 3, 'plot_type', 2, 'axis_limit', [-10 70 0.8 2.0]);
% [interp_time mean_value std_error] = plot_excel_file(p, file_name,...
% 'num_sheets', 3, 'plot_type', 3, 'interp_time', (-5:5:45)',...
% 'norm_time', [-5 0]);

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function [interp_time mean_interp_value std_error exp] = ...
    plot_excel_file(p, file_name, varargin)
para_name = {'num_sheets','show_figure','plot_type','axis_limit', ...
    'norm_time','interp_time','average_time'};
default_val = {1, 1, 1, [], [-20 0], (0:5:40)', [30 40]};
[num_sheets, show_figure, plot_type, axis_limit, norm_time, ...
    interp_time, average_time] = ...
    parse_parameter(para_name, default_val, varargin);
if ~isempty(axis_limit),
    fix_axis = 1;
else
    fix_axis = 0;
end;
% Read the excel file and save the results
excel_file = strcat(p, file_name);
[~, ~, xls_str] = fileparts(file_name);
mat_file = regexprep(excel_file, xls_str, '.mat');
if ~exist(mat_file, 'file'),
    exp = excel_read_curve(excel_file);
    save(mat_file, 'exp');
else 
    input = load(mat_file);
    exp = input.exp;
    clear input;
end;

num_exps = num_sheets;
smooth_nbhd = 10;
% Plot the original value
if show_figure && (plot_type ==1 ),
    num_colors = 6;
    cc = jet(num_colors);
    for i = 1:num_exps,
        figure('color','w'); hold on;
        set(gca, 'FontSize', 12, 'FontWeight', 'bold','Box', 'off', 'LineWidth',3); 
        xlabel('Time (min)'); ylabel('FRET Ratio'); 
        num_cells = exp{i}.num_cells;
        for j = 1:num_cells,  % Plot the values before normalization
            time = exp{i}.cell(j).time;
            value = exp{i}.cell(j).value;
            sm_int = smooth(time, value, smooth_nbhd, 'rloess');
            k = mod(j, num_colors) + 1;
            plot(time, sm_int, '-', 'Color',cc(k,:), 'LineWidth', 2);
            clear sm_int time value;
        end;
        title(exp{i}.name);
        if fix_axis,
            axis(axis_limit);
        end;
    end;
end;

% Calculate and plot the normalized values with the smooth curve
the_cell = cell(num_exps, 1);
% before_time = 3;
for i = 1:num_exps,    
    the_cell{i} = get_normalized_value(exp{i}.cell,norm_time);
    num_cells = exp{i}.num_cells;
    [all_time all_index] = sort(cat(1, the_cell{i}.time));
    temp = cat(1, the_cell{i}.norm_value);
    all_int = temp(all_index); clear temp;
    % loess smooth
    sm_int = smooth(all_time, all_int, smooth_nbhd*num_cells, 'loess');
    
    % Plot the normalized values with the smooth curves.
    if show_figure &&  (plot_type==2 ),
        figure('color','w'); hold on;
        set(gca, 'FontSize', 12, 'FontWeight', 'bold','Box', 'off', 'LineWidth',3); 
        xlabel('Time (min)'); ylabel('Normalized FRET Ratio');
        for j =1:num_cells,
            plot(the_cell{i}(j).time, the_cell{i}(j).norm_value, '+',...
                'MarkerSize', 6, 'LineWidth', 2);
        end;
        plot(all_time, sm_int, 'r', 'LineWidth', 2);
        title(exp{i}.name);
        if fix_axis,
            axis(axis_limit);
        end;
    end;

    clear all_time all_int sm_int;
end; % for i

% calculate and plot the interpolated value.
mean_interp_value = zeros(length(interp_time), num_exps);
std_error = zeros(length(interp_time), num_exps);
average_index = (interp_time>=average_time(1) & interp_time<=average_time(2));
% Loop throught the experiments
for i = 1:num_exps,    
    % Calculate the interpolated value.
    the_cell{i} = get_interpolated_value(the_cell{i}, interp_time, 'method', 'spline');
    
    % Calculate the average and std_error of the interpolated values.
    interp_value = cat(2, the_cell{i}.interp_value);
    mean_interp_value(:, i) = mean(interp_value,2);
    std_error(:,i) = std(interp_value,0,2)/sqrt(num_cells);

    % Calculate the average value within the average_time for each cell.
    exp{i}.average_value = (mean(interp_value(average_index, :), 1))';
    clear interp_value;
end; % for i
%
if show_figure && (plot_type ==3 ),
    % Plot the mean value with standard error.
    figure('color','w'); hold on;
    set(gca, 'FontSize', 12, 'FontWeight', 'bold','Box', 'off', 'LineWidth',3); 
    xlabel('Time (min)'); ylabel('Normalized Average FI');
    color = {'r', 'g', 'b','k'};
    t = interp_time;
    for i = 1:num_exps,
        miv = mean_interp_value(:,i); se = std_error(:,i);
        errorbar(t, miv,se, 'Color', color{i}, 'LineWidth',2);
        plot(t, miv, strcat(color{i}, 'o'), 'MarkerSize', 6, 'LineWidth', 2);
        clear miv se;
    end;
end;

return;

% Calculate the normalized intensity of an array of the_cell structure
% with time and value
% Input: the_cell(j).time and the_cell(j).value
% Output: the_cell(j).norm_value
function the_cell = get_normalized_value(the_cell, norm_time)
    num_cells = length(the_cell);
    for j = 1:num_cells,
        time = the_cell(j).time;
        ave_intensity = the_cell(j).value;
        before_index = (time>= norm_time(1) & time<= norm_time(2));
        before_average = mean(ave_intensity(before_index));
        norm_intensity = ave_intensity/before_average;
        the_cell(j).norm_value = norm_intensity;
        clear time ave_intensity before_index before_average norm_intensity;
    end; 
return;

% Calculated the interpolated value of an array of the_cell structure
% with norm_value at interp_time 
% Input: the_cell(j).norm_value
% Output: the_cell(j).interp_value
function the_cell = get_interpolated_value(the_cell, interp_time, varargin)
    parameter_name = {'method'};
    default_value = {'spline'};
    method = parse_parameter(parameter_name, default_value, varargin);
    num_cells = length(the_cell);
    for j = 1:num_cells,
        % spline interpolation and allow for extrapolation
        the_cell(j).interp_value = interp1(the_cell(j).time, the_cell(j).norm_value,...
            interp_time, method);
    end; % for j
return;

