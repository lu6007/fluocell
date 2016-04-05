% For the fluorescent image of membrane targeted biosensors 
% such as lyn-Src biosensor, we can just use Atsu's method to find cell edge.
% Right now this program only detect one cell.
% function [bd, bw] = get_cell_edge(im, brightness_factor);

function bd = cell_edge_thresh(img, varargin)
% set up the parameter values by input
% or the default values.
parameter_name = {'brightness_factor','min_area','threshold', 'mask_bw'};
default_value = {1.0, 2, 0, []};
[brightness_factor, min_area, threshold, mask_bw]...
    = parse_parameter(parameter_name, default_value, varargin);

img = uint16(img);
  
if ~threshold,
    threshold = my_graythresh(img);
end;

bw_image = im2bw( img, threshold*brightness_factor);
% bw_image = edge(img,'sobel');
% get rid of objects with size less than min_area
bw_image = bwareaopen(bw_image, min_area);
se = strel('disk',1);
bw_image = imerode(bw_image,se);
bw_image = imdilate(bw_image,se);
bw_image = bwareaopen(bw_image, min_area);
bw_image = imclose(bw_image, strel('disk', 6));

bd = find_longest_boundary(bw_image);

return;