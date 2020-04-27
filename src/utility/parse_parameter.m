% function [parameter_values success print_function] = ...
% parse_parameter(parameter_name, default_value, varargin);
%
% parameter_name is a cell array containing all the possible names
% of the optional parameters
% paramter_values is the cell array containing the
% parsed parameter values in the same order of
% parameter_name.
%
% Example (use inside a function):
% 
%     p.name = {'save_file', 'image_index', 'algorithm'};
%     default_v = {1, (1:5), 'segmentation'};
%     [save_file, image_index, algorithm, ~, print_parameter] = parse_parameter(p.name,...
%     default_v, varargin);
%     p.value = {save_file, image_index, algorithm}; 
%     p.format = {'%d', '', '%s'};     % '' indicates not printing
%     print_parameter(p);
% 

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function varargout = parse_parameter(parameter_name,...
    default_value, varargin)

%initialize with default values
varargout = default_value;
verbose = 0;

% update with optional parameter values
varargin = varargin{1};
num_varargin = length(varargin);
parameter_recognized = 0;
success = 1;
num_parameter = length(parameter_name);
for i = 1:2:num_varargin
    if parameter_recognized
        parameter_recognized = 0;
    end
    for j = 1:num_parameter
        if strcmpi(varargin{i}, parameter_name{j})
            varargout{j} = varargin{i+1};
            parameter_recognized = 1;
            break;
%         elseif strcmpi(varargin{i}, 'verbose')
%             verbose = varargin{i+1};
%             parameter_recognized = 1;
%             break;
        end % if

    end % for j

    % Kathy: 03/08/2019, this part needs to be uncommented and tested
%     if ~parameter_recognized
%         disp('Parse_parameter: Unrecognized parameter!');
%         disp(varargin{i});
%         dbstack(1)
%         success = 0;
%     end
end

% Should switch to a print_parameter function interface
if verbose
    dbstack(1)
    fprintf('Parameters: \n\n'); 
    for j = 1:num_parameter
        fprintf('%s = ', parameter_name{j}); disp(varargout{j}); 
    end
    fprintf('%s = ', 'verbose'); disp(verbose);
    fprintf('Function parse_parameter() changed implementation 04/04/2019 \n');
    fprintf('In the future, use the print_parameter function instead. \n');
end

varargout{num_parameter+1} = success;
varargout{num_parameter+2} = @print_function;
return;

function print_function(parameter)
% parameter.name, parameter.format, parameter.value
temp = dbstack(1);
fprintf('Function %s() parameters: \n', temp.name);
num_parameter = length(parameter.name);
for i = 1:num_parameter
    %fprintf('%s = parameter.format{i} \n', parameter.name{i}, parameter.value{i});
    cmd = ['fprintf(''%s = ', parameter.format{i}, ...
        '\n'', parameter.name{i}, parameter.value{i});'];
    eval(cmd);
end
return;
