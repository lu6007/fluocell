% initialize data  for the various applications.
function data = sample_init_data(name, function_name)
root = '..\..\data\';
switch name,
    case 'src_pax',
        % General parameters
        data.path = strcat(root, '10_24_08_Src_fret_pax\');
        data.index_pattern = {'001', '%03d'};
        data.image_index = 1:10;
        switch function_name
            case 'make_movie',
                % Making Movie
                % For the data.first_file, user needs to adjust it to their
                % own path and file name.
                data.first_file = 'output\0.3-0.8\ratio001.tiff';
                data.file_name = strcat(data.path,'output\fret.avi');
            %case 'detect_cell',
            case 'batch_detect_cell',
                % cell detection
                data.first_cfp_file = '2-11.001';
                data.cfp_channel = {'2-11'};
                data.yfp_channel = {'2-12'};
                data.pax_channel = {'2-14'};
                data.index = data.image_index';
                data.subtract_background = 1;
                data.median_filter = 1;
                data.threshold = 0.04; % for cell_detection;
                data.brightness_factor = 1.0;
                data.with_smoothing = 1;
                data.need_mask = 0;
                data.pdgf_between_frame = [5; 6];
                % data.pax_cbound = [0 2000];
                data.yfp_cbound = [0 5000];
            %case 'detect_fa',
            case 'batch_detect_fa',
                % FA detection
                data.subtract_background = 1;
                data.median_filter = 1;
                data.threshold = 0.03; %for fa_detection;
                data.with_smoothing = 1;
                data.first_cfp_file = '2-11.001';
                data.cfp_channel = {'2-11'};
                data.yfp_channel = {'2-12'};
                data.pax_channel = {'2-14'};
                data.index = data.image_index';
                data.need_mask = 0;
                data.pdgf_between_frame = [5; 6];
                data.pax_cbound = [0 300];
                data.yfp_cbound = [0 5000];
                data.ref_pax_intensity = 8829698;
                data.fa.min_water = 30;
                data.fa.single_min_area = 10;
                data.num_layers = 5;
                % data.num_fans = 1;
                data.is_cfp_over_fret = 0;
        end; % switch function_name  
case 'akt_1',
        data.path = strcat(root, 'PH-Akt-GFP_1\');
        data.output_path = strcat(data.path, 'output\');
        data.prefix = 'AKT-PH-YFP_PDGF5';
        data.channel_number = 2;
        data.time_pt = 119; % the largest time point in the analysis.
        data.PDGF_add = 68; % the frame before PDGF was added.
        data.PDGF_time = 497160;
        data.DRUG_add = 'none';
        data.threshold = 0.01;
        data.flip_cell = 1;
        data.subtract_background = 1;
        data.median_filter = 1;
        data.crop_image = 1;
        
end; % switch name (cell_name)
return;