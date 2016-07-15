% Calculate the high pass filter image
% and save the images to save computing time
function im_filt = get_im_filt(im, file_filter, file_type)
% file_type = 'tiff'
filter_size = 61; % 40x objective
if ~exist(file_filter, 'file'),
    im_filt = high_pass_filter(im, filter_size,'method',1);
    temp = uint16(im_filt); clear im_filt;
    im_filt = temp; clear temp;
    imwrite(im_filt, file_filter, file_type, 'Compression', 'none');
else
     im_filt = imread(file_filter, file_type);
end;
return;