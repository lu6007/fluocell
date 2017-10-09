% function new_im2 = test_align_image( im1, im2 )
% Align im2 to the location of im1 using  2d cross-correlation xcorr2
% data = fluocell_data;
% data_file = strcat(data.output_path, 'data.mat');
% save(data_file, 'data');

p = 'D:\doc\paper\2016\yijia_0830\data\ts12\';
data_file = strcat(p, 'output\', 'data.mat');
load(data_file);

<<<<<<< HEAD
%data.image_index = (1:10:124);
data.image_index = (1:124);
=======
%data.image_index = (1:10:124)';
data.image_index = (1:124)';
>>>>>>> current/master
data = init_figure(data);

data.index = data.image_index(1);
data = get_image(data, 1);
data = update_figure(data);
fret = preprocess(data.im{1}, data);
cfp = preprocess(data.im{2}, data);
% cross correlation
cc_matrix = normxcorr2(fret, cfp);
% index of max of cross correlation matrix
[i_row, i_col] =find(cc_matrix ==max(cc_matrix(:))); % row and column
% shift direction
shift = - [i_row, i_col]+size(cfp);
clear fret cfp cc_matrix;

<<<<<<< HEAD
for i = data.image_index,
=======
for i = data.image_index'
>>>>>>> current/master
    data.index = i;
    data = get_image(data, 0); 
    data = update_figure(data);
    fret = preprocess(data.im{1}, data);
    cfp = preprocess(data.im{2}, data);
    % image translation
    % i_row and shift(2) give the x-axis; i_col and shift(1) give the y-axis.  
    new_cfp = imtranslate(cfp, [shift(2) shift(1)], 'FillValues', 0);
    ratio = get_imd_image(fret./new_cfp, fret+new_cfp, 'ratio_bound', data.ratio_bound, 'intensity_bound', data.intensity_bound);
    figure(3); imshow(ratio);
    
    new_fret_file = regexprep(data.file{1}, 'FRET', 'newFRET');
    imwrite(uint16(fret), new_fret_file, 'tiff');
    new_cfp_file = regexprep(data.file{2}, 'CFP', 'newCFP');
    imwrite(uint16(new_cfp), new_cfp_file, 'tiff');
    clear fret cfp new_cfp ratio new_fret_file new_cfp_file;
end