% initialize data  for the detection of FAs.
% Updates: 08/05/2010
% 1. Can handle the case where the images were not background subtracted.
% 2. Use the function get_time to automatically generate the time.data file
% 3. Automatically check whether cell_mask needed to be drawn when 
%     data.need_mask =1.
% 4. The support for the file format of multiple acquisition on the Nikon
% microscope which can be handled by the new batch_detect_cell_bw_2()
% function. Use general file name pattern, threshold values for computing
% cell mask. 
function data = init_data_0223_2011(name)
root = 'E:\sof\fluocell_2.1\data\';
%root = 'C:\sylu\copy_07_19_2009-xxx\sof\fluocell_2.1\data\';
%root = 'C:\sylu\copy_xxx-06_05_2009\sof\fluocell_2.1\data\';
switch name
    case 'fakpax1'
        data.path = strcat(root, ...
            'jihye_fak_pdgf_03_10_2008\FAKPAX1''D\');
        data.prefix = 'FAKPAX1''';
        %data.index = 1:53;
        data.index = [1, 3:7, 9:12, 14, 15, 17:39, 41:47, 49:53];
        % 2 8 13 16 40 48
        % data.save_file = 1;
        % PDGF at 15& 16 at 959.26 seconds.
        data.fa.brightness_factor = 0.9;
        data.fa.filter_size = 61; % 61 pixel = 9.5 um at 100x
        data.fa.min_water = 30;
        data.fa.max_water = 200;
        data.fa.single_min_area = 15;
        data.fa.min_area = 50;
        data.pax_cbound = [1500 2645];
    case '07_05_dish2'
        data.path = strcat(root, ...
            '07_05_2008\dish2_lyn_src_pax\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        %data.index = [1:49];
        data.index = [1, 4:9, 12, 16:17, 21:24, 26:30, 44:45];
        data.fa.brightness_factor = 0.9;
        data.fa.filter_size = 61; 
        data.fa.min_water = 50;
        data.fa.max_water = 200;
        data.fa.single_min_area = 15;
        data.fa.min_area = 50;
        data.pax_cbound = [0 600];
        data.ref_pax_intensity = 7949663;
        data.before_pdgf = 12;
        data.pdgf_time = 709.97;
    case '07_05_dish3'
        data.path = strcat(root, ...
            '07_05_2008\dish3_lyn_src_pax\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:7, 9:12, 16:21, 23:30,33,35:37, 40:42, 44:45]; 
        data.fa.brightness_factor = 0.9;
        data.fa.filter_size = 61;
        data.fa.min_water = 60;
        data.fa.max_water = 1000;
        data.fa.single_min_area = 15;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity = 59685817;
        data.before_pdgf = 12;
        data.pdgf_time = 767.98;
    case '07_05_dish4'
        data.path = strcat(root, ...
            '07_05_2008\dish4_lyn_src_pax\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        % data.index = [1:50]; % frame 12-22, 40, 46-50: there is another cell attaching  
        % Can consider deleting this cell because of the other attching
        % cell
        data.index = [1,2,5:8,10:17,19:28,30:50]; 
        data.fa.brightness_factor = 0.9;
        data.fa.filter_size = 61;
        data.fa.min_water = 60;
        data.fa.max_water = 1000;
        data.fa.single_min_area = 15;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
    case '07_05_dish5'
        % naco treatment
        data.path = strcat(root, ...
            '07_05_2008\dish5_naco_lyn_src_pax\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        %data.index = [1:58]; % pdgf between frames 23 and 24
        data.index = [1:3, 6:10, 14:19, 25:48, 50:54, 56:58];
        data.fa.brightness_factor = 1.4; % this really is for the detection of the cell
        data.fa.filter_size = 61;
        data.fa.min_water = 60;
        data.fa.max_water = 1000;
        data.fa.single_min_area = 15;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1000];        
    case '07_05_dish6'
        % naco treatment
        data.path = strcat(root, ...
            '07_05_2008\dish6_naco_lyn_src_pax\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        %data.index = [1:40]; % pdgf between frames 12 and 13
        % The shape of the cell was not properly detected
        % We used the whole image instead of the mask of the cell
        % as the mask for FAs. As a result, the FRET ratio out of
        % the FAs was not calculated or plotted correctly.
        data.index = [3:9, 15:21, 23:39];
        data.fa.brightness_factor = 0.9; 
        data.fa.filter_size = 61;
        data.fa.min_water = 45;
        data.fa.max_water = 500;
        data.fa.single_min_area = 15;
        data.fa.min_area = 50;
        data.pax_cbound = [0 800];        
    case '07_05_dish7'
        % naco treatment
        data.path = strcat(root, ...
            '07_05_2008\dish7_naco_lyn_src_pax\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = (1:35); % pdgf between frames 8 and 9, 531.81 sec
        %data.index = [1:3, 6:10, 14:19, 25:48, 50:54, 56:58];
        data.fa.brightness_factor = 0.9; 
        data.fa.filter_size = 61;
        data.fa.min_water = 50;
        data.fa.max_water = 600;
        data.fa.single_min_area = 15;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1000];  
        % For some reason this cell did not respond significantly to pdgf
        % The FAs did not disassemble, instead it appeared to
        % increase in terms of average intensity.
    case '07_05_dish8'
        % The FAs looked kind of weired, like endosom structure.
        % not include this cell.
        data.path = strcat(root, ...
            '07_05_2008\dish8_lyn_src_pax\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:41]; % pdgf between frames 12 and 13, frame 36, the cell was not well-detected
        %data.index = [1,2,5:8,10:17,19:28,30:50]; 
        data.fa.brightness_factor = 0.9;
        data.fa.filter_size = 61;
        data.fa.min_water = 60;
        data.fa.max_water = 1000;
        data.fa.single_min_area = 15;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];    
    case '07_14_dish1'
        data.path = strcat(root, ...
            '07_14_2008\dish1_lyn_src_dsred_pax\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        %data.index = 1:53; % very sharp at 5 16 19 24
        data.index = [6:10, 12:15,17, 20:22, 25:26, 28:40, 42];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.min_water = 30;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.fa.max_water = 200;
        data.pax_cbound = [0 800];
        data.ref_pax_intensity = 13292854;
        data.before_pdgf = 15;
        data.pdgf_time = 903.82;
    case '07_14_dish2'
        % There is a sudden drop in the mCherry intensity
        % after adding PDGF, which is not same as 
        % the Src kinetics. It is not likely due to photobleaching
        % I also double-checked the background subtracting,
        % which should not be the reason either.
        % The detected disassembly was good.
        data.path = strcat(root, ...
            '07_14_2008\dish2_lyn_src_mcherry\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = 1:54; % PDGF between 14-15 at 822.28
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.min_water = 50; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.fa.max_water = 200;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity = 52462967;
        data.before_pdgf = 14;
        data.pdgf_time = 822.28;
    case '07_14_dish3'
        % The FAs were well-detected.
        % The dynamics results of FA disassembly was not clear.
        data.path = strcat(root, ...
            '07_14_2008\dish3_lyn_src_mcherry\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        %data.index = 1:56; 
        data.index = [1:12, 14:50];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.min_water = 50; % should this be a little higher?
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.fa.max_water = 200;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity = 31627850;
        data.before_pdgf = 12;
        data.pdgf_time = 748.17;
    case '07_14_dish4'
        %Not much response
        data.path = strcat(root, ...
            '07_14_2008\dish4_lyn_src_mcherry\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [2:11, 13:19, 21:30, 32:33, 35:37, 39:40];; % PDGF between 13-14 at 812.01 s
        data.fa.brightness_factor =0.7;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.fa.min_water = 50; % should it be lower?
        data.fa.max_water = 200;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity= 185344356;
        data.before_pdgf = 13;
        data.pdgf_time = 812.01;
        data.shift = 14;
    case '07_14_dish5'
        % good
        data.path = strcat(root, ...
            '07_14_2008\dish5_lyn_src_mcherry\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = 1:48; 
        data.fa.brightness_factor =0.6;
        data.fa.filter_size = 61; 
        data.fa.min_water = 50; % should this be a little higher?
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.fa.max_water = 200;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity = 123766869;
        data.before_pdgf = 15;
        data.pdgf_time = 920.52;
    case '07_14_dish6'
        % For some reason there was only 3 frames after PDGF
        % Will not use this cell.
        data.path = strcat(root, ...
            '07_14_2008\dish6_lyn_src_dsred_pax\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        %data.index = 1:53; % very sharp at 5 16 19 24
        data.index = [6:10, 12:15,17, 20:22, 25:26, 28:40, 42];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.min_water = 30;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.fa.max_water = 200;
        data.pax_cbound = [0 800];
   case '07_14_dish7' % dsred
       % PDGF added between frames 7 and 8 at 421.46 sec.
       % There were ~20% response in Src activation and the FA did not 
       % start to disassemble significantly
        data.path = strcat(root, ...
            '07_14_2008\dish7_lyn_src_dsred_pax\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        %data.index = 1:28; 
        data.index = [3:7, 10:11, 13:18, 20, 22:24, 26:28];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.min_water = 45;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.fa.max_water = 300;
        data.pax_cbound = [0 800];
        data.ref_pax_intensity = 123766869;
        data.before_pdgf = 7;
        data.pdgf_time = 421.46;
   case '07_14_dish8' %dsred
        % Added PDGF between frames 8-9
        % at time 482.09 seconds
        % This cell reponded about 10% to PDGF
        % and FA's did not significantly disassemble.
        data.path = strcat(root, ...
            '07_14_2008\dish8_lyn_src_dsred_pax\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:5, 7:8, 10:12, 14:21, 23:32];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.min_water = 45;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.fa.max_water = 300;
        data.pax_cbound = [0 400];
        data.ref_pax_intensity = 11108157;
        data.before_pdgf = 8;
        data.pdgf_time = 482.09;
   case '07_29_dish1'
       % Good Cell, OK detection
       % However the FAs did not disassemble.
        data.path = strcat(root, ...
            '07_29_2008\dish1_lyn_src_mcherry_pax\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        %data.index = 1:55;
        % finished 1:44.
        data.index = [1:12, 14:55];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.min_water = 45;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.fa.max_water = 300;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity = 22900427;
        % PDGF between 11-12: 678.78s 
        data.before_pdgf = 11;
        data.pdgf_time = 678.78;
   case '07_29_dish2'
       % Good Results
        data.path = strcat(root, ...
            '07_29_2008\dish2_lyn_src_mcherry_pax\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:13, 15:53];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.min_water = 45;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.fa.max_water = 300;
        data.pax_cbound = [0 1000];
        data.before_pdgf = 9;
        data.pdgf_time = 614.72;
   case '07_29_dish3'
       %The cell only respond 10% to PDGF
       % Not much disassembly
        data.path = strcat(root, ...
            '07_29_2008\dish3_lyn_src_mcherry_pax\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        %data.index = 1:48;
        data.index = [1:6,14:15, 19,23:32];
        % PDGF between 15&16: 904.87s 
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.min_water = 45;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.fa.max_water = 300;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity = 50043995;
        data.before_pdgf = 15;
        data.pdgf_time = 904.87;
        data.num_fans = 1;
   case '07_29_dish4'
       % After applying two fan region
       % Not much disassembly after pdgf,
       % More assembly after pp1.
        data.path = strcat(root, ...
            '07_29_2008\dish4_pp1\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        %data.index = [1:10, 13:23, 25:39, 41,43:55];
        data.index = [1:10, 13:23, 25:39];
        % PDGF between 11&12: 823.17s 
        % pp1 between 39&40: 2628.70s
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.min_water = 100;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.fa.max_water = 300;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity = 50043995;
        data.before_pdgf = 11;
        data.pdgf_time = 823.17;
        data.num_fans = 2;
    % Looks like dish5 and 6 did not add pp1
    % double check in metafluor
    case '07_29_dish5' %pp1 pretreat.
        data.path = strcat(root, '07_29_2008\dish5_pp1\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:13,15:25, 28:33];
        data.fa.brightness_factor = 0.7;
        data.fa.filter_size =61;
        data.fa.min_water = 100;
        data.fa.single_min_area = 50;
        data.fa.max_water = 300;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity= 61103756;
        data.before_pdgf = 10;
        data.pdgf_time = 678.24;
        data.num_fans = 1;
    case '07_29_dish6' % wound cell .
        data.path = strcat(root, '07_29_2008\dish6_wound\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [2:42];
        data.fa.brightness_factor = 0.8;
        data.fa.filter_size =61;
        data.fa.min_water = 100;
        data.fa.single_min_area = 50;
        data.fa.max_water = 300;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity= 40795886;
        data.before_pdgf = 10;
        data.pdgf_time = 595.64;
   case '07_29_dish7'
       % The FAs did not significantly disassemble or
       % assemble after PDGF or pp1.
       % Maybe the detection was not accurate
       % due to the high intensity at the center.
        data.path = strcat(root, ...
            '07_29_2008\dish7_wound_pp1\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        %data.index = 1:48;
        data.index = 1:37;
        % PDGF between 11&12: 674.80s 
        % pp1 between 37&38: 2300.65s
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.min_water = 100;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.fa.max_water = 300;
        data.pax_cbound = [0 1000];
        data.before_pdgf = 11;
        data.pdgf_time = 674.80;
   case '07_29_dish8'
       % The FAs started to disassemble or
       % assemble after PDGF, and even more after pp1
       % inhibition.
       % The FA detection seems to work better.
        data.path = strcat(root, ...
            '07_29_2008\dish8_wound_pp1\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = 1:42; % intensity fluctuated after 43
        % PDGF between 8&9 501.80s 
        % pp1 between 42&43 2579.48s
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.min_water = 100;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.fa.max_water = 300;
        data.pax_cbound = [0 1000];
        data.before_pdgf = 8;
        data.pdgf_time = 501.80;
   case '07_29_dish9'
       % wound
        data.path = strcat(root, ...
            '07_29_2008\dish9_wound\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = 1:39;
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.min_water = 100;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.fa.max_water = 300;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity = 40862787;
        data.before_pdgf = 10;
        data.pdgf_time = 626.01;
        data.num_fans =1;
   case '10_24_dish21'
       % The FAs started to disassemble or
       % assemble after PDGF, and even more after pp1
       % inhibition.
       % The FA detect seems to work better.
        data.path = strcat(root, ...
            '10_24_08_Src_mcherry_pax\2\dish1\');
        data.prefix = '2-1';
        data.prefix_sub = '2-1_SUB';
        data.index = [5:10, 12:14,16:65];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.max_water = 100;
        data.fa.min_water = 30;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 250];
        data.ref_pax_intensity = 8245204;
        % PDGF between 10&11 611.52s 
        data.before_pdgf = 10;
        data.pdgf_time = 611.52;
   case '10_24_dish22'
       % The FAs started to disassemble or
       % assemble after PDGF, and even more after pp1
       % inhibition.
       % This cell does look good for analysis
        % After adding pp1 (frame 41), the cell moved and resulting the detected FAs
        % changed to more brighter ones. (not suitable for pp1 results).
        data.path = strcat(root, ...
            '10_24_08_Src_mcherry_pax\2\dish2\');
        data.prefix = '2-2';
        data.prefix_sub = '2-2_SUB';
        % data.index = 1:57; % should be 1:65
        % PDGF between 6&7 406.94s
        % pp1 between 40&41 at 2469.80s
        data.index = [1:2,4:6,8:40];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.max_water = 100;
        data.fa.min_water = 40;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 800];
        %data.fa.threshold = 400;
        data.fa.threshold = 300;
        data.ref_pax_intensity = 59296199;
        data.before_pdgf = 6;
        data.pdgf_time = 406.94;
        data.before_pp1 = 40;
        data.pp1_time = 2469.80;
   case '10_24_dish31'
       % The FAs appeared to decrease after PDGF
        data.path = strcat(root, ...
            '10_24_08_Src_mcherry_pax\3\dish1\');
        data.prefix = '3-1';
        data.prefix_sub = '3-1_SUB';
        %data.index = [1:65, 67:81]; % could be 1:103
        data.index = [1:49];
        % PDGF between 4&5 260.21s
        % pp1 between 50&51 at 3018.49s
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.max_water = 100;
        data.fa.min_water = 30;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 400];
        data.before_pdgf = 4;
        data.pdgf_time = 260.21;
   case '10_24_dish32'
       % Disassemble after pdgf, continue disassembly after pp1.
        data.path = strcat(root, ...
            '10_24_08_Src_mcherry_pax\3\dish2\');
        data.prefix = '3-2';
        data.prefix_sub = '3-2_SUB';
        %data.index = 1:54;
        data.index = [1:9, 11:37];
        data.fa.brightness_factor =0.5;
        data.fa.filter_size = 61; 
        data.fa.max_water = 200;
        data.fa.min_water = 50;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity = 60202909;
        data.num_fans = 1;
        % PDGF between 5&6 249.61s
        % pp1 between 38&39 at 2270.99s
        data.before_pdgf = 5;
        data.pdgf_time = 249.61;
   case '10_24_dish33'
       % The detection of FA did not work very well.
        data.path = strcat(root, ...
            '10_24_08_Src_mcherry_pax\3\dish3\');
        data.prefix = '3-3';
        data.prefix_sub = '3-3_SUB';
        %data.index = 1:54;
        data.index = 1:36;
        data.fa.brightness_factor =0.5;
        data.fa.filter_size = 61; 
        data.fa.max_water = 200;
        data.fa.min_water = 80;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 141941365;
        data.num_fans = 2;
        % PDGF between 7&8 428.90s
        % pp1 between 37&38 2193.84s
        data.before_pdgf = 7;
        data.pdgf_time = 428.90;
   case '10_24_dish41'
       % The detection of FA worked OK.
       % The cell was very dynamic after adding PDGF, 
       % with much ruffling process.
        data.path = strcat(root, ...
            '10_24_08_Src_mcherry_pax\4\dish1\');
        data.prefix = '4-1';
        data.prefix_sub = '4-1_SUB';
        % data.index = 1:54;
        % data.index = 3:54;
        data.index = 3:41;
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.max_water = 100;
        data.fa.min_water = 25;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 400];
        data.ref_pax_intensity = 29315608;
        % PDGF between 7&8 423.61s
        % pp1 between 41&42 2465.31s
        data.before_pdgf = 7;
        data.pdgf_time = 423.61;
        data.num_fans = 1;
   case '10_24_dish42'
        data.path = strcat(root, ...
            '10_24_08_Src_mcherry_pax\4\dish2\');
        data.prefix = '4-2';
        data.prefix_sub = '4-2_SUB';
        data.index = [2:3, 5:70];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.max_water = 300;
        data.fa.min_water = 105;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 21846666;
        data.before_pdgf = 6;
        data.pdgf_time = 471.60;
        data.num_fans = 2;
   case '10_24_dish43'
       % This is a very dynamic cell, surprisingly the total 
       % paxillin intensity in the cells remain relative stable
       % during the experiment.
        data.path = strcat(root, ...
            '10_24_08_Src_mcherry_pax\4\dish3\');
        data.prefix = '4-3';
        data.prefix_sub = '4-3_SUB';
        data.index = [1:20, 22:40];
        data.fa.brightness_factor =0.5;
        data.fa.filter_size = 61; 
        data.fa.max_water = 300;
        data.fa.min_water = 105;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity = 26901872;
        data.before_pdgf = 9; % another  pdgf at 20
        data.pdgf_time = 551.09;
        data.num_fans = 2;
   case '11_14_dish3'
       % The detection of FA worked very well.
       % There were mysterious oscillation of the total intensity at the
       % frames 21 24 27 29 with no obvious reason, possibly due 
       % to an increase of background staining due to ruffling.
        data.path = strcat(root, ...
            '11_14_2008_src_pax\3_pp1_ pdgf\');
        data.prefix = '3';
        data.prefix_sub = '3''';
        %data.index = 1:30;
        %data.index = [1:6, 8:12, 14:30];
        data.index = [1:6, 8:12, 14:20, 22:23, 25:26, 28, 30];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.max_water = 300;
        data.fa.min_water = 80;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity = 83643752;
        data.before_pdgf = 6;
        data.pdgf_time = 346.56;
   case '11_14_dish4'
       % The detection of FA looks good.
       % There were mysterious oscillation of the total intensity at the
       % frames 1-2, 10, 14-16, 20, 24 with no obvious reason, possibly due 
       % to an increase of background staining due to ruffling.
        data.path = strcat(root, ...
            '11_14_2008_src_pax\4_pp1_pdgf\');
        data.prefix = '4';
        data.prefix_sub = '4''';
        %data.index = [1:3,5,7,9:29, 31:32];
        data.index = [3, 5, 7, 9, 11:13, 17:19, 21:23, 25:29, 31:32];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.max_water = 300;
        data.fa.min_water = 80;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 38296557;
        data.before_pdgf = 5;
        data.pdgf_time = 308.48;
   case '11_14_dish5'
       % The detection of FA looks OK.
       % 6% reduction in FA intensity over time.
        data.path = strcat(root, ...
            '11_14_2008_src_pax\5_pp1_pdgf\');
        data.prefix = '5';
        data.prefix_sub = '5''';
        %data.index = [1:32];
        data.index = [1:3, 5, 7:27, 29:32];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 300;
        data.fa.min_water = 80;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 35611454;
        data.before_pdgf = 6;
        data.pdgf_time = 300.43;
   case '11_18_dish1'
       % The detection of FA looks OK.
        data.path = strcat(root, ...
            '11_18_2008_src_pax_pdgf_pp1\1\');
        data.prefix = '1''';
        data.prefix_sub = '1''_SUB';
        %data.index = [1:112];
        %data.index = 1:88;
        %data.index = [10:18, 22:35, 37:43, 47:52, 55:88];
        data.index = [10:18, 22,24:35, 37:43, 47:52];
        % PDGF between 13&14 813.6sec
        % pp1 between 57&58 at 3466.89 sec
        data.fa.brightness_factor =0.7;
        data.fa.filter_size = 61; 
        data.fa.max_water = 400;
        data.fa.min_water = 80;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 85132441;
        data.before_pdgf = 13;
        data.pdgf_time = 813.6;
   case '11_18_dish2'
       % The detection of FA looks OK.
        data.path = strcat(root, ...
            '11_18_2008_src_pax_pdgf_pp1\2\');
        data.prefix = '2''';
        data.prefix_sub = '2''_SUB';
        % data.index = 1:126;
        % data.index = [1:11, 13:20, 22:126];
        data.index = [5:9,11, 13:20, 22:29, 31:46, 48:50];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.max_water = 400;
        data.fa.min_water = 80;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 59741441;
        % PDGF between 11&12 683.19 sec
        % pp1 between 51&52 at 3038.71 sec
        data.before_pdgf = 11;
        data.pdgf_time = 683.19;
   case '11_18_dish3'
       % The detection of FA looks OK.
       % FA intensity did not decrease, but increased.
        data.path = strcat(root, ...
            '11_18_2008_src_pax_pdgf_pp1\3\');
        data.prefix = '3''';
        data.prefix_sub = '3''_SUB';
        % data.index = 1:99;
        % data.index = [1:9, 11:56, 58:80];
        data.index = [1:9, 11:22, 26:41, 45:55];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.max_water = 400;
        data.fa.min_water = 80;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 43005466;
        % PDGF between 9&10 549.57 sec
        % pp1 between 56&57 at 3356.14 sec
        data.before_pdgf = 9; 
        data.pdgf_time = 549.57;
    case '12_10_dish1' 
        % pdgf between 6-7 at 1048.51 sec
        data.path = strcat(root, ...
            '12_10_2008\mch_pax_pdgf\1\');
        data.prefix = '1';
        data.prefix_sub = '1_SUB';
        data.index = [2:22, 24:43];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 125;
        data.fa.min_water = 40;
        data.fa.single_min_area = 28;
        data.fa.min_area = 50;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity = 19725862;
        data.before_pdgf = 6;
        data.pdgf_time = 1048.51;
        data.has_yfp = 0;
    case '12_10_dish2'
        %pdgf between 9-10 at 512.43 sec
        data.path = strcat(root, ...
            '12_10_2008\mch_pax_pdgf\2\');
        data.prefix = '2';
        data.prefix_sub = '2_SUB';
        data.index = [1:31];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 125;
        data.fa.min_water = 35;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity = 17192530; 
        data.before_pdgf = 9;
        data.pdgf_time = 512.43;
        data.has_yfp = 0;
        data.need_mask = 1;
    case '12_10_dish3'
        % The cell was very dynamic with lots of ruffles.
        data.path = strcat(root, ...
            '12_10_2008\mch_pax_pdgf\3\');
        data.prefix = '3';
        data.prefix_sub = '3_SUB';
        data.index = [1:3,5:46];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 200;
        data.fa.min_water = 38;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity = 22621904;
        data.before_pdgf = 9;
        data.pdgf_time = 525.81;
        data.has_yfp = 0;
        data.need_mask = 0;
    case '12_10_dish4'
        %pdgf between 6-7 at 437.17 sec
        data.path = strcat(root, ...
            '12_10_2008\mch_pax_pdgf\4\');
        data.prefix = '4';
        data.prefix_sub = '4_SUB';
        data.index = [1:42];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 125;
        data.fa.min_water = 30;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity = 17901651;
        data.before_pdgf = 6;
        data.pdgf_time = 437.17;
        data.has_yfp = 0;
        data.need_mask = 0;
        data.num_fans = 1;
    case '12_10_dish5'
        %pdgf between 8-9 at 479.98 sec
        data.path = strcat(root, ...
            '12_10_2008\mch_pax_pdgf\5\');
        data.prefix = '5';
        data.prefix_sub = '5_SUB';
        data.index = [7:56];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 125;
        data.fa.min_water = 60;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity = 44859723; 
        data.before_pdgf = 8;
        data.pdgf_time = 479.98;
        data.has_yfp = 0;
        data.need_mask = 0;
        data.num_fans = 1;
    case '12_10_dish6'
        %pdgf between 5-6 at 314.56 sec
        data.path = strcat(root, ...
            '12_10_2008\mch_pax_pdgf\6\');
        data.prefix = '6';
        data.prefix_sub = '6_SUB';
        %data.index = [1:51];
        data.index = [1:17, 19:21, 23, 25, 27:28, 30, 32, 34:39, 41:40, 48:50];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 125;
        data.fa.min_water = 40;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity = 9813746;        
        data.before_pdgf = 5;
        data.pdgf_time = 314.56;
        data.has_yfp = 0;
        data.need_mask = 0;
        data.num_fans = 0;
    case '12_10_dish7'
        %pdgf between 6-7 at 359.35 sec
        data.path = strcat(root, ...
            '12_10_2008\mch_pax_pdgf\7\');
        data.prefix = '7';
        data.prefix_sub = '7_SUB';
        %data.index = [1:37];
        data.index = [1:17, 19:22, 24:25, 27:30, 32:36];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 160;
        data.fa.min_water = 40;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity = 13726110; 
        data.before_pdgf = 6;
        data.pdgf_time = 359.35;
        data.has_yfp = 0;
        data.need_mask = 0;
        data.num_fans = 0;
    case '12_10_dish7'
        %pdgf between 6-7 at 359.35 sec
        data.path = strcat(root, ...
            '12_10_2008\mch_pax_pdgf\7\');
        data.prefix = '7';
        data.prefix_sub = '7_SUB';
        %data.index = [1:37];
        data.index = [1:17, 19:22, 24:25, 27:30, 32:36];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 160;
        data.fa.min_water = 40;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity = 13726110; 
        data.before_pdgf = 6;
        data.pdgf_time = 359.35;
        data.has_yfp = 0;
        data.need_mask = 0;
        data.num_fans = 0;
    case '12_10_dish8'
        % The detection of the boundary was not stable.
        % Had to copy cell_bw.007 to all the cell_bw.008-cell_bw.061.
        data.path = strcat(root, ...
            '12_10_2008\mch_pax_pdgf\8\');
        data.prefix = '8';
        data.prefix_sub = '8_SUB';
        data.index = [3:61];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 125;
        data.fa.min_water = 30;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 400];
        data.ref_pax_intensity = 14435136;        
        data.before_pdgf = 6;
        data.pdgf_time = 362.91;
        data.has_yfp = 0;
        data.need_mask = 1;
        data.num_fans = 0;
    case '12_18_dish1' % copied the first mask to the rest of images
        %pdgf between  5-6 at 310.90 sec
        data.path = strcat(root, ...
            '12_18_2008\mch_pax_pdgf\1\');
        data.prefix = '1';
        data.prefix_sub = '1_SUB';
        data.index = [1:49];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 10000;
        data.fa.min_water = 2000;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 40000];
        data.ref_pax_intensity = 1.1227e+009;
        data.before_pdgf = 5;
        data.pdgf_time = 310.90;
        data.has_yfp = 0;
        data.need_mask = 0;
        data.num_fans =0;
    case '12_18_dish2'
        %pdgf between  5-6 at 331.84 sec
        data.path = strcat(root, ...
            '12_18_2008\mch_pax_pdgf\2\');
        data.prefix = '2';
        data.prefix_sub = '2_SUB';
        data.index = [1:15, 17, 19:21,24, 26:54];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 10000;
        data.fa.min_water = 1500;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 30000];
        data.ref_pax_intensity = 886636912;
        data.before_pdgf = 5;
        data.pdgf_time = 331.84;
        data.has_yfp = 0;
        data.need_mask = 1;
        data.num_fans =0;
    case '12_18_dish3'
        % pdgf between  7-8 at 417.19 sec
        data.path = strcat(root, ...
            '12_18_2008\mch_pax_pdgf\3\');
        data.prefix = '3';
        data.prefix_sub = '3_SUB';
        data.index = [1:58];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 15000;
        data.fa.min_water = 2200;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 30000];
        data.ref_pax_intensity = 1.1620e+009;        
        data.before_pdgf = 7;
        data.pdgf_time = 417.19;
        data.has_yfp = 0;
        data.need_mask = 1;
        data.num_fans =0;
    case '12_18_vinc_dish1'
        % pdgf between  6-7 at 365.23 sec
        data.path = strcat(root, ...
            '12_18_2008\mch_vinc_pdgf\1\');
        data.prefix = '1';
        data.prefix_sub = '1_SUB';
        data.index = [1:51];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 125;
        data.fa.min_water = 40;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity = 14606230; 
        data.before_pdgf = 6;
        data.pdgf_time = 365.23;
        data.has_yfp = 0;
        data.need_mask = 0;
        data.num_fans =0;
    case '12_18_vinc_dish2'
        % pdgf between  8-9 at 488.21 sec
        data.path = strcat(root, ...
            '12_18_2008\mch_vinc_pdgf\2\');
        data.prefix = '2';
        data.prefix_sub = '2_SUB';
        data.index = [1:43];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 125;
        data.fa.min_water = 40;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity = 14606230;        
    case '12_18_vinc_dish3'
        % pdgf between  7-8 at 428.84 sec
        data.path = strcat(root, ...
            '12_18_2008\mch_vinc_pdgf\3\');
        data.prefix = '3';
        data.prefix_sub = '3_SUB';
        data.index = [1:56];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 125;
        data.fa.min_water = 40;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity = 14606230;        
    case '12_18_vinc_dish4'
        % pdgf between  9-10 at 466.25 sec
        data.path = strcat(root, ...
            '12_18_2008\mch_vinc_pdgf\4\');
        data.prefix = '4';
        data.prefix_sub = '4_SUB';
        data.index = [1:46];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 125;
        data.fa.min_water = 40;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity = 14606230;        
    case '12_18_vinc_dish5'
        % pdgf between  9-10 at 596.00 sec
        data.path = strcat(root, ...
            '12_18_2008\mch_vinc_pdgf\5\');
        data.prefix = '5';
        data.prefix_sub = '5_SUB';
        data.index = [1:50];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 125;
        data.fa.min_water = 40;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity = 14606230;        
    case '12_18_vinc_dish6'
        % pdgf between 8-9 at 445.79 sec
        data.path = strcat(root, ...
            '12_18_2008\mch_vinc_pdgf\6\');
        data.prefix = '6';
        data.prefix_sub = '6_SUB';
        data.index = [1:45];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 125;
        data.fa.min_water = 40;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity = 14606230;        
    case '12_18_vinc_dish7'
        % pdgf between 5-6 at 321.04 sec
        data.path = strcat(root, ...
            '12_18_2008\mch_vinc_pdgf\7\');
        data.prefix = '7';
        data.prefix_sub = '7_SUB';
        data.index = [1:61];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 125;
        data.fa.min_water = 40;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity = 14606230;        
    case '01_12_pax_dish1'
        data.path = strcat(root, ...
            '01_12_2009\src_mcherry_pax\1\');
        data.prefix = '1';
        data.prefix_sub = '1_SUB';
        data.index = [1:63];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 375;
        data.fa.min_water = 100;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 47071959;
        data.before_pdgf = 4;
        data.pdgf_time = 301.24;
        data.num_fans = 1;
    case '01_12_pax_dish2' 
        % Not much pdgf response or disassembly
        data.path = strcat(root, ...
            '01_12_2009\src_mcherry_pax\2\');
        data.prefix = '2';
        data.prefix_sub = '2_SUB';
        data.index = [2:7, 12:24, 31:33, 42:45];
        data.fa.brightness_factor =0.8;
        data.fa.filter_size = 61; 
        data.fa.max_water = 300;
        data.fa.min_water = 150;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity = 100644158;
        data.before_pdgf = 6;
        data.pdgf_time = 315.61;
        data.num_fans = 1;
    case '01_12_pax_dish3'
        % good Src response, no disassembly
        data.path = strcat(root, ...
            '01_12_2009\src_mcherry_pax\3\');
        data.prefix = '3';
        data.prefix_sub = '3_SUB';
        data.index = [3:4, 8:11,13:14, 18:20, 27:42];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 200;
        data.fa.min_water = 75;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 36344166;
        data.before_pdgf = 11;
        data.pdgf_time = 678.43;
    case '01_12_pax_dish4'
        data.path = strcat(root, ...
            '01_12_2009\src_mcherry_pax\4\');
        data.prefix = '4';
        data.prefix_sub = '4_SUB';
        data.index = [1:23];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 250;
        data.fa.min_water = 120;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 35069561;
        data.before_pdgf = 5;
        data.pdgf_time = 278.30;
    case '01_12_vin_dish1'
        % low src response, no disassembly.
        data.path = strcat(root, ...
            '01_12_2009\src_mcherry_vin\1\');
        data.prefix = '1';
        data.prefix_sub = '1_SUB';
        data.index = [1:7, 11:13, 16:58];
        data.fa.brightness_factor =0.7;
        data.fa.filter_size = 61; 
        data.fa.max_water = 300;
        data.fa.min_water = 120;
        data.fa.single_min_area = 50;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1700];
        data.ref_pax_intensity = 164814640;
        data.before_pdgf = 6;
        data.pdgf_time = 384.23;
        data.need_mask = 1;
        data.num_fans = 1;
    case '01_12_vin_dish2'
        % low Src response, slightly disassembly.
        data.path = strcat(root, ...
            '01_12_2009\src_mcherry_vin\2\');
        data.prefix = '2';
        data.prefix_sub = '2_SUB';
        data.index = [1:6, 10:39];
        %data.index = [1:28];
        data.fa.brightness_factor =0.6;
        data.fa.filter_size = 61; 
        data.fa.max_water = 550;
        data.fa.min_water = 300;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 3000];
        data.ref_pax_intensity = 117389405;
        data.before_pdgf = 5;
        data.pdgf_time = 340.50;
        data.num_fans = 2;
    case '01_12_vin_dish3'
        data.path = strcat(root, ...
            '01_12_2009\src_mcherry_vin\3\');
        data.prefix = '3';
        data.prefix_sub = '3_SUB';
        data.index = [1,3:7,19:44,47:48];
        data.fa.brightness_factor =0.4;
        data.fa.filter_size = 61; 
        data.fa.max_water = 400;
        data.fa.min_water = 200;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 3000];
        data.ref_pax_intensity = 184916588;
        data.before_pdgf = 5;
        data.pdgf_time = 428.65;
        data.num_fans = 1;
        %data.unspecific_gate = 1100;
    case '01_12_vin_dish4' %some disassembly
        data.path = strcat(root, ...
            '01_12_2009\src_mcherry_vin\4\');
        data.prefix = '4';
        data.prefix_sub = '4_SUB';
        data.index = [1, 3:9, 13:41];
        data.fa.brightness_factor =0.8;
        data.fa.filter_size = 61; 
        data.fa.max_water = 400;
        data.fa.min_water = 160;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity = 134326045;
        data.before_pdgf = 8;
        data.pdgf_time = 406.90;
        %data.unspecific_gate = 1000;
    case '01_12_vin_dish5' % not much disassembly
        data.path = strcat(root, ...
            '01_12_2009\src_mcherry_vin\5\');
        data.prefix = '5';
        data.prefix_sub = '5_SUB';
        data.index = [1:10, 12:13, 15:44];
        data.fa.brightness_factor =0.5;
        data.fa.filter_size = 61; 
        data.fa.max_water = 400;
        data.fa.min_water = 160;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2500];
        data.ref_pax_intensity = 134650263;
        data.before_pdgf = 8;
        data.pdgf_time = 443.50;
        data.num_fans = 1;
    case '01_12_vin_dish6'
        data.path = strcat(root, ...
            '01_12_2009\src_mcherry_vin\6\');
        data.prefix = '6';
        data.prefix_sub = '6_SUB';
        data.index = [1:9,14:29];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 600;
        data.fa.min_water = 350;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 3000];
        data.ref_pax_intensity = 91463814;
        data.before_pdgf = 7;
        data.pdgf_time = 415.54;
        data.num_fans = 1;
    case '01_31_dish1' % significant disassembly
        data.path = strcat(root, ...
            '01_31_2009_src_mcherry pax_pd\1\');
        data.prefix = '1';
        data.prefix_sub = '1_SUB';
        data.index = [1:33];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 800;
        data.fa.min_water = 200;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity = 36875447;
        data.before_pdgf = 5;
        data.pdgf_time = 299.72;
    case '01_31_dish1' % significant disassembly
        data.path = strcat(root, ...
            '01_31_2009_src_mcherry pax_pd\1\');
        data.prefix = '1';
        data.prefix_sub = '1_SUB';
        data.index = [1:33];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 800;
        data.fa.min_water = 200;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity = 36875447;
        data.before_pdgf = 5;
        data.pdgf_time = 299.72;
    case '01_31_dish2' 
        data.path = strcat(root, ...
            '01_31_2009_src_mcherry pax_pd\2\');
        data.prefix = '2';
        data.prefix_sub = '2_SUB';
        data.index = [1:15, 19:24];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 280;
        data.fa.min_water = 80;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 29687378;
        data.before_pdgf = 15;
        data.pdgf_time = 869.68; % another mark of pdgf at 6
    case '01_31_dish3' % not disassembly
        data.path = strcat(root, ...
            '01_31_2009_src_mcherry pax_pd\3\');
        data.prefix = '3';
        data.prefix_sub = '3_SUB';
        data.index = [1:28];
        data.fa.brightness_factor =0.5;
        data.fa.filter_size = 61; 
        data.fa.max_water = 400;
        data.fa.min_water = 200;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity = 72069824;
        data.before_pdgf = 5;
        data.pdgf_time = 281.38;
        %data.unspecific_gate = 700;
        data.num_fans = 1;
    case '01_31_dish4'
        % There were significantly less FAs in the base level
        % compared to untreated cells.
        % There were significant disassembly.
        data.path = strcat(root, ...
            '01_31_2009_src_mcherry pax_pd\4\');
        data.prefix = '4';
        data.prefix_sub = '4_SUB';
        data.index = [1:19];
        data.fa.brightness_factor =0.7;
        data.fa.filter_size = 61; 
        data.fa.max_water = 400;
        data.fa.min_water = 150;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 32491256;
        data.before_pdgf = 4;
        data.pdgf_time = 207.43;
    case '01_31_dish5'
        % The time course was only 13 minutes after
        % the second time PDGF was added.
        % This was too short to tell.
        data.path = strcat(root, ...
            '01_31_2009_src_mcherry pax_pd\5\');
        data.prefix = '5';
        data.prefix_sub = '5_SUB';
        data.index = [3:7, 10:11,13:14, 19:24];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 280;
        data.fa.min_water = 50;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 35902000;
        data.before_pdgf = 11;
        data.pdgf_time = 466.66;
        data.num_fans =1;
    % The water algorithm was updated after Feb 5th here.
    case '02_05_dish1'
        % significant disassembly.
        data.path = strcat(root, ...
            '02_05_2009_src_mcherry pax_pd\1\');
        data.prefix = '1';
        data.prefix_sub = '1_SUB';
        %data.index = [1:33];
        data.index = [1:4, 7:12, 16:32];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 600;
        data.fa.min_water = 250;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity = 30401565;
        data.before_pdgf = 7;
        data.pdgf_time = 445.77;
    case '02_05_dish2'
        data.path = strcat(root, ...
            '02_05_2009_src_mcherry pax_pd\2\');
        data.prefix = '2';
        data.prefix_sub = '2_SUB';
        % data.index = [1:32];
        data.index = [1:3,5, 8, 11, 16:17, 20:21, 24];
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.max_water = 500;
        data.fa.min_water = 150;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity = 73060768;
        data.before_pdgf = 5;
        data.pdgf_time = 295.79;
        data.num_fans = 1;
     case '02_05_dish3'
         % There was disassembly.
        data.path = strcat(root, ...
            '02_05_2009_src_mcherry pax_pd\3\');
        data.prefix = '3';
        data.prefix_sub = '3_SUB';
        %data.index = [1:35];
        data.index = [1,3:9, 12:13, 21,24:26, 31:33];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 500;
        data.fa.min_water = 200;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity = 50004595;
        data.before_pdgf = 7;
        data.pdgf_time = 354.91;
        %data.unspecific_gate = 550;
     case '02_05_dish4'
         % FAs were disassembled
        data.path = strcat(root, ...
            '02_05_2009_src_mcherry pax_pd\4\');
        data.prefix = '4';
        data.prefix_sub = '4_SUB';
        %data.index = [1:40];
        data.index = [2,7:9, 11:12,14:30,32:39];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 500;
        data.fa.min_water = 200;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity = 47703430;
        data.before_pdgf = 8;
        data.pdgf_time = 496.98;
        data.num_fans = 1;
        %data.unspecific_gate = 550;
     case '02_05_dish5'
         % FAs were disassembled
        data.path = strcat(root, ...
            '02_05_2009_src_mcherry pax_pd\5\');
        data.prefix = '5';
        data.prefix_sub = '5_SUB';
        data.index = [1:3,5,7, 16:17,19:29];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 450;
        data.fa.min_water = 150;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 38177434;
        data.before_pdgf = 6;
        data.pdgf_time = 340.51;
        data.num_fans = 1;
        %data.unspecific_gate = 550;
     case '02_10_dish1'
        data.path = strcat(root, ...
            '02_10_2009\src_mch pax_ly\1\');
        data.prefix = '1';
        data.prefix_sub = '1_SUB';
        data.index = [1:3, 5:13, 15:18, 20:21, 23:32];
        data.fa.brightness_factor =0.8;
        data.fa.filter_size = 61; 
        data.fa.max_water = 500;
        data.fa.min_water = 200;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 30898557;
        data.before_pdgf = 5;
        data.pdgf_time = 265.64;
        %data.unspecific_gate = 550;
        data.num_fans = 0;
     case '02_10_dish2'
         % disassembled for 7% 
        data.path = strcat(root, ...
            '02_10_2009\src_mch pax_ly\2\');
        data.prefix = '2';
        data.prefix_sub = '2_SUB';
        data.index = [1:12, 20:33];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 420;
        data.fa.min_water = 120;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity = 23041274;
        data.before_pdgf = 5;
        data.pdgf_time = 326.20;
        %data.unspecific_gate = 550;
        data.num_fans = 2;
     case '02_10_dish3'
         % Src did not response and FAs did not disassemble
        data.path = strcat(root, ...
            '02_10_2009\src_mch pax_ly\3\');
        data.prefix = '3';
        data.prefix_sub = '3_SUB';
        data.index = [27:32, 36,41:56]; %1:63
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 420;
        data.fa.min_water = 120;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity = 8584343;
        data.before_pdgf = 34;
        data.pdgf_time = 1997.11;
        %data.unspecific_gate = 550;
     case '02_10_dish6'
         % to subtract_background
        data.path = strcat(root, ...
            '02_10_2009\src_mch pax_ly\6\');
        data.prefix = '6';
        data.prefix_sub = '6_SUB';
        data.index = [1:5,11, 13:25, 27:28];
        data.fa.brightness_factor =0.5;
        data.fa.filter_size = 61; 
        data.fa.max_water = 450;
        data.fa.min_water = 150;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity = 85852178;
        data.before_pdgf = 5;
        data.pdgf_time = 290.88;
        data.num_fans = 1;
        %data.unspecific_gate = 550;
     case '02_10_dish4'
         % to subtract_background
        data.path = strcat(root, ...
            '02_10_2009\src_mch pax_ly pd\4\');
        data.prefix = '1';
        data.prefix_sub = '1_SUB';
        %data.index = [1:46];
        data.index = [1:3,5,9:11, 13, 17:18, 20:24, 27:37];
        data.fa.brightness_factor =0.5;
        data.fa.filter_size = 61; 
        data.fa.max_water = 550;
        data.fa.min_water = 250;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity = 74167247;
        data.before_pdgf = 11;
        data.pdgf_time = 691.58;
        data.num_fans = 1;
        %data.unspecific_gate = 550;
     case '02_10_dish5'
         % to subtract_background
        data.path = strcat(root, ...
            '02_10_2009\src_mch pax_ly pd\5\');
        data.prefix = '5';
        data.prefix_sub = '5_SUB';
        data.index = [3:12, 16, 18:37, 39:42, 44:45];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 500;
        data.fa.min_water = 200;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity = 13474126;
        data.before_pdgf = 15;
        data.pdgf_time = 843.79;
        %data.unspecific_gate = 550;
     case '02_20_racn_dish1'
        data.path = strcat(root, ...
            '02_20_2009\src_mcherry pax_RacN17\1\');
        data.prefix = '1';
        data.prefix_sub = '1_SUB';
        data.index = [1,3:5, 8,9, 11,14:22, 24:25, 28:31, 33:37, 39:47];
        data.fa.brightness_factor =0.2;
        data.fa.filter_size = 61; 
        data.fa.max_water = 400;
        data.fa.min_water = 300;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 5000];
        data.ref_pax_intensity = 99341657;
        data.before_pdgf = 7;
        data.pdgf_time = 393.39;
        data.num_fans = 1;
        %data.unspecific_gate = 550;
     case '02_20_racn_dish2'
        data.path = strcat(root, ...
            '02_20_2009\src_mcherry pax_RacN17\2\');
        data.prefix = '2';
        data.prefix_sub = '2_SUB';
        data.index = [1:6,10, 15:52];
        data.fa.brightness_factor =0.5;
        data.fa.filter_size = 61; 
        data.fa.max_water = 500;
        data.fa.min_water = 200;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity = 77541367;
        data.before_pdgf = 6;
        data.pdgf_time = 337.48;
        %data.unspecific_gate = 550;
        data.num_fans = 1;
     case '02_20_racn_dish3'
        data.path = strcat(root, ...
            '02_20_2009\src_mcherry pax_RacN17\3\');
        data.prefix = '3';
        data.prefix_sub = '3_SUB';
        data.index = [1:8,12,14:16, 18,20:24,26,28:31,36:38,41:42];
        data.fa.brightness_factor =0.7;
        data.fa.filter_size = 61; 
        data.fa.max_water = 450;
        data.fa.min_water = 150;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 700];
        data.ref_pax_intensity = 13470797;
        data.before_pdgf = 6;
        data.pdgf_time = 381.36;
        %data.unspecific_gate = 550;
        data.num_fans = 1;
     case '02_20_racn_dish4'
        data.path = strcat(root, ...
            '02_20_2009\src_mcherry pax_RacN17\4\');
        data.prefix = '4';
        data.prefix_sub = '4_SUB';
        data.index = [4:7,10,12:14, 19:27,30:39];
        data.fa.brightness_factor =0.7;
        data.fa.filter_size = 61; 
        data.fa.max_water = 420;
        data.fa.min_water = 120;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity =  50233612;
        data.before_pdgf = 7;
        data.pdgf_time = 217.21;
        %data.unspecific_gate = 550;
        data.num_fans = 1;
         % '02_20_frnk_dish1'
         %There was some unspecific staining of pax on the glass
         % Did not proceed analyzing experiment
    case '02_20_frnk_dish2'
        data.path = strcat(root, ...
            '02_20_2009\lyn fak_pax_FRNK\2\');
        data.prefix = '2';
        data.prefix_sub = '2_SUB';
        data.index = [2,4:5, 7,9,14:19, 21:22];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 600;
        data.fa.min_water = 300;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 2500];
        data.ref_pax_intensity =  75651717;
        data.before_pdgf = 5;
        data.pdgf_time = 245.32;
        data.unspecific_gate = 550;
    case '02_20_frnk_dish3'
        % It is weired that the cell is switching between
        % two different shape at the last few images in 
        % the time sequence.
        data.path = strcat(root, ...
            '02_20_2009\lyn fak_pax_FRNK\3\');
        data.prefix = '3';
        data.prefix_sub = '3_SUB';
        data.index = [4, 6,8,10, 13,15:21,23:25,27:29,31,33];
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.max_water = 500;
        data.fa.min_water = 200;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity =  71130526;
        data.before_pdgf = 7;
        data.pdgf_time = 333.19;
        data.unspecific_gate = 550;
    case '02_20_frnk_dish4'
        % It is weired that the cell is switching between
        % two different shape at the last few images in 
        % the time sequence.
        data.path = strcat(root, ...
            '02_20_2009\lyn fak_pax_FRNK\4\');
        data.prefix = '4';
        data.prefix_sub = '4_SUB';
        data.index = [1:6,10:11, 19:26];
        data.fa.brightness_factor =0.7;
        data.fa.filter_size = 61; 
        data.fa.max_water = 500;
        data.fa.min_water = 200;
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.pax_cbound = [0 3000];
        data.ref_pax_intensity =  84616571;
        data.before_pdgf = 4;
        data.pdgf_time = 243.21;
        data.unspecific_gate = 550;
        % finished subtract_background
% All the data up to here were stored in 
% root = 'C:\sylu\copy_07_19_2009-xxx\sof\fluocell_2.1\data\';
% root = 'C:\sylu\copy_xxx-06_05_2009\sof\fluocell_2.1\data\';
% The rest of the data are stored in another position
    case '07_18_dish1'
        % very good.
        data.path = strcat(root, ...
            '07_18_2009\RFP_MEF_dish01\');
        data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:6,8:13,15, 17:21, 27:40, 42:48];
        data.fa.max_water = 500; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.pax_cbound = [0 1500];
        data.ref_pax_intensity =  52934933; % total paxillin intensity
        data.before_pdgf = 8;
        data.pdgf_time = 2183.87;
        % data.unspecific_gate = 550;
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.has_yfp = 0;
    case '07_18_dish2'
        % good, need mask.
        data.path = strcat(root, ...
            '07_18_2009\mCherry_MEF_dish02\');
        data.prefix = 'MCHERRY_MEF_02';
        data.prefix_sub = 'MCHERRY_MEF_02_SUB';
        data.index = [1:60];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 11;
        data.pdgf_time = 1000.87;
        data.ref_pax_intensity =  105514249; % total paxillin intensity
        data.fa.max_water = 500; % upper threshold
        data.fa.min_water = 180; % lower threshold
        % data.unspecific_gate = 550;
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
    case '07_18_dish3'
        % good. need mask.
        data.path = strcat(root, ...
            '07_18_2009\mCherry_MEF_dish03\');
                data.prefix = 'MCHERRY_MEF_03';
        data.prefix_sub = 'MCHERRY_MEF_03_SUB';
        data.index = [1:60];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 10;
        data.pdgf_time = 931.84;
        %data.ref_pax_intensity =  271873134; % total paxillin intensity
        data.ref_pax_intensity = 150163189;
        data.fa.max_water = 500; % upper threshold
        data.fa.min_water = 200; % lower threshold
        % data.unspecific_gate = 550;
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
    case '07_18_dish4'
        % good
        data.path = strcat(root, ...
            '07_18_2009\mCherry_MEF_dish04\');
                data.prefix = 'MCHERRY_MEF_04';
        data.prefix_sub = 'MCHERRY_MEF_04_SUB';
        data.index = [1:4,6:7,11:12,20:23,26:27,30:34,37:44];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 7;
        data.pdgf_time = 1025.47;
        %data.ref_pax_intensity =  271873134; % total paxillin intensity
        data.ref_pax_intensity = 295762051;
        data.fa.max_water = 500; % upper threshold
        data.fa.min_water =150; % lower threshold
        % data.unspecific_gate = 550;
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
    case '07_18_dish5'
        % Graph good
        data.path = strcat(root, ...
            '07_18_2009\mCherry_MEF_dish05\');
                data.prefix = 'MCHERRY_MEF_05';
        data.prefix_sub = 'MCHERRY_MEF_05_SUB';
        data.index = [1:9,11:40,42:43,45,47:49];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 16;
        data.pdgf_time = 999.50;
        %data.ref_pax_intensity =  271873134; % total paxillin intensity
        data.ref_pax_intensity = 152399599;
        data.fa.max_water = 500; % upper threshold
        data.fa.min_water =100; % lower threshold
        % data.unspecific_gate = 550;
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
    case '07_18_syf1' % need_mask = 0
        % only part of the cell, not very good.
        data.path = strcat(root, ...
            '07_18_2009\mCherry_SYF_dish01\');
                data.prefix = 'MCHERRY_SYF_01';
        data.prefix_sub = 'MCHERRY_SYF_01_SUB';
        data.index = [1:49];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 9;
        data.pdgf_time = 955.72;
        data.ref_pax_intensity =  179600190; % total paxillin intensity
        data.fa.max_water = 300; % upper threshold
        data.fa.min_water =100; % lower threshold
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        %'07_18_syf2' lost cell after pdgf.
    case '07_18_syf3'
        data.path = strcat(root, ...
            '07_18_2009\mCherry_SYF_dish03\');
                data.prefix = 'MCHERRY_SYF_03';
        data.prefix_sub = 'MCHERRY_SYF_03_SUB';
        data.index = [1:60];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 9;
        data.pdgf_time = 1035.20;
        data.ref_pax_intensity =  232184168; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water =200; % lower threshold
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
    case '07_18_syf4' % cell migrating % 07_18_syf5 lost cell
        data.path = strcat(root, ...
            '07_18_2009\mCherry_SYF_dish04\');
                data.prefix = 'MCHERRY_SYF_04';
        data.prefix_sub = 'MCHERRY_SYF_04_SUB';
        data.index = [1:58];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 7;
        data.pdgf_time = 1226.87;
        data.ref_pax_intensity =  165685778; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water =200; % lower threshold
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
    case '07_28_syf2' % Could not detect FA; cell 3: Src was activated
        data.path = strcat(root, ...
            '07_28_2009\SYF_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:43];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 11;
        data.pdgf_time = 688.66;
        data.ref_pax_intensity =  154852919; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water =200; % lower threshold
        data.fa.brightness_factor =0.7;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
    % 07_22_2009 syf, >50% of the cells responsed to pdgf in Src ratio
    % those may be a bad batch of cells.
    case '07_28_syf4' 
        data.path = strcat(root, ...
            '07_28_2009\SYF_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:7,10:12, 14:48];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 7;
        data.pdgf_time = 528.92;
        data.ref_pax_intensity =  53320112; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water =150; % lower threshold
        data.fa.brightness_factor =0.7;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 2;
    case '07_28_syf5' 
        data.path = strcat(root, ...
            '07_28_2009\SYF_dish05\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:53];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 7;
        data.pdgf_time = 474.21;
        data.ref_pax_intensity =  165176451; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water =150; % lower threshold
        data.fa.brightness_factor =0.6;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;    
    case '07_28_syf6' 
        data.path = strcat(root, ...
            '07_28_2009\SYF_dish06_Cell2\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:48,51:64,67:69];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 9;
        data.pdgf_time = 598.56;
        data.ref_pax_intensity =  307487702; % total paxillin intensity
        data.fa.max_water = 600; % upper threshold
        data.fa.min_water =200; % lower threshold
        data.fa.brightness_factor =0.7;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 1;
    case '08_01_fn10_mef1' 
        data.path = strcat(root, ...
            '08_01_2009\MEF_FN10_dish01\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:66];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 8;
        data.pdgf_time = 520.72;
        data.ref_pax_intensity =  104497929; % total paxillin intensity
        data.fa.max_water = 550; % upper threshold
        data.fa.min_water = 350; % lower threshold
        data.fa.brightness_factor =0.9;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 3;
    case '08_01_fn10_mef2' % low Src response 
        data.path = strcat(root, ...
            '08_01_2009\MEF_FN10_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1,5:12, 15:44];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 8;
        data.pdgf_time = 460.72;
        data.ref_pax_intensity =  70835114; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor =1.0;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 0;
    case '08_01_fn10_mef3' 
        data.path = strcat(root, ...
            '08_01_2009\MEF_FN10_dish03\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:57];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 8;
        data.pdgf_time = 520.72;
        data.ref_pax_intensity =  62187219; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 1;
    case '08_01_fn10_mef4' 
        data.path = strcat(root, ...
            '08_01_2009\MEF_FN10_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:80];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 8;
        data.pdgf_time = 520.72;
        data.ref_pax_intensity =  71903153; % total paxillin intensity
        data.fa.max_water = 450; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor = 0.8;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans =1 ;
    case '08_01_fn10_mef5' 
        data.path = strcat(root, ...
            '08_01_2009\MEF_FN10_dish05\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:50];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 5;
        data.pdgf_time = 317.14;
        data.ref_pax_intensity =  292894281; % total paxillin intensity
        data.fa.max_water = 450; % upper threshold
        data.fa.min_water = 250; % lower threshold
        data.fa.brightness_factor = 0.8;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 3;
    case '08_01_fn5_mef1' 
        data.path = strcat(root, ...
            '08_01_2009\MEF_FN5_dish01\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:50];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 5;
        data.pdgf_time = 338.43;
        data.ref_pax_intensity =  397578309; % total paxillin intensity
        data.fa.max_water = 500; % upper threshold
        data.fa.min_water = 300; % lower threshold
        data.fa.brightness_factor = 0.55;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;   
        data.num_fans = 1;
    case '08_01_fn5_mef2' 
        data.path = strcat(root, ...
            '08_01_2009\MEF_FN5_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:5, 7:15, 17:38];
        data.pax_cbound = [0 1000];
        data.before_pdgf = 6;
        data.pdgf_time = 364.99;
        data.ref_pax_intensity =  42650104; % total paxillin intensity
        data.fa.max_water = 300; % upper threshold
        data.fa.min_water = 100; % lower threshold
        data.fa.brightness_factor = 0.7;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;   
    case '08_01_fn5_mef3' 
        data.path = strcat(root, ...
            '08_01_2009\MEF_FN5_dish03\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:7, 9:36];
        data.pax_cbound = [0 1500];
        data.before_pdgf = 7;
        data.pdgf_time = 398.04;
        data.ref_pax_intensity =  100497509; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 0.6;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 1;
    case '08_01_fn5_mef4' 
        data.path = strcat(root, ...
            '08_01_2009\MEF_FN5_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:6, 10:11, 13:14, 16:17, 19:20, 22, 24:25, 27, ...
            30:33, 36:41];
        data.pax_cbound = [0 800];
        data.before_pdgf = 6;
        data.pdgf_time = 413.38;
        data.ref_pax_intensity =  31393130; % total paxillin intensity
        data.fa.max_water = 270; % upper threshold
        data.fa.min_water = 70; % lower threshold
        data.fa.brightness_factor = 0.55;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 1;
    case '08_01_fn5_mef5' 
        data.path = strcat(root, ...
            '08_01_2009\MEF_FN5_dish05\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:45];
        %data.index = [1:14,22:45];
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5;
        data.pdgf_time = 318.87;
        data.ref_pax_intensity =  70518549; % total paxillin intensity
        data.fa.max_water = 300; % upper threshold
        data.fa.min_water = 100; % lower threshold
        data.fa.brightness_factor = 0.9;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 2;
    case '08_04_mef1' 
        data.path = strcat(root, ...
            '08_04_2009\MEF_dish01\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:49];
        data.pax_cbound = [0 1500];
        data.before_pdgf = 7;
        data.pdgf_time = 431.09;
        data.ref_pax_intensity =  31056077; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor = 0.8;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;   
    case '08_04_mef2' 
        data.path = strcat(root, ...
            '08_04_2009\MEF_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:54];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 6;
        data.pdgf_time = 367.95;
        data.ref_pax_intensity =  147185749; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 0.5;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 1;
    case '08_04_mef3' 
        data.path = strcat(root, ...
            '08_04_2009\MEF_dish03\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [5:12, 14:57, 60, 61, 63];
        data.pax_cbound = [0 1500];
        data.before_pdgf = 7;
        data.pdgf_time = 454.04;
        data.ref_pax_intensity =  43064535; % total paxillin intensity
        data.fa.max_water = 450; % upper threshold
        data.fa.min_water = 250; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 1;
    case '08_04_mef4' 
        data.path = strcat(root, ...
            '08_04_2009\MEF_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:51];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 7;
        data.pdgf_time = 442.82;
        data.ref_pax_intensity =  43358478; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 1.0;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;   
    case '08_04_mef5' 
        data.path = strcat(root, ...
            '08_04_2009\MEF_dish05\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:5,7:50];
        data.pax_cbound = [0 1500];
        data.before_pdgf = 5;
        data.pdgf_time = 357.75;
        data.ref_pax_intensity =  54098618; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor = 1.0;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 3;
    case '08_04_mef6' 
        data.path = strcat(root, ...
            '08_04_2009\MEF_dish06\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:8, 11:27, 29:60];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 6;
        data.pdgf_time = 387.53;
        data.ref_pax_intensity =  96720043; % total paxillin intensity
        data.fa.max_water = 375; % upper threshold
        data.fa.min_water = 175; % lower threshold
        data.fa.brightness_factor = 1.0;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 1;
    case '08_14_mef1' 
        data.path = strcat(root, ...
            '08_14_2009\MEF_dish01\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [4:44];
        %data.index = [2:25,28,38:45];
        data.pax_cbound = [0 1500];
        data.before_pdgf = 8;
        data.pdgf_time = 492.91;
        data.ref_pax_intensity =  38242829; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor = 0.6;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1;
    case '08_14_mef2' 
        data.path = strcat(root, ...
            '08_14_2009\MEF_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:48];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 7;
        data.pdgf_time = 451.75;
        data.ref_pax_intensity =  60419411; % total paxillin intensity
        data.fa.max_water = 450; % upper threshold
        data.fa.min_water = 250; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
    case '08_14_mef3' 
        data.path = strcat(root, ...
            '08_14_2009\MEF_dish03\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:6,8:64];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 6;
        data.pdgf_time = 368.12;
        data.ref_pax_intensity =  33389273; % total paxillin intensity
        data.fa.max_water = 285; % upper threshold
        data.fa.min_water = 85; % lower threshold
        data.fa.brightness_factor = 0.25;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1;
    case '08_14_mef4' %This cell shrank
        data.path = strcat(root, ...
            '08_14_2009\MEF_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:40];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 7;
        data.pdgf_time = 459.64;
        data.ref_pax_intensity =  85217116; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 125; % lower threshold
        data.fa.brightness_factor = 0.8;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
    case '08_14_mef5' % This cell shrank a lot
        data.path = strcat(root, ...
            '08_14_2009\MEF_dish05\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:5, 10:46];
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5;
        data.pdgf_time = 330.37;
        data.ref_pax_intensity =  55208222; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 1;
    case '08_21_mef1' 
        data.path = strcat(root, ...
            '08_21_2009\MEF_SrcKD_dish01\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [2:8,10:43];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 7;
        data.pdgf_time = 477.65;
        data.ref_pax_intensity =  43428474; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
    case '08_21_mef2' 
        data.path = strcat(root, ...
            '08_21_2009\MEF_SrcKD_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:7,9:20,38:55,57:60];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 7;
        data.pdgf_time = 478.75;
        data.ref_pax_intensity =  64256570; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 0.9;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
    case '08_21_mef3' 
        data.path = strcat(root, ...
            '08_21_2009\MEF_SrcKD_dish03\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:10,16:18,25:68];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 5;
        data.pdgf_time = 315.57;
        data.ref_pax_intensity =  143905309; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans= 3;
    case '08_21_mef4' 
        data.path = strcat(root, ...
            '08_21_2009\MEF_SrcKD_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        %data.index = [1:9, 11:15,33:37, 39:49];
        data.index = [1:6,8, 11:17, 19:26, 28:37, 39:49];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 5;
        data.pdgf_time = 332.28;
        data.ref_pax_intensity =  44288084; % total paxillin intensity
        data.fa.max_water = 300; % upper threshold
        data.fa.min_water = 100; % lower threshold
        data.fa.brightness_factor = 0.8;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans =1;
    case '08_21_mef5' 
        data.path = strcat(root, ...
            '08_21_2009\MEF_SrcKD_dish05\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:8,10:12, 16:22,25:45];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 6;
        data.pdgf_time = 368.84;
        data.ref_pax_intensity =  182248597; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 0.6;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50;
        data.num_fans = 1;
    case '08_29_mef1' 
        data.path = strcat(root, ...
            '08_29_2009\MEF_dish01\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:2,4:21,24:29,31:45];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 8;
        data.pdgf_time = 473.14;
        data.ref_pax_intensity =  31747818; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 0 ;
    case '08_29_mef3' 
        data.path = strcat(root, ...
            '08_29_2009\MEF_dish03\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:3,5:8,10,13:20,22:50,53:54,56:71];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 6;
        data.pdgf_time = 353.54;
        data.ref_pax_intensity =  96642235; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 0.7;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 2 ;
    case '08_29_mef4' 
        data.path = strcat(root, ...
            '08_29_2009\MEF_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:6,8,10:23,25:38,40:41,43:45];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 5;
        data.pdgf_time = 339.82;
        data.ref_pax_intensity =  33839360; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 2 ;
    case '08_29_mef5' 
        data.path = strcat(root, ...
            '08_29_2009\MEF_dish05\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1,3:6,8:18,20,23:36];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 6;
        data.pdgf_time = 375.06;
        data.ref_pax_intensity =  64630634; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 125; % lower threshold
        data.fa.brightness_factor = 0.8;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 2 ;
    case '08_29_mef7' 
        data.path = strcat(root, ...
            '08_29_2009\MEF_dish07\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:4,6:7,9:31];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 9;
        data.pdgf_time = 484.76;
        data.ref_pax_intensity =  58178470; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 125; % lower threshold
        data.fa.brightness_factor = 0.8;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 2 ;
    case '08_29_mef8' 
        data.path = strcat(root, ...
            '08_29_2009\MEF_dish08\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:36];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 6;
        data.pdgf_time = 364.74;
        data.ref_pax_intensity =  117109233; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 3 ;
    case '08_29_mef2' % Src did not respond
        data.path = strcat(root, ...
            '08_29_2009\MEF_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:49];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 5;
        data.pdgf_time = 357.95;
        data.ref_pax_intensity =  116160050; % total paxillin intensity
        data.fa.max_water = 450; % upper threshold
        data.fa.min_water = 250; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 4 ;
    case '08_29_mef6' %low Src response
        data.path = strcat(root, ...
            '08_29_2009\MEF_dish06\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:4,6:13,15:32,34:46];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 5;
        data.pdgf_time = 337.37;
        data.ref_pax_intensity =  39605936; % total paxillin intensity
        data.fa.max_water = 300; % upper threshold
        data.fa.min_water = 100; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
       % data.num_fans = 4 ;
    case '09_02_mef1' 
        data.path = strcat(root, ...
            '09_02_2009\MEF_dish01_cell02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:2,4:6,7:8,10:13,15:19,22:32,34:44];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 9;
        data.pdgf_time = 576.70;
        data.ref_pax_intensity =  51468249; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 0.85;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 2 ;
    case '09_02_mef6_NZ' 
        data.path = strcat(root, ...
            '09_02_2009\MEF_NZ_dish06\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:7,9:30,32:52];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 6;
        data.pdgf_time = 410.72;
        data.ref_pax_intensity =  36863478; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 2 ;
    case '09_02_mef7_NZ' 
        data.path = strcat(root, ...
            '09_02_2009\MEF_NZ_dish07\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:6,9:10,12,14:52];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 7;
        data.pdgf_time = 453.08;
        data.ref_pax_intensity =  141813475; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 0.75;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '09_02_mef8_NZ' 
        data.path = strcat(root, ...
            '09_02_2009\MEF_NZ_dish08\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [2,4:11,13:40];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 6;
        data.pdgf_time = 323.35;
        data.ref_pax_intensity =  116203198; % total paxillin intensity
        data.fa.max_water = 375; % upper threshold
        data.fa.min_water = 175; % lower threshold
        data.fa.brightness_factor = 0.8;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
    case '09_02_mef2' 
        data.path = strcat(root, ...
            '09_02_2009\MEF_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1,3:4,6:9,11:20,22:36,38:39,41];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 7;
        data.pdgf_time = 452.03;
        data.ref_pax_intensity =  128005395; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor = 0.75;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 3 ;
    case '09_02_mef3' 
        data.path = strcat(root, ...
            '09_02_2009\MEF_dish03\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:61];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 6;
        data.pdgf_time = 353.06;
        data.ref_pax_intensity =  25354687; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 125; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 3 ;
    case '09_02_mef4' 
        data.path = strcat(root, ...
            '09_02_2009\MEF_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:45];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 8 ;
        data.pdgf_time = 526.16;
        data.ref_pax_intensity =  110257092; % total paxillin intensity
        data.fa.max_water = 700; % upper threshold
        data.fa.min_water = 500; % lower threshold
        data.fa.brightness_factor = 0.8;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 3 ;
    case '09_02_mef5' 
        data.path = strcat(root, ...
            '09_02_2009\MEF_dish05\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:2,4:5,7:9,13:43];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 7 ;
        data.pdgf_time = 382.60;
        data.ref_pax_intensity =  52370824; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor = 0.85;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '09_11_mef1_NZ' 
        data.path = strcat(root, ...
            '09_11_2009\MEF_NZ_dish01\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:2,4:11,13:25,27:30,32:49];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 9 ;
        data.pdgf_time = 612.42;
        data.ref_pax_intensity =  103665807; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor = 0.9;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        % data.num_fans = 1 ;
    case '09_11_mef2_NZ' 
        data.path = strcat(root, ...
            '09_11_2009\MEF_NZ_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:7,9:10,12:45];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 6 ;
        data.pdgf_time = 418.08;
        data.ref_pax_intensity =  34168819; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 2 ;
    case '09_11_mef3_NZ' 
        data.path = strcat(root, ...
            '09_11_2009\MEF_NZ_dish03\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:5,8:10,13:47,49:74];
        data.pax_cbound = [0 1000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 352.66;
        data.ref_pax_intensity =  52769552; % total paxillin intensity
        data.fa.max_water = 270; % upper threshold
        data.fa.min_water = 70; % lower threshold
        data.fa.brightness_factor = 0.85;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '09_11_mef4_NZ' %not include b/c there was some problem with the excitation light
        data.path = strcat(root, ...
            '09_11_2009\MEF_NZ_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:51];
        data.pax_cbound = [0 1500];
        data.before_pdgf = 8 ;
        data.pdgf_time = 520.76;
        data.ref_pax_intensity =  26764211; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        % data.num_fans = 1 ;
    case '09_11_mef5_NZ' 
        data.path = strcat(root, ...
            '09_11_2009\MEF_NZ_dish05\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:7,10:43];
        data.pax_cbound = [0 1500];
        data.before_pdgf = 6 ;
        data.pdgf_time = 411.64;
        data.ref_pax_intensity =  40641808; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 0.9;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 2 ;
    case '09_11_mef6_NZ' 
        data.path = strcat(root, ...
            '09_11_2009\MEF_NZ_dish06\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:52];
        data.pax_cbound = [0 2000];
        data.before_pdgf = 6 ;
        data.pdgf_time = 386.84;
        data.ref_pax_intensity =  115491117; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 2 ;
    case '09_16_mef1' 
        data.path = strcat(root, ...
            '09_16_2009\MEF_dish1_FN20\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:5,8:12,14:21,23:26,28:34,36:50];
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 369.77;
        data.ref_pax_intensity =  47026891; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 2 ;
    case '09_16_mef2' 
        data.path = strcat(root, ...
            '09_16_2009\MEF_dish2_FN20\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:2,4:9,12:24,29:41:43:45,47:53];
        data.pax_cbound = [0 2000];
        data.before_pdgf = 7 ;
        data.pdgf_time = 427.21;
        data.ref_pax_intensity =  60323680; % total paxillin intensity
        data.fa.max_water = 300; % upper threshold
        data.fa.min_water = 100; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 2 ;
    case '09_16_mef3' 
        data.path = strcat(root, ...
            '09_16_2009\MEF_dish3_FN20\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:14,18,20:40,42:43,46:49,51,55:84];
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 339.87;
        data.ref_pax_intensity =  40337657; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 125; % lower threshold
        data.fa.brightness_factor = 0.9;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 2 ;
    case '09_16_mef4' 
        data.path = strcat(root, ...
            '09_16_2009\MEF_dish4_FN20\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:7,9:12,14:23,25:29,32:40,42:48,50:62];
        data.pax_cbound = [0 1000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 335.26;
        data.ref_pax_intensity =  19000697; % total paxillin intensity
        data.fa.max_water = 275; % upper threshold
        data.fa.min_water = 75; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 2 ;
    case '09_16_mef5_NZ' 
        data.path = strcat(root, ...
            '09_16_2009\MEF_dish5_NZ\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:58];
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 320.68;
        data.ref_pax_intensity =  34670830; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 125; % lower threshold
        data.fa.brightness_factor = 0.75;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 2 ;
    case '09_16_mef6_NZ' 
        data.path = strcat(root, ...
            '09_16_2009\MEF_dish6_NZ\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:65];
        data.pax_cbound = [0 2000];
        data.before_pdgf = 6 ;
        data.pdgf_time = 338.66;
        data.ref_pax_intensity =  103730026; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 2 ;
    case '09_22_mef1' 
        data.path = strcat(root, ...
            '09_22_2009\MEF_dish01\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:13,15:24,27:29,31:46];
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 418.45;
        data.ref_pax_intensity =  119917049; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 125; % lower threshold
        data.fa.brightness_factor = 0.9;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 2 ;
    case '09_22_mef2' 
        data.path = strcat(root, ...
            '09_22_2009\MEF_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:5,7:8,10,12:19,44:54,56:72];
        data.pax_cbound = [0 1500];
        data.before_pdgf = 5 ;
        data.pdgf_time = 357.8;
        data.ref_pax_intensity =  68946933; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 125; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 2 ;
    case '09_22_mef3' 
        data.path = strcat(root, ...
            '09_22_2009\MEF_dish03\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:7,9:46];
        data.pax_cbound = [0 1500];
        data.before_pdgf = 5 ;
        data.pdgf_time = 347.71;
        data.ref_pax_intensity =  63283068; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 0.9;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '09_22_mef4' 
        data.path = strcat(root, ...
            '09_22_2009\MEF_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1,3:9,11:13,15:45];
        data.pax_cbound = [0 1000];
        data.before_pdgf = 7 ;
        data.pdgf_time = 432.16;
        data.ref_pax_intensity =  32255773; % total paxillin intensity
        data.fa.max_water = 275; % upper threshold
        data.fa.min_water = 75; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
       % data.num_fans = 1 ;
    case '09_22_mef5' 
        data.path = strcat(root, ...
            '09_22_2009\MEF_dish05\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:45];
        data.pax_cbound = [0 1000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 329.46;
        data.ref_pax_intensity =  39886863; % total paxillin intensity
        data.fa.max_water = 265; % upper threshold
        data.fa.min_water = 65; % lower threshold
        data.fa.brightness_factor = 0.85;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
       % data.num_fans = 1 ;
    case '09_22_mef6' 
        data.path = strcat(root, ...
            '09_22_2009\MEF_dish06\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:41];
        data.pax_cbound = [0 3000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 323.11;
        data.ref_pax_intensity =  79908740; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor = 0.8;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 3 ;
    case '09_22_mef7' 
        data.path = strcat(root, ...
            '09_22_2009\MEF_dish07\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:40];
        data.pax_cbound = [0 1000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 320.11;
        data.ref_pax_intensity =  46020511; % total paxillin intensity
        data.fa.max_water = 300; % upper threshold
        data.fa.min_water = 100; % lower threshold
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '09_22_mef8' 
        data.path = strcat(root, ...
            '09_22_2009\MEF_dish08\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:5,7,9:13,15:33];
        data.pax_cbound = [0 1000];
        data.before_pdgf = 4 ;
        data.pdgf_time = 257.39;
        data.ref_pax_intensity =  32644821; % total paxillin intensity
        data.fa.max_water = 275; % upper threshold
        data.fa.min_water = 75; % lower threshold
        data.fa.brightness_factor = 0.85;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '10_14_mef1' 
        data.path = strcat(root, ...
            '10_14_2009\MEF_dish01\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:4,6:7,9,13:15,17:19,21:45];
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 351.75;
        data.ref_pax_intensity =  95052196; % total paxillin intensity
        data.fa.max_water = 300; % upper threshold
        data.fa.min_water = 100; % lower threshold
        data.fa.brightness_factor = 0.9 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 2 ;
    case '10_14_mef2' 
        data.path = strcat(root, ...
            '10_14_2009\MEF_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:6,8:10,12:18,25:53,55:57];
        data.pax_cbound = [0 1200];
        data.before_pdgf = 5 ;
        data.pdgf_time = 369.71;
        data.ref_pax_intensity =  70516736; % total paxillin intensity
        data.fa.max_water = 275; % upper threshold
        data.fa.min_water = 75; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '10_14_mef3' 
        data.path = strcat(root, ...
            '10_14_2009\MEF_dish03\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:58];
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 369.71;
        data.ref_pax_intensity =  210261560; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor = 0.7 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
    case '10_14_mef4' 
        data.path = strcat(root, ...
            '10_14_2009\MEF_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:42];
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 330.14;
        data.ref_pax_intensity =  120543832; % total paxillin intensity
        data.fa.max_water = 400; % upper threshold
        data.fa.min_water = 200; % lower threshold
        data.fa.brightness_factor = 0.65 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '10_14_mef5' 
        data.path = strcat(root, ...
            '10_14_2009\MEF_dish05\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1, 3, 5:6,8:9,12:13,16:17,19,23:24, 26:38, 40:43];
        data.pax_cbound = [0 1000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 354.83;
        data.ref_pax_intensity =  25291442; % total paxillin intensity
        data.fa.max_water = 250; % upper threshold
        data.fa.min_water = 50; % lower threshold
        data.fa.brightness_factor = 0.8;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
    case '10_14_mef6' 
        data.path = strcat(root, ...
            '10_14_2009\MEF_dish06\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:7,9,11:18,20:30,32:35,38:41,43:44];
        data.pax_cbound = [0 1500];
        data.before_pdgf = 5 ;
        data.pdgf_time = 330.79;
        data.ref_pax_intensity =  44781244; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 125; % lower threshold
        data.fa.brightness_factor = 0.65;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '10_14_mef7' 
        data.path = strcat(root, ...
            '10_14_2009\MEF_dish07\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:6,8,11:14,16:45];
        data.pax_cbound = [0 1000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 332.94;
        data.ref_pax_intensity =  37075426; % total paxillin intensity
        data.fa.max_water = 275; % upper threshold
        data.fa.min_water = 75; % lower threshold
        data.fa.brightness_factor = 0.85;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
       % data.num_fans = 1 ;
    case '10_22_mef1' 
        data.path = strcat(root, ...
            '10_22_2009\MEF_dish01\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:46];
        data.pax_cbound = [0 1000];
        data.before_pdgf = 7 ;
        data.pdgf_time = 449.72;
        data.ref_pax_intensity =  37173497; % total paxillin intensity
        data.fa.max_water = 300; % upper threshold
        data.fa.min_water = 100; % lower threshold
        data.fa.brightness_factor = 0.9;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '10_22_mef2' 
        data.path = strcat(root, ...
            '10_22_2009\MEF_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:6,8:48];
        data.pax_cbound = [0 1500];
        data.before_pdgf = 6 ;
        data.pdgf_time = 363.82;
        data.ref_pax_intensity =  86454302; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 0.8;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '10_22_mef3' 
        data.path = strcat(root, ...
            '10_22_2009\MEF_dish03\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:9,11,14:24,28:51];
        data.pax_cbound = [0 1500];
        data.before_pdgf = 5 ;
        data.pdgf_time = 320.00 ;
        data.ref_pax_intensity =  26816090; % total paxillin intensity
        data.fa.max_water = 300; % upper threshold
        data.fa.min_water = 100; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
    case '10_22_mef4' 
        data.path = strcat(root, ...
            '10_22_2009\MEF_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:5,7:9,11:30,32:35,37:38,41:44,46:49] ;
        data.pax_cbound = [0 1500];
        data.before_pdgf = 6 ;
        data.pdgf_time = 392.38 ;
        data.ref_pax_intensity =  83180771; % total paxillin intensity
        data.fa.max_water = 300; % upper threshold
        data.fa.min_water = 100; % lower threshold
        data.fa.brightness_factor = 0.8 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
    case '10_22_mef5' 
        data.path = strcat(root, ...
            '10_22_2009\MEF_dish05\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [2:34,36:39] ;
        data.pax_cbound = [0 1000];
        data.before_pdgf = 6 ;
        data.pdgf_time = 410.16 ;
        data.ref_pax_intensity =  14110485; % total paxillin intensity
        data.fa.max_water = 300; % upper threshold
        data.fa.min_water = 100; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
    case '10_22_mef6' 
        data.path = strcat(root, ...
            '10_22_2009\MEF_dish06\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:2,5,7,9:34,36:43] ;
        data.pax_cbound = [0 1500];
        data.before_pdgf = 6 ;
        data.pdgf_time = 363.56 ;
        data.ref_pax_intensity =  29988850; % total paxillin intensity
        data.fa.max_water = 300; % upper threshold
        data.fa.min_water = 100; % lower threshold
        data.fa.brightness_factor = 0.9 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
    case '10_22_mef7' 
        data.path = strcat(root, ...
            '10_22_2009\MEF_dish07\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:2,4:5,7:40] ;
        data.pax_cbound = [0 1500];
        data.before_pdgf = 5 ;
        data.pdgf_time = 335.68 ;
        data.ref_pax_intensity =  41512024; % total paxillin intensity
        data.fa.max_water = 315; % upper threshold
        data.fa.min_water = 115; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '10_30_mef2' 
        % Out of focus from 17~34 and 43~47
        data.path = strcat(root, ...
            '10_30_2009\MEF_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:14,16,35:42,48:50] ;
        data.pax_cbound = [0 1500];
        data.before_pdgf = 6 ;
        data.pdgf_time = 365.48 ;
        data.ref_pax_intensity =  11067422; % total paxillin intensity
        data.fa.max_water = 335; % upper threshold
        data.fa.min_water = 135; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
       % data.num_fans = 1 ;
    case '10_30_mef3' 
        data.path = strcat(root, ...
            '10_30_2009\MEF_dish03\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:7,9:10,12:39,41:45] ;
        data.pax_cbound = [0 1500];
        data.before_pdgf = 5 ;
        data.pdgf_time = 322.22 ;
        data.ref_pax_intensity =  34030681; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 125; % lower threshold
        data.fa.brightness_factor = 0.85 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '10_30_mef4' 
        data.path = strcat(root, ...
            '10_30_2009\MEF_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1,3:10,12:27,29:48] ;
        data.pax_cbound = [0 1500];
        data.before_pdgf = 6 ;
        data.pdgf_time = 369.83 ;
        data.ref_pax_intensity =  75937342; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 125; % lower threshold
        data.fa.brightness_factor = 0.9 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '10_30_mef5' 
        data.path = strcat(root, ...
            '10_30_2009\MEF_dish05\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [4:49] ;
        data.pax_cbound = [0 1500];
        data.before_pdgf = 8 ;
        data.pdgf_time = 519.28 ;
        data.ref_pax_intensity =  63580391; % total paxillin intensity
        data.fa.max_water = 350; % upper threshold
        data.fa.min_water = 150; % lower threshold
        data.fa.brightness_factor = 0.75 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '10_30_mef6' 
        data.path = strcat(root, ...
            '10_30_2009\MEF_dish06\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [2:10,12:48] ;
        data.pax_cbound = [0 1500];
        data.before_pdgf = 5 ;
        data.pdgf_time = 319.75 ;
        data.ref_pax_intensity =  29113662; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 125; % lower threshold
        data.fa.brightness_factor = 0.85 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '01_11_mef1' 
        data.path = strcat(root, ...
            '01_11_2010\MEF_dish01\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:5,7:21,23:37,39:43] ;
        data.pax_cbound = [0 800];
        data.before_pdgf = 6 ;
        data.pdgf_time = 406.35 ;
        data.ref_pax_intensity =  14997583; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 50; % lower threshold
        data.fa.brightness_factor = 0.85 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '01_11_mef2' 
        data.path = strcat(root, ...
            '01_11_2010\MEF_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:14,16:21,23:25,29,31:34,36:43,46:47] ;
        data.pax_cbound = [0 2000];
        data.before_pdgf = 6 ;
        data.pdgf_time = 381.46 ;
        data.ref_pax_intensity =  64822607; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 90; % lower threshold
        data.fa.brightness_factor = 0.85 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 2 ;
    case '01_11_mef3' 
        data.path = strcat(root, ...
            '01_11_2010\MEF_dish03\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [2:3,5:6,8,10,12:13,16:20,22:25,27:31,35,41] ;
        data.pax_cbound = [0 1200];
        data.before_pdgf = 6 ;
        data.pdgf_time = 408.40 ;
        data.ref_pax_intensity =  33887013; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 60; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
       % data.num_fans = 2 ;
    case '01_11_mef4' 
        data.path = strcat(root, ...
            '01_11_2010\MEF_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:13,17:34,38:39] ;
        data.pax_cbound = [0 1000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 341.18 ;
        data.ref_pax_intensity =  19835693; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 45 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
       % data.num_fans = 2 ;
    case '01_11_mef5' 
        data.path = strcat(root, ...
            '01_11_2010\MEF_dish05\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:8,10,13:39] ;
        data.pax_cbound = [0 1500];
        data.before_pdgf = 6 ;
        data.pdgf_time = 404.52 ;
        data.ref_pax_intensity =  23262202; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 125 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
       % data.num_fans = 2 ;
    case '01_11_mef6' 
        data.path = strcat(root, ...
            '01_11_2010\MEF_dish06\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:2,4:21,23:43] ;
        data.pax_cbound = [0 1200];
        data.before_pdgf = 7 ;
        data.pdgf_time = 447.00 ;
        data.ref_pax_intensity =  54993226; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 55 ; % lower threshold
        data.fa.brightness_factor = 0.85 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
       % data.num_fans = 2 ;
    case '01_11_mef7' 
        data.path = strcat(root, ...
            '01_11_2010\MEF_dish07\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1,5:7,10:25,27:35] ;
        data.pax_cbound = [0 1200];
        data.before_pdgf = 7 ;
        data.pdgf_time = 428.28 ;
        data.ref_pax_intensity =  48179124; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 65 ; % lower threshold
        data.fa.brightness_factor = 0.9 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '01_22_mef1' 
        data.path = strcat(root, ...
            '01_22_2010\MEF_FN2_dish01\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:69] ;
        data.pax_cbound = [0 13000];
        data.before_pdgf = 6 ;
        data.pdgf_time = 537.16 ;
        data.ref_pax_intensity =  706191971; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 2500 ; % lower threshold
        data.fa.brightness_factor = 0.9 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '01_22_mef2' 
        data.path = strcat(root, ...
            '01_22_2010\MEF_FN2_dish02\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:2,6:7,11,15:25,27:52] ;
        data.pax_cbound = [0 750];
        data.before_pdgf = 6 ;
        data.pdgf_time = 557.44 ;
        data.ref_pax_intensity =  20803402; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 60 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
    case '01_22_mef3' 
        data.path = strcat(root, ...
            '01_22_2010\MEF_FN2_dish03\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:60] ;
        data.pax_cbound = [0 5000];
        data.before_pdgf = 7 ;
        data.pdgf_time = 576.38 ;
        data.ref_pax_intensity =  137695884; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 300 ; % lower threshold
        data.fa.brightness_factor = 0.8 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '01_22_mef4' 
        data.path = strcat(root, ...
            '01_22_2010\MEF_FN2_dish04\');
                data.prefix = 'FRET';
        data.prefix_sub = 'FRET_SUB';
        data.index = [1:4,6:9,12:14,16:22,24:51] ;
        data.pax_cbound = [0 750];
        data.before_pdgf = 8 ;
        data.pdgf_time = 634.48 ;
        data.ref_pax_intensity =  29714011; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 60 ; % lower threshold
        data.fa.brightness_factor = 0.75 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
    case '01_22_mef5' 
        data.path = strcat(root, ...
            '01_22_2010\MEF_FN2_dish05\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [5,7,12,18:20,25,29:34,36,39:40] ;
        data.pax_cbound = [0 5000];
        data.before_pdgf = 8 ;
        data.pdgf_time = 584.20 ;
        data.ref_pax_intensity =  105600797; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 350 ; % lower threshold
        data.fa.brightness_factor = 0.65 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '01_28_mef1' 
        data.path = strcat(root, ...
            '01_28_2010\MEF_dish01\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:16,21:40,42:54] ;
        data.pax_cbound = [0 5000];
        data.before_pdgf = 9 ;
        data.pdgf_time = 746.16 ;
        data.ref_pax_intensity =  217157155; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 550 ; % lower threshold
        data.fa.brightness_factor = 1.0 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '01_28_mef3' 
        data.path = strcat(root, ...
            '01_28_2010\MEF_dish03\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:19,24:41,43:48,51:52] ;
        data.pax_cbound = [0 5000];
        data.before_pdgf = 6 ;
        data.pdgf_time = 559.51 ;
        data.ref_pax_intensity =  79279208; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 450 ; % lower threshold
        data.fa.brightness_factor = 0.9 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '01_28_mef4' 
        data.path = strcat(root, ...
            '01_28_2010\MEF_dish04\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:52] ;
        data.pax_cbound = [0 5000];
        data.before_pdgf = 7 ;
        data.pdgf_time = 605.32 ;
        data.ref_pax_intensity =  134382206; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 450 ; % lower threshold
        data.fa.brightness_factor = 0.7 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
        % data.num_fans = 1 ;
    case '01_28_mef5' 
        data.path = strcat(root, ...
            '01_28_2010\MEF_dish05\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:45] ;
        data.pax_cbound = [0 6000];
        data.before_pdgf = 8 ;
        data.pdgf_time = 667.51 ;
        data.ref_pax_intensity =  169316040; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 450 ; % lower threshold
        data.fa.brightness_factor = 0.9 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '01_28_mef6' 
        data.path = strcat(root, ...
            '01_28_2010\MEF_dish06\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:17,19:22,25:45] ;
        data.pax_cbound = [0 6000];
        data.before_pdgf = 7 ;
        data.pdgf_time = 637.73 ;
        data.ref_pax_intensity =  297494758; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 450 ; % lower threshold
        data.fa.brightness_factor = 0.5 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
        % data.num_fans = 1 ;
    case '01_28_mef7' 
        data.path = strcat(root, ...
            '01_28_2010\MEF_dish07\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:45] ;
        data.pax_cbound = [0 10000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 453.80 ;
        data.ref_pax_intensity =  369723045; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 500 ; % lower threshold
        data.fa.brightness_factor = 0.6 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '02_01_mef1' 
        data.path = strcat(root, ...
            '02_01_2010\MEF_dish01\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:54] ;
        data.pax_cbound = [0 3000];
        data.before_pdgf = 6 ;
        data.pdgf_time = 439.70 ;
        data.ref_pax_intensity =  50561361; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 250 ; % lower threshold
        data.fa.brightness_factor = 0.5 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
      %  data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '02_01_mef2' 
        data.path = strcat(root, ...
            '02_01_2010\MEF_dish02\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:64] ;
        data.pax_cbound = [0 5000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 366.54 ;
        data.ref_pax_intensity =  202227820; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 700 ; % lower threshold
        data.fa.brightness_factor = 0.85 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '02_01_mef3' 
        data.path = strcat(root, ...
            '02_01_2010\MEF_dish03\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:37,40:42,44,46:47,49,51:53,55,58:63,65:66] ;
        data.pax_cbound = [0 4000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 377.88 ;
        data.ref_pax_intensity =  119344031; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 600 ; % lower threshold
        data.fa.brightness_factor = 0.7 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
       % data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '02_01_mef4' 
        data.path = strcat(root, ...
            '02_01_2010\MEF_dish04\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:67] ;
        data.pax_cbound = [0 4000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 345.02 ;
        data.ref_pax_intensity =  124951214; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 550 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '02_01_mef5' 
        data.path = strcat(root, ...
            '02_01_2010\MEF_dish05\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:55] ;
        data.pax_cbound = [0 15000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 332.43 ;
        data.ref_pax_intensity =  748993910; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 1400 ; % lower threshold
        data.fa.brightness_factor = 0.9 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
       % data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '02_01_mef6' 
        data.path = strcat(root, ...
            '02_01_2010\MEF_dish06\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:22,24:32,34:42,44:45] ;
        data.pax_cbound = [0 3000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 348.38 ;
        data.ref_pax_intensity =  70192659; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 150 ; % lower threshold
        data.fa.brightness_factor = 0.7 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 3 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '02_09_FN2_mef1' 
        data.path = strcat(root, ...
            '02_09_2010\MEF_FN2_dish01\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:48] ;
        data.pax_cbound = [0 5000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 348.38 ;
        data.ref_pax_intensity =  245447410; % total paxillin intensity
        data.fa.max_water = 325; % upper threshold
        data.fa.min_water = 600 ; % lower threshold
        data.fa.brightness_factor = 0.75 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '03_02_control1' 
        data.path = strcat(root, ...
            '03_02_2010\MEF_FN10_control\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:42] ;
        data.pax_cbound = [0 3000];
        data.before_pdgf = 7 ;
        data.pdgf_time = 461.72 ;
        data.ref_pax_intensity =  56640968; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 200 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '03_02_control2' 
        data.path = strcat(root, ...
            '03_02_2010\MEF_FN10_control2\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:8,10:14,16:36] ;
        data.pax_cbound = [0 2500];
        data.before_pdgf = 6 ;
        data.pdgf_time = 431.48 ;
        data.ref_pax_intensity =  111983107; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 150 ; % lower threshold
        data.fa.brightness_factor = 0.35 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '03_10_control1' 
        data.path = strcat(root, ...
            '03_10_2010\MEF_control1\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:21,24:44] ;
        data.pax_cbound = [0 1000];
        data.before_pdgf = 6 ;
        data.pdgf_time = 433.20 ;
        data.ref_pax_intensity =  18538280; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 100 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
       % data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '03_10_control2' 
        data.path = strcat(root, ...
            '03_10_2010\MEF_control2\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:43,45] ;
        data.pax_cbound = [0 1500];
        data.before_pdgf = 7 ;
        data.pdgf_time = 470.49 ;
        data.ref_pax_intensity =  27824394; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 125 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
       % data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_13_FN10_dish01' 
        data.path = strcat(root, ...
            '04_13_2010\MEF_FN10_dish01\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:71] ;
        data.pax_cbound = [0 3000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 345.94 ;
        data.ref_pax_intensity =  58362269; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 200 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_13_FN10_dish02' 
        data.path = strcat(root, ...
            '04_13_2010\MEF_FN10_dish02\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:57] ;
        data.pax_cbound = [0 3000];
        data.before_pdgf = 6 ;
        data.pdgf_time = 411.69 ;
        data.ref_pax_intensity =  163646608; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 250 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_13_FN10_dish03' 
        data.path = strcat(root, ...
            '04_13_2010\MEF_FN10_dish03\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:53] ;
        data.pax_cbound = [0 3000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 363.12 ;
        data.ref_pax_intensity =  62027524; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 150 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_13_FN10_dish04' 
        data.path = strcat(root, ...
            '04_13_2010\MEF_FN10_dish04\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:5,7:40] ;
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 354.99 ;
        data.ref_pax_intensity =  48080368; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 150 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_13_FN10_dish06' 
        data.path = strcat(root, ...
            '04_13_2010\MEF_FN10_dish06\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:30,32:36,38:41] ;
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 329.48 ;
        data.ref_pax_intensity =  27683699; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 150 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_14_FN10_dish01' 
        data.path = strcat(root, ...
            '04_14_2010\MEF_FN10_dish01\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:49] ;
        data.pax_cbound = [0 1000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 323.80 ;
        data.ref_pax_intensity =  18092686; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 75 ; % lower threshold
        data.fa.brightness_factor = 1.1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_13_FN10_control01' 
        data.path = strcat(root, ...
            '04_13_2010\MEF_control01\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:9,11:16,29:33,38:39] ;
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 423.63 ;
        data.ref_pax_intensity =  52539672; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 125 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_13_FN10_control02' 
        data.path = strcat(root, ...
            '04_13_2010\MEF_control02\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:36] ;
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 347.60 ;
        data.ref_pax_intensity =  42272899; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 125 ; % lower threshold
        data.fa.brightness_factor = 0.95 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_14_FN10_control01' 
        data.path = strcat(root, ...
            '04_14_2010\MEF_control1\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:7,9:35] ;
        data.pax_cbound = [0 1000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 354.95 ;
        data.ref_pax_intensity =  18878033; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 75 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_21_FN10_control01' 
        data.path = strcat(root, ...
            '04_21_2010\MEF_control1\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:44] ;
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 357.10 ;
        data.ref_pax_intensity =  34576609; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 125 ; % lower threshold
        data.fa.brightness_factor = 0.9 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_21_FN10_mef1' 
        data.path = strcat(root, ...
            '04_21_2010\MEF_dish01\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:56] ;
        data.pax_cbound = [0 5000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 331.60 ;
        data.ref_pax_intensity =  196824528; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 300 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_21_FN10_mef2' 
        data.path = strcat(root, ...
            '04_21_2010\MEF_dish02\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:61] ;
        data.pax_cbound = [0 5000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 381.47 ;
        data.ref_pax_intensity =  167834490; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 250 ; % lower threshold
        data.fa.brightness_factor = 0.9 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_21_FN10_mef3' 
        data.path = strcat(root, ...
            '04_21_2010\MEF_dish03\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:54] ;
        data.pax_cbound = [0 3000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 343.73 ;
        data.ref_pax_intensity =  53561034; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 200 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_21_FN10_mef4' 
        data.path = strcat(root, ...
            '04_21_2010\MEF_dish04\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:55] ;
        data.pax_cbound = [0 4000];
        data.before_pdgf = 6 ;
        data.pdgf_time = 401.07 ;
        data.ref_pax_intensity =  143360122; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 250 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_21_FN10_mef5' 
        data.path = strcat(root, ...
            '04_21_2010\MEF_dish05\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:45] ;
        data.pax_cbound = [0 1000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 327.68 ;
        data.ref_pax_intensity =  22498967; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 100 ; % lower threshold
        data.fa.brightness_factor = 0.8 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_21_FN10_mef6' 
        data.path = strcat(root, ...
            '04_21_2010\MEF_dish06\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:39] ;
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 332.47 ;
        data.ref_pax_intensity =  47044997; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 150 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_21_FN10_mef7' 
        data.path = strcat(root, ...
            '04_21_2010\MEF_dish07\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:6,8:12,14:49] ;
        data.pax_cbound = [0 4000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 330.40 ;
        data.ref_pax_intensity =  222304835; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 250 ; % lower threshold
        data.fa.brightness_factor = 0.9 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_28_FN10_control1' 
        data.path = strcat(root, ...
            '04_28_2010\MEF_control01\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:49,51:54] ;
        data.pax_cbound = [0 4000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 329.96 ;
        data.ref_pax_intensity =  91423477; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 200 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_28_FN10_control2' 
        data.path = strcat(root, ...
            '04_28_2010\MEF_control02\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:2,4,6,9,11,15,17,20,22:23,26,28:31,34:35,37:41,43:59] ;
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 336.68 ;
        data.ref_pax_intensity =  33595019; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 200 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_28_FN10_control3' 
        data.path = strcat(root, ...
            '04_28_2010\MEF_control03\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:50] ;
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 340.18 ;
        data.ref_pax_intensity =  47165093; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 125 ; % lower threshold
        data.fa.brightness_factor = 0.85 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        %data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_28_FN10_control4' 
        data.path = strcat(root, ...
            '04_28_2010\MEF_control04\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:54] ;
        data.pax_cbound = [0 3000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 321.20 ;
        data.ref_pax_intensity =  85095436; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 200 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_28_FN10_control5' 
        data.path = strcat(root, ...
            '04_28_2010\MEF_control05\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:13,18:25,31:41] ;
        data.pax_cbound = [0 4000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 360.16 ;
        data.ref_pax_intensity =  160768757; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 300 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_28_FN10_mef1' 
        data.path = strcat(root, ...
            '04_28_2010\MEF_dish01\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:50] ;
        data.pax_cbound = [0 4000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 333.73 ;
        data.ref_pax_intensity =  155287190; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 300 ; % lower threshold
        data.fa.brightness_factor = 0.9 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 2 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_14_FN2_mef1' 
        data.path = strcat(root, ...
            '04_14_2010\MEF_FN2_dish01\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:53] ;
        data.pax_cbound = [0 1000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 365.83 ;
        data.ref_pax_intensity =  36150327; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 100 ; % lower threshold
        data.fa.brightness_factor = 0.95 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    case '04_14_FN2_mef2' 
        data.path = strcat(root, ...
            '04_14_2010\MEF_FN2_dish02\');
                data.prefix = 'FLUOR';
        data.prefix_sub = 'FLUOR_SUB';
        data.index = [1:54] ;
        data.pax_cbound = [0 2000];
        data.before_pdgf = 5 ;
        data.pdgf_time = 346.43 ;
        data.ref_pax_intensity =  57138889; % total paxillin intensity
        data.fa.max_water = 125; % upper threshold
        data.fa.min_water = 125 ; % lower threshold
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.fa.min_area = 50; 
        data.num_fans = 1 ;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 3;
    % Yi's data from the Nikon microscope
    % multiple acquisition and the file names are different.
    case '07_20_2s1'
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_20_2010_RacV12_fn25\2\p1\');
        data.path_all = {data.path,
            strcat(root, '07_20_2010_RacV12_fn25\2\pdgf\p1\')};
        data.first_cfp_file_all = {'fret5_w2CFP_s1_t1.TIF''fret5_w2CFP_s1_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10, 1:51};
        data.threshold = 0.0015;
        data.pax_cbound = [0 300];
        data.ref_pax_intensity =  6431572; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_fans = 2 ;
        data.num_layer = 3;
%         batch_detect_cell_bws('07_20_2s1' 'save_file' 0, 'image_index' {1,[]},...
% 'cbound' [1 200]);
% batch_detect_fa_labels('07_20_2s1' 'save_file' 1);
%
    case '07_20_2s2'
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_20_2010_RacV12_fn25\2\p2\');
        data.path_all = {data.path,
            strcat(root, '07_20_2010_RacV12_fn25\2\pdgf\p2\')};
        data.first_cfp_file_all = {'fret5_w2CFP_s2_t1.TIF''fret5_w2CFP_s2_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10, 1:51};
        data.threshold = 0.0025;
        data.pax_cbound = [0 300];
        data.ref_pax_intensity =  5747092; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_fans = 3 ;
        data.num_layer = 5;
    case '07_20_2s3'
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_20_2010_RacV12_fn25\2\p3\');
        data.path_all = {data.path, strcat(root, '07_20_2010_RacV12_fn25\2\pdgf\p3\')};
        data.first_cfp_file_all = {'fret5_w2CFP_s3_t1.TIF''fret5_w2CFP_s3_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10, 1:51};
        data.threshold = 0.007;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity =  19856338; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_fans = 1 ;
        data.num_layer = 5;
    case '07_20_2s4'
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_20_2010_RacV12_fn25\2\p4\');
        data.path_all = {data.path,
            strcat(root, '07_20_2010_RacV12_fn25\2\pdgf\p4\')};
        data.first_cfp_file_all = {'fret5_w2CFP_s4_t1.TIF''fret5_w2CFP_s4_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10, 1:51};
        data.threshold = 0.007;
        data.pax_cbound = [0 800];
        data.ref_pax_intensity =  77682940; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_fans = 1;
        data.num_layer = 5;
    case '07_20_2s5'
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_20_2010_RacV12_fn25\2\p5\');
        data.path_all = {data.path,
            strcat(root, '07_20_2010_RacV12_fn25\2\pdgf\p5\')};
        data.first_cfp_file_all = {'fret5_w2CFP_s5_t1.TIF''fret5_w2CFP_s5_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10, 1:51};
        data.threshold = 0.004;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity =  19510221; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_fans = 1;
        data.num_layer = 5;
    case '07_29_1s1'
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_29_2010_RacV12_fn25\1\s1\');
        data.path_all = {data.path,
            strcat(root, '07_29_2010_RacV12_fn25\1\+pdgf\s1\')};
        data.first_cfp_file_all = {'fret6_w2CFP_s1_t1.TIF''fret6_w2CFP_s1_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10, 1:51};
        data.threshold = 0.002; 
        data.pax_cbound = [0 400];
        data.ref_pax_intensity =  11044123; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_fans = 3;
        data.num_layer = 5;
        data.need_mask = 1;
    case '07_29_1s2'
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_29_2010_RacV12_fn25\1\s2\');
        data.path_all = {data.path,
            strcat(root, '07_29_2010_RacV12_fn25\1\+pdgf\s2\')};
        data.first_cfp_file_all = {'fret6_w2CFP_s2_t1.TIF''fret6_w2CFP_s2_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10, 1:51};
        data.threshold = 0.0045; 
        data.pax_cbound = [0 400];
        data.ref_pax_intensity =  10811674; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_fans = 2;
        data.num_layer = 5;
    case '07_29_1s3'
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_29_2010_RacV12_fn25\1\s3\');
        data.path_all = {data.path,
            strcat(root, '07_29_2010_RacV12_fn25\1\+pdgf\s3\')};
        data.first_cfp_file_all = {'fret6_w2CFP_s3_t1.TIF''fret6_w2CFP_s3_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10, 1:45, 47:51};
        data.threshold = 0.0015; 
        data.pax_cbound = [0 200];
        data.ref_pax_intensity =  4919036; % total paxillin intensity
        data.fa.min_water = 10 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_fans = 2;
        data.num_layer = 5;
        data.need_mask = 1;
    case '07_29_1s4'
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_29_2010_RacV12_fn25\1\s4\');
        data.path_all = {data.path,
            strcat(root, '07_29_2010_RacV12_fn25\1\+pdgf\s4\')};
        data.first_cfp_file_all = {'fret6_w2CFP_s4_t1.TIF''fret6_w2CFP_s4_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10, 1:51};
        data.threshold = 0.004; 
        data.pax_cbound = [0 400];
        data.ref_pax_intensity =  12626104; % total paxillin intensity
        data.fa.min_water = 10 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
    case '07_29_1s5' % image too dim cannot detect cell well
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_29_2010_RacV12_fn25\1\s5\');
        data.path_all = {data.path,
            strcat(root, '07_29_2010_RacV12_fn25\1\+pdgf\s5\')};
        data.first_cfp_file_all = {'fret6_w2CFP_s5_t1.TIF''fret6_w2CFP_s5_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10, 1:51};
        data.threshold = 0.001; 
        data.need_mask = 1;
        data.pax_cbound = [0 200];
        data.ref_pax_intensity =  12626104; % total paxillin intensity
        data.fa.min_water = 10 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
    case '07_29_2s1' 
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_29_2010_RacV12_fn25\2\s1\');
        data.path_all = {data.path,
            strcat(root, '07_29_2010_RacV12_fn25\2\+pdgf\s1\')};
        data.first_cfp_file_all = {'fret6_w2CFP_s1_t1.TIF''fret6_w2CFP_s1_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:30};
        data.threshold = 0.0025; 
        data.pax_cbound = [0 200];
        data.ref_pax_intensity =  7055414; % total paxillin intensity
        data.fa.min_water = 10 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
    case '07_29_2s2' 
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_29_2010_RacV12_fn25\2\s2\');
        data.path_all = {data.path,
            strcat(root, '07_29_2010_RacV12_fn25\2\+pdgf\s2\')};
        data.first_cfp_file_all = {'fret6_w2CFP_s2_t1.TIF''fret6_w2CFP_s2_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:30};
        data.threshold = 0.003; 
        data.pax_cbound = [0 200];
        data.ref_pax_intensity =  7336510; % total paxillin intensity
        data.fa.min_water = 10 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
    case '07_29_2s3' 
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_29_2010_RacV12_fn25\2\s3\');
        data.path_all = {data.path,
            strcat(root, '07_29_2010_RacV12_fn25\2\+pdgf\s3\')};
        data.first_cfp_file_all = {'fret6_w2CFP_s3_t1.TIF''fret6_w2CFP_s3_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1, 3, 5, 7:30};
        data.threshold = 0.035;
        data.need_mask = 1;
        data.pax_cbound = [0 2000];
        data.ref_pax_intensity =  43332975; % total paxillin intensity
        data.fa.min_water = 100 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
    case '07_29_2s4' 
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_29_2010_RacV12_fn25\2\s4\');
        data.path_all = {data.path,
            strcat(root, '07_29_2010_RacV12_fn25\2\+pdgf\s4\')};
        data.first_cfp_file_all = {'fret6_w2CFP_s4_t1.TIF''fret6_w2CFP_s4_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:30};
        data.threshold = 0.005;
        data.need_mask = 0;
        data.pax_cbound = [0 300];
        data.ref_pax_intensity =  11609619; % total paxillin intensity
        data.fa.min_water = 10 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
    case '07_29_2s5' 
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_29_2010_RacV12_fn25\2\s5\');
        data.path_all = {data.path,
            strcat(root, '07_29_2010_RacV12_fn25\2\+pdgf\s5\')};
        data.first_cfp_file_all = {'fret6_w2CFP_s5_t1.TIF''fret6_w2CFP_s5_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:30};
        data.threshold = 0.005;
        data.need_mask = 0;
        data.pax_cbound = [0 300];
        data.ref_pax_intensity =  36996565; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
    case '07_29_3s3' 
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_29_2010_RacV12_fn25\3\s3\');
        data.path_all = {data.path,
            strcat(root, '07_29_2010_RacV12_fn25\3\+pdgf\s3\')};
        data.first_cfp_file_all = {'fret6_w2CFP_s3_t1.TIF''fret6_w2CFP_s3_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:46};
        data.threshold = 0.0035;
        data.need_mask = 0;
        data.pax_cbound = [0 300];
        data.ref_pax_intensity =  3789310; % total paxillin intensity
        data.fa.min_water = 40 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 4;
    case '07_29_3s4' 
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_29_2010_RacV12_fn25\3\s4\');
        data.path_all = {data.path,
            strcat(root, '07_29_2010_RacV12_fn25\3\+pdgf\s4\')};
        data.first_cfp_file_all = {'fret6_w2CFP_s4_t1.TIF''fret6_w2CFP_s4_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:46};
        data.threshold = 0.0035;
        data.need_mask = 1;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity =  16667840; % total paxillin intensity
        data.fa.min_water = 40 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 3;
    case '07_29_3s5' 
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_29_2010_RacV12_fn25\3\s5\');
        data.path_all = {data.path,
            strcat(root, '07_29_2010_RacV12_fn25\3\+pdgf\s5\')};
        data.first_cfp_file_all = {'fret6_w2CFP_s5_t1.TIF''fret6_w2CFP_s5_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:46};
        data.threshold = 0.007;
        data.need_mask = 0;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity =  27519090; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
    case '07_29_3s6' 
        data.multiple_acquisition = 1;
        data.path = strcat(root, '07_29_2010_RacV12_fn25\3\s6\');
        data.path_all = {data.path,
            strcat(root, '07_29_2010_RacV12_fn25\3\+pdgf\s6\')};
        data.first_cfp_file_all = {'fret6_w2CFP_s6_t1.TIF''fret6_w2CFP_s6_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:46};
        data.threshold = 0.0055;
        data.need_mask = 0;
        data.pax_cbound = [0 400];
        data.ref_pax_intensity =  12864776; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
     % 08_06_1s1 fret 10 1:10, 1:51, [1 500], [1 500]
     case '08_06_1s1' 
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_06_2010_RacV12_fn20\1\s1\');
        data.path_all = {data.path,
            strcat(root, '08_06_2010_RacV12_fn20\1\+pdgf\s1\')};
        data.first_cfp_file_all = {'fret10_w2CFP_s1_t1.TIF''fret10_w2CFP_s1_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:10, 1:51};
        data.threshold = 0.008;
        data.need_mask = 0;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity =  16486545; % total paxillin intensity
        data.fa.min_water = 50 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
     case '08_06_1s2' 
         % [0 500]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_06_2010_RacV12_fn20\1\s2\');
        data.path_all = {data.path,
            strcat(root, '08_06_2010_RacV12_fn20\1\+pdgf\s2\')};
        data.first_cfp_file_all = {'fret10_w2CFP_s2_t1.TIF''fret10_w2CFP_s2_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:10, 1:51};
        data.threshold = 0.002;
        data.need_mask = 0;
        data.pax_cbound = [0 200];
        data.ref_pax_intensity =  2741622; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
     case '08_06_1s3' 
         % [0 5000]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_06_2010_RacV12_fn20\1\s3\');
        data.path_all = {data.path,
            strcat(root, '08_06_2010_RacV12_fn20\1\+pdgf\s3\')};
        data.first_cfp_file_all = {'fret10_w2CFP_s3_t1.TIF''fret10_w2CFP_s3_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:10, 1:51};
        data.threshold = 0.03;
        data.need_mask = 0;
        data.pax_cbound = [0 1600];
        data.ref_pax_intensity =  81621820; % total paxillin intensity
        data.fa.min_water = 80 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
     case '08_06_1s5' 
         % [0 1000]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_06_2010_RacV12_fn20\1\s5\');
        data.path_all = {data.path,
            strcat(root, '08_06_2010_RacV12_fn20\1\+pdgf\s5\')};
        data.first_cfp_file_all = {'fret10_w2CFP_s5_t1.TIF''fret10_w2CFP_s5_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:10, 1:51};
        data.threshold = 0.01;
        data.need_mask = 0;
        data.pax_cbound = [0 800];
        data.ref_pax_intensity =  28280305; % total paxillin intensity
        data.fa.min_water = 60 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
     case '08_06_1s6' 
         % [0 1800]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_06_2010_RacV12_fn20\1\s6\');
        data.path_all = {data.path,
            strcat(root, '08_06_2010_RacV12_fn20\1\+pdgf\s6\')};
        data.first_cfp_file_all = {'fret10_w2CFP_s6_t1.TIF''fret10_w2CFP_s6_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:10, 1:51};
        data.threshold = 0.01;
        data.need_mask = 0;
        data.pax_cbound = [0 700];
        data.ref_pax_intensity =  33120114; % total paxillin intensity
        data.fa.min_water = 40 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 3;
     case '08_06_2s1' 
         % [0 800]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_06_2010_RacV12_fn20\2\s1\');
        data.path_all = {data.path,
            strcat(root, '08_06_2010_RacV12_fn20\2\+pdgf\s1\')};
        data.first_cfp_file_all = {'fret10_w2CFP_s1_t1.TIF''fret10_w2CFP_s1_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:10, 1:51};
        data.threshold = 0.003;
        data.need_mask = 0;
        data.pax_cbound = [0 200];
        data.ref_pax_intensity =  8013025; % total paxillin intensity
        data.fa.min_water = 15 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
     case '08_06_2s2' 
         % [0 4000]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_06_2010_RacV12_fn20\2\s2\');
        data.path_all = {data.path,
            strcat(root, '08_06_2010_RacV12_fn20\2\+pdgf\s2\')};
        data.first_cfp_file_all = {'fret10_w2CFP_s2_t1.TIF''fret10_w2CFP_s2_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:10, 1:51};
        data.threshold = 0.05;
        data.need_mask = 1;
        data.pax_cbound = [0 4000];
        data.ref_pax_intensity =  166584952; % total paxillin intensity
        data.fa.min_water = 120 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
     case '08_06_2s3' 
         % [0 500]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_06_2010_RacV12_fn20\2\s3\');
        data.path_all = {data.path,
            strcat(root, '08_06_2010_RacV12_fn20\2\+pdgf\s3\')};
        data.first_cfp_file_all = {'fret10_w2CFP_s3_t1.TIF''fret10_w2CFP_s3_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:10, 1:51};
        data.threshold = 0.004;
        data.need_mask = 0;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity =  11515319; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
     case '08_06_2s4' 
         % [0 200]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_06_2010_RacV12_fn20\2\s4\');
        data.path_all = {data.path,
            strcat(root, '08_06_2010_RacV12_fn20\2\+pdgf\s4\')};
        data.first_cfp_file_all = {'fret10_w2CFP_s4_t1.TIF''fret10_w2CFP_s4_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:10, 1:51};
        data.threshold = 0.0025;
        data.need_mask = 1;
        data.pax_cbound = [0 200];
        data.ref_pax_intensity =  6159042; % total paxillin intensity
        data.fa.min_water = 15 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
     case '08_06_2s5' 
         % [0 300]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_06_2010_RacV12_fn20\2\s5\');
        data.path_all = {data.path,
            strcat(root, '08_06_2010_RacV12_fn20\2\+pdgf\s5\')};
        data.first_cfp_file_all = {'fret10_w2CFP_s5_t1.TIF''fret10_w2CFP_s5_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:10, 1:51};
        data.threshold = 0.0025;
        data.need_mask = 1;
        data.pax_cbound = [0 300];
        data.ref_pax_intensity =  4696689; % total paxillin intensity
        data.fa.min_water = 15 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
     case '08_06_2s6' 
         % [0 400]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_06_2010_RacV12_fn20\2\s6\');
        data.path_all = {data.path,
            strcat(root, '08_06_2010_RacV12_fn20\2\+pdgf\s6\')};
        data.first_cfp_file_all = {'fret10_w2CFP_s6_t1.TIF''fret10_w2CFP_s6_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:10, 1:51};
        data.threshold = 0.0025;
        data.need_mask = 0;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity =  7347395; % total paxillin intensity
        data.fa.min_water = 15 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
     case '08_19_fn25_1s1'  %RacV12_fn25
         % [0 200]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn2.5\1\s1\');
        data.path_all = {data.path, ...
            strcat(root, '08_19_2010\fn2.5\1\+pdgf\s1\'), strcat(root, '08_19_2010\fn2.5\1\+pdgf\s1\2\')};
        data.first_cfp_file_all = {'dish4-2_w2CFP_s1_t1.TIF''dish4-2_w2CFP_s1_t1.TIF'...
            'dish4-3_w2CFP_s1_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:7, 1:20, 1:20};
        data.threshold = 0.004;
        data.need_mask = 0;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity =  14150110; % total paxillin intensity
        data.fa.min_water = 30 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
     case '08_19_fn25_1s2'  
         % [0 100]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn2.5\1\s2\');
        data.path_all = {data.path, ...
            strcat(root, '08_19_2010\fn2.5\1\+pdgf\s2\'),...
            strcat(root, '08_19_2010\fn2.5\1\+pdgf\s2\2\')};
        data.first_cfp_file_all = {'dish4-2_w2CFP_s2_t1.TIF'...
            'dish4-2_w2CFP_s2_t1.TIF'...
            'dish4-3_w2CFP_s2_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {[1:3], 1:24, 1:20};
        % pdgf time occurs between 1st acquisition, image 7 
        % and 2nd acquisition, image 1 
        data.time_before_after = [ 1 7; 2 1];
        data.threshold = 0.002;
        data.need_mask = 0;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity =  6307724; % total paxillin intensity
        data.fa.min_water = 30 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
     case '08_19_fn25_1s3'  
         % [0 100]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn2.5\1\s3\');
        data.path_all = {data.path, ...
            strcat(root, '08_19_2010\fn2.5\1\+pdgf\s3\'), strcat(root, '08_19_2010\fn2.5\1\+pdgf\s3\2\')};
        data.first_cfp_file_all = {'dish4-2_w2CFP_s3_t1.TIF''dish4-2_w2CFP_s3_t1.TIF'...
            'dish4-3_w2CFP_s3_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {[1:4, 6], [1:4, 6:24], [1:5, 7:20]};
        data.time_before_after = [1 7; 2 1];
        data.threshold = 0.0015;
        data.need_mask = 1;
        data.pax_cbound = [0 400];
        data.ref_pax_intensity =  5980038; % total paxillin intensity
        data.fa.min_water = 30 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 4;
     case '08_19_fn25_1s5'  
         % [0 1000]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn2.5\1\s5\');
        data.path_all = {data.path, ...
            strcat(root, '08_19_2010\fn2.5\1\+pdgf\s5\'), strcat(root, '08_19_2010\fn2.5\1\+pdgf\s5\2\')};
        data.first_cfp_file_all = {'dish4-2_w2CFP_s5_t1.TIF''dish4-2_w2CFP_s5_t1.TIF'...
            'dish4-3_w2CFP_s5_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:7, 1:19, 5:19};
        data.threshold = 0.008;
        data.need_mask = 0;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity =  194106425; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
     case '08_19_fn25_1s6'  
         % [0 100]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn2.5\1\s6\');
        data.path_all = {data.path, ...
            strcat(root, '08_19_2010\fn2.5\1\+pdgf\s6\'), ...
            strcat(root, '08_19_2010\fn2.5\1\+pdgf\s6\2\')};
        data.first_cfp_file_all = {'dish4-2_w2CFP_s6_t1.TIF' ...
            'dish4-2_w2CFP_s6_t1.TIF' ...
            'dish4-3_w2CFP_s6_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:7, 8:24, 1:7};
        data.time_before_after = [1 7; 2 1];
        data.threshold = 0.002;
        data.need_mask = 0;
        data.pax_cbound = [0 300];
        data.ref_pax_intensity =  14412822; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
     case '08_19_fn25_2s2'  
         % [0 500]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn2.5\2\s2\');
        data.path_all = {data.path, ...
            strcat(root, '08_19_2010\fn2.5\2\+pdgf\s1\')};
        data.first_cfp_file_all = {'dish4-3_w2CFP_s2_t1.TIF' ...
            'dish4-3_w2CFP_s1_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {3:8, 1:51};
        data.threshold = 0.007;
        data.need_mask = 0;
        data.pax_cbound = [0 800];
        data.ref_pax_intensity =  46257873; % total paxillin intensity
        data.fa.min_water = 40 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 3;
     case '08_19_fn25_2s3'  
         % [0 200]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn2.5\2\s3\');
        data.path_all = {data.path, ...
            strcat(root, '08_19_2010\fn2.5\2\+pdgf\s2\')};
        data.first_cfp_file_all = {'dish4-3_w2CFP_s3_t1.TIF' ...
            'dish4-3_w2CFP_s2_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:8, 1:51};
        data.threshold = 0.004;
        data.need_mask = 1;
        data.pax_cbound = [0 750];
        data.ref_pax_intensity =  30417102; % total paxillin intensity
        data.fa.min_water = 40 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
     case '08_19_fn25_2s4'  % [0 500]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn2.5\2\s4\');
        data.path_all = {data.path, ...
            strcat(root, '08_19_2010\fn2.5\2\+pdgf\s3\')};
        data.first_cfp_file_all = {'dish4-3_w2CFP_s4_t1.TIF' ...
            'dish4-3_w2CFP_s3_t1.TIF'};
        data.cfp_channel = {'w2CFP'}; data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'}; data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:8, 1:51};
        data.threshold = 0.008;
        data.need_mask = 0;
        data.pax_cbound = [0 1200];
        data.ref_pax_intensity =  99344663; % total paxillin intensity
        data.fa.min_water = 40 ; 
        data.fa.brightness_factor = 1; data.fa.filter_size = 61; 
        data.fa.single_min_area = 30; data.num_layer = 2.5;
        data.num_fans = 1;
     case '08_19_fn25_2s5'  % [0 700]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn2.5\2\s5\');
        data.path_all = {data.path, ...
            strcat(root, '08_19_2010\fn2.5\2\+pdgf\s4\')};
        data.first_cfp_file_all = {'dish4-3_w2CFP_s5_t1.TIF' ...
            'dish4-3_w2CFP_s4_t1.TIF'};
        data.cfp_channel = {'w2CFP'}; data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'}; data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:8, 1:46};
        data.threshold = 0.006;
        data.need_mask = 0;
        data.pax_cbound = [0 800];
        data.ref_pax_intensity =  87369028; % total paxillin intensity
        data.fa.min_water = 50 ; 
        data.fa.brightness_factor = 1; data.fa.filter_size = 61; 
        data.fa.single_min_area = 30; data.num_layer = 5;
        data.num_fans = 2;
     case '08_19_fn25_2s6'  % [0 100]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn2.5\2\s6\');
        data.path_all = {data.path, ...
            strcat(root, '08_19_2010\fn2.5\2\+pdgf\s5\')};
        data.first_cfp_file_all = {'dish4-3_w2CFP_s6_t1.TIF' ...
            'dish4-3_w2CFP_s5_t1.TIF'};
        data.cfp_channel = {'w2CFP'}; data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'}; data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:8, [1:15, 17:41, 43:48, 50:51]};
        data.threshold = 0.0015;
        data.need_mask = 0;
        data.pax_cbound = [0 400];
        data.ref_pax_intensity =  7141833; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1; data.fa.filter_size = 61; 
        data.fa.single_min_area = 30; data.num_layer = 5;
        data.num_fans = 3;
     case '08_19_fn25_2s7'  % [0 80]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn2.5\2\s7\');
        data.path_all = {data.path, ...
            strcat(root, '08_19_2010\fn2.5\2\+pdgf\s6\')};
        data.first_cfp_file_all = {'dish4-3_w2CFP_s7_t1.TIF' ...
            'dish4-3_w2CFP_s6_t1.TIF'};
        data.cfp_channel = {'w2CFP'}; data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'}; data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:8, 1:51};
        data.threshold = 0.0008;
        data.need_mask = 1;
        data.pax_cbound = [0 200];
        data.ref_pax_intensity =  3912049; % total paxillin intensity
        data.fa.min_water = 15 ; 
        data.fa.brightness_factor = 1; data.fa.filter_size = 61; 
        data.fa.single_min_area = 30; data.num_layer = 5;
        data.num_fans = 1;

        
        
      case '08_19_fn20_1s2'  % RacV12 FN20
         % [0 200]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn20\1\s2\');
        data.path_all = {data.path, ...
            strcat(root, '08_19_2010\fn20\1\+pdgf\s2\1\'), ...
            strcat(root, '08_19_2010\fn20\1\+pdgf\s2\')};
        data.first_cfp_file_all = {'dish4-3_w2CFP_s2_t1.TIF' ...
            'dish4-3_w2CFP_s2_t1.TIF' ...
            'dish4-4_w2CFP_s2_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:7, 1:2, 1:50};
        data.time_before_after = [ 1 8; 2 1];
        data.threshold = 0.0045;
        data.need_mask = 1;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity =  20267486; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '08_19_fn20_1s3'  % RacV12 FN20 s6-s3
         % [0 100]
        data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn20\1\s6\');
        data.path_all = {data.path, ...
            strcat(root, '08_19_2010\fn20\1\+pdgf\s3\1\'), ...
            strcat(root, '08_19_2010\fn20\1\+pdgf\s3\')};
        data.first_cfp_file_all = {'dish4-3_w2CFP_s6_t1.TIF' ...
            'dish4-3_w2CFP_s3_t1.TIF' ...
            'dish4-4_w2CFP_s3_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:8, 1:2, 1:51};
        data.threshold = 0.0025;
        data.need_mask = 0;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity =  28191193; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      %case '08_19_fn20_1s4'  % RacV12 FN20 s7-s4
      % did not analyze since the the cells could not be detected
      % correctly
%          % [0 100]
%         data.multiple_acquisition = 3;
%         data.path = strcat(root, '08_19_2010\fn20\1\s7\');
%         data.path_all = {data.path, ...
%             strcat(root, '08_19_2010\fn20\1\+pdgf\s4\1\'), ...
%             strcat(root, '08_19_2010\fn20\1\+pdgf\s4\')};
%         data.first_cfp_file_all = {'dish4-3_w2CFP_s7_t1.TIF' ...
%             'dish4-3_w2CFP_s4_t1.TIF' ...
%             'dish4-4_w2CFP_s4_t1.TIF'};
%       data.pax_cbound = [0 400];
      case '08_19_fn20_1s5'  % ??-s5 
          % cannot be used for CC analysis because the PDGF time was
          % not correct
         % [0 100]
         data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn20\1\+pdgf\s5\1\');
        data.path_all = {data.path, strcat(root, '08_19_2010\fn20\1\+pdgf\s5\')};
        data.first_cfp_file_all = {'dish4-3_w2CFP_s5_t1.TIF' ...
            'dish4-4_w2CFP_s5_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:2, 1:51};
        data.threshold = 0.002;
        data.need_mask = 0;
        data.pax_cbound = [0 300];
        data.ref_pax_intensity =  7295794; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '08_19_fn20_2s1'  
         % [0 100]
         data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn20\2\s1\');
        data.path_all = {data.path, strcat(root, '08_19_2010\fn20\2\+pdgf\s1\1\'), ...
            strcat(root, '08_19_2010\fn20\2\+pdgf\s1\')};
        data.first_cfp_file_all = {'dish4-4_w2CFP_s1_t1.TIF' ...
            'dish4-4_w2CFP_s1_t1.TIF' 'dish4-5_w2CFP_s1_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {[3, 4, 6, 8:15], [1:2,4:5], [2, 3, 5:8, 12:15, 18:20, 22:23, 30:31]};
        % data.time_before_after = [1 15; 2 1];
        data.threshold = 0.0015;
        data.need_mask = 0;
        data.pax_cbound = [0 400];
        data.ref_pax_intensity =  3815265; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '08_19_fn20_2s2'  
         % [0 100]
         data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn20\2\s2\');
        data.path_all = {data.path, strcat(root, '08_19_2010\fn20\2\+pdgf\s2\1\'), ...
            strcat(root, '08_19_2010\fn20\2\+pdgf\s2\')};
        data.first_cfp_file_all = {'dish4-4_w2CFP_s2_t1.TIF' ...
            'dish4-4_w2CFP_s2_t1.TIF' 'dish4-5_w2CFP_s2_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:15, [1:3, 5:13], [1:3, 5:10, 12:19, 21:35]};
        data.threshold = 0.0015;
        data.need_mask = 0;
        data.pax_cbound = [0 400];
        data.ref_pax_intensity =  20787829; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '08_19_fn20_2s3'  
         % [0 500]
         data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn20\2\s3\');
        data.path_all = {data.path, strcat(root, '08_19_2010\fn20\2\+pdgf\s3\1\'), ...
            strcat(root, '08_19_2010\fn20\2\+pdgf\s3\')};
        data.first_cfp_file_all = {'dish4-4_w2CFP_s3_t1.TIF' ...
            'dish4-4_w2CFP_s3_t1.TIF' 'dish4-5_w2CFP_s3_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:15, 1:13, 1:35};
        data.threshold = 0.007;
        data.need_mask = 0;
        data.pax_cbound = [0 800];
        data.ref_pax_intensity =  48145321; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '08_19_fn20_2s4'  
         % [0 80]
         data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn20\2\s4\');
        data.path_all = {data.path, strcat(root, '08_19_2010\fn20\2\+pdgf\s4\1\'), ...
            strcat(root, '08_19_2010\fn20\2\+pdgf\s4\')};
        data.first_cfp_file_all = {'dish4-4_w2CFP_s4_t1.TIF' ...
            'dish4-4_w2CFP_s4_t1.TIF' 'dish4-5_w2CFP_s4_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {[1:13,15], [2:9, 11, 13], [1,2,4:6, 8:16, 18:19, 21:26, 28:31]};
        data.time_before_after = [1 15; 2 1];
        data.threshold = 0.001;
        data.need_mask = 0;
        data.pax_cbound = [0 200];
        data.ref_pax_intensity =  7154116; % total paxillin intensity
        data.fa.min_water = 15 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '08_19_fn20_2s5'  
         % [0 100]
         data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn20\2\s5\');
        data.path_all = {data.path, strcat(root, '08_19_2010\fn20\2\+pdgf\s5\1\'), ...
            strcat(root, '08_19_2010\fn20\2\+pdgf\s5\')};
        data.first_cfp_file_all = {'dish4-4_w2CFP_s5_t1.TIF' ...
            'dish4-4_w2CFP_s5_t1.TIF' 'dish4-5_w2CFP_s5_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:15, 1:13, [1:9, 11:15, 17:35]};
        data.threshold = 0.0015;
        data.need_mask = 0;
        data.pax_cbound = [0 500];
        data.ref_pax_intensity =  9726208; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '08_19_fn20_2s6'  
         % [0 100]
         data.multiple_acquisition = 1;
        data.path = strcat(root, '08_19_2010\fn20\2\s6\');
        data.path_all = {data.path, strcat(root, '08_19_2010\fn20\2\+pdgf\s6\1\'), ...
            strcat(root, '08_19_2010\fn20\2\+pdgf\s6\')};
        data.first_cfp_file_all = {'dish4-4_w2CFP_s6_t1.TIF' ...
            'dish4-4_w2CFP_s6_t1.TIF' 'dish4-5_w2CFP_s6_t1.TIF'};
        data.cfp_channel = {'w2CFP'};
        data.yfp_channel = {'w1FRET'};
        data.pax_channel = {'w4MCherry-dim'};
        data.index_pattern = {'_t1.' '_t%d.'};
        data.index = {1:15, [1, 3:4, 6:13], 1:35};
        data.threshold = 0.0015;
        data.need_mask = 0;
        data.pax_cbound = [0 400];
        data.ref_pax_intensity =  9599203; % total paxillin intensity
        data.fa.min_water = 20 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
% RhoV14
      case '11_11_RhoV14_1p1'  
         data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\1\p1\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\1\p1\after_1\'), ...
            strcat(root, '11_11_2010\RhoV14\1\p1\after_2\'),...
            strcat(root, '11_11_2010\RhoV14\1\p1\after_3\')};
        data.first_cfp_file_all = {'dish1_w1CFP_s1_t1.TIF' ...
            'dish1-after PDGF_w1CFP_s1_t1.TIF' 'dish1-after PDGF-2_w1CFP_s1_t1.TIF'...
            'dish1-after PDGF-3_w1CFP_s1_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,1:5, [1:28, 30:31], 1:20}; % removed seqence2: 6-7, seq3:32-34
        data.threshold = 0.11;
        data.need_mask = 0;
        data.pax_cbound = [0 9000];
        data.ref_pax_intensity =  368671565; % total paxillin intensity
        data.fa.min_water = 450 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '11_11_RhoV14_1p2'  
         data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\1\p2\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\1\p2\after_1\'), ...
            strcat(root, '11_11_2010\RhoV14\1\p2\after_2\'),...
            strcat(root, '11_11_2010\RhoV14\1\p2\after_3\')};
        data.first_cfp_file_all = {'dish1_w1CFP_s2_t1.TIF' ...
            'dish1-after PDGF_w1CFP_s2_t1.TIF' 'dish1-after PDGF-2_w1CFP_s2_t1.TIF'...
            'dish1-after PDGF-3_w1CFP_s2_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,1:7, 1:34, 1:20}; 
        data.threshold = 0.16;
        data.need_mask = 0;
        data.pax_cbound = [0 12000];
        data.ref_pax_intensity =  645093262; % total paxillin intensity
        data.fa.min_water = 800 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '11_11_RhoV14_1p3'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\1\p3\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\1\p3\after_1\'), ...
            strcat(root, '11_11_2010\RhoV14\1\p3\after_2\'),...
            strcat(root, '11_11_2010\RhoV14\1\p3\after_3\')};
        data.first_cfp_file_all = {'dish1_w1CFP_s3_t1.TIF' ...
            'dish1-after PDGF_w1CFP_s3_t1.TIF' 'dish1-after PDGF-2_w1CFP_s3_t1.TIF'...
            'dish1-after PDGF-3_w1CFP_s3_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,1:7, 1:2, 1:20}; % remove seq3: 3-34
        data.threshold = 0.08;
        data.need_mask = 0;
        data.pax_cbound = [0 9000];
        data.ref_pax_intensity =  304956489; % total paxillin intensity
        data.fa.min_water = 500 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '11_11_RhoV14_1p4'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\1\p4\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\1\p4\after_1\'), ...
            strcat(root, '11_11_2010\RhoV14\1\p4\after_2\'),...
            strcat(root, '11_11_2010\RhoV14\1\p4\after_3\')};
        data.first_cfp_file_all = {'dish1_w1CFP_s4_t1.TIF' ...
            'dish1-after PDGF_w1CFP_s4_t1.TIF' 'dish1-after PDGF-2_w1CFP_s4_t1.TIF'...
            'dish1-after PDGF-3_w1CFP_s4_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,1:5, [1:11,18:34], 1:20}; % removed: seq2: 6-7; seq3: 12:17.  
        data.threshold = 0.04;
        data.need_mask = 0;
        data.pax_cbound = [0 5000];
        data.ref_pax_intensity =  283628108; % total paxillin intensity
        data.fa.min_water = 250 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '11_11_RhoV14_1p5'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\1\p5\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\1\p5\after_1\'), ...
            strcat(root, '11_11_2010\RhoV14\1\p5\after_2\'),...
            strcat(root, '11_11_2010\RhoV14\1\p5\after_3\')};
        data.first_cfp_file_all = {'dish1_w1CFP_s5_t1.TIF' ...
            'dish1-after PDGF_w1CFP_s5_t1.TIF' 'dish1-after PDGF-2_w1CFP_s5_t1.TIF'...
            'dish1-after PDGF-3_w1CFP_s5_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,1:7, 1:29, 1:20}; %Removed seq3:30-34
        data.threshold = 0.4;
        data.need_mask = 0;
        data.pax_cbound = [0 30000];
        data.ref_pax_intensity =  1.2636e+009; % total paxillin intensity
        data.fa.min_water = 2000 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '11_11_RhoV14_1p6'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\1\p6\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\1\p6\after_1\'), ...
            strcat(root, '11_11_2010\RhoV14\1\p6\after_2\'),...
            strcat(root, '11_11_2010\RhoV14\1\p6\after_3\')};
        data.first_cfp_file_all = {'dish1_w1CFP_s6_t1.TIF' ...
            'dish1-after PDGF_w1CFP_s6_t1.TIF' 'dish1-after PDGF-2_w1CFP_s6_t1.TIF'...
            'dish1-after PDGF-3_w1CFP_s6_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,1:7, 1:29, 1:20}; % Removed seq3: 30-34
        data.threshold = 0.2;
        data.need_mask = 0;
        data.pax_cbound = [0 20000];
        data.ref_pax_intensity =  692291201; % total paxillin intensity
        data.fa.min_water = 1400 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '11_11_RhoV14_1p7'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\1\p7\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\1\p7\after_1\'), ...
            strcat(root, '11_11_2010\RhoV14\1\p7\after_2\'),...
            strcat(root, '11_11_2010\RhoV14\1\p7\after_3\')};
        data.first_cfp_file_all = {'dish1_w1CFP_s7_t1.TIF' ...
            'dish1-after PDGF_w1CFP_s7_t1.TIF' 'dish1-after PDGF-2_w1CFP_s7_t1.TIF'...
            'dish1-after PDGF-3_w1CFP_s7_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,1:7, 1:33, 1:20}; % Removed Seq3:34
        data.threshold = 0.13;
        data.need_mask = 0;
        data.pax_cbound = [0 15000];
        data.ref_pax_intensity =  554433268; % total paxillin intensity
        data.fa.min_water = 1200 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '11_11_RhoV14_1p8'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\1\p8\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\1\p8\after_1\'), ...
            strcat(root, '11_11_2010\RhoV14\1\p8\after_2\'),...
            strcat(root, '11_11_2010\RhoV14\1\p8\after_3\')};
        data.first_cfp_file_all = {'dish1_w1CFP_s8_t1.TIF' ...
            'dish1-after PDGF_w1CFP_s8_t1.TIF' 'dish1-after PDGF-2_w1CFP_s8_t1.TIF'...
            'dish1-after PDGF-3_w1CFP_s8_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,1:7, [1,3:7,9:18, 20:34], [1:2,5]}; % Removed Seq3: 2 8 19; Seq4:6-20
        data.threshold = 0.08;
        data.need_mask = 0;
        data.pax_cbound = [0 10000];
        data.ref_pax_intensity =  292176074; % total paxillin intensity
        data.fa.min_water = 600 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '11_11_RhoV14_2p1'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\2\p1\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\2\p1\after\')};
        data.first_cfp_file_all = {'dish2_w1CFP_s1_t1.TIF' ...
            'dish2-after PDGF_w1CFP_s1_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,1:51}; % 
        data.threshold = 0.025;
        data.need_mask = 0;
        data.pax_cbound = [0 3000];
        data.ref_pax_intensity =  133329487; % total paxillin intensity
        data.fa.min_water = 200 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '11_11_RhoV14_2p2'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\2\p2\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\2\p2\after\')};
        data.first_cfp_file_all = {'dish2_w1CFP_s2_t1.TIF' ...
            'dish2-after PDGF_w1CFP_s2_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,[1:38, 42:47, 50]}; %Removed seq2:39-41,48-49, 51 
        data.threshold = 0.2;
        data.need_mask = 0;
        data.pax_cbound = [0 20000];
        data.ref_pax_intensity =  1.4968e+009; % total paxillin intensity
        data.fa.min_water = 1500 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '11_11_RhoV14_2p3'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\2\p3\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\2\p3\after\')};
        data.first_cfp_file_all = {'dish2_w1CFP_s3_t1.TIF' ...
            'dish2-after PDGF_w1CFP_s3_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,[1:4, 24:42, 49, 51]}; %
        data.threshold = 0.1;
        data.need_mask = 0;
        data.pax_cbound = [0 7000];
        data.ref_pax_intensity =  195373312; % total paxillin intensity
        data.fa.min_water = 500 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '11_11_RhoV14_2p4'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\2\p4\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\2\p4\after\')};
        data.first_cfp_file_all = {'dish2_w1CFP_s4_t1.TIF' ...
            'dish2-after PDGF_w1CFP_s4_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,[1:16,20:33,36:51]}; %
        data.threshold = 0.1;
        data.need_mask = 0;
        data.pax_cbound = [0 10000];
        data.ref_pax_intensity =  325507661; % total paxillin intensity
        data.fa.min_water = 800 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '11_11_RhoV14_2p5'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\2\p5\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\2\p5\after\')};
        data.first_cfp_file_all = {'dish2_w1CFP_s5_t1.TIF' ...
            'dish2-after PDGF_w1CFP_s5_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,1:49}; %Removed Seq2: 50-51
        data.threshold = 0.27;
        data.need_mask = 0;
        data.pax_cbound = [0 30000];
        data.ref_pax_intensity =  1.7627e+009; % total paxillin intensity
        data.fa.min_water = 1500 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '11_11_RhoV14_3p1'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\3\p1\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\3\p1\after_1\'), ...
            strcat(root, '11_11_2010\RhoV14\3\p1\after_2\')};
        data.first_cfp_file_all = {'dish3_w1CFP_s1_t1.TIF' ...
            'dish3-after PDGF_w1CFP_s1_t1.TIF' ...
            'dish3-after PDGF1_w1CFP_s1_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {2:10,1:3, [1:2,14:16,18, 22,25:27, 30:32, 35:44, 46:49]}; %
        data.threshold = 0.033;
        data.need_mask = 0;
        data.pax_cbound = [0 3000];
        data.ref_pax_intensity =  121900986; % total paxillin intensity
        data.fa.min_water = 250 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '11_11_RhoV14_3p2'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\3\p2\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\3\p2\after_1\'), ...
            strcat(root, '11_11_2010\RhoV14\3\p2\after_2\')};
        data.first_cfp_file_all = {'dish3_w1CFP_s2_t1.TIF' ...
            'dish3-after PDGF_w1CFP_s2_t1.TIF' ...
            'dish3-after PDGF1_w1CFP_s2_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,1:4, [3:11, 16:33, 36:39, 41:51]}; %Removed seq2:4, seq3:13-14
        data.threshold = 0.11;
        data.need_mask = 0;
        data.pax_cbound = [0 12000];
        data.ref_pax_intensity =  491161156; % total paxillin intensity
        data.fa.min_water = 1000 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '11_11_RhoV14_3p3'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\3\p3\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\3\p3\after_1\'), ...
            strcat(root, '11_11_2010\RhoV14\3\p3\after_2\')};
        data.first_cfp_file_all = {'dish3_w1CFP_s3_t1.TIF' ...
            'dish3-after PDGF_w1CFP_s3_t1.TIF' ...
            'dish3-after PDGF1_w1CFP_s3_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:10,1:4, [3:22,28:36,38:39, 41:43, 45:51]}; %Removed seq2:4, seq3:1-2
        data.threshold = 0.09;
        data.need_mask = 0;
        data.pax_cbound = [0 9000];
        data.ref_pax_intensity =  317030641; % total paxillin intensity
        data.fa.min_water = 700 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '11_11_RhoV14_3p4'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\3\p4\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\3\p4\after_1\'), ...
            strcat(root, '11_11_2010\RhoV14\3\p4\after_2\')};
        data.first_cfp_file_all = {'dish3_w1CFP_s4_t1.TIF' ...
            'dish3-after PDGF_w1CFP_s4_t1.TIF' ...
            'dish3-after PDGF1_w1CFP_s4_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {6:8,1:3, [4:5,42,44:46,48:51]}; 
        %Removed seq1:1-5,9-10, seq2:4-5, seq3:1-2,6-41,43
        data.threshold = 0.035;
        data.need_mask = 0;
        data.pax_cbound = [0 3000];
        data.ref_pax_intensity =  67564048; % total paxillin intensity
        data.fa.min_water = 200 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '11_11_RhoV14_3p5'  % too much noise, did not include in analysis
        data.multiple_acquisition = 1;
        data.path = strcat(root, '11_11_2010\RhoV14\3\p5\before\');
        data.path_all = {data.path, strcat(root, '11_11_2010\RhoV14\3\p5\after_1\'), ...
            strcat(root, '11_11_2010\RhoV14\3\p5\after_2\')};
        data.first_cfp_file_all = {'dish3_w1CFP_s5_t1.TIF' ...
            'dish3-after PDGF_w1CFP_s5_t1.TIF' ...
            'dish3-after PDGF1_w1CFP_s5_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {[1,3, 10],[1,4:5], [1:3,6,9,12,16:17,20,23:26,28,30,31,36,43:47]}; 
        data.threshold = 0.035;
        data.need_mask = 0;
        data.pax_cbound = [0 3000];
        data.ref_pax_intensity =  76800896; % total paxillin intensity
        data.fa.min_water = 250 ; 
        data.fa.brightness_factor = 1 ;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_1p1'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax\1\p1\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax\1\p1\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax\1\p1\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s1_t1.TIF' ...
            'dish1-add PDGF_w1CFP_s1_t1.TIF' ...
            'dish1-add PDGF-2_w1CFP_s1_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {7:8,[1:5], [1:6, 8:9,11:12, 14:15, 17:21]}; 
        data.threshold = 0.035;
        data.need_mask = 0;
        data.pax_cbound = [0 1000];
        data.ref_pax_intensity =  28692598; % total paxillin intensity
        data.fa.min_water = 80; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 3;
      case '01_27_fn25_1p2'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax\1\p2\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax\1\p2\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax\1\p2\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s2_t1.TIF' ...
            'dish1-add PDGF_w1CFP_s2_t1.TIF' ...
            'dish1-add PDGF-2_w1CFP_s2_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8,1:20, [1:8, 10, 13:17]}; 
        data.threshold = 0.015;
        data.need_mask = 0;
        data.pax_cbound = [0 400];
        data.yfp_cbound = [0 3000];
        data.ref_pax_intensity =  10311535; % total paxillin intensity
        data.fa.min_water = 40; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '01_27_fn25_1p3'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax\1\p3\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax\1\p3\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax\1\p3\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s3_t1.TIF' ...
            'dish1-add PDGF_w1CFP_s3_t1.TIF' ...
            'dish1-add PDGF-2_w1CFP_s3_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {5:8,2:19, [1:5, 7:14, 16:17, 19:21]}; 
        data.threshold = 0.01;
        data.need_mask = 0;
        data.pax_cbound = [0 350];
        data.yfp_cbound = [0 2000];
        data.ref_pax_intensity =  6940736; % total paxillin intensity
        data.fa.min_water = 40; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '01_27_fn25_1p4'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax\1\p4\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax\1\p4\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax\1\p4\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s4_t1.TIF' ...
            'dish1-add PDGF_w1CFP_s4_t1.TIF' ...
            'dish1-add PDGF-2_w1CFP_s4_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {6:8,[1:2,4:14,16:19], [3:5, 6:11, 14]}; 
        data.threshold = 0.04;
        data.need_mask = 0;
        data.pax_cbound = [0 1000];
        data.yfp_cbound = [0 5000];
        data.ref_pax_intensity =  29836771; % total paxillin intensity
        data.fa.min_water = 90; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 3;
      case '01_27_fn25_1p5'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax\1\p5\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax\1\p5\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax\1\p5\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s5_t1.TIF' ...
            'dish1-add PDGF_w1CFP_s5_t1.TIF' ...
            'dish1-add PDGF-2_w1CFP_s5_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8,1:19, [1:2, 4:22]}; 
        data.threshold = 0.015;
        data.need_mask = 0;
        data.pax_cbound = [0 300];
        data.yfp_cbound = [0 3000];
        data.ref_pax_intensity =  9807531; % total paxillin intensity
        data.fa.min_water = 30; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_2p1'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax\2\p1\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax\2\p1\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax\2\p1\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s1_t1.TIF' ...
            'dish2-add PDGF_w1CFP_s1_t1.TIF' ...
            'dish2-add PDGF-2_w1CFP_s1_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {3:8,1:2, 5:36}; 
        data.threshold = 0.015;
        data.need_mask = 0;
        data.pax_cbound = [0 600];
        data.yfp_cbound = [0 2000];
        data.ref_pax_intensity =  18613055; % total paxillin intensity
        data.fa.min_water = 50; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_2p2'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax\2\p2\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax\2\p2\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax\2\p2\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s2_t1.TIF' ...
            'dish2-add PDGF_w1CFP_s2_t1.TIF' ...
            'dish2-add PDGF-2_w1CFP_s2_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8,[], [2:4, 6:38]}; 
        data.threshold = 0.02;
        data.need_mask = 0;
        data.pax_cbound = [0 1000];
        data.yfp_cbound = [0 3000];
        data.ref_pax_intensity =  17798665; % total paxillin intensity
        data.fa.min_water = 80; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_2p3'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax\2\p3\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax\2\p3\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax\2\p3\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s3_t1.TIF' ...
            'dish2-add PDGF_w1CFP_s3_t1.TIF' ...
            'dish2-add PDGF-2_w1CFP_s3_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {2:8,3:4, [1:3,6:12,19:35, 38:39]}; 
        data.threshold = 0.015;
        data.need_mask = 1;
        data.pax_cbound = [0 600];
        data.yfp_cbound = [0 2500];
        data.ref_pax_intensity =  8865619; % total paxillin intensity
        data.fa.min_water = 50; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
        % p4 time course too short not using
      case '01_27_fn25_2p5'  
          % data unstable before pdgf, not using.
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax\2\p5\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax\2\p5\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax\2\p5\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s5_t1.TIF' ...
            'dish2-add PDGF_w1CFP_s5_t1.TIF' ...
            'dish2-add PDGF-2_w1CFP_s5_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8,1:4, 1:39}; 
        data.threshold = 0.025;
        data.need_mask = 0;
        data.pax_cbound = [0 600];
        data.yfp_cbound = [0 5000];
        data.ref_pax_intensity =  16551735; % total paxillin intensity
        data.fa.min_water = 50; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 3;
      case '01_27_fn25_racn17_1p1'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p1\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p1\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p1\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s1_t1.TIF' ...
            'dish1-add PDGF-1_w1CFP_s1_t1.TIF' ...
            'dish1-add PDGF--3_w1CFP_s1_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8,1:31, 1:12}; 
        data.threshold = 0.0045;
        data.need_mask = 0;
        data.pax_cbound = [0 130];
        data.yfp_cbound = [0 1000];
        data.ref_pax_intensity =  2239616; % total paxillin intensity
        data.fa.min_water = 10; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_racn17_1p21'  
          % two cells -- this one is the lower left cell
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p2\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p2\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p2\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s2_t1.TIF' ...
            'dish1-add PDGF-1_w1CFP_s2_t1.TIF' ...
            'dish1-add PDGF--3_w1CFP_s2_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {2:3,[1:9, 11:17, 19:29, 31], [1:4, 6:7, 9:10,12]}; 
        data.threshold = 0.006;
        data.need_mask = 1;
        data.pax_cbound = [0 200];
        data.yfp_cbound = [0 1000];
        data.ref_pax_intensity =  2542501; % total paxillin intensity
        data.fa.min_water = 10; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '01_27_fn25_racn17_1p22'  
          % two cells -- this one is the top right cell
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p22\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p22\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p22\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s2_t1.TIF' ...
            'dish1-add PDGF-1_w1CFP_s2_t1.TIF' ...
            'dish1-add PDGF--3_w1CFP_s2_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {2:3,[1:14,16:18,20:29,31], [1:5,7, 9:11]}; 
        data.threshold = 0.005;
        data.need_mask = 1;
        data.pax_cbound = [0 200];
        data.yfp_cbound = [0 1000];
        data.ref_pax_intensity =  2359463; % total paxillin intensity
        data.fa.min_water = 10; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_racn17_1p3'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p3\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p3\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p3\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s3_t1.TIF' ...
            'dish1-add PDGF-1_w1CFP_s3_t1.TIF' ...
            'dish1-add PDGF--3_w1CFP_s3_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8,[1:18, 20:30], [1:11]}; 
        data.threshold = 0.015;
        data.need_mask = 1;
        data.pax_cbound = [0 300];
        data.yfp_cbound = [0 2000];
        data.ref_pax_intensity =  6740221; % total paxillin intensity
        data.fa.min_water = 20; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '01_27_fn25_racn17_1p4'  
          % unstable before pdgf, not using.
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p4\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p4\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p4\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s4_t1.TIF' ...
            'dish1-add PDGF-1_w1CFP_s4_t1.TIF' ...
            'dish1-add PDGF--3_w1CFP_s4_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8,1:31, [1:12]}; 
        data.threshold = 0.01;
        data.need_mask = 1;
        data.pax_cbound = [0 300];
        data.yfp_cbound = [0 1500];
        data.ref_pax_intensity =   4943863; % total paxillin intensity
        data.fa.min_water = 20; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '01_27_fn25_racn17_1p5'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p5\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p5\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p5\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s5_t1.TIF' ...
            'dish1-add PDGF-1_w1CFP_s5_t1.TIF' ...
            'dish1-add PDGF--3_w1CFP_s5_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8,1:31, 1:12}; 
        data.threshold = 0.008;
        data.need_mask = 0;
        data.pax_cbound = [0 200];
        data.yfp_cbound = [0 2000];
        data.ref_pax_intensity =   5384729; % total paxillin intensity
        data.fa.min_water = 20; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_racn17_1p6'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p6\');
        data.path_all = {data.path, strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p6\'), ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\1\p6\')};
        data.output_path_all = {'output\before\' 'output\after_1\' 'output\after_2\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s6_t1.TIF' ...
            'dish1-add PDGF-1_w1CFP_s6_t1.TIF' ...
            'dish1-add PDGF--3_w1CFP_s6_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, [1:10, 12:16],1:11};
        data.threshold = 0.008;
        data.need_mask = 0;
        data.pax_cbound = [0 150];
        data.yfp_cbound = [0 1500];
        data.ref_pax_intensity =   4930173; % total paxillin intensity
        data.fa.min_water = 10; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 2;
      case '01_27_fn25_racn17_2p1'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\2\p1\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\2\p1\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s1_t1.TIF' ...
            'dish2-add PDGF-1_w1CFP_s1_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {[3:4, 6:7], [1:7, 9, 11:26, 28:42]};
        data.threshold = 0.025;
        data.need_mask = 0;
        data.pax_cbound = [0 600];
        data.yfp_cbound = [0 4000];
        data.ref_pax_intensity =   12831163; % total paxillin intensity
        data.fa.min_water = 80; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 30;
        data.num_layer = 5;
        data.num_fans = 3;
      case '01_27_fn25_racn17_2p2'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\2\p2\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\2\p2\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s2_t1.TIF' ...
            'dish2-add PDGF-1_w1CFP_s2_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {2:8, [2:22, 24:29, 31:42]};
        data.threshold = 0.008;
        data.need_mask = 0;
        data.pax_cbound = [0 300];
        data.yfp_cbound = [0 2000];
        data.ref_pax_intensity =   5790761; % total paxillin intensity
        data.fa.min_water = 30; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 20;
        data.num_layer = 5;
        data.num_fans = 2;
      case '01_27_fn25_racn17_2p3'  
          % did not use, the paxillin was unstable before pdgf.
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\2\p3\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\2\p3\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s3_t1.TIF' ...
            'dish2-add PDGF-1_w1CFP_s3_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, [1:34, 36:39, 41:42]};
        data.threshold = 0.015;
        data.need_mask = 0;
        data.pax_cbound = [0 200];
        data.yfp_cbound = [0 2500];
        data.ref_pax_intensity =   6152204; % total paxillin intensity
        data.fa.min_water = 25; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 20;
        data.num_layer = 5;
        data.num_fans = 3;
      case '01_27_fn25_racn17_2p4'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\2\p4\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\2\p4\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s4_t1.TIF' ...
            'dish2-add PDGF-1_w1CFP_s4_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {[1:2, 4:8], 1:42};
        data.threshold = 0.0045;
        data.need_mask = 0;
        data.pax_cbound = [0 150];
        data.yfp_cbound = [0 1000];
        data.ref_pax_intensity =   2503230; % total paxillin intensity
        data.fa.min_water = 25; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 4;
      case '01_27_fn25_racn17_2p5'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\2\p5\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\2\p5\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s5_t1.TIF' ...
            'dish2-add PDGF-1_w1CFP_s5_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {4:8, [1:3, 6:30, 33:35, 40:41]};
        data.threshold = 0.005;
        data.need_mask = 0;
        data.pax_cbound = [0 150];
        data.yfp_cbound = [0 1000];
        data.ref_pax_intensity =   2932430; % total paxillin intensity
        data.fa.min_water = 25; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 4;
      case '01_27_fn25_racn17_2p6'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\2\p6\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\2\p6\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s6_t1.TIF' ...
            'dish2-add PDGF-1_w1CFP_s6_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {[3,5:8], 1:42};
        data.threshold = 0.012;
        data.need_mask = 0;
        data.pax_cbound = [0 200];
        data.yfp_cbound = [0 2000];
        data.ref_pax_intensity =   6727487; % total paxillin intensity
        data.fa.min_water = 25; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 2;
      case '01_27_fn25_racn17_3p1'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\3\p1\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\3\p1\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish3_w1CFP_s1_t1.TIF' ...
            'dish3-add PDGF-1_w1CFP_s1_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:40};
        data.threshold = 0.02;
        data.need_mask = 0;
        data.pax_cbound = [0 600];
        data.yfp_cbound = [0 3000];
        data.ref_pax_intensity =   11452022; % total paxillin intensity
        data.fa.min_water = 70; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 3;
      case '01_27_fn25_racn17_3p21'  
          % two cells -- this one is the top left cell
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\3\p2\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\3\p2\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish3_w1CFP_s2_t1.TIF' ...
            'dish3-add PDGF-1_w1CFP_s2_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {4:6, [2:4, 6:7, 9:13, 15, 18:34, 37:40]};
        data.threshold = 0.0055;
        data.need_mask = 1;
        data.pax_cbound = [0 150];
        data.yfp_cbound = [0 1000];
        data.ref_pax_intensity =   2308172; % total paxillin intensity
        data.fa.min_water = 20; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_racn17_3p22'  
          % some near nuclear unspecificity, not using the data.
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\3\p22\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\3\p22\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish3_w1CFP_s2_t1.TIF' ...
            'dish3-add PDGF-1_w1CFP_s2_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:40};
        data.threshold = 0.0055;
        data.need_mask = 1;
        data.pax_cbound = [0 150];
        data.yfp_cbound = [0 1000];
        data.ref_pax_intensity =   2951016; % total paxillin intensity
        data.fa.min_water = 20; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 3;
      case '01_27_fn25_racn17_3p3'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\3\p3\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\3\p3\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish3_w1CFP_s3_t1.TIF' ...
            'dish3-add PDGF-1_w1CFP_s3_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:40};
        data.threshold = 0.015;
        data.need_mask = 1;
        data.pax_cbound = [0 300];
        data.yfp_cbound = [0 2000];
        data.ref_pax_intensity =   7031253; % total paxillin intensity
        data.fa.min_water = 30; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 3;
      case '01_27_fn25_racn17_3p4'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\3\p4\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\3\p4\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish3_w1CFP_s4_t1.TIF' ...
            'dish3-add PDGF-1_w1CFP_s4_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, [1:2, 9:20, 24:30,33, 36:40]};
        data.threshold = 0.006;
        data.need_mask = 0;
        data.pax_cbound = [0 150];
        data.yfp_cbound = [0 1000];
        data.ref_pax_intensity =   4353228; % total paxillin intensity
        data.fa.min_water = 20; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 3;
      case '01_27_fn25_racn17_3p5'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\3\p5\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\3\p5\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish3_w1CFP_s5_t1.TIF' ...
            'dish3-add PDGF-1_w1CFP_s5_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:40};
        data.threshold = 0.006;
        data.need_mask = 0;
        data.pax_cbound = [0 100];
        data.yfp_cbound = [0 1000];
        data.ref_pax_intensity =   3136802; % total paxillin intensity
        data.fa.min_water = 15; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 2;
      case '01_27_fn25_racn17_3p6'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\3\p6\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RaCN17\3\p6\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish3_w1CFP_s6_t1.TIF' ...
            'dish3-add PDGF-1_w1CFP_s6_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, [1:17, 19:20, 22:29, 31:40]};
        data.threshold = 0.005;
        data.need_mask = 0;
        data.pax_cbound = [0 150];
        data.yfp_cbound = [0 1000];
        data.ref_pax_intensity =   4029420; % total paxillin intensity
        data.fa.min_water = 15; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 2;
      case '01_27_fn25_racv12_1p2'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\1\p2\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\1\p2\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s2_t1.TIF' ...
            'dish1-add PDGF-1_w1CFP_s2_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {3:8, 1:35};
        data.threshold = 0.009;
        data.need_mask = 0;
        data.pax_cbound = [0 200];
        data.yfp_cbound = [0 1500];
        data.ref_pax_intensity =   8552598; % total paxillin intensity
        data.fa.min_water = 25; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 2;
      case '01_27_fn25_racv12_1p4'  
          % cell not stable before pdgf, not using.
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\1\p4\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\1\p4\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s4_t1.TIF' ...
            'dish1-add PDGF-1_w1CFP_s4_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:40};
        data.threshold = 0.03;
        data.need_mask = 0;
        data.pax_cbound = [0 400];
        data.yfp_cbound = [0 5000];
        data.ref_pax_intensity =   17623358; % total paxillin intensity
        data.fa.min_water = 60; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_racv12_1p5'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\1\p5\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\1\p5\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s5_t1.TIF' ...
            'dish1-add PDGF-1_w1CFP_s5_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {4:8, [1:7, 9, 11:17, 19:27, 30:39]};
        data.threshold = 0.04;
        data.need_mask = 0;
        data.pax_cbound = [0 1000];
        data.yfp_cbound = [0 6000];
        data.ref_pax_intensity =   49112660; % total paxillin intensity
        data.fa.min_water = 60; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_racv12_1p6'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\1\p6\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\1\p6\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish1_w1CFP_s6_t1.TIF' ...
            'dish1-add PDGF-1_w1CFP_s6_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {[4, 7:8], [1:4, 6:40]};
        data.threshold = 0.015;
        data.need_mask = 0;
        data.pax_cbound = [0 300];
        data.yfp_cbound = [0 2500];
        data.ref_pax_intensity =   13630920; % total paxillin intensity
        data.fa.min_water = 40; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_racv12_2p1'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\2\p1\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\2\p1\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s1_t1.TIF' ...
            'dish2-add PDGF-1_w1CFP_s1_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {[3 5 6:7], [1, 3:9, 11:14, 16:51]};
        data.threshold = 0.015;
        data.need_mask = 0;
        data.pax_cbound = [0 300];
        data.yfp_cbound = [0 2500];
        data.ref_pax_intensity =   12577357; % total paxillin intensity
        data.fa.min_water = 40; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 4;
      case '01_27_fn25_racv12_2p2'  
          % unstable before pdgf not using
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\2\p2\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\2\p2\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s2_t1.TIF' ...
            'dish2-add PDGF-1_w1CFP_s2_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {6:8, 1:51};
        data.threshold = 0.008;
        data.need_mask = 1;
        data.pax_cbound = [0 150];
        data.yfp_cbound = [0 2000];
        data.ref_pax_intensity =   3176069; % total paxillin intensity
        data.fa.min_water = 25; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_racv12_2p3'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\2\p3\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\2\p3\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s3_t1.TIF' ...
            'dish2-add PDGF-1_w1CFP_s3_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {3:6, [2:6, 8:9, 11:34, 36, 38, 40, 42:43,46, 48:49]};
        data.threshold = 0.035;
        data.need_mask = 0;
        data.pax_cbound = [0 300];
        data.yfp_cbound = [0 7000];
        data.ref_pax_intensity =   17012829; % total paxillin intensity
        data.fa.min_water = 40; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_racv12_2p4'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\2\p4\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\2\p4\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s4_t1.TIF' ...
            'dish2-add PDGF-1_w1CFP_s4_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:51};
        data.threshold = 0.015;
        data.need_mask = 1;
        data.pax_cbound = [0 300];
        data.yfp_cbound = [0 3000];
        data.ref_pax_intensity =   25464219; % total paxillin intensity
        data.fa.min_water = 40; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_racv12_2p5'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\2\p5\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\2\p5\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s5_t1.TIF' ...
            'dish2-add PDGF-1_w1CFP_s5_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {[1:2,4, 6,8], [1:32,34:51]};
        data.threshold = 0.02;
        data.need_mask = 0;
        data.pax_cbound = [0 500];
        data.yfp_cbound = [0 4000];
        data.ref_pax_intensity =   40767056; % total paxillin intensity
        data.fa.min_water = 45; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 2;
      case '01_27_fn25_racv12_2p6'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\2\p6\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\2\p6\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish2_w1CFP_s6_t1.TIF' ...
            'dish2-add PDGF-1_w1CFP_s6_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {6:8, [1:4, 6:51]};
        data.threshold = 0.012;
        data.need_mask = 0;
        data.pax_cbound = [0 300];
        data.yfp_cbound = [0 3000];
        data.ref_pax_intensity =   9053528; % total paxillin intensity
        data.fa.min_water = 45; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 3;
      case '01_27_fn25_racv12_3p1'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\3\p1\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\3\p1\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish3_w1CFP_s1_t1.TIF' ...
            'dish3-add PDGF-1_w1CFP_s1_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, [1:12, 15:44]};
        data.threshold = 0.008;
        data.need_mask = 0;
        data.pax_cbound = [0 300];
        data.yfp_cbound = [0 1500];
        data.ref_pax_intensity =   9689187; % total paxillin intensity
        data.fa.min_water = 20; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 3;
      case '01_27_fn25_racv12_3p2'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\3\p2\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\3\p2\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish3_w1CFP_s2_t1.TIF' ...
            'dish3-add PDGF-1_w1CFP_s2_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:27};
        data.threshold = 0.008;
        data.need_mask = 0;
        data.pax_cbound = [0 300];
        data.yfp_cbound = [0 1500];
        data.ref_pax_intensity =   18415266; % total paxillin intensity
        data.fa.min_water = 20; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_racv12_3p3'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\3\p3\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\3\p3\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish3_w1CFP_s3_t1.TIF' ...
            'dish3-add PDGF-1_w1CFP_s3_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {[1:2,4:8], [2:19, 21:30, 32:44]};
        data.threshold = 0.03;
        data.need_mask = 0;
        data.pax_cbound = [0 500];
        data.yfp_cbound = [0 5000];
        data.ref_pax_intensity =   30874977; % total paxillin intensity
        data.fa.min_water = 50; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_racv12_3p4'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\3\p4\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\3\p4\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish3_w1CFP_s4_t1.TIF' ...
            'dish3-add PDGF-1_w1CFP_s4_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {[1:4, 7:8], [1:21,23:27]};
        data.threshold = 0.04;
        data.need_mask = 0;
        data.pax_cbound = [0 1000];
        data.yfp_cbound = [0 7000];
        data.ref_pax_intensity =   40601793; % total paxillin intensity
        data.fa.min_water = 80; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 1;
      case '01_27_fn25_racv12_3p5'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\3\p5\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\3\p5\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish3_w1CFP_s5_t1.TIF' ...
            'dish3-add PDGF-1_w1CFP_s5_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:44};
        data.threshold = 0.015;
        data.need_mask = 0;
        data.pax_cbound = [0 300];
        data.yfp_cbound = [0 2000];
        data.ref_pax_intensity =   20933486; % total paxillin intensity
        data.fa.min_water = 40; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 0;
      case '01_27_fn25_racv12_3p6'  
        data.multiple_acquisition = 1;
        data.path = strcat(root, '01_27_2011\Lyn_src-pax-RacV12\3\p6\');
        data.path_all = {data.path, ...
            strcat(root, '01_27_2011\Lyn_src-pax-RacV12\3\p6\')};
        data.output_path_all = {'output\before\' 'output\after\'};
        data.first_cfp_file_all = {'dish3_w1CFP_s6_t1.TIF' ...
            'dish3-add PDGF-1_w1CFP_s6_t1.TIF'};
        data.cfp_channel = {'w1CFP'};
        data.yfp_channel = {'w2FRET'};
        data.pax_channel = {'w4MCherry'};
        data.index_pattern = {'t1' 't%d'};
        data.index = {1:8, 1:44};
        data.threshold = 0.06;
        data.need_mask = 0;
        data.pax_cbound = [0 900];
        data.yfp_cbound = [0 8000];
        data.ref_pax_intensity =   57178656; % total paxillin intensity
        data.fa.min_water = 110; 
        data.fa.brightness_factor = 1;
        data.fa.filter_size = 61; 
        data.fa.single_min_area = 10;
        data.num_layer = 5;
        data.num_fans = 1;
       
        
        
       %%% Jihye's data.
    case 'fak_pax_1_1'
        data.path = strcat(root, 'jihye_LynFAK_mCherryPax_08_2010\1\1\');
        data.prefix = '1-1';
        data.index = 1:39;
        data.before_pdgf = 9;
        data.pdgf_time = 559.46;
        data.ref_pax_intensity = 16830670;
        data.fa.brightness_factor = 1;
        data.fa.min_water = 80;
        data.fa.filter_size = 61;
        data.fa.single_min_area = 30;
        data.num_fans = 1;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 4;
        data.pax_cbound = [0 700];
        % batch_detect_cell_bws('fak_pax_1_1' 'save_file' 0, ...
        % 'image_index' [1 10 30], 'cbound' [1 10000]);
        % batch_detect_fa_labels('fak_pax_1_1' 'save_file' 1);
        % compute_fa_properties('fak_pax_1_1');
     case 'fak_pax_1_2' % this cell did not have significant spatial difference
        data.path = strcat(root, 'jihye_LynFAK_mCherryPax_08_2010\1\2\');
        data.prefix = '2-1';
        data.index = [1:6, 9:37];
        data.before_pdgf = 6;
        data.pdgf_time = 385.53;
        data.ref_pax_intensity = 53794356;
        data.fa.brightness_factor = 1;
        data.fa.min_water = 80;
        data.fa.filter_size = 61;
        data.fa.single_min_area = 30;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 4;
        data.pax_cbound = [0 2000];
     case 'fak_pax_1_3' 
        data.path = strcat(root, 'jihye_LynFAK_mCherryPax_08_2010\1\3\');
        data.prefix = '3-1';
        data.index = 1:36;
        data.before_pdgf = 6;
        data.pdgf_time = 413.67;
        data.ref_pax_intensity = 68108057;
        data.fa.brightness_factor = 1;
        data.fa.min_water = 80;
        data.fa.filter_size = 61;
        data.fa.single_min_area = 30;
        data.num_fans = 1;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 4;
        data.pax_cbound = [0 2000];
     case 'fak_pax_1_4' 
        data.path = strcat(root, 'jihye_LynFAK_mCherryPax_08_2010\1\4\');
        data.prefix = '4-1';
        data.index = 3:39;
        data.before_pdgf = 9;
        data.pdgf_time = 581.65;
        data.ref_pax_intensity = 31163465;
        data.fa.brightness_factor = 1;
        data.fa.min_water = 80;
        data.fa.filter_size = 61;
        data.fa.single_min_area = 30;
        data.num_fans = 1;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 4;
        data.pax_cbound = [0 1000];
        data.need_mask = 1;
     case 'fak_pax_1_5' 
        data.path = strcat(root, 'jihye_LynFAK_mCherryPax_08_2010\1\5\');
        data.prefix = '5-1';
        data.index = 4:38;
        data.before_pdgf = 8;
        data.pdgf_time = 464.92;
        data.ref_pax_intensity = 55271410;
        data.fa.brightness_factor = 1;
        data.fa.min_water = 60;
        data.fa.filter_size = 61;
        data.fa.single_min_area = 30;
        data.num_fans = 1;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 4;
        data.pax_cbound = [0 1000];
        data.need_mask = 1;
     case 'fak_pax_2_1' 
        data.path = strcat(root, 'jihye_LynFAK_mCherryPax_08_2010\2\1\');
        data.prefix = '1';
        data.index = [4:11, 18:47];
        data.before_pdgf = 9;
        data.pdgf_time = 561.76;
        data.ref_pax_intensity = 125707620;
        data.fa.brightness_factor = 0.9;
        data.fa.min_water = 60;
        data.fa.filter_size = 61;
        data.fa.single_min_area = 30;
        data.num_fans = 1;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 4;
        data.pax_cbound = [0 1500];
     case 'fak_pax_2_2' 
        data.path = strcat(root, 'jihye_LynFAK_mCherryPax_08_2010\2\2\');
        data.prefix = '2';
        data.index = 4:37;
        data.before_pdgf = 6;
        data.pdgf_time = 722.75;
        data.ref_pax_intensity = 95287881;
        data.fa.brightness_factor = 0.8;
        data.fa.min_water = 60;
        data.fa.filter_size = 61;
        data.fa.single_min_area = 30;
        data.num_fans = 1;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 4;
        data.pax_cbound = [0 1500];
     case 'fak_pax_2_3' 
        data.path = strcat(root, 'jihye_LynFAK_mCherryPax_08_2010\2\3\');
        data.prefix = '3';
        data.index = 3:36;
        data.before_pdgf = 6;
        data.pdgf_time = 392.69;
        data.ref_pax_intensity = 15232553;
        data.fa.brightness_factor = 1;
        data.fa.min_water = 60;
        data.fa.filter_size = 61;
        data.fa.single_min_area = 30;
        data.cfp_channel = 1;
        data.yfp_channel = 2;
        data.pax_channel = 4;
        data.pax_cbound = [0 700];
        data.num_fans = 2;
       

end
return;