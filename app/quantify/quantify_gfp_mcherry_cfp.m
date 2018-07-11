function [intensity, ratio] = quantify_gfp_mcherry_cfp(exp_name)
load_result = 1;
%
data = this_init_data(exp_name);
detect_channel = 3;
[intensity, ratio] = quantify_ratio_multiple_cell(data, 'load_result', load_result, 0, ...
    'save_result', 0, 'add_channel', 1, 'detect_type', detect_channel);
% index_array = (ratio>=1 & ratio<=10 & intensity(:,detect_channel)>10);
% index_array = true(size(ratio));
index_array = (intensity(:, detect_channel)>10); 
temp = ratio(index_array); clear ratio;
ratio = temp; clear temp;
temp = intensity(index_array, :); clear intensity;
intensity = temp; clear temp;

return


function data = this_init_data(exp_name)
root = '/Users/kathylu/Documents/data/2018/ali_0426/';
data.segment_method = 2;
switch exp_name
    case 'control'
        data.path = strcat(root, 'control/');
        data.first_file = 'GFP.001'; % FRET channel
        data.index_pattern = {'001', '%03d'};
        data.channel_pattern= {'GFP', 'mCherry', 'CFP', 'DIC'}; 
        data.detection = 'auto';
        % data.image_index =[2; 4; 6; 8; 10];
        data.image_index = (1:10)';
        data.intensity_bound = [];
        % data.intensity_bound = [1 100];
        data.ratio_bound = [1 1000];
        data.brightness_factor = 1.1;
        data.min_area = 1000;
        data.subtract_background = 1;
        data.median_filter = 1;
end
return
