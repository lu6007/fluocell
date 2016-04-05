% function [parameter_values success] = ...
% parse_parameter(parameter_name, default_value, varargin);
%
% parameter_name is a cell array containing all the possible names
% of the optional parameters
% paramter_values is the cell array containing the
% parsed parameter values in the same order of
% parameter_name.
%
% Example:
% 
%     p_name = {'save_file', 'image_index', 'algorithm'};
%     default_v = {1, (1:5), 'segmentation'};
%     [save_file, image_index, algorithm ] = parse_parameter(p_name,...
%     default_v, varargin);
% 

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function varargout = parse_parameter(parameter_name,...
    default_value, varargin)

%initialize with default values
varargout = default_value;

% update with optional parameter values
varargin = varargin{1};
num_varargin = length(varargin);
parameter_recognized = 0;
success = 1;
num_parameters = length(parameter_name);
for i = 1:num_varargin,
    if parameter_recognized,
        parameter_recognized = 0;
        continue;
    end;
    for j = 1:num_parameters,
        if strcmpi(varargin{i}, parameter_name{j}),
            varargout{j} = varargin{i+1};
            parameter_recognized = 1;
            break;
        end; % if
    end; % for j
%     if ~parameter_recognized,
%         display('Parse_parameter: Unrecognized parameter!');
%         success = 0;
%     end;
end;

varargout{num_parameters+1} = success;
return;