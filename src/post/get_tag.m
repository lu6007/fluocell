% function vec_tag = get_tag(vec, tag_name)
% Make a vector of tags, for the multiple_comparison() function.

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function vec_tag = get_tag(vec, tag_name)
% function vec_tag = get_tag(vec, tag_name, varargin)
% para_name = {'tag_length'};
% this_tag_length = size(tag_name, 1); 
% para_default = {this_tag_length};
% tag_length = parse_parameter(para_name, para_default, varargin); 
% % assert(tag_length >= this_tag_length, "get_tag: tag_length< this_tag_length! \n");
% if tag_length > this_tag_length
%     temp = tag_name; clear tag_name;
%     tag_name = pad(temp, tag_length); clear temp; 
% end

n = length(vec);
cell_vec_tag = cell(n, 1);
for i = 1:n
    cell_vec_tag{i} = tag_name; 
end
vec_tag = char(cell_vec_tag);
clear cell_vec_tag;

return
