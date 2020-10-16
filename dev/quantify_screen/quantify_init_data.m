function data = quantify_init_data(exp_name, varargin)
para_name = {'type'};
default_value = {'quantify'};
type = parse_parameter(para_name, default_value, varargin);

switch type
    case 'group_compare'
        group_name = exp_name; 
        switch group_name %group_name
            case 'sample'
                name_string = {'AC7', 'PC'}; 
                num_exp = size(name_string, 2);
                data.name_string = name_string;
                data.num_exp = num_exp;
                data.exp_index = (1:num_exp)';
                data.repeat = ones(num_exp, 1);
        end
    case 'quantify'
        % Update root with your data location
        root = '/Users/kathylu/Documents/sof/data/fluocell_dataset_2/quantify_screen/';
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
        not_subtract_background = 1; 
        if not_subtract_background 
            data.subtract_background = 0;
            data.intensity_bound(2) = data.intensity_bound(2) *2;
        end
        switch exp_name
            case {'AC71', 'ac7'}
                data.path = strcat(root, 'AC7/');
                data.image_index = [1:5, 7:9]';        
            case {'PC1','pc'}
                data.path = strcat(root, 'PC/');
                data.image_index = (1:11)';
        end
end % switch type
return