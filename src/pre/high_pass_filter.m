% function im_new = high_pass_filter(im, filter_size, varargin)
% High pass filter with given filter size (required to be 
% an odd number)
% Using symmetric pad for the image
% method- 1: filter only; method-2 : filter and convert to
% uint16 image

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function im_new = high_pass_filter(im, filter_size, varargin)
parameter_name = {'method'};
default_value = {1};
method = parse_parameter(parameter_name, default_value, varargin);

middle = floor((filter_size-1)/2)+1;
high_pass_filter = -1./(filter_size*filter_size)*ones(filter_size, filter_size);
high_pass_filter(middle, middle) = high_pass_filter(middle, middle)+1;
pad_size = floor((filter_size-1)/2);
im_pad = padarray(im, [pad_size, pad_size], 'symmetric');
im_new = filter2(high_pass_filter, im_pad,'valid');

if method ==2,
    min_im = min(min(im_new));
    if min_im<0,
        im_new = im_new - min_im;
    end;
    temp = uint16(im_new); clear im_new;
    im_new = temp;
end;

return