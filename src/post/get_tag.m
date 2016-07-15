% function vec_tag = get_tag(vec, tag_name)
% Make a vector of tags, for the multiple_comparison() function.

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function vec_tag = get_tag(vec, tag_name)
n = length(vec);
vec_tag = tag_name;
for i = 1:n-1,
    % when n is big, use strvcat() to improve speed
    vec_tag = [tag_name; vec_tag];
end;

return;
