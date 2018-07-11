% function qfun = quantify_fun()
% Example:
% qfun = quantify_fun()
% im_new = qfun.sum_image(im1, im2, alpha)
%
% function im_detect = get_image_detect(im, data, varargin)
% para_name = {'type'};
% para_value = {4};
% For type = 1, 2, 3, use im{type} for detection.
% For type = 4 (default), use a weighted sum of im{1} and im{2} for detection. 
%
% function im_new = sum_image(im1, im2, alpha)
% combines im1 and im2 with the expected ratio 
% of im1:im2 = alpha, trying to enhance the ratio of
% image for use and minize the chance of getting the result
% image oversturated
function qfun = quantify_fun()
qfun.get_image_detect = @get_image_detect; 
qfun.sum_image = @sum_image;
return

function im_detect = get_image_detect(im, data, varargin)
para_name = {'type'};
para_value = {4};
type = parse_parameter(para_name, para_value, varargin);
switch type
    case {1, 2, 3}
        temp = im{type};
    case 4
        if ~isempty(data) && isfield(data,'alpha')
            alpha = data.alpha;
        else 
            alpha = 1;
        end
        temp = sum_image(im{1}, im{2}, alpha);
end
im_detect = uint16(temp); clear temp;
return

function im_new = sum_image(im1, im2, alpha)
if alpha <=1
    im_new = im1+alpha*im2;
else % alpha>1
    im_new = im1/alpha + im2;
end
return;
