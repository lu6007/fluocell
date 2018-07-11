function my = my_function()
    % Change the following line to the location of your quanty_dataset_2.
    % Close the folder name with '/'
    my.root = '/Users/kathylu/Documents/sof/data/quanty_dataset_2/';
    my.pause = @my_pause;
    my.dir = @my_dir;
    %
    my.get_value_norm = @get_value_norm;
    my.get_value_before = @get_value_norm;
    my.get_time_interp = @get_time_interp;
    my.normalize_time_value_array = @normalize_time_value_array;
    my.interpolate_time_value_array = @interpolate_time_value_array;
    my.statistic_test = @statistic_test;
    my.get_derivative = @get_derivative;
    my.get_area_ratio = @get_area_ratio;
return

% function my_pause(enable_pause, pause_str)
% Allows the function name and pause_str to be dislayed
% when enable_pause = 1 . 
function my_pause(enable_pause, pause_str)
if enable_pause
    % find the name of upper level function
    fun = dbstack;
    if length(fun)>=2
        disp([fun(2).name, ': paused. ', pause_str]);
    else
        disp([fun(1).name, ': paused. ', pause_str]);
    end
    pause;
end
return

% Find the list of subfolders
% ignore the 1st and 2nd folders which are './' and '../'
% ignore all the files and the output folder
function list = my_dir(p)
    % Loop through the subfolders 
    % ignore the 1st and 2nd folders which are './' and '../'
    % ignore all the files and the output folder
    list = dir(p);
    num_folder = length(list);
    valid_folder = false(num_folder, 1);
    for i = 3:num_folder
        if list(i).isdir && ~strcmp(list(i).name, 'output')
            valid_folder(i) = true;
        end
    end
    temp = list(valid_folder); clear list;
    list = temp; clear temp; 
return

% function value_before = my_get_value_before(time, value)
% Find average value for time between -15 min and 0 min
function value_norm = get_value_norm(time, value)
    norm_index = (time>=-15) & (time<=0); 
    % norm_index = (time>=70) & (time<=80);
    value_norm = nanmean(value(norm_index))';
    if isnan(value_norm) 
        % find the first non-nan value and use that to normalize
       ii = find(~isnan(value),1); 
       value_norm = value(ii);
    end
return

% function time_interp = my_get_time_interp(time_bound, time_array)
% Caculate time for interpolation from time_bound
% If the user did not specify an itnerpolation range, 
% estimate time_interp from the time_array. 
function time_interp = get_time_interp(time_array, varargin)
    para_name = {'time_bound'};
    default_value = {[]};
    time_bound = parse_parameter(para_name, default_value, varargin);
    
    if isempty(time_bound)   
        time_bound = [max(min(time_array)), min(max(time_array))]; 
    end % if isempty(time_bound)
    
    time_interp = [time_bound(1):0.5:0, 0.1:0.1:10, 10.5:0.5:time_bound(2)]';
return

% function norm_ratio_array = normalize_time_value_array(time_array, ratio_array )
% Calculated normalized ratio array
function norm_value_array = normalize_time_value_array(time_array, value_array)
    [num_frame, num_cell] = size(time_array);
    norm_value_array = nan(num_frame, num_cell);
    for j = 1:num_cell
        value = value_array(:,j);
        value_norm = get_value_norm(time_array(:,j), value);
        norm_value_array(:,j) = value/value_norm;
        clear value;
    end
return

% function interp_value_array = interpolate_time_value_array(time_array, value_array,...
%    time_interp)
% Calculate interpolation of arrays
function interp_value_array = interpolate_time_value_array(time_array, value_array,...
    time_interp)
    num_time = size(time_interp, 1);
    num_cell = size(value_array, 2);
    interp_value_array = nan(num_time, num_cell);
    for j = 1:num_cell
        interp_value_array(:, j) = my_interp(time_array(:,j),value_array(:, j), ...
            time_interp, 'smooth_span', 9);
    end 
return;

% function p = statistic_test(x, y, varargin)
% parameter_name = {'method', 'group'};
% default_value = {'ttest', 'two groups'};
% 
% Perform statistical comparison between two groups
% method can be 'kstest', ranksum', or 'ttest'
% 
% Example:
% statistical_test(yf, wt, 'method', 'ranksum', 'group', 'yf and wt');
%
function p = statistic_test(x, y, varargin)
parameter_name = {'method', 'group'};
default_value = {'ttest', 'two groups'};
[method, group] = parse_parameter(parameter_name, default_value, varargin);

switch method
    case 'kstest'
            [~, p] = kstest2(x,y);
    case 'ttest' % t-test
        [~, p] = ttest2(x, y, 'Vartype','unequal', 'tail', 'both');
    case 'ranksum' % ranksum
        [p, ~] = ranksum(x, y);
end
n1 = size(x,1); 
stat.x.size = n1;
stat.x.average = mean(x);
stat.x.standard_error = std(x)/sqrt(n1);
n2 = size(y,1); 
stat.y.size = n2;
stat.y.average = mean(y);
stat.y.standard_error = std(y)/sqrt(n2);
fprintf('Compare %s,\n', group);
fprintf('p-value = %e, method: %s; \n', p, method);
fprintf('n1 = %d, mean-SEM: %f +/- %f; \n', stat.x.size, stat.x.average, stat.x.standard_error);
fprintf('n2 = %d, mean-SEM: %f +/- %f. \n\n', stat.y.size, stat.y.average, stat.y.standard_error);
return

% function [max_deriv, max_i, min_deriv, min_i] = get_derivative(t, y)
function [max_deriv, max_i, min_deriv, min_i] = get_derivative(t, y)
first_deriv = gradient(y, t).*(t>0); %??? 
[max_deriv, max_i] = max(first_deriv);
if max_deriv <=0
    max_deriv = nan;
    max_i = nan;
    min_deriv = nan;
    min_i = nan;
    return;
end
[min_deriv, min_i] = min(first_deriv(max_i+1:end));
if isempty(min_deriv) || min_deriv >=0
    min_deriv = nan;
    min_i = nan;
end
return

% function area_ratio = get_area_ratio(t, y)
% Area ratio is a measure of transient index
function area_ratio = get_area_ratio(t, y)
time_th = 15; % min
time_span = 15; % min
max_y_95 = prctile(y, 95, 1);
max_i_95 = find(y>=max_y_95, 1);
if t(max_i_95)>=time_th
    area_ratio = nan;
    return;
end
t95 = t(max_i_95);
index = (t>=t95)&(t<=t95+time_span);
area_curve = trapz(t(index), y(index));
area_ratio = area_curve/max_y_95*time_span;
return