% Calculate the subscribing region of interest based on the
% given boundary and size of the image.
% This function is the inverse of the function bwboundaries().

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function new_im = bd2im(im, x, y);
new_im = roipoly(im, x, y);
[num_rows num_cols] = size(im);
% round to the closest integer
[x y] = interpolation(x,y);
x = max(floor(x+0.5),1); y = max(floor(y+0.5),1);
im_bd = sparse(y,x, ones(size(x)), num_rows, num_cols);
im_bd = full(im_bd);
%new_im = new_im.*(~im_bd);
new_im = new_im|im_bd;
return;

