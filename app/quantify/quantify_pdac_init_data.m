function data = quantify_pdac_init_data(exp_name)
% Update root with your data location
% root = 'C:\Users\kathy_group\Documents\External Drive Sync\data\2017\Charlotte\';
% root = '/Volumes/KathyWD2TB/data/2017/yan_yuxin_1221/1215/';
root = '/Volumes/Kathy2018D2/yan_huang/Results_Image Experiments/';
data.segment_method = 2;
switch exp_name
    case 'sample'
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
       
    case 'pdac_nr_10171'
        data.path = strcat(root, '1017/nr/');
        data.first_file = '11.001';
        data.index_pattern = {'001', '%03d'};
        data.channel_pattern= {'11', '11', '11'}; 
        data.detection = 'auto';
        data.image_index = (1:1)'; %(1:30)';
        data.intensity_bound = [];
        data.ratio_bound = [0.5, 1.5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 4; % subtract a constant=3000 passed in as "data"
        data.median_filter = 1;
        
    % 12/21/2017
    % Non-resistant PDACs
    case 'pdacnr_pretreat_12151'
        data.path = strcat(root, '12152017_pdac_NR_Nontreat/NR1/');
        data.first_file = 'NR1_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacnr_pretreat_12152'
        data.path = strcat(root, '12152017_pdac_NR_Nontreat/NR2/');
        data.first_file = 'NR2_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacnr_pretreat_12153'
        data.path = strcat(root, '12152017_pdac_NR_Nontreat/NR3/');
        data.first_file = 'NR3_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacnr_pretreat_12154'
        data.path = strcat(root, '12152017_pdac_NR_Nontreat/NR4/');
        data.first_file = 'NR4_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = [1:17, 19]';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacnr_24hr_12161'
        data.path = strcat(root, '12162017_pdac_NR_24hr/NR1/');
        data.first_file = 'NR1_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacnr_24hr_12162'
        data.path = strcat(root, '12162017_pdac_NR_24hr/NR2/');
        data.first_file = 'NR2_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacnr_24hr_12163'
        data.path = strcat(root, '12162017_pdac_NR_24hr/NR3/');
        data.first_file = 'nr3_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacnr_24hr_12164'
        data.path = strcat(root, '12162017_pdac_NR_24hr/NR4/');
        data.first_file = 'nr4_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacnr_48hr_12171'
        data.path = strcat(root, '12172017_pdac_NR_48hr/NR1/');
        data.first_file = 'NR1_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:19)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2; % automatic
        data.median_filter = 1;
    case 'pdacnr_48hr_12172'
        data.path = strcat(root, '12172017_pdac_NR_48hr/NR2/');
        data.first_file = 'NR2_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2; % automatic
        data.median_filter = 1;
    case 'pdacnr_48hr_12173'
        data.path = strcat(root, '12172017_pdac_NR_48hr/NR3/');
        data.first_file = 'NR3_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:25)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2; % automatic
        data.median_filter = 1;
    case 'pdacnr_48hr_12174'
        data.path = strcat(root, '12172017_pdac_NR_48hr/NR4/');
        data.first_file = 'nr4_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:21)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2; % automatic
        data.median_filter = 1;
        
    case 'pdacnr_72hr_12181'
        data.path = strcat(root, '12182017_pdac_NR_72hr/NR1/');
        data.first_file = 'NR1_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:27)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;
    case 'pdacnr_72hr_12182'
        data.path = strcat(root, '12182017_pdac_NR_72hr/NR2/');
        data.first_file = 'nr5_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;
    case 'pdacnr_72hr_12183'
        data.path = strcat(root, '12182017_pdac_NR_72hr/NR3/');
        data.first_file = 'nr7_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:25)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;
    case 'pdacnr_72hr_12184'
        data.path = strcat(root, '12182017_pdac_NR_72hr/NR4/');
        data.first_file = 'nr6_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:22)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;
    case 'pdacnr_72hr_12185'
        data.path = strcat(root, '12182017_pdac_NR_72hr/NR5/');
        data.first_file = 'nr8_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:24)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;
        
    % Resistant PDAD cells
    case 'pdacr_pretreat_12151'
        data.path = strcat(root, '12152017_pdac_R_Nontreat/R1/');
        data.first_file = 'R1_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacr_pretreat_12152'
        data.path = strcat(root, '12152017_pdac_R_Nontreat/R2/');
        data.first_file = 'R2_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacr_pretreat_12153'
        data.path = strcat(root, '12152017_pdac_R_Nontreat/R3/');
        data.first_file = 'R3_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacr_pretreat_12154'
        data.path = strcat(root, '12152017_pdac_R_Nontreat/R4/');
        data.first_file = 'R4_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacr_24hr_12161'
        data.path = strcat(root, '12162017_pdac_R_24hr/R1/');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:22)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacr_24hr_12162'
        data.path = strcat(root, '12162017_pdac_R_24hr/R2/');
        data.first_file = 'r2_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:21)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacr_24hr_12163'
        data.path = strcat(root, '12162017_pdac_R_24hr/R3/');
        data.first_file = 'r3_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:21)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacr_24hr_12164'
        data.path = strcat(root, '12162017_pdac_R_24hr/R4/');
        data.first_file = 'r4_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdacr_48hr_12171'
        data.path = strcat(root, '12172017_pdac_R_48hr/R1/');
        data.first_file = 'R1_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:22)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;
    case 'pdacr_48hr_12172'
        data.path = strcat(root, '12172017_pdac_R_48hr/R2/');
        data.first_file = 'R2_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:23)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;
    case 'pdacr_48hr_12173'
        data.path = strcat(root, '12172017_pdac_R_48hr/R3/');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;
    case 'pdacr_48hr_12174'
        data.path = strcat(root, '12172017_pdac_R_48hr/R4/');
        data.first_file = 'r4_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:21)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;
    case 'pdacr_72hr_12181'
        data.path = strcat(root, '12182017_pdac_R_72hr/R1/');
        data.first_file = 'r1_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;
     case 'pdacr_72hr_12182'
        data.path = strcat(root, '12182017_pdac_R_72hr/R2/');
        data.first_file = 'r5_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;
    case 'pdacr_72hr_12183'
        data.path = strcat(root, '12182017_pdac_R_72hr/R3/');
        data.first_file = 'r6_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:16)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;
    case 'pdacr_72hr_12184'
        data.path = strcat(root, '12182017_pdac_R_72hr/R4/');
        data.first_file = 'R4_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = [1:2,4:5,7, 9:17,19:21]';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;
    case 'pdacr_72hr_12185'
        data.path = strcat(root, '12182017_pdac_R_72hr/R5/');
        data.first_file = 'R7_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:30)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;
    case 'pdacr_72hr_12186'
        data.path = strcat(root, '12182017_pdac_R_72hr/R6/');
        data.first_file = 'R8_w2YFP-FRET- 10-_s1_t2.TIF';
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:29)';
        data.intensity_bound = [];
        data.ratio_bound = [2 6];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 2;
        data.median_filter = 1;

    
    % 10/16/2017
    case 'pdac_72hr_10131' 
        data.path = strcat(root, '10132017 PDAC p53 R172H 72hr Gem Treat\1\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:19)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
     case 'pdac_72hr_10132' 
        data.path = strcat(root, '10132017 PDAC p53 R172H 72hr Gem Treat\2\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:18)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
     case 'pdac_72hr_10133' 
        data.path = strcat(root, '10132017 PDAC p53 R172H 72hr Gem Treat\3\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
     case 'pdac_72hr_10134' 
        data.path = strcat(root, '10132017 PDAC p53 R172H 72hr Gem Treat\4\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:22)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdac_72hr_100nM_10131' 
        data.path = strcat(root, '10132017 PDAC p53 R172H 100 nM Gem-res 72hr Treat\1\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:19)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
     case 'pdac_72hr_100nM_10132' 
        data.path = strcat(root, '10132017 PDAC p53 R172H 100 nM Gem-res 72hr Treat\2\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
     case 'pdac_72hr_100nM_10133' 
        data.path = strcat(root, '10132017 PDAC p53 R172H 100 nM Gem-res 72hr Treat\3\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
     case 'pdac_72hr_100nM_10134' 
        data.path = strcat(root, '10132017 PDAC p53 R172H 100 nM Gem-res 72hr Treat\4\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
     case 'pdac_72hr_100nM_10135' 
        data.path = strcat(root, '10132017 PDAC p53 R172H 100 nM Gem-res 72hr Treat\5\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
     case 'pdac_72hr_100nM_10136' 
        data.path = strcat(root, '10132017 PDAC p53 R172H 100 nM Gem-res 72hr Treat\6\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % 10/11/2017
    case 'pdac_pre_10101' 
        data.path = strcat(root, '10102017 PDAC p53 R172H Pre Treat\1\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
        
    case 'pdac_pre_10102' 
        data.path = strcat(root, '10102017 PDAC p53 R172H Pre Treat\2\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
 
    case 'pdac_pre_10103' 
        data.path = strcat(root, '10102017 PDAC p53 R172H Pre Treat\3\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
          
    case 'pdac_pre_10104' 
        data.path = strcat(root, '10102017 PDAC p53 R172H Pre Treat\4\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
        
        % 10/11/2017 
    case 'pdac_pre_100nM_10101' 
        data.path = strcat(root, '10102017 PDAC p53 R172H 100 nM Gem Pre Treat\1\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
        
    case 'pdac_pre_100nM_10102' 
        data.path = strcat(root, '10102017 PDAC p53 R172H 100 nM Gem Pre Treat\2\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
 
    case 'pdac_pre_100nM_10103' 
        data.path = strcat(root, '10102017 PDAC p53 R172H 100 nM Gem Pre Treat\3\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdac_pre_100nM_10104' 
        data.path = strcat(root, '10102017 PDAC p53 R172H 100 nM Gem Pre Treat\4\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
        
    case 'pdac_pre_100nM_10105' 
        data.path = strcat(root, '10102017 PDAC p53 R172H 100 nM Gem Pre Treat\5\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
 
    case 'pdac_pre_100nM_10106' 
        data.path = strcat(root, '10102017 PDAC p53 R172H 100 nM Gem Pre Treat\6\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_pre_100nM_09261' 
        data.path = strcat(root, '09262017 PDAC p53 R172H 100nM Gem-res PreTreat\1\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
        
    case 'pdac_pre_100nM_09262' 
        data.path = strcat(root, '09262017 PDAC p53 R172H 100nM Gem-res PreTreat\2\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
 
    case 'pdac_pre_100nM_09263' 
        data.path = strcat(root, '09262017 PDAC p53 R172H 100nM Gem-res PreTreat\3\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    % 09/27/2017
    case 'pdac_24hr_100nM_09271' 
        data.path = strcat(root, '\09272017 PDAC p53 R172H 100nM Gem-res 24hr Treat\1 2.5 uM\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
     
    case 'pdac_24hr_100nM_09272' 
        data.path = strcat(root, '09272017 PDAC p53 R172H 100nM Gem-res 24hr Treat\2 2.5 uM\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
   
    case 'pdac_24hr_100nM_09273' 
        data.path = strcat(root, '09272017 PDAC p53 R172H 100nM Gem-res 24hr Treat\3 2.5 uM\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = [1:6, 8:20]';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    % 09/28/2017
    case 'pdac_48hr_100nM_09281' 
        data.path = strcat(root, '09282017 PDAC p53 R172H 100nM Gem-res 48hr Treat\1 2.5 uM\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_48hr_100nM_09282' 
        data.path = strcat(root, '09282017 PDAC p53 R172H 100nM Gem-res 48hr Treat\2 2.5 uM\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
  % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_72hr_100nM_09291' 
        data.path = strcat(root, '09292017 PDAC p53 R172H 100nM Gem-res 72hr Treat\1 2.5 uM\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:6)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    % 09/26/2017
    case 'pdac_pre_09261' 
        data.path = strcat(root, '09262017 PDAC p53 R172H PreTreat\1\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = [1:4, 9:20]';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
        
    case 'pdac_pre_09262' 
        data.path = strcat(root, '09262017 PDAC p53 R172H PreTreat\2\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
 
    case 'pdac_pre_09263' 
        data.path = strcat(root, '09262017 PDAC p53 R172H PreTreat\3\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    % 09/27/2017
    case 'pdac_24hr_09271' 
        data.path = strcat(root, '\09272017 PDAC p53 R172H 24hr Treat\1 2.5 uM\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
     
    case 'pdac_24hr_09272' 
        data.path = strcat(root, '09272017 PDAC p53 R172H 24hr Treat\2 2.5 uM\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
   
    case 'pdac_24hr_09273' 
        data.path = strcat(root, '09272017 PDAC p53 R172H 24hr Treat\3 2.5 uM\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    % 09/28/2017
    case 'pdac_48hr_09281' 
        data.path = strcat(root, '09282017 PDAC p53 R172H 48hr Treat\1 2.5 uM\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_48hr_09282' 
        data.path = strcat(root, '09282017 PDAC p53 R172H 48hr Treat\2 2.5 uM\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
               % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_48hr_09283' 
        data.path = strcat(root, '09282017 PDAC p53 R172H 48hr Treat\3 2.5 uM\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    % 09/29/2017
    case 'pdac_72hr_09292' 
        data.path = strcat(root, '09292017 PDAC p53 R172H 72hr Treat\2 2.5 uM\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
               % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_72hr_09293' 
        data.path = strcat(root, '09292017 PDAC p53 R172H 72hr Treat\3 2.5 uM\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t2.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:15)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
        
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_pre_100nm_09011' 
        data.path = strcat(root, '09012017 PDAC p53 R172H 100 nM Gem Resistant\Test\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:10)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
        % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_pre_100nm_09121' 
        data.path = strcat(root, '09122017 PDAC p53 R172H 100 nM Gem Resistant\1\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_72hr_09152' 
        data.path = strcat(root, '09152017 PDAC p53 R172H 72hr Gem Treat\2 2.5 uM\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
               % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_72hr_09153' 
        data.path = strcat(root, '09152017 PDAC p53 R172H 72hr Gem Treat\3 2.5 uM\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
        % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_48hr_09141' 
        data.path = strcat(root, '09142017 PDAC p53 R172H 48hr Gem Treat\1 2.5 uM\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = ([1:14, 16, 19:20])';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_48hr_09142' 
        data.path = strcat(root, '09142017 PDAC p53 R172H 48hr Gem Treat\2 2.5 uM\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
               % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_48hr_09143' 
        data.path = strcat(root, '09142017 PDAC p53 R172H 48hr Gem Treat\3 2.5 uM\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_24hr_09131' 
        data.path = strcat(root, '09132017 PDAC p53 R172H 24hr Gem Treat\1 2.5 uM\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
           % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_24hr_09132' 
        data.path = strcat(root, '09132017 PDAC p53 R172H 24hr Gem Treat\2 2.5 uM\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
               % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_24hr_09133' 
        data.path = strcat(root, '09132017 PDAC p53 R172H 24hr Gem Treat\3 2.5 uM\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_pre_09121' 
        data.path = strcat(root, '09122017 PDAC p53 R172H Pre Treat\1\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_pre_09122' 
        data.path = strcat(root, '09122017 PDAC p53 R172H Pre Treat\2\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    % Add new entries here. It is recommended to  organize them into sections as dates. 
    case 'pdac_pre_09123' 
        data.path = strcat(root, '09122017 PDAC p53 R172H Pre Treat\3\');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;

    % copy the section below and double-check the first 3 lines of the database info
    % 09/19/2017
    case 'pdac_pre_08232' 
        data.path = strcat(root, '08232017 PDAC p53 R172H Pre Treat No Folders\2\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
     % end of section.       
     case 'pdac_pre_08233'
        data.path = strcat(root, '08232017 PDAC p53 R172H Pre Treat No Folders\3\');
        data.first_file = '1_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdac_24hr_08242'
        data.path = strcat(root, '08242017 PDAC p53 R172H 24hr Gem Treat No Folders/2 uM/');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdac_24hr_08243'
        data.path = strcat(root, '08242017 PDAC p53 R172H 24hr Gem Treat No Folders/3 uM/');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdac_48hr_08252'
        data.path = strcat(root, '08252017 PDAC p53 R172H 48hr Gem Treat No Folders\2 uM/');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 1000;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
    case 'pdac_48hr_08253'
        data.path = strcat(root, '08252017 PDAC p53 R172H 48hr Gem Treat No Folders\3 uM/');
        data.first_file = 'Experiment3_w2YFP-FRET- 10-_s1_t4.TIF'; % FRET channel
        % 1 - FRET; 2 - CFP; 
        data.index_pattern = {'s1', 's%d'};
        data.channel_pattern= {'_w2YFP-FRET- 10-_', '_w1CFP-10-_'}; 
        data.detection = 'auto';
        data.image_index = (1:20)';
        data.intensity_bound = [];
        data.ratio_bound = [1 5];
        data.brightness_factor = 1.0;
        data.min_area = 500;
        data.alpha = 1.0; % average ratio between channels 1 and 2. 
        % 
        data.subtract_background = 1;
        data.median_filter = 1;
end

return
