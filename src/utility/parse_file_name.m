% function [file_name, varargout] = parse_file_name(first_file_name, index_pattern, varargin)

% Copyright: Shaoying Lu 2013
% kalu@ucsd.edu
function [file_name, varargout] = parse_file_name(first_file_name, index_pattern, varargin)
num_input = length(varargin);
assert(num_input>=2);

file_name = regexprep(first_file_name, index_pattern{1}, index_pattern{2});
% n = num_output = num_input-1
n = num_input-1;
output = cell(n,1);
for i = 1:n,
    output{i} = regexprep(file_name, varargin{1}, varargin{i+1});
end;
varargout = output;
return;