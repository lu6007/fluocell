% function [bw, bd] = clean_up_boundary(im, boundaries,...
%    with_smoothing, smoothing_factor)

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function [bw, bd] = clean_up_boundary(im, boundaries, with_smoothing, smoothing_factor)
% 10/14/2015 Lexie - change the boundary data structure to be cell to store more than one
% objects
num_objects = length(boundaries);
bw = cell(num_objects, 1);
bd = cell(num_objects, 1);
for i = 1 : num_objects
    x = boundaries{i}(:,2); y = boundaries{i}(:,1);

    % delete duplicated nodes
    [x,y] = delete_duplicate_node(x,y);

    % smoothing
    if with_smoothing
        x = smooth(x, smoothing_factor, 'lowess');
        y = smooth(y, smoothing_factor, 'lowess');
    end

    % delete unecessary nodes, such as a little needle 
    % at edge of the image
    [x,y] = delete_extra_node(x,y, pi*10.0/180.0);
    bw{i} = bd2im(im, x, y);
    bd{i}= [y x];
end

% 10/14/2015 Lexie - For molly's problem, combine all masks to be one
temp = bw{1};
if length(bw) > 1
    for i = 2 : length(bw)
        temp = temp + bw{i};
    end
    clear bw
end
bw = temp; clear temp

return;