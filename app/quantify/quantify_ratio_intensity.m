% function [intensity, ratio] = quantify_ratio_intensity(exp_name)
% based on the function quantify_gfp_mcherry_cfp
% 
% >> exp_name = 'test'; % or >> exp_name = 'test2';
% >> [intensity, ratio] = quantify_ratio_intensity(exp_name);
% The output can be found in intensity and ratio
function [intensity, ratio] = quantify_ratio_intensity(exp_name)
load_result = 0;
%
data = this_init_data(exp_name);
detect_channel = 3; % Use channel 3 for detection
[intensity, ratio] = quantify_ratio_multiple_cell(data, 'load_result', load_result, ...
    'save_result', 0, 'add_channel', 1, 'detect_type', detect_channel, 'image_grid', 0, 'verbose',0);
index_array = (ratio>=1 & ratio<=10 & intensity(:,detect_channel)>10);
disp('quantify_ratio_intensity:')
disp('Screen cells with: (ratio>=1 & ratio<=10 & intensity(:,detect_channel)>10)');
% index_array = true(size(ratio));
% index_array = (intensity(:, detect_channel)>10); 
temp = ratio(index_array); clear ratio;
ratio = temp; clear temp;
temp = intensity(index_array, :); clear intensity;
intensity = temp; clear temp;

return


function data = this_init_data(exp_name)
root = '/Users/kathylu/Documents/data/qin_0706_2023/';
% data.segment_method = 2; % needed in detect_watershed
switch exp_name
    case 'test'
        data.path = strcat(root, 'image_2/');
        data.first_file = 'FRET1.tif'; % FRET channel
        data.index_pattern = {'1.tif', '%d.tif'};
        data.channel_pattern= {'FRET', 'ECFP', 'YPet'}; 
        data.detection = 'auto gradient';
        data.image_index = [1,6:9]'; % (1:10)';
        data.intensity_bound = [];
        data.intensity_bound = [200 5000];
        data.ratio_bound = [1 4];
        data.brightness_factor = 1.0; % 2,3,4,5,10-10.0
        data.min_area = 500;
        data.subtract_background = 2;
        data.median_filter = 1;
     case 'test2'
        data.path = strcat(root, 'image_2/');
        data.first_file = 'FRET1.tif'; % FRET channel
        data.index_pattern = {'1.tif', '%d.tif'};
        data.channel_pattern= {'FRET', 'ECFP', 'YPet'}; 
        data.detection = 'auto gradient';
        data.image_index = [2:5,10]'; % (1:10)';
        data.intensity_bound = [];
        data.intensity_bound = [200 5000];
        data.ratio_bound = [1 4];
        data.brightness_factor = 10.0; % 2,3,4,5,10-10.0
        data.min_area = 500;
        data.subtract_background = 2;
        data.median_filter = 1;
end
return
