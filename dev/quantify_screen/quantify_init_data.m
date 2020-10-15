function data = quantify_init_data(exp_name)
% Update root with your data location
root = '/Users/kathylu/Documents/sof/data/fluocell_dataset_2/';
data.segment_method = 2;
%
data.first_file = '11.001'; % FRET channel
% 1 - DAPI; 2 - AF594; 3-DIC
data.index_pattern = {'001', '%03d'};
data.channel_pattern= {'11.', '12.'}; 
data.detection = 'auto';
data.intensity_bound = [0 7000];
data.ratio_bound = [0.3 0.8];
data.brightness_factor = 1.0;
data.min_area = 1000;
data.alpha = 1.0; % average ratio between channels 1 and 2. 
% 
data.subtract_background = 1;
data.median_filter = 1;  
%
switch exp_name
    case {'AC71','0828_ac7'}
        data.path = strcat(root, 'quantify_screen/AC7/');
        data.image_index = [1:5, 7:9]';   
end
return