% function bw =get_background(im, file_bg)
% parameter_name = {'method'};
% default_value = {'manual'};
% 0 - no background subtraction
% 1 - manually choose background
% 2 - automatically select background
% provide two methods to get the background:
% method "auto": Automatically select a background region with the minimal 
% intensity value among the four corners.
% method "manual": Manually choose the region as the background.

% Copyright: Shaoying Lu and Yingxiao Wang 2011
% Modified by Lexie Qin Qin and Shaoyng Lu 2014

function [bw, poly] =get_background(im, file_bg, varargin)
parameter_name = {'method'};
default_value = {'manual'};
method = parse_parameter(parameter_name, default_value,varargin);

switch method
    case {'manual','m', 1}        % 1 and 2 added Kathy 04/24/2016
        [bw_cell, poly_cell] = get_polygon(im, file_bg,...
            'Please choose the background region.');
        bw = bw_cell{1};
        poly = poly_cell{1};
        
    case {'auto','a', 2}
        %Automatically select a background region with the minimal 
        %intensity value among the four corners.
        [bw_cell, poly_cell] = get_polygon(im, file_bg,...
            'Automatically detect the background region.', 'method', 'auto');
        bw = bw_cell{1};
        poly = poly_cell{1};
        
end        
        
return;
