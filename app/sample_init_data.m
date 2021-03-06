% initialize data for the various applications.
function data = sample_init_data(name, function_name)
global fluocell_data_root; 
if isempty(fluocell_data_root)
    %%% replace root value here %%%
    root = '/Users/kathylu/Documents/sof/data/fluocell_sample/';
    %%% 
else 
    root = fluocell_data_root;
    fprintf('\nfunction sample_init_data() --- \n')
    fprintf('  set root to %s ... \n', root);
end
if ~exist(root, 'dir')
    fprintf('\nfunction sample_init_data() --- \n')
    fprintf('  the root variable needs to be changed to the folder of fluocell sample data. \n');
    fprintf('Please select in the pop-up window... \n');
    temp = uigetdir(); 
    root = strcat(temp, '/');
    fprintf('root = %s\n', root);
    fprintf('******\n');
    fprintf('For future convenience, please copy and paste the root value into sample_init_data(). \n');
    fprintf('******\n');
    fprintf('----------- \n');
end 
if isempty(fluocell_data_root)
    fluocell_data_root = root; 
    fprintf('Set fluocell_data_root to %s ... \n', root);
end

switch name
    case 'src_pax'
        % General parameters
        data.path = strcat(root, '10_24_08_Src_fret_pax/');
        data.index_pattern = {'001', '%03d'};
        data.image_index = (1:10)';
        switch function_name
            case 'make_movie'
                % Making Movie
                % For the data.first_file, user needs to adjust it to their
                % own path and file name.
                data.first_file = 'output/0.3-0.8/ratio001.tiff';
                data.file_name = strcat(data.path,'output/fret.avi');
            %case 'detect_cell',
            case 'batch_detect_cell'
                % cell detection
                data.first_cfp_file = '2-11.001';
                data.cfp_channel = {'2-11'};
                data.yfp_channel = {'2-12'};
                data.pax_channel = {'2-14'};
                data.index = data.image_index;
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
            case 'batch_detect_fa'
                % FA detection
                data.subtract_background = 1;
                data.median_filter = 1;
                data.threshold = 0.03; %for fa_detection;
                data.with_smoothing = 1;
                data.first_cfp_file = '2-11.001';
                data.cfp_channel = {'2-11'};
                data.yfp_channel = {'2-12'};
                data.pax_channel = {'2-14'};
                data.index = data.image_index;
                data.need_mask = 0;
                data.pdgf_between_frame = [5; 6];
                data.pax_cbound = [0 300];
                data.yfp_cbound = [0 5000];
                data.ref_pax_intensity = 8829698;
                data.fa.min_water = 30;
                data.fa.single_min_area = 10;
                data.num_roi = 5;
                % data.num_fans = 1;
                data.is_cfp_over_fret = 0;
        end % switch function_name  

case 'akt_1'
        data.path = strcat(root, 'PH-Akt-GFP_1/');
        data  = load_data(data.path);
        % data.output_path = strcat(data.path, 'output/');
        data.prefix = 'AKT-PH-YFP_PDGF52';
        data.postfix = '.001';
        data.time_pt = 27; % the largest time point in the analysis.
        data.PDGF_add = 68; % the frame before PDGF was added.
        data.PDGF_time = 497160;
        data.DRUG_add = 'none';
        data.threshold = 0.01;
        data.flip_cell = 1;
        data.subtract_background = 1;
        data.median_filter = 1;
        data.protocol = 'Intensity';
        data.index_pattern = {'001', '%03d'};
        data.need_apply_mask = 0;
        data.num_roi = 1;
        data.quantify_roi = 3;
        data.crop_image = 0;
case 'tracking_ex'
        % General parameters
        data.path = strcat(root, 'tracking_ex/');
        data.first_file = strcat(data.path, 'cfp_t1.tif');
        
end % switch name (cell_name)
return;