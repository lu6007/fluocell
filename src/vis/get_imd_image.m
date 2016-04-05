% function get_imd_image(im_color, im_intensity, varargin)
% parameter_names = {'ratio_bound', 'intensity_bound'};
% default_values ={[min(min(im_color)), max(max(im_color))],...
%     [min(min(im_intensity)), max(max(im_intensity))]};
%
% Converts gray scale images im_color and im_intensity into a color image
% with the IMD display. 

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function imd_image = get_imd_image(im_color, im_intensity, varargin)
parameter_name = {'ratio_bound', 'intensity_bound'};
default_value ={[min(min(im_color)), max(max(im_color))],...
    [min(min(im_intensity)), max(max(im_intensity))]};
[ratio_bound, intensity_bound] = ...
    parse_parameter(parameter_name, default_value, varargin);
load 'my_hsv.mat';
cbound = [1 length(my_hsv)];
temp = floor(imscale(im_color, cbound(1), cbound(2), ratio_bound));
im_rgb = ind2rgb(temp, my_hsv); clear temp;
temp = floor(imscale(im_intensity, cbound(1), cbound(2), intensity_bound));
im_gray = ind2rgb(temp, gray(cbound(2))); clear temp;
imd_image = im_gray.*im_rgb;
clear my_hsv;
return;