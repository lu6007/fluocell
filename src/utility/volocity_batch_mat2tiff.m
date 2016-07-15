% volocity_batch_mat2tiff
% Example
% file_name = {'1\02May2013_HS578T_shFAPa3_XY point 11.mat', ...
% '2\02May2013_HS578T_shFAPa3_XY point 22.mat'};
% volocity_batch_mat2tiff(file_name);
function volocity_batch_mat2tiff(file_name)
num_files = length(file_name);
for i = 1:num_files,
    [p,name, extension] = fileparts(file_name{i});
    volocity_mat2tiff(strcat(p,'/'), strcat(name, extension));
end;
return;
function volocity_mat2tiff(path,file_name)
im_data = load(strcat(path,file_name));
im_array = im_data.Greyscale_16Bit;
nn = size(im_array); %[1000 1000 1 2 num_images]
im = zeros(nn(1), nn(2)); 
for i = 1:nn(5),
    i_str = sprintf('%03d',i);
    im = im_array(:,:,1,2,i);
    imwrite(im, strcat(path, 'ch2_',i_str,'.tiff'),'tiff');
end
return;