% function im_merge = merge_image(im1, im2)
% Merge the red channel of im1 with the green channel of
% im2 to make one colored image im_merge. For the best effect 
% im1 and im2 need to be background-subtracted, filtered, and 
% scaled using the imscale() function, so that the pixel values
% lie in a similar range.
% Example: 
%  cd ../data/12_05_2012_yfp_mcherry/
% im_yfp = imread('YFP.tif');
% im_pax = imread('pax.tif');
% im_merge = merge_image(im_pax(:,:,1), im_yfp(:,:,2));

% Copyright: Shaoying Lu and Yingxiao Wang 2012 
function im_merge = merge_image(im1, im2)
c_red = 1; 
c_green = 1;
[num_rows num_cols]=size(im1);
type = class(im1);
% im_red = uint16(zeros(num_rows, num_cols,3));
im_red = eval(strcat(type, '(zeros(num_rows, num_cols, 3))'));
im_red(:,:,1) = c_red*im1;
im_green = eval(strcat(type, '(zeros(num_rows, num_cols, 3))'));
im_green(:,:,2) = c_green*im2;

im_merge = im_green+im_red;
figure; imagesc(im_red);
figure; imagesc(im_green);
figure; imagesc(im_merge);
return;