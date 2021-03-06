% function subtract_background(im, data, varargin)
% subtract back ground for one image

% Copyright: Shaoying Lu and Yingxiao Wang 2011-2017

function im = subtract_background(im, data, varargin)
parameter_name={'method'};
default_value = {1};
method = parse_parameter(parameter_name, default_value, ...
    varargin);
if method ==1 % simply subtract the background in the region
    bg_value = compute_average_value(im, data.bg_bw);
    im = double(im)-bg_value;
elseif method ==2 % use the wavelet functions
    wavelet_type = data.wavelet_type;
    wavelet_fun_num = data.wavelet_fun_num;
    [C, S] = wavedec2(double(im), wavelet_fun_num(1), wavelet_type);
    A = wrcoef2('a', C, S, wavelet_type, wavelet_fun_num(2));
    B = wrcoef2('a', C, S, wavelet_type, wavelet_fun_num(3));
    temp  = A-B; clear im C S A B;
    im = temp; clear temp;
elseif method ==3 % data = bw
    bw = data;
    bg_value = compute_average_value(im, bw);
    im = double(im)-bg_value;
elseif method == 4 % data = value
    bg_value = double(data);
    im = double(im)-bg_value;
elseif image == 5 % subtract the image
    im = double(im) - double(bw);
end

return;
