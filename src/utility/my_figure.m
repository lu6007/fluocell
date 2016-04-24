% function handle = my_figure(varargin)
% parameter_name = {'handle', 'font_size', 'line_width'};
% default_value = {[], 12, 1.5};
% If the handle exists, draw on the current figure handle. 
% else, make a new figure. 

% Copyright: Shaoying Lu and Yingxiao Wang 2011-2016
function handle = my_figure(varargin)
parameter_name = {'handle', 'font_size', 'line_width'};
default_value = {[], 12, 1.5};
[handle, fs, lw] = parse_parameter(parameter_name, default_value, varargin);
if ~isempty(handle),
    figure(handle);
    set(gcf,'color', 'w');
else % isempty(handle)
    handle = figure('color', 'w'); 
end
set(gca, 'FontSize', fs, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth', lw);
return;