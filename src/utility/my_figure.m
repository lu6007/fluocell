% function handle = my_figure(varargin)
% parameter_name = {'handle'};
% default_value = {[]};
% If the handle exists, draw on the current figure handle. 
% else, make a new figure. 

% Copyright: Shaoying Lu and Yingxiao Wang 2011-2016
function handle = my_figure(varargin)
parameter_name = {'handle'};
default_value = {[]};
handle = parse_parameter(parameter_name, default_value, varargin);
if ~isempty(handle),
    figure(handle);
    set(gcf,'color', 'w');
else % isempty(handle)
    handle = figure('color', 'w'); 
end
set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth',1.5);
return;