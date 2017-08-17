% For the fluorescent image of membrane targeted biosensors 
% such as lyn-Src biosensor, we can just use Atsu's method to find cell edge.
% function [bd, bw] = get_cell_edge(im, brightness_factor);
% Output: bd is a cell and bw is a logical image/matrix. 

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function [bd, bw, threshold] = get_cell_edge(im, varargin)
% set up the parameter values by input
% or the default values.
% 10/14/2015 Lexie - add new parameter multiple_object to detect more one object
parameter_name = {'brightness_factor', ...
    'min_area','threshold', 'mask_bw', 'multiple_object', 'segment_method'};
default_value = {1.0, 500, 0, [], 0, 0};
[brightness_factor, min_area, threshold, mask_bw, multiple_object, segment_method]...
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

temp = version;
% Kathy 08/16/2017, make compatible with Windows MATLAB R2013
if length(temp)>=19
    tt = temp(15:19);
else
    tt = temp(12:16);
end
if strcmp(tt,'R2018')||strcmp(tt, 'R2017')||strcmp(tt, 'R2016')
    bw_image = imbinarize(im, threshold*brightness_factor);
elseif strcmp(tt, 'R2015')||strcmp(tt, 'R2014')||strcmp(tt, 'R2013')||...
        strcmp(tt, 'R2012')
    bw_image = im2bw(im, threshold*brightness_factor);
else 
    disp('Function get_cell_edge warning: ');
    disp('MATLAB version not in the range 2012-2018.');
end
clear temp tt;
% get rid of objects with size less than min_area
bw_image_open = bwareaopen(bw_image, min_area);
clear bw_image; bw_image = bw_image_open; clear bw_image_open;


% Apply different segmentation methods
temp_im_bw = bw_image;
clear bw_image
bw_image = detect_watershed(im, temp_im_bw, 'segment_method', segment_method);


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

