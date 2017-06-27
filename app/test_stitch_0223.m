% % For ERK movies
% first_file = {'jurkat/1_ratio_s19_t1.TIF.tif', 'jcam_lckwt/1_ratio_s22_t1.TIF.tif', ...
%     'jcam_lckyf/1_ratio_s19_t1.TIF.tif', 'jcam_lckkr/1_ratio_s7_t1.TIF.tif', ...
%     'jcam/1_ratio_s2_t1.TIF.tif'};
% % first_cfp_file = {'jurkat/1_w1CFP_s19_t1.TIF', 'jcam_lckwt/1_w1CFP-10-_s22_t1.TIF', ...
% %     'jcam_lckyf/1_w1CFP_s19_t1.TIF', 'jcam_lckkr/1_w1CFP_s7_t1.TIF', ...
% %     'jcam/1_w1CFP_s2_t1.TIF'};
% image_index = {[3:6, 7:16, 17:25]', (1:23)', (2:24)', [4:7, 8:15, 17:18, 19:27]', (2:24)'};
% frame_pattern = {'t1', 't%d'};
% frame_index = (1:23)';

% For Lck movies
first_file = {'jurkat/1_ratio-10-_s15_t2.TIF.tif', 'jcam_lckwt/1_ratio-10-_s19_t2.TIF.tif', ...
    'jcam_lckyf/1_ratio-10-_s30_t2.TIF.tif', 'jcam_lckkr/1ratios13_t2.TIF.tif', ...
    'jcam/1_ratio-10-_s19_t2.TIF.tif'};
image_index = {(2:24)', (2:24)', (2:24)', (2:24)', (2:24)'};
frame_pattern = {'t2', 't%d'};
frame_index = (1:23)';
% Added CD3/CD28 between frames 5 and 6
% PP1 between frames 15 and 16
% 3 min each frame. 

num_exp = length(first_file);
im0 = imread(first_file{1});
im_size = size(im0);
num_frame = size(frame_index, 1);
% time = zeros(num_frame, num_exp);
% stimuli_after_frame = 5; % the frame number before adding CD3/CD28
title_str = {'Jurkat', 'JCam-LckWT', 'JCam-LckYF', 'JCam-LckKR', 'JCam'};
xy = [50 25]; ss = im_size;
title_loc = [xy; xy+[ss(1) 0]; xy+[0 ss(2)]; xy+ss(1:2); xy+[2*ss(1) ss(2)]];
for i = frame_index'
    % i
    im = cell(num_exp, 1);
    for j = 1:num_exp
       index_str = sprintf(frame_pattern{2}, image_index{j}(i));
       file_name = regexprep(first_file{j}, frame_pattern{1}, index_str);
       im{j} = imread(file_name);
%        cfp_file = regexprep(first_cfp_file{j}, frame_pattern{1}, index_str);
%        time(i,j) = get_time(cfp_file, 'method', 2);
       clear file_name cfp_file index_str;
    end
    im_together = uint8(zeros(2*im_size(1), 3*im_size(2), im_size(3)));
    im_together(1:im_size(1), 1:2*im_size(2), :) = cat(2, im{1}(1:im_size(1), 1:im_size(2), :), im{2});
    im_together(im_size(1)+1:2*im_size(2), :, :) = cat(2, im{3}, im{4}, im{5});
    temp = insertText(im_together, title_loc, title_str, 'TextColor', 'white', ...
'Font', 'LucidaSansDemiBold', 'FontSize', 24, 'Boxcolor', 'Black');
    clear im_together; im_together = temp; clear temp
    % add scale bar of 10 um at 100x
    im_together(520:525, 770:834, :) = 255;
    
    frame_str = sprintf(frame_pattern{2}, i);
    output_file = strcat('together_', frame_str, '.tiff');
    imwrite(im_together, output_file);
    
    if i ==1
        figure; imagesc(im_together);
    end;
    
   
    % figure; imshow(im_together);
    clear im im_together frame_str;
end

% time_file = 'result.mat';
% if ~exist(time_file,'file')
%     save(time_file, 'time');
% else 
%     res = load(time_file);
%     time = res.time;
%     clear res;
% end

% Make movie for ERK
% info.path = 'E:\Images used to make movie\ERK biosensor2\movie\';
% info.first_file = 'together_t1.tiff';
% info.index_pattern = {'t1', 't%d'};
% info.image_index = 1:23;
% info.movie_name = strcat(info.path, 'erk_ratio.avi');
% movie = make_movie(info);
% 
% info.time_location = [630 90];
% info.event_location = [630 30];
% info.has_event(1:3) = 1;
% info.has_event(4:15) = 2;
% info.has_event(16:23) = 3;
% info.time = (info.image_index'-4)*3;
% info.event_text = {'Before', '+CD3/CD28', '+PP1'};
% movie = make_movie(info);

