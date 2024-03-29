% 
% function data = quantify_ratio_init_data(exp_name)
% Quantify ratio values for many cells in image slides
% Example: 
% data = quantify_ratio_init_data('sample');
% [intensity, ratio] = quantify_ratio_multiple_cell(data);
function data = quantify_ratio_init_data(exp_name)
% root = 'E:/data/2016/binbin_0217/';
% root = '/Volumes/KathyWD2TB/data/2017/yanmin_0525/';
% root = '/Volumes/KathyWD2TB/data/2017/molly_0606/';
root = '/Users/kathylu/';
switch exp_name
    case 'sample'
        data.path = strcat(root, ...
            "Documents/sof/data/fluocell_dataset2/quantify/AC7/");
        data.first_file = '11.001'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'001', '%03d'};
        data.channel_pattern= {'11.', '12.'}; 
        data.detection = 'auto';
        data.image_index =[1;2];
        data.intensity_bound = [0 10000];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;    
    case 'h3k9_0' % For Fazlur
        data.path = strcat(root, ...
            'Google Drive/data/share/0203_2023_fazlur/0222/');
        data.protocol = 'FRET-Split-View';
        data.first_file = '1.tif'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'1.tif', '%d.tif'};
        % data.channel_pattern= {'11.', '12.'}; 
        data.detection = 'manual'; % 'auto'
        data.image_index =[1;6];
        data.num_roi = [2;1];
        data.intensity_bound = [2 10];
        data.ratio_bound = [0 3];
%         data.brightness_factor = 0.8;
%         data.min_area = 1000;
%         data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2; % Automatic background
        data.median_filter = 1;   
        data.max_ratio = 20.0;
    case 'sample_old'
        data.path = 'D:/sof/data/fluocell_dataset2/quantify/1/';
        data.first_file = 'H3K921.002'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'H3K921', 'H3K922'}; 
        data.detection = 'auto';
        data.image_index =[2; 4; 6; 8; 10];
        data.intensity_bound = [0 20000];
        data.ratio_bound = [0.4 2];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;    
    case '0616_6'
        data.path = strcat(root, '0616/6/');
        data.first_file = 'JURKAT1.001'; % Intensity Only
        data.index_pattern = {'001', '%03d'};
        data.channel_pattern= {'JURKAT1', 'JURKAT5'}; 
        data.detection = 'auto';
        data.image_index =(1:11)';
        data.intensity_bound = [0 10000];
        data.ratio_bound = [0 0.5];
        data.brightness_factor = 0.3;
        data.min_area = 30;
        data.alpha = 10; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 0;
        data.median_filter = 1;
        data.high_pass_filter = 61; % use when background not even
    case '0616_7'
        data.path = strcat(root, '0616/7/');
        data.first_file = 'JURKAT1.001'; % Intensity Only
        data.index_pattern = {'001', '%03d'};
        data.channel_pattern= {'JURKAT1', 'JURKAT5'}; 
        data.detection = 'auto';
        data.image_index =(1:10)';
        data.intensity_bound = [0 10000];
        data.ratio_bound = [0 0.5];
        data.brightness_factor = 0.3;
        data.min_area = 30;
        data.alpha = 10; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 0;
        data.median_filter = 1;
        data.high_pass_filter = 61; % use when background not even
    case '0616_8'
        data.path = strcat(root, '0616/8/');
        data.first_file = 'JURKAT1.001'; % Intensity Only
        data.index_pattern = {'001', '%03d'};
        data.channel_pattern= {'JURKAT1', 'JURKAT5'}; 
        data.detection = 'auto';
        data.image_index =(1:12)';
        data.intensity_bound = [0 10000];
        data.ratio_bound = [0 0.5];
        data.brightness_factor = 0.3;
        data.min_area = 30;
        data.alpha = 10; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 0;
        data.median_filter = 1;
        data.high_pass_filter = 61; % use when background not even
    case '0616_9'
        data.path = strcat(root, '0616/9/');
        data.first_file = 'JURKAT1.001'; % Intensity Only
        data.index_pattern = {'001', '%03d'};
        data.channel_pattern= {'JURKAT1', 'JURKAT5'}; 
        data.detection = 'auto';
        data.image_index =(1:11)';
        data.intensity_bound = [0 10000];
        data.ratio_bound = [0 0.5];
        data.brightness_factor = 0.3;
        data.min_area = 30;
        data.alpha = 10; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 0;
        data.median_filter = 1;
        data.high_pass_filter = 61; % use when background not even
    case '0616_10'
        data.path = strcat(root, '0616/10/');
        data.first_file = 'JURKAT1.001'; % Intensity Only
        data.index_pattern = {'001', '%03d'};
        data.channel_pattern= {'JURKAT1', 'JURKAT5'}; 
        data.detection = 'auto';
        data.image_index =(1:12)';
        data.intensity_bound = [0 10000];
        data.ratio_bound = [0 0.5];
        data.brightness_factor = 0.3;
        data.min_area = 30;
        data.alpha = 10; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 0;
        data.median_filter = 1;
        data.high_pass_filter = 61; % use when background not even
    case '0616_11'
        data.path = strcat(root, '0616/11/');
        data.first_file = 'JURKAT1.001'; % Intensity Only
        data.index_pattern = {'001', '%03d'};
        data.channel_pattern= {'JURKAT1', 'JURKAT5'}; 
        data.detection = 'auto';
        data.image_index =(1:11)';
        data.intensity_bound = [0 10000];
        data.ratio_bound = [0 0.5];
        data.brightness_factor = 0.3;
        data.min_area = 30;
        data.alpha = 10; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 0;
        data.median_filter = 1;
        data.high_pass_filter = 61; % use when background not even
    case 'molly_1'
        data.path = strcat(root, 'sample_data/1/');
        data.first_file = 'JURKAT1.001'; % Intensity Only
        data.index_pattern = {'001', '%03d'};
        data.channel_pattern= {'JURKAT1', 'JURKAT5'}; 
        data.detection = 'auto';
        data.image_index =(1:6)';
        data.intensity_bound = [0 10000];
        data.ratio_bound = [0 0.5];
        data.brightness_factor = 0.3;
        data.min_area = 30;
        data.alpha = 0.5; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 0;
        data.median_filter = 1;
        data.high_pass_filter = 61; % use when background not even
    case 'molly_2'
        data.path = strcat(root, 'sample_data/2/');
        data.first_file = 'JURKAT1.001'; % Intensity Only
        data.index_pattern = {'001', '%03d'};
        data.channel_pattern= {'JURKAT1', 'JURKAT5'}; 
        data.detection = 'auto';
        data.image_index =(1:6)';
        data.intensity_bound = [0 10000];
        data.ratio_bound = [0 0.5];
        data.brightness_factor = 0.3;
        data.min_area = 30;
        data.alpha = 2; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 0; 
        data.median_filter = 1;
        data.high_pass_filter = 61; % use when background not even
    case 'molly_25'
        data.path = strcat(root, 'molly_0606/sample_data/2/');
        data.first_file = 'JURKAT5.001'; % Intensity Only
        data.index_pattern = {'001', '%03d'};
        data.channel_pattern= {'JURKAT', 'JURKAT'}; 
        data.detection = 'auto';
        data.image_index =(1:6)';
        data.intensity_bound = [0 20000];
        data.ratio_bound = [0.5 1.5];
        data.brightness_factor = 1.0;
        data.min_area = 30;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 0;
        data.median_filter = 1;
        data.high_pass_filter = 61;
    case 'none'
        data.path = strcat(root, 'None/');
        data.first_file = '1_w1mCherry2_s1.TIF'; 
        % 1 - mCherry; 2 - GFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'w1mCherry2', 'w2GFP-WPZ'}; 
        data.detection = 'auto';
        data.image_index =(1:10)';
        data.intensity_bound = [0 4000];
        data.ratio_bound = [0.5 10];
        data.brightness_factor = 0.3;
        data.min_area = 70;
        data.alpha = 3; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 0;    
    case '10min'
        data.path = strcat(root, '10min/');
        data.first_file = '1_w1mCherry2_s1.TIF'; 
        % 1 - mCherry; 2 - GFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'w1mCherry2', 'w2GFP-WPZ'}; 
        data.detection = 'auto';
        data.image_index =(1:10)';
        data.intensity_bound = [0 4000];
        data.ratio_bound = [0.5 10];
        data.brightness_factor = 0.3;
        data.min_area = 70;
        data.alpha = 1; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 0;    

    case '1122_wt1'
        data.path = 'G:\20161122\JCam_LckWT_LckBS\';
        data.first_file = '1_w1CFP-10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'w1CFP-10-', 'w2FRET-10-', 'w4mCherry-10--Molly'}; 
        data.detection = 'auto';
        data.image_index =(1:96)';
        data.intensity_bound = [0 20000];
        data.ratio_bound = [0.2 0.5];
        data.brightness_factor = 0.9;
        data.min_area = 1000;
        data.alpha = 0.35; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        
    case '1122_wt2'
        data.path = 'G:\20161122\JCam_LckWT_LckBS2\';
        data.first_file = '1_w1CFP-10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'w1CFP-10-', 'w2FRET-10-', 'w4mCherry-10--Molly'}; 
        data.detection = 'auto';
        data.image_index =(1:98)';
        data.intensity_bound = [0 20000];
        data.ratio_bound = [0.2 0.5];
        data.brightness_factor = 0.9;
        data.min_area = 1000;
        data.alpha = 0.35; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        
    case '1122_wt3'
        data.path = 'G:\20161122\JCam_LckWT_LckBS3\';
        data.first_file = '1_w1CFP-10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'w1CFP-10-', 'w2FRET-10-', 'w4mCherry-10--Molly'}; 
        data.detection = 'auto';
        data.image_index =(1:80)';
        data.intensity_bound = [0 20000];
        data.ratio_bound = [0.2 0.5];
        data.brightness_factor = 0.9;
        data.min_area = 1000;
        data.alpha = 0.35; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        
    case '1122_yf1'
        data.path = 'G:\20161122\JCam_LckYF_LckBS\';
        data.first_file = '1_w1CFP-10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'w1CFP-10-', 'w2FRET-10-', 'w4mCherry-10--Molly'}; 
        data.detection = 'auto';
        data.image_index =(1:97)';
        data.intensity_bound = [0 20000];
        data.ratio_bound = [0.2 0.5];
        data.brightness_factor = 0.9;
        data.min_area = 1000;
        data.alpha = 0.35; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        
    case '1122_yf2'
        data.path = 'G:\20161122\JCam_LckYF_LckBS2\';
        data.first_file = '1_w1CFP-10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'w1CFP-10-', 'w2FRET-10-', 'w4mCherry-10--Molly'}; 
        data.detection = 'auto';
        data.image_index =(1:91)';
        data.intensity_bound = [0 20000];
        data.ratio_bound = [0.2 0.5];
        data.brightness_factor = 0.9;
        data.min_area = 1000;
        data.alpha = 0.35; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        
    case '1122_yf3'
        data.path = 'G:\20161122\JCam_LckYF_LckBS3\';
        data.first_file = '1_w1CFP-10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'w1CFP-10-', 'w2FRET-10-', 'w4mCherry-10--Molly'}; 
        data.detection = 'auto';
        data.image_index =(1:99)';
        data.intensity_bound = [0 20000];
        data.ratio_bound = [0.2 0.5];
        data.brightness_factor = 0.9;
        data.min_area = 1000;
        data.alpha = 0.35; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        

        
        % F
        
    case 'wt_1030'
        %data.path = 'D:\data\rongxue_1031\20161030_WT\output\';
        data.path = 'E:\data\2016\rongxue_1030\20161030_WT\';
        data.first_file = '1_w1CFP-10-_s2_t1.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s2', 's%d'};
        data.channel_pattern= {'w1CFP-10-', 'w2FRET-10-', 'w4mCherry-10--Molly'}; 
        data.detection = 'auto';
        data.image_index =(2:60)';
        data.intensity_bound = [0 20000];
        data.ratio_bound = [0.2 0.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 0.25; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        
   
    case 'wt_1030_2'
        %data.path = 'D:\data\rongxue_1031\20161030_WT\output\';
        data.path = 'E:\data\2016\rongxue_1030\20161030_WT2\';
        data.first_file = '1_w1CFP-10-_s2_t1.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s2', 's%d'};
        data.channel_pattern= {'w1CFP-10-', 'w2FRET-10-', 'w4mCherry-10--Molly'}; 
        data.detection = 'auto';
        data.image_index =(1:31)';
        data.intensity_bound = [0 20000];
        data.ratio_bound = [0.2 0.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 0.25; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        

   case 'yf_1030'
        %data.path = 'D:\data\rongxue_1031\20161030_WT\output\';
        data.path = 'E:\data\2016\rongxue_1030\20161030_YF\';
        data.first_file = '1_w1CFP-10-_s2_t1.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s2', 's%d'};
        data.channel_pattern= {'w1CFP-10-', 'w2FRET-10-', 'w4mCherry-10--Molly'}; 
        data.detection = 'auto';
        data.image_index =(1:94)';
        data.intensity_bound = [0 20000];
        data.ratio_bound = [0.2 0.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 0.25; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        

   case 'yf_1030_2'
        %data.path = 'D:\data\rongxue_1031\20161030_WT\output\';
        data.path = 'E:\data\2016\rongxue_1030\20161030_YF2\';
        data.first_file = '2_w1CFP-10-_s2_t1.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s2', 's%d'};
        data.channel_pattern= {'w1CFP-10-', 'w2FRET-10-', 'w4mCherry-10--Molly'}; 
        data.detection = 'auto';
        data.image_index =(1:55)';
        data.intensity_bound = [0 20000];
        data.ratio_bound = [0.2 0.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 0.25; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        

    case 'rep1_1012'
        data.path = strcat(root, 'try3/1012_2015_rep1/');
        data.first_file = 'PSIN-H31.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'PSIN-H31', 'PSIN-H32'}; 
        data.detection = 'auto';
        data. image_index =[2;4;8;10;12;15; 17; 19; 21; 23; 25; 27; 29; 31;33; 35; 37; 39; ...
            41; 43; 45; 47; 49; 51; 55; 57];
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        
    case 'rep2_1013'
        data.path = strcat(root, 'try3/1013_2015_rep2/');
        data.first_file = 'PSIN-H31.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'PSIN-H31', 'PSIN-H32'}; 
        data.detection = 'auto';
        data. image_index =[(2:2:10), (14:2:48), (52:2:72), (76:2:86)]'; 
        % data.image_index = [12, 50, 74]'; % deleted
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        
    case 'rep3_1014'
        data.path = strcat(root, 'try3/1014_2015_rep3/');
        data.first_file = 'PSIN-H31.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'PSIN-H31', 'PSIN-H32'}; 
        data.detection = 'auto';
        data. image_index =[(3:2:9), (13:2:21),(24:2:56), (60:2:70), (73:2:91)]'; % delete 11 and 58
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        
    case 'rep4_1015'
        data.path = strcat(root, 'try3/1015_2015_rep4/');
        data.first_file = 'H3K921.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'H3K921', 'H3K922'}; 
        data.detection = 'auto';
        data. image_index =[(2:2:16),(19:2:47),(50:2:72),(77:2:85), (89:2:101), ...
            (104:2:122), (125:2:141)]'; 
        % delete 87, 74
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        
    case 'rep5_1016'
        data.path = strcat(root, 'try3/1016_2015_rep5/');
        data.first_file = 'H3K9 IN1.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'H3K9 IN1', 'H3K9 IN2'}; 
        data.detection = 'auto';
        data. image_index =[(2:2:4),(10:2:26),(29:2:41),(45:2:67),(70:2:74)]'; 
        % delete 43
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        
    case 'rep6_1017'
        data.path = strcat(root, 'try3/1017_2015_rep6/');
        data.first_file = 'H3K921.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'H3K921', 'H3K922'}; 
        data.detection = 'auto';
        data. image_index =[2,5:2:25, 41:2:49, 53:2:95, 98 ]'; 
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        
    case 'rep7_1018'
        data.path = strcat(root, 'try3/1018_2015_rep7/');
        data.first_file = 'H3K921.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'H3K921', 'H3K922'}; 
        data.detection = 'auto';
        data. image_index =[2:2:16, 19:2:53, 56:2:66, 69:2:119]'; 
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        
    case 'rep8_1019'
        data.path = strcat(root, 'try3/1019_2015_rep8/');
        data.first_file = 'H3K921.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'H3K921', 'H3K922'}; 
        data.detection = 'auto';
        data. image_index =[4:2:22, 26:2:30, 38:2:48, 52, 56:2:60, 70, 72:2:108, 111:2:117]'; 
        % delete 72, 62, 64, 68, 54, 50, 36, 34, 32
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;        
    case 'con1_1012'
        data.path = strcat(root, 'try3/1012_2015_con1/');
        data.first_file = 'PSIN-H31.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'PSIN-H31', 'PSIN-H32'}; 
        data.detection = 'auto';
        data.image_index =[3;11;14;16;20;22;25;27;...
            33;35;40;44;46;48;50;52;55];
        % Deleted 6, 8 38
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1; 
    case 'con2_1013'
        data.path = strcat(root, 'try3/1013_2015_con2/');
        data.first_file = 'PSIN-H31.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'PSIN-H31', 'PSIN-H32'}; 
        data.detection = 'auto';
        data.image_index =[(2:2:6),8,(10:2:30),(33:2:93)]';
        % Deleted 8
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1; 
    case 'con3_1014'
        data.path = strcat(root, 'try3/1014_2015_con3/');
        data.first_file = 'PSIN-H31.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'PSIN-H31', 'PSIN-H32'}; 
        data.detection = 'auto';
        data.image_index =[(2:2:32),(35:2:53),(56:2:60),(63:2:67)]';
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1; 
    case 'con4_1015'
        data.path = strcat(root, 'try3/1015_2015_con4/');
        data.first_file = 'H3K921.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'H3K921', 'H3K922'}; 
        data.detection = 'auto';
        data.image_index =[2:2:46, 49:2:75, 80, 83:2:91]';
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1; 
    case 'con5_1016'
        data.path = strcat(root, 'try3/1016_2015_con5/');
        data.first_file = 'H3K921.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'H3K921', 'H3K922'}; 
        data.detection = 'auto';
        data.image_index =[2,8:2:20, 25, 27, 30:2:34, 37:2:79, ...
            84:2:94, 97:2:107, 110:2:122, 126,131:2:137, ...
            141:2:161, 164, 168:2:176, 180:2:184]';
        % delete 178, 166
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1; 
    case 'con6_1017'
        data.path = strcat(root, 'try3/1017_2015_con6/');
        data.first_file = 'H3K921.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'H3K921', 'H3K922'}; 
        data.detection = 'auto';
        data.image_index =[2:2:8, 11:2:21, 26:2:32, 36:2:80, 84:2:92, ...
            95:2:101, 104:2:116, 123:2:141,144:2:154, 157]';
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1; 
    case 'con7_1018' % name of experiment
        data.path = strcat(root, 'try3/1018_2015_con7/');
        data.first_file = 'H3K921.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'H3K921', 'H3K922'}; 
        data.detection = 'auto';
        % update for every experiment
        data.image_index =[ 2:2:62, 66, 68, 72:2:78, 81:2:99, 103:2:109, 116:2:130 ]';
        % delete 113 111 109 101 70 64 
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1; 
    case 'con8_1019' % name of experiment
        data.path = strcat(root, 'try3/1019_2015_con8/');
        data.first_file = 'H3K921.002'; % FRET channel
        % 1 - FRET; 2 - CFP;  
        data.index_pattern = {'002', '%03d'};
        data.channel_pattern= {'H3K921', 'H3K922'}; 
        data.detection = 'auto';
        % update for every experiment
        data.image_index =[ 4:2:10, 14:2:28, 32:2:40, 44, 46, 50:2:68, 74, 78:2:96]';
        % delete 98 76 72 48 30 12
        data.intensity_bound = [0 5000];
        data.ratio_bound = [1.0 3.5];
        data.brightness_factor = 1.2;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1; 
        
end
return;