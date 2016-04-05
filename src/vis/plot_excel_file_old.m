% function test_plot_excel_file(p, file_name);
% Example: 
% p = 'C:\Users\Administrator\Documents\doc\paper\MT1_MMP\yi\';
% file_name = 'Figure_5_mda_adhesion.xlsx';
% [interp_time mean_value std_error] = plot_excel_file(p, file_name, 'num_sheets', 3);

function [interp_time mean_interp_value std_error] = ...
    plot_excel_file(p, file_name, varargin)
para_name = {'num_sheets','show_figure'};
default_val = {[1], [1]};
[num_sheets show_figure] = parse_parameter(para_name, default_val, varargin);
% Read the excel file and save the results
exp = excel_read_curve(strcat(p, file_name));
num_exps = num_sheets;
the_cell = cell(num_exps, 1);
% Calculate the normalized values.
for i = 1:num_exps,    
    % Calculate the normalized value
    the_cell{i} = get_normalized_value(exp{i}.cell, 'before_time', 3);
    % Calculate the smooth curve
    num_cells = exp{i}.num_cells;
    smooth_nbhd = 10;
    [all_time all_index] = sort(cat(1, the_cell{i}.time));
    temp = cat(1, the_cell{i}.norm_value);
    all_int = temp(all_index); clear temp;
    % loess smooth & plot the smooth curve
    sm_int = smooth(all_time, all_int, smooth_nbhd*num_cells, 'loess');
    
    % Plot the normalized values with the smooth curves.
    if show_figure,
        figure('color','w'); hold on;
        set(gca, 'FontSize', 12, 'FontWeight', 'bold','Box', 'off', 'LineWidth',3); 
        xlabel('Time (min)'); ylabel('Normalized FRET Ratio');
        for j =1:num_cells,
            plot(the_cell{i}(j).time, the_cell{i}(j).norm_value, '+',...
                'MarkerSize', 6, 'LineWidth', 2);
        end;
        plot(all_time, sm_int, 'r', 'LineWidth', 2);
    
    %     for j = 1:num_cells,  % Plot the values before normalization
    %         plot(the_cell(j).time, the_cell(j).value, '+', ...
    %             'MarkerSize', 6, 'LineWidth', 2);
    %     end;
        title(exp{i}.name);
        axis([-5 40 0.8 1.5]);
    end;

    % Calculate the average and std_error of the interpolated values.
    interp_value = cat(2, the_cell.interp_value);
    mean_interp_value(:, i) = mean(interp_value,2);
    std_error(:,i) = std(interp_value,0,2)/sqrt(num_cells);

    clear interp_value the_cell all_time all_int sm_int;
end; % for i



interp_time = (0:5:40)';
mean_interp_value = zeros(length(interp_time), num_exps);
std_error = zeros(length(interp_time), num_exps);
% Loop throught the experiments
for i = 1:num_exps,    
    % Calculate the normalized and interpolated value.
    the_cell = get_normalized_value(exp{i}.cell, 'before_time', 3);
    the_cell = get_interpolated_value(the_cell, interp_time, 'method', 'spline');
    
    % Calculate the smooth curve
    num_cells = exp{i}.num_cells;
    smooth_nbhd = 10;
    [all_time all_index] = sort(cat(1, the_cell.time));
    temp = cat(1, the_cell.norm_value);
    all_int = temp(all_index); clear temp;
    % loess smooth & plot the smooth curve
    sm_int = smooth(all_time, all_int, smooth_nbhd*num_cells, 'loess');
    
    % Plot the normalized values with the smooth curves.
    if show_figure,
        figure('color','w'); hold on;
        set(gca, 'FontSize', 12, 'FontWeight', 'bold','Box', 'off', 'LineWidth',3); 
        xlabel('Time (min)'); ylabel('Normalized FRET Ratio');
        for j =1:num_cells,
            plot(the_cell(j).time, the_cell(j).norm_value, '+',...
                'MarkerSize', 6, 'LineWidth', 2);
        end;
        plot(all_time, sm_int, 'r', 'LineWidth', 2);
    %     Plot the values before normalization
    %     for j = 1:num_cells,
    %         plot(the_cell(j).time, the_cell(j).value, '+', ...
    %             'MarkerSize', 6, 'LineWidth', 2);
    %     end;
        title(exp{i}.name);
        axis([-5 40 0.8 1.5]);
    end;

    % Calculate the average and std_error of the interpolated values.
    interp_value = cat(2, the_cell.interp_value);
    mean_interp_value(:, i) = mean(interp_value,2);
    std_error(:,i) = std(interp_value,0,2)/sqrt(num_cells);

    clear interp_value the_cell all_time all_int sm_int;
end; % for i

if show_figure,
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
function the_cell = get_normalized_value(the_cell, varargin)
    parameter_name = {'before_time'};
    default_value = {0};
    before_time = parse_parameter(parameter_name, default_value, varargin);
    num_cells = length(the_cell);
    for j = 1:num_cells,
        time = the_cell(j).time;
        ave_intensity = the_cell(j).value;
        before_index = (time<=before_time);
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
