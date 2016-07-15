% Draw a mask for the cell image
% This is for generating mask for the function
% batch_detect_cell_fas with the option need_mask =1.

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function make_cell_mask(data)
str_index = sprintf('%03d', data.index(1));
im = imread(strcat(data.path, data.prefix_sub, '4.', str_index));
figure; imagesc(im); cell_mask = roipoly();
imwrite(cell_mask, strcat(data.path, 'cell_mask'), 'tiff');
return;