% add a tail containing the string form of index
% into all the titles

% Copyright: Shaoying Lu, Shannon Laub and Yingxiao Wang 2014
function my_title(title_name, index, varargin)
%Enabled possible display of z-index for the title. - Shannon 8/24/2016
parameter_name = {'data'};
default_value = {[]};
[data] = parse_parameter(parameter_name, default_value, varargin);

%Check if the z-stack viewer is in use.
if ~(isfield(data,'image_type') && strcmp(data.image_type,'z-stack'))
    title(strcat(title_name, '\_', num2str(index))); %Default behavior.
else
    title(strcat(title_name,'\_', num2str(index),'\_z',num2str(data.z_index))); %Viewing z-stack.
end

return;
