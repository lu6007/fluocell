% For the fluorescent image of membrane targeted biosensors 
% such as lyn-Src biosensor, we can just use Otsu's method to find cell edge.
% function [bd, bw] = get_cell_edge(im, brightness_factor);
% Output: bd is a cell and bw is a logical image/matrix. 

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function [bd, bw, threshold] = get_cell_edge(im, varargin)
% set up the parameter values by input
% or the default values.
parameter_name = {'brightness_factor', ...
    'min_area','threshold', 'mask_bw', 'multiple_object'};
default_value = {1.0, 500, 0, [], 0};
[brightness_factor, min_area, threshold, mask_bw, multiple_object]...
    = parse_parameter(parameter_name, default_value, varargin);

% for molly's data, Lexie on 10/15/2015
if multiple_object
    threshold = my_graythresh(uint16(im));
end

if ~isempty(mask_bw)
    temp = double(im).*double(mask_bw); clear im;
    im = temp; clear temp;
end

% in the case the input im is double
temp = uint16(im); clear im;
im = temp; clear temp;

if ~threshold
    threshold = my_graythresh(im);
end

try        
    bw_image = imbinarize(im, threshold*brightness_factor);
catch
    try
        bw_image = imbinarize(im, threshold*brightness_factor);
    catch
        disp('Function get_cell_edge warning: ');
        disp('MATLAB version not in the range 2012-current.');
    end
end
% get rid of objects with size less than min_area
bw_image_open = bwareaopen(bw_image, min_area);
clear bw_image; bw_image = bw_image_open; clear bw_image_open;

if ~isempty(mask_bw)
    bw_image = bw_image.*mask_bw;
end

% Lexie and Shirley on 10/13/2015
% option to have multiple detections

if ~multiple_object
    boundaries{1} = find_longest_boundary(bw_image);
else
    [boundaries, ~] = bwboundaries(bw_image, 8, 'noholes');
end

if isempty(boundaries)
    bd = [];
    bw = [];
   return;
end

bd = boundaries;
bw = bw_image;
clear bw_image;

% if show_figure,
%     % set(gca, 'FontSize', 12,'Box', 'off', 'LineWidth',2);
%     h = gca;
%     % title('Cell image overlayed with boundary');
%     plot(bd{1}(:,2),bd{1}(:,1),'r', 'LineWidth',2);
% else
%     h = 0;
% end;

return;

