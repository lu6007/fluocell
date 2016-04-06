% initialize data  for the detection of FAs.
% an updated copy from intialize_data_02_23_2011()
% Updates: 08\05\2010
% 1. Can handle the case where the images were not background subtracted.
% 2. Use the function get_time to automatically generate the time.data file
% 3. Automatically check whether cell_mask needed to be drawn when 
%     data.need_mask =1.
% 4. The support for the file format of multiple acquisition on the Nikon
% microscope which can be handled by the new batch_detect_cell_bw_2()
% function. Use general file name pattern, threshold values for computing
% cell mask. 
% Example:
% >> data = init_data('12_18_ba_fn25_p3');
% >> batch_detect_cell('12_18_ba_fn25_p1','image_index', data.index,...
% 'save_file', 1);
% >> batch_detect_fa('12_18_ba_fn25_p1','image_index', data.index,...
% 'save_file', 1);
% >> compute_fa_property('12_18_ba_fn25_p1','remove_data', 0);
function data = init_data(name)
root = 'C:\Users\public.wanglab-PC-11\Desktop\test_data\';
data.cfp_channel = {'w1CFP'};
data.yfp_channel = {'w2FRET'};
data.index_pattern = {'t1', 't%d'};
data.fa.filter_size = 61;
data.fa.brightness_factor = 1;
data.fa.single_min_area = 10;
data.num_layers = 5;
data.multiple_acquisition = 1;
data.cell_name = name;
switch name,
      case '12_18_ba_fn25_p1',
        data.path = strcat(root,'jie\12_18_2012\4_25fn\p1\');
        data.first_cfp_file = 'BTAM_w1CFP_s1_t1.TIF';
        data.pax_channel = {'w3MCherry-EYE'};
        data.index = 2:51;
        data.need_mask = 0;
        data.pdgf_between_frame = [10; 11];
        data.pax_cbound = [0 8000];
        data.yfp_cbound = [0 4500];
        data.threshold = 0.05;
        data.ref_pax_intensity = 449752161;
        data.fa.min_water = 500;
        data.num_fans = 1;
        data.is_cfp_over_fret = 0;
        % '12_18_ba_fn25_p2' did not have obvious fas and did not analyze.
        % '12_18_ba_fn25_p3' too dim in CFP\FRET channel did not include.
      case '12_18_ba_fn25_p3',
        data.path = strcat(root,'jie\12_18_2012\4_25fn\p3\');
        data.first_cfp_file = 'BTAM_w1CFP_s3_t1.TIF';
        data.pax_channel = {'w3MCherry-EYE'};
        data.index = 1:51;
        data.need_mask = 0;
        data.pdgf_between_frame = [10; 11];
        data.pax_cbound = [0 1200];
        data.yfp_cbound = [0 800];
        data.threshold = 0.005;
        data.ref_pax_intensity = 39880967;
        data.fa.min_water = 1000;
        data.num_fans = 1;
        data.is_cfp_over_fret = 0;
      case '12_18_ba_fn25_p4',
        data.path = strcat(root,'jie\12_18_2012\4_25fn\p4\');
        data.first_cfp_file = 'BTAM1_w1CFP_s4_t1.TIF';
        data.pax_channel = {'w3MCherry-EYE'};
        data.index = 1:51;
        data.need_mask = 0;
        data.pdgf_between_frame = [10; 11];
        data.pax_cbound = [0 2000];
        data.yfp_cbound = [0 3000];
        data.threshold = 0.03;
        data.ref_pax_intensity = 37116509;
        data.fa.min_water = 300;
        data.num_fans = 1;
        data.is_cfp_over_fret = 0;
      case '12_18_ba_fn25_p5',
        data.path = strcat(root,'jie\12_18_2012\4_25fn\p5\');
        data.first_cfp_file = 'BTAM1_w1CFP_s5_t1.TIF';
        data.pax_channel = {'w3MCherry-EYE'};
        data.index = 8:51;
        data.need_mask = 0;
        data.pdgf_between_frame = [10; 11];
        data.pax_cbound = [0 2000];
        data.yfp_cbound = [0 1000];
        data.threshold = 0.014;
        data.ref_pax_intensity = 66320883;
        data.fa.min_water = 150;
        data.num_fans = 2;
        data.is_cfp_over_fret = 0;
      case '12_18_ba_fn25_p6',
        data.path = strcat(root,'jie\12_18_2012\4_25fn\p6\');
        data.first_cfp_file = 'BTAM1_w1CFP_s6_t1.TIF';
        data.pax_channel = {'w3MCherry-EYE'};
        data.index = [1:16, 21:51];
        data.need_mask = 0;
        data.pdgf_between_frame = [10; 11];
        data.pax_cbound = [0 2000];
        data.yfp_cbound = [0 1500];
        data.threshold = 0.03;
        data.ref_pax_intensity = 66320883;
        data.fa.min_water = 1350;
        data.num_fans = 1;
        data.is_cfp_over_fret = 0;
      case '12_18_ba_fn25_p7',
        data.path = strcat(root,'jie\12_18_2012\4_25fn\p7\');
        data.first_cfp_file = 'BTAM1_w1CFP_s7_t1.TIF';
        data.pax_channel = {'w3MCherry-EYE'};
        data.index = [1:51];
        data.need_mask = 0;
        data.pdgf_between_frame = [10; 11];
        data.pax_cbound = [0 2000];
        data.yfp_cbound = [0 1000];
        data.threshold = 0.004;
        data.ref_pax_intensity = 66320883;
        data.fa.min_water = 1350;
        data.num_fans = 1;
        data.is_cfp_over_fret = 0;
      case '12_18_ba_fn10_p1',
        data.path = strcat(root,'jie\12_18_2012\5_10fn\p1\');
        data.first_cfp_file = 'BTAM1_w1CFP_s1_t1.TIF';
        data.pax_channel = {'w3MCherry-EYE'};
        data.index = [1:51];
        data.need_mask = 0;
        data.pdgf_between_frame = [10; 11];
        data.pax_cbound = [0 3000];
        data.yfp_cbound = [0 3000];
        data.threshold = 0.03;
        data.ref_pax_intensity = 59310338;
        data.fa.min_water = 500;
        data.num_fans = 1;
        data.is_cfp_over_fret = 0;
      case '12_18_ba_fn10_p2',
        data.path = strcat(root,'jie\12_18_2012\5_10fn\p2\');
        data.first_cfp_file = 'BTAM1_w1CFP_s2_t1.TIF';
        data.pax_channel = {'w3MCherry-EYE'};
        data.index = [1:51];
        data.need_mask = 0;
        data.pdgf_between_frame = [10; 11];
        data.pax_cbound = [0 3000];
        data.yfp_cbound = [0 3000];
        data.threshold = 0.03;
        data.ref_pax_intensity = 47258682;
        data.fa.min_water = 500;
        data.num_fans = 1;
        data.is_cfp_over_fret = 0;
      case '12_18_ba_fn10_p3',
        data.path = strcat(root,'jie\12_18_2012\5_10fn\p3\');
        data.first_cfp_file = 'BTAM1_w1CFP_s3_t1.TIF';
        data.pax_channel = {'w3MCherry-EYE'};
        data.index = [1:51];
        data.need_mask = 0;
        data.pdgf_between_frame = [10; 11];
        data.pax_cbound = [0 3000];
        data.yfp_cbound = [0 3000];
        data.threshold = 0.03;
        data.ref_pax_intensity = 30585591;
        data.fa.min_water = 500;
        data.num_fans = 2;
        data.is_cfp_over_fret = 0;
      case '12_18_ba_fn10_p4',
        data.path = strcat(root,'jie\12_18_2012\5_10fn\p4\');
        data.first_cfp_file = 'BTAM1_w1CFP_s4_t1.TIF';
        data.pax_channel = {'w3MCherry-EYE'};
        data.index = [1:51];
        data.need_mask = 0;
        data.pdgf_between_frame = [10; 11];
        data.pax_cbound = [0 8000];
        data.yfp_cbound = [0 10000];
        data.threshold = 0.04;
        data.ref_pax_intensity = 146437462;
        data.fa.min_water = 500;
        data.num_fans = 1;
        data.is_cfp_over_fret = 0;
        
      %% Invapodia analysis 6\10\2013
      case '0518_control2',
          data.path = strcat('\Users\shirleywu\Desktop\Research UCSD\Kaiwen Zhang\individual FA tracking\2\');
          data.first_file = 'T00001C02Z001.tif';
          data.index_pattern = {'T00001', 'T%05d'};
          data.index = (1:34)';
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [0 5000];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 16;
      case '0518_control8',
          data.path = strcat(root,'bristow\0518_2013\control\matlab\8\');
          data.first_file = 'ch2_001.tiff';
          data.index_pattern = {'001', '%03d'};
          data.index = (1:33)';
          data.image_index = data.index;
          data.need_mask = 0;
          data.cbound = [0 10000];
          data.threshold = 0.02; %%%
          data.fa.min_water = 1500;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 16;
      case '0518_shFAPa4',
          data.path = strcat(root,'bristow\0518_2013\shFAPa\matlab\4\');
          data.first_file = 'ch2_001.tiff';
          data.index_pattern = {'001', '%03d'};
          data.index = (1:33)'; % cell shrank after frame 36.
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [0 10000];
          data.threshold = 0.02; %%%
          data.fa.min_water = 1500;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 16;
      case '0518_shFAPa6',
          data.path = strcat(root,'bristow\0518_2013\shFAPa\matlab\6\');
          data.first_file = 'ch2_001.tiff';
          data.index_pattern = {'001', '%03d'};
          data.index = (1:38)'; % cell shrank after frame 36.
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [0 5000];
          data.threshold = 0.01; %%%
          data.fa.min_water = 1500;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 16;
          
      % track fak and pax FAs. 03\18\2014
     case 'fak_pax',
        % This cell is extending at the front with no flow
        data.path = strcat(root, 'yingli_0307\fak_pax\fak_paxillin\');
        %data.first_file = 'leona20x5_w1FITC_t01.TIF';
        data.first_file = 'FAK_filt_01.tiff';
        data.pattern = {'1FITC', '2TRITC'}; 
        data.channel = {'FAK', 'Pax'};
        data.index_pattern = {'01','%02d'};
        data.image_index = [1:9]';
        %data.image_index = [1:9, 11:53]';
        data.index = data.image_index;
        data.mask_with_cell = 0;
        data.subtract_background = 0;
        data.median_filter = 1;
        % For plotting
        data.lines = {'-', '--'};
        data.region_name = {'Nascent', 'Front', 'Intermediate', 'Body'};
        data.time_interval = 3;
        % For segmentation
        % data.thresh = [60 30]; % fak - 60; paxillin - 30
        % For calculating FRET ratio
        data.factor = 2;
        data.fa.min_water = 90;
        data.pax_cbound = [1 600];
        data.protocol = 'FAK-Pax';
        % For tracking
        data.cbound = [1, data.pax_cbound(2)\2];
        
       % For displaying images and plotting tracks
        % data.image_axis = [47 411 90 495]'; %front
        % data.track_index = [333:335 341 383 385:386 387 389 414 415 448]';
        % data.track_index = [333:335 341 383 385:389 413:415 448 610 648]';
        %data.image_frame = [53 813 82 809]';
        % data.movie_frame = [35 791 83 809]';
        %data.image_axis = [264 455 247 448]; %body
        %data.track_index = [5 6 7 81 92 150 163 315 399 444]';
        % data.image_frame = ?
        case '05_19_fak', %11\18\14
          data.path = strcat(root,'05_19_11_fak_2s2\');
          % change from t8 to t57 03/31/15 and later change to t47 and later change to t40 for
          % inhibitor analysis
          data.first_file = 'dish2_w3YFP_s2_t8.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = 'dish2_w1CFP_s2_t8.TIF';
          data.FRET_first_file = 'dish2_w2FRET_s2_t8.TIF';
          data.index_pattern = {'t8', 't%d'};
          data.index = (8:22)';%[40:55 58:86]';%[47:55 58:86]';%(8:22)'; %(1:87)';% (8:22)'used for normal adhesion analysis
%           data.index = [47:55 58:86]'; % for inhibitor analysis; to see if addition 
          % of inhibitor still gives same cc as before 03/31/15
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [1000 17000];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 10; % used for before inhibitor
          %data; commented on 04/12/15
%           data.track_max_search_radius = 15; %04/12/15 for after inhibitor
%           data.track_index = [2 3 4 9 14 40 51 65 67 77]; % after inhibitor [47:55 58:86]; 
          %redetect fa with thresold = 3000 instead of 3500 which was used by Kaiwen 04/12/15
%           data.track_index = [1 2 5 15 16 20 24 57 90 94 99 123]; % for frame 
          % [40:55 58:86] with maxradius = 15 and th = 3000 and linearmotion = 1; 08/10/15
%           data.track_index = [3 5 16 18 24 53 73]; % for after inhibitor 
          % (47:87) 04/02/15
          %data.track_index = [2 12 15 16 18 21 35 42]; % for after inhibitor 
          % (57:87) 03/31/15
          data.track_index = [1 21 25 34 36 50 53 68 72 74:76 92 97:98 104];
          % track no. 22 33 54 are discarded after rechecking tracking
          % 106 also well-tracked but cc result is strange; for normal FA analysis
          %(before inhibitor)
%           data.track_index = [1 21 25 34 36 50 53 68 72 74 75 76 97 98 104];%assembly 090315
%            data.track_index = [1 21 25 50 68 72 74:76 92 97 98 104]; % assembly for 
          %individual fa tracking statistics 050415
%           data.track_index = [25 34 50 68]; % disassembly 050415
          data.crop_image = 1;
%           data.faindex = [1 21 25 34 36 50 98];
%           data.frameinfo = [3 8;2 5;7 10;7 11;6 9;9 12;12 13];
          % faindex and frameinfo are for function calculatecc in
          % plot_track.m 080415
          
      case '05_26_11_fak_1s5', %01\02\15
          data.path = strcat(root,'\05_26_11_fak_1s5\');
          data.first_file = 'dish1_w3YFP_s5_t6.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = 'dish1_w1CFP_s5_t6.TIF';
          data.FRET_first_file = 'dish1_w2FRET_s5_t6.TIF';
          data.index_pattern = {'t6', 't%d'};
          %data.index = (6:121)'; 
          data.index = [6:18 20:27 29:35]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [3000 17000];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 16;
          data.track_index = [6 13 21:22 25];
          %data.track_index = [6 9 13 21:22];
          %recheck tracking: delete 9, add 25
%           data.track_index = [6 13 22]; % assembly 090315 
%           data.track_index = [6, 22]; % assembly for 
          %individual fa tracking statistics 050415
%           data.track_index = [6, 25]; % disassembly 050415
          data.crop_image = 1;

     case '04_04_13_fak_3s6', %01\02\15
          data.path = strcat(root,'\04_04_13\d3\p6\');
          data.first_file = 'MDA_FAK_04_04_d3_w3YFP_s6_t20.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = 'MDA_FAK_04_04_d3_w1CFP_s6_t20.TIF';
          data.FRET_first_file = 'MDA_FAK_04_04_d3_w2FRET_s6_t20.TIF';
          data.index_pattern = {'t20', 't%d'};
          data.index = (20:35)'; 
          %data.index = (6:35)'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [0 5000];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 7;
          data.track_index = [1:3 10 17 19:21 25 32];
%           data.track_index = [1:2 10 19 20 25 32]; % assembly 090315
%           data.track_index = [1:3, 10 17 19 25 32]; % assembly for 
          %individual fa tracking statistics 050415
%           data.track_index = [2 3 10 19 20]; % disassembly 050415
          data.crop_image = 1;
          data.faindex = [1 3 10 17 19 20 21 25];
          data.frameinfo = [1 7; 1 2; 2 9; 4 8; 5 9; 7 8; 5 7; 7 8];
          % faindex and frameinfo are for the function calculatecc in
          % plot_track.m 080415
          
     case '04_04_13_fak_3s3', %01\02\15  best one
          data.path = strcat(root,'\04_04_13\d3\p3\');
          data.first_file = 'MDA_FAK_04_04_d3_w3YFP_s3_t3.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = 'MDA_FAK_04_04_d3_w1CFP_s3_t3.TIF';
          data.FRET_first_file = 'MDA_FAK_04_04_d3_w2FRET_s3_t3.TIF';
          data.index_pattern = {'t3', 't%d'};
          data.index = [3:6 8:10 14:23]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [0 4000];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 7;
          data.track_index = [1 12 20 23 25 30 54 57 67 76 84 110 116];
%           data.track_index = [1 12 30 54 57 76]; %assembly 090315
%           data.track_index = [1 12 20 23 25 30 54 76]; % assembly for 
          %individual fa tracking statistics 050415
%           data.track_index = [1 30 54 57 67 76]; % disassembly 050415
          data.crop_image = 1;
          
       case '05_19_src', %01\02\15
          data.path = strcat(root,'\05_19_11_src_1s4\');
          data.first_file = 'dish1_w3YFP_s4_t12.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = 'dish1_w1CFP_s4_t12.TIF';
          data.FRET_first_file = 'dish1_w2FRET_s4_t12.TIF';
          data.index_pattern = {'t12', 't%d'};
          data.index = [12:22 24:40]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [2000 7000];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 10;
          data.track_index = [3 5 7 11 66 73];
          %data.track_index = [3 5 7 11 58 66 73];
          %recheck tracking: delete 58; specific modification for 3
%           data.track_index = [3 5 7 11 66 73]; %assembly 090315
%           data.track_index = [5 11 66 73];% assembly for 
          %individual fa tracking statistics 050415
%           data.track_index = [3 5 7]; % disassembly 050415
          data.crop_image = 1;
          
      case '05_19_src_pax', %01\05\15
          data.path = strcat(root,'\05_19_11_src_1s1\');
          data.first_file = 'dish1_w3YFP_s1_t3.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = 'dish1_w1CFP_s1_t3.TIF';
          data.FRET_first_file = 'dish1_w2FRET_s1_t3.TIF';
          data.index_pattern = {'t3', 't%d'};
          data.index = [3:11 13:24 27:31 33:34 36:37]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [2400 17500];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 10;%7;%10; %always use 10 before 101515; use 7 on 101515 for redetecing FAs
%           data.track_index = [1 3 4 15 16 18 39 41 42 53 61]; % for peri FA used
          % in the tracking movie; linearmotion = 0; 081115
          data.track_index = [1 3 5 9 24 26 51 53 54 69 78];
          % deleted track no. 22 for bad tracking (splitting) 01/21/15
          % recheck tracking: deleted 2; added 54 78 01/22/15
%           data.track_index = [1 4 15 16 18 39 41 42 53 61];%assembly 090315 (for peri FA; yfp_fa_peri)
%           data.track_index = [1 24 26 51 53 54 69 78];% assembly for 
          %individual fa tracking statistics 050415
          % add #23 071715
%           data.track_index = [1 3 5 24 26 53]; % disassembly 050415
          data.crop_image = 1;
          
      case '05_26_11_src_1s3', %01\05\15
          data.path = strcat(root,'\05_26_11_src_1s3\');
          data.first_file = 'dish1_w3YFP_s3_t3.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = 'dish1_w1CFP_s3_t3.TIF';
          data.FRET_first_file = 'dish1_w2FRET_s3_t3.TIF';
          data.index_pattern = {'t3', 't%d'};
          data.index = [3:15]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [0 7000];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 10;
          data.track_index = [41:42 44:46 57 62 70:71 73];
%           data.track_index = [41 44 45 46 57 62 70 71 73]; %assembly 090315
%           data.track_index = [41 44:46 57 62 70 71 73];% assembly for 
          %individual fa tracking statistics 050415
%           data.track_index = 44;% disassembly 050415
          data.crop_image = 1;
          
      case '05_26_11_src_2s3', %01\05\15
          data.path = strcat(root,'05_26_11_src_2s3\');
          data.first_file = 'dish2_w3YFP_s3_t4.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = 'dish2_w1CFP_s3_t4.TIF';
          data.FRET_first_file = 'dish2_w2FRET_s3_t4.TIF';
          data.index_pattern = {'t4', 't%d'};
          data.index = [4:18]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [500 4000]; 
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 10;
          data.track_index = [5 11 13 30 33 44 64 75 81 90 109];
%           data.track_index = [5 13 30 33 64 75 81 90]; %assembly 090315
%           data.track_index = [5 13 30 33 64 75 81 90]; % assembly for 
          %individual fa tracking statistics 050415
%           data.track_index = [5 64]; % disassembly 050415
          data.crop_image = 1;
          
      case '05_04_13_src_2s1', %01\06\15
          data.path = strcat(root,'05_04_13\d2\p1\');
          data.first_file = '05_04_MDA_FAT_Src_w3YFP_s1_t9.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = '05_04_MDA_FAT_Src_w1CFP_s1_t9.TIF';
          data.FRET_first_file = '05_04_MDA_FAT_Src_w2FRET_s1_t9.TIF';
          data.index_pattern = {'t9', 't%d'};
          data.index = [9 11 15:19 24:26]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [500 12000];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 10;
          data.track_index = [18 24 36];
%           data.track_index = [24 36]; %assembly 090315
%           data.track_index = [24 36];% assembly for 
          %individual fa tracking statistics 050415
%           data.track_index = [24]; % disassembly 050415
          data.crop_image = 1;
          
      case '05_04_13_src_3s1', %01\06\15
          data.path = strcat(root,'05_04_13\d3\p1\');
          data.first_file = '05_04_MDA_FAT_Src_w3YFP_s1_t17.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = '05_04_MDA_FAT_Src_w1CFP_s1_t17.TIF';
          data.FRET_first_file = '05_04_MDA_FAT_Src_w2FRET_s1_t17.TIF';
          data.index_pattern = {'t17', 't%d'};
          data.index = [17:26]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [500 8000];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 10;
          data.track_index = [2 5 17:18];
%           data.track_index = [2 5 18]; %assembly 090315
%           data.track_index = [2 5]; % assembly for 
          %individual fa tracking statistics 050415
%           data.track_index = [2]; % disassembly 050415
          data.crop_image = 1;
          
      case '05_04_13_src_3s4', %01\06\15
          data.path = strcat(root,'05_04_13\d3\p4\');
          data.first_file = '05_04_MDA_FAT_Src_w3YFP_s4_t15.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = '05_04_MDA_FAT_Src_w1CFP_s4_t15.TIF';
          data.FRET_first_file = '05_04_MDA_FAT_Src_w2FRET_s4_t15.TIF';
          data.index_pattern = {'t15', 't%d'};
          data.index = [15:35]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [500 8000];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 10;
%           data.track_index = [3 20 27 38 45 66 69 93 116:117];% discard #69 when overlay image with markers 
          % since its cc result is not a typical +ve or -ve
          data.track_index = [3 20 27 45 66 69 116 117]; %assembly 090315
%           data.track_index = [3 20 27 45 66 69 117]; % assembly for 
          %individual fa tracking statistics 050415
%           data.track_index = [20 27]; % disassembly 050415
          data.crop_image = 1;
          
      case '05_22_13_src_2s3', %01\07\15
          data.path = strcat(root,'05_22_13\d2\p3\');
          data.first_file = '05_22_MDA_FAT_Src_w3YFP_s3_t3.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = '05_22_MDA_FAT_Src_w1CFP_s3_t3.TIF';
          data.FRET_first_file = '05_22_MDA_FAT_Src_w2FRET_s3_t3.TIF';
          data.index_pattern = {'t3', 't%d'};
          data.index = [3:23 25:28]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [500 3500];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 15;
          data.track_index = [3 20 29:30];
%           data.track_index = [3 20 29 30]; %assembly 090315
%           data.track_index = [3 20 29 30]; % assembly for 
          %individual fa tracking statistics 050415
%           data.track_index = [3 20 29]; % disassembly 050415
          data.crop_image = 1;
          
      case '05_22_13_src_2s5', %01\07\15
          data.path = strcat(root,'05_22_13\d2\p5\');
          data.first_file = '05_22_MDA_FAT_Src_w3YFP_s5_t4.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = '05_22_MDA_FAT_Src_w1CFP_s5_t4.TIF';
          data.FRET_first_file = '05_22_MDA_FAT_Src_w2FRET_s5_t4.TIF';
          data.index_pattern = {'t4', 't%d'};
          data.index = [4:8 10:11 14:16]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [500 4500];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 15;
          data.track_index = [33:35 37];
%           data.track_index = 34; % assembly 090515 (this cell was originally not included) 
          data.crop_image = 1;
          
      case '05_22_13_src_3s2', %01\07\15
          data.path = strcat(root,'05_22_13\d3\p2\');
          data.first_file = '05_22_MDA_FAT_Src_w3YFP_s2_t5.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = '05_22_MDA_FAT_Src_w1CFP_s2_t5.TIF';
          data.FRET_first_file = '05_22_MDA_FAT_Src_w2FRET_s2_t5.TIF';
          data.index_pattern = {'t4', 't%d'};
          data.index = [5:39]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [500 6500];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 15;
          data.track_index = [28 87 90 94 97 101 106];
%           data.track_index = [28 87 90 97 101]; %assembly 090315
%           data.track_index = [28 87 90 97 101]; % assembly for 
          %individual fa tracking statistics 050415
%           data.track_index = [28 90]; % disassembly 050415
          data.crop_image = 1;
          
      case '05_19_11_fak_1s2', %01\08\15
          data.path = strcat(root,'05_19_11_fak_1s2\');
          data.first_file = 'dish1_w3YFP_s2_t5.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = 'dish1_w1CFP_s2_t5.TIF';
          data.FRET_first_file = 'dish1_w2FRET_s2_t5.TIF';
          data.index_pattern = {'t5', 't%d'};
          data.index = [5:10 12 18 26 31:35 37]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [500 3500];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 20;
          data.track_index = [3 6 21 33:34 40 46 50:51 55];%ratio or intensity 
          %can peak at the first frame
%           data.track_index = [3 55]; %assembly 090315
%           data.track_index = [3 40 46 55]; % assembly for 
          %individual fa tracking statistics 050415
%           data.track_index = [33 40 46 51]; % disassembly 050415
          data.crop_image = 1;
          
      case '05_19_13_fak_3s2', %01\08\15
          data.path = strcat(root,'05_19_13\FAK\d3\p2\');
          data.first_file = '05_19_MDA_FAT_FAK_w3YFP_s2_t2.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = '05_19_MDA_FAT_FAK_w1CFP_s2_t2.TIF';
          data.FRET_first_file = '05_19_MDA_FAT_FAK_w2FRET_s2_t2.TIF';
          data.index_pattern = {'t2', 't%d'};
          data.index = [2:6 8 10 12 14:18]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [0 4000];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 15;
          data.track_index = [23:24 26 30 32 39 43];;%ratio or intensity 
          %can peak at the first frame
%           data.track_index = [23 30 32 43]; %assembly 090315
%           data.track_index = [23 30 32]; % assembly for 
          %individual fa tracking statistics 050415
%           data.track_index = 30; % disassembly 050415
          data.crop_image = 1;
          
      case '05_19_11_fak_2s3', %04\05\15  --> did not work (?)
          data.path = strcat(root,'05_19_11_fak_2s3\');
          data.first_file = 'dish2_w3YFP_s3_t1.TIF'; % load raw data and 
          %then preprocess in get_movie_info.m
          data.CFP_first_file = 'dish2_w1CFP_s3_t1.TIF';
          data.FRET_first_file = 'dish2_w2FRET_s3_t1.TIF';
          data.index_pattern = {'t1', 't%d'};
          data.index = [1:50]'; 
          data.image_index = data.index;
          data.need_mask = 1;
          data.cbound = [1000 14000];
          data.threshold = 0.025; %%%
          data.fa.min_water = 2000;
          data.num_fans = 0;
          data.pax_cbound = data.cbound;
          data.time_interval = 4;
          data.subtract_background = 1;
          data.median_filter = 1;
          data.protocol = 'Intensity';
          % Tracking parameters
          data.track_max_search_radius = 15;
          data.track_index = [1:200];%ratio or intensity 
          %can peak at the first frame
          %data.track_index = [23 30 32];
          data.crop_image = 1;
              
end;
if ~isfield(data, 'path'),
    data = init_data_0223_2011(name);
end;
return;