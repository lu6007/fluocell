% function get_imd_image(im_color, im_intensity, varargin)
% parameter_names = {'ratio_bound', 'intensity_bound'};
% default_values ={[min(min(im_color)), max(max(im_color))],...
<<<<<<< HEAD
%     [min(min(im_intensity)), max(max(im_intensity))]};
=======
%     default_intensity_bound};
>>>>>>> current/master
%
% Converts gray scale images im_color and im_intensity into a color image
% with the IMD display. 

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function imd_image = get_imd_image(im_color, im_intensity, varargin)
<<<<<<< HEAD
parameter_name = {'ratio_bound', 'intensity_bound'};
default_value ={[min(min(im_color)), max(max(im_color))],...
    [min(min(im_intensity)), max(max(im_intensity))]};
[ratio_bound, intensity_bound] = ...
    parse_parameter(parameter_name, default_value, varargin);
=======
%
alpha = 0.5;
min_i = min(min(im_intensity));
max_i = max(max(im_intensity));
default_intensity_bound = [min_i, min_i+alpha*(max_i-min_i)];
%
parameter_name = {'ratio_bound', 'intensity_bound'};
default_value ={[min(min(im_color)), max(max(im_color))],...
    default_intensity_bound};
[ratio_bound, intensity_bound] = ...
    parse_parameter(parameter_name, default_value, varargin);

if isempty(intensity_bound)
    intensity_bound = default_intensity_bound;
end

>>>>>>> current/master
load 'my_hsv.mat';
cbound = [1 length(my_hsv)];
temp = floor(imscale(im_color, cbound(1), cbound(2), ratio_bound));
im_rgb = ind2rgb(temp, my_hsv); clear temp;
temp = floor(imscale(im_intensity, cbound(1), cbound(2), intensity_bound));
im_gray = ind2rgb(temp, gray(cbound(2))); clear temp;
imd_image = im_gray.*im_rgb;
clear my_hsv;
return;