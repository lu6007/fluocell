% For the fluorescent image of membrane targeted biosensors 
% such as lyn-Src biosensor, we can just use Atsu's method to find cell edge.
% Right now this program only detect one cell.
% function [bd, bw] = get_cell_edge(im, brightness_factor);

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function [bd, bw, threshold] = get_cell_edge(im, varargin)
% set up the parameter values by input
% or the default values.
parameter_name = {'brightness_factor', ...
    'with_smoothing', 'smoothing_factor', 'min_area','threshold', 'mask_bw'};
default_value = {1.0, 1, 9, 500, 0, []};
[brightness_factor, ...
    with_smoothing, smoothing_factor, min_area, threshold, mask_bw]...
    = parse_parameter(parameter_name, default_value, varargin);

if ~isempty(mask_bw),
    temp = double(im).*double(mask_bw); clear im;
    im = temp; clear temp;
end;

% in the case the input im is double
temp = uint16(im); clear im;
im = temp; clear temp;

if ~threshold,
    threshold = graythresh(im);
end;

bw_image = im2bw( im, threshold*brightness_factor);
% get rid of objects with size less than min_area
bw_image_open = bwareaopen(bw_image, min_area);
clear bw_image; bw_image = bw_image_open; clear bw_image_open;

% if ~isempty(mask_bw),
%     bw_image = bw_image.*mask_bw;
% end;

boundaries = find_longest_boundary(bw_image);

if isempty(boundaries),
    bd = [];
   bw = [];
   return;
end;

% remove the holes on the mask if there are any
[m, n] = size(bw_image); clear bw_image;
bw_image = poly2mask(boundaries(:,2), boundaries(:,1), m,n);

bd = boundaries;
bw = bw_image;
clear bw_image;

% [bw bd] = clean_up_boundary(im, boundaries, with_smoothing,...
%     smoothing_factor);

% if show_figure,
%     % set(gca, 'FontSize', 12,'Box', 'off', 'LineWidth',2);
%     h = gca;
%     % title('Cell image overlayed with boundary');
%     plot(bd{1}(:,2),bd{1}(:,1),'r', 'LineWidth',2);
% else
%     h = 0;
% end;

return;

