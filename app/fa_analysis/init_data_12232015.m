% initialize data  for the detection of FAs.
% an updated copy from intialize_data_02_23_2011()
% Updates: 08/05/2010
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
root = 'F:\data\';
data.cfp_channel = {'w1CFP'};
data.yfp_channel = {'w2FRET'};
data.index_pattern = {'t1', 't%d'};
data.fa.filter_size = 61;
data.fa.brightness_factor = 1;
data.fa.single_min_area = 10;
data.num_layer = 5;
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
        % '12_18_ba_fn25_p3' too dim in CFP/FRET channel did not include.
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
        
      %% Invapodia analysis 6/10/2013
      case '0518_control2',
          data.path = strcat(root,'bristow\0518_2013\control\matlab\2\');
          data.first_file = 'ch2_001.tiff';
          data.index_pattern = {'001', '%03d'};
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
          
      % track fak and pax FAs. 03/18/2014
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
        data.cbound = [1, data.pax_cbound(2)/2];
        
       % For displaying images and plotting tracks
        % data.image_axis = [47 411 90 495]'; %front
        % data.track_index = [333:335 341 383 385:386 387 389 414 415 448]';
        % data.track_index = [333:335 341 383 385:389 413:415 448 610 648]';
        %data.image_frame = [53 813 82 809]';
        % data.movie_frame = [35 791 83 809]';
        %data.image_axis = [264 455 247 448]; %body
        %data.track_index = [5 6 7 81 92 150 163 315 399 444]';
        % data.image_frame = ?

end;
if ~isfield(data, 'path'),
    data = initialize_data_02_23_2011(name);
end;
return;