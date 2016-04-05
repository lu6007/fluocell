% function [bw, bd] = clean_up_boundary(im, boundaries,...
%    with_smoothing, smoothing_factor)

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function [bw, bd] = clean_up_boundary(im, boundaries,...
    with_smoothing, smoothing_factor)
x = boundaries(:,2); y = boundaries(:,1);

% delete duplicated nodes
[x,y] = delete_duplicate_node(x,y);

% smoothing
if with_smoothing,
    x = smooth(x, smoothing_factor, 'lowess');
    y = smooth(y, smoothing_factor, 'lowess');
end;

% delete unecessary nodes, such as a little needle 
% at edge of the image
[x,y] = delete_extra_node(x,y, pi*10.0/180.0);
bw = bd2im(im, x, y);
bd{1}= [y x];
return;