function data = init_data_1008(exp_name, varargin)
para_name = {'type'};
default_value = {'quantify'};
data_type = parse_parameter(para_name, default_value, varargin);

switch data_type
    case 'group_compare'
        group_name = exp_name;
        switch group_name
            case 'Y493'
                name_string = {'Y493AC7', 'Y493AE3', 'Y493B5', 'Y493D3', ...
                    'Y493F11', 'Y493NC', 'Y493PC', ...
                    'R360AC7', 'R360B5', 'R360NC', 'R360PC'}; 
                num_exp = size(name_string, 2);
                data.name_string = name_string;
                data.num_exp = num_exp;
                data.exp_index = (1:num_exp)';
                data.repeat = ones(num_exp, 1);
            case 'pLAT'
                name_string = {'pLAT191AC7', 'pLAT191B5', 'pLAT191NC', 'pLAT191PC',  ...
                    'pLAT191R360AC7', 'pLAT191R360B5', 'pLAT191R360NC', 'pLAT191R360PC'}; 
                num_exp = size(name_string, 2);
                data.name_string = name_string;
                data.num_exp = num_exp;
                data.exp_index = (1:num_exp)'; % This could be selecting some experiment groups
                data.repeat = ones(num_exp, 1);
        end % switch group_name
                      
    case 'quantify'
        % Update root with your data location
        root = '/Users/kathylu/Google Drive/data/';
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
            case {'Y493AC71', '0828_ac7'}
                data.path = strcat(root, '0913_longwei/0828_pZap70Y493/AC7/');
                data.image_index = [1:5, 7:9]';        
            case {'Y493AE31','0828_ae3'}
                data.path = strcat(root, '0913_longwei/0828_pZap70Y493/AE3/');
                data.image_index = (1:8)';
            case {'Y493B51', '0828_b5'}
                data.path = strcat(root, '0913_longwei/0828_pZap70Y493/B5/');
                data.image_index = (1:8)';
            case {'Y493D31','0828_d3'}
                data.path = strcat(root, '0913_longwei/0828_pZap70Y493/D3/');
                data.image_index = (1:8)';
            case {'Y493F111','0828_f11'}
                data.path = strcat(root, '0913_longwei/0828_pZap70Y493/F11/');
                data.image_index = (1:8)';
            case {'Y493NC1','0828_nc'}
                data.path = strcat(root, '0913_longwei/0828_pZap70Y493/NC/');
                data.image_index = (1:8)';
            case {'0828_pc'}
                data.path = strcat(root, '0913_longwei/0828_pZap70Y493/PC/');
                data.image_index = [1, 9:15]';
            case {'Y493PC1','0828_pc2'}
                data.path = strcat(root, '0913_longwei/0828_pZap70Y493/PC2/');
                data.image_index = (1:11)';
            case {'R360AC71', '0912_ac7'}
                data.path = strcat(root, '0913_longwei/0912_P116R360P_IF/AC7/');
                data.image_index = (1:15)';
            case {'R360B51','0912_b5'}
                data.path = strcat(root, '0913_longwei/0912_P116R360P_IF/B5/');
                data.image_index = (1:15)';
            case {'R360NC1','0912_nc'}
                data.path = strcat(root, '0913_longwei/0912_P116R360P_IF/NC/');
                data.image_index = (1:15)';
            case {'R360PC1', '0912_pc'}
                data.path = strcat(root, '0913_longwei/0912_P116R360P_IF/PC/');
                data.image_index = (1:15)';

            % PLAT191 cells
            case {'pLAT191AC71', 'plat191_ac7'}
                data.path = strcat(root, '0913_longwei/1003_pLAT191/Jurkat/AC7/');
                data.image_index = (1:15)';
            case {'pLAT191B51', 'plat191_b5'}
                data.path = strcat(root, '0913_longwei/1003_pLAT191/Jurkat/B5/');
                data.image_index = (1:15)';
            case {'pLAT191NC1', 'plat191_nc'}
                data.path = strcat(root, '0913_longwei/1003_pLAT191/Jurkat/NC-1/');
                data.image_index = (1:15)';
            case {'pLAT191PC1', 'plat191_pc'}
                data.path = strcat(root, '0913_longwei/1003_pLAT191/Jurkat/PC_antiTCR/');
                data.image_index = (1:11)';
            case {'pLAT191R360AC71', 'plat191_r360ac7'}
                data.path = strcat(root, '0913_longwei/1003_pLAT191/R360P/AC7/');
                data.image_index = (1:15)';
            case {'pLAT191R360B51', 'plat191_r360b5'}
                data.path = strcat(root, '0913_longwei/1003_pLAT191/R360P/B5/');
                data.image_index = (1:15)';
            case {'pLAT191R360NC1', 'plat191_r360nc'}
                data.path = strcat(root, '0913_longwei/1003_pLAT191/R360P/NC/');
                data.image_index = [1:11, 13:15]';
                % Something is wrong with the format of frame 12
            case {'pLAT191R360PC1', 'plat191_r360pc'}
                data.path = strcat(root, '0913_longwei/1003_pLAT191/R360P/PC/');
                data.image_index = (1:15)';
        end % switch exp_name
end % switch data_type

return
