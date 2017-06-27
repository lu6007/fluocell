% --- Executes on button press in open_pushbutton. Open
% Read the file names and initialize the figures.

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function data = open_button_callback(data)
% open and initialize file variables
if isfield(data, 'path')
    default_file = strcat(data.path, '*.*');
else
    default_file = '*.*';
end
[file, path, success] = uigetfile(default_file);
if ~success
    data.success = 0;
    return;
else
    data.success = 1;
end

% Use ~ only if MATLAB 2009b (version 7.9) or later
% if verLessThan('matlab', '7.9'), do not use ~

[~, prefix,postfix] = fileparts(file); 
data.path = path;
data.prefix =prefix;
data.postfix = postfix;

data.output_path = strcat(data.path, 'output/');
if ~exist(data.output_path, 'dir')
    mkdir(data.output_path);
end

% % Update the user-interface and the figures
% data = init_figure(data);
return;

