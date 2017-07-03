% function subtract_background(im, data, varargin)
% subtract back ground for one image

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function im = subtract_background(im, data, varargin)
parameter_name={'method'};
default_value = {1};
method = parse_parameter(parameter_name, default_value, ...
    varargin);
if method ==1, % simply subtract the background in the region
    bw = data.bg_bw;
    temp = double(bw); clear bw;
    bw = temp;
    % subtract background
    sum_bw = sum(sum(bw));
    bg = sum(sum(double(im)/sum_bw.*bw));
    im = double(im)-bg;
elseif method ==2, % use the wavelet functions
    wavelet_type = data.wavelet_type;
    wavelet_fun_num = data.wavelet_fun_num;
    [C, S] = wavedec2(double(im), wavelet_fun_num(1), wavelet_type);
    A = wrcoef2('a', C, S, wavelet_type, wavelet_fun_num(2));
    B = wrcoef2('a', C, S, wavelet_type, wavelet_fun_num(3));
    temp  = A-B; clear im C S A B;
    im = temp; clear temp;
elseif method ==3, % data = bw
    bw = double(data);
    sum_bw = sum(sum(bw));
    bg = sum(sum(double(im)/sum_bw.*bw));
    im = double(im)-bg;
end;
return;
