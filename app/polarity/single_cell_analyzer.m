%% Quantify the fluorescent intensity and draw the intensity landscape for one cell 
% and save the results 
% Adapted from the function single_cell_analyzer(cell_name) for Mingxing's
% polarity data.
% Previously single_cell_analyser_4()
% Example: 
% cell_name = 'akt_1';
% data = sample_init_data(cell_name);
% single_cell_analyzer(cell_name);
function single_cell_analyzer(cell_name, data,varargin)
parameter_name = {'make_movie'};
default_value = {0};
make_movie = parse_parameter(parameter_name, default_value, varargin);

% data = polarity_init_data(cell_name);
% path = data.path;
% prefix = data.prefix;
time = get_time(data, 'ref_time', data.PDGF_time,'method',1);	
index_before = find(time>=-5&time<=0); 
index_after = find(time>=20&time<=30);
data.image_index = [index_before' index_after'];
image_index = data.image_index;
channel_number = data.channel_number;
channel_index = strcat(num2str(channel_number),'.');

%% Preprocessing images
% 1. Subtract background; 2. median filter; 3. Rotate image; 4. Crop image.
% Save the processed images.
% angle = data.angle;
num_frames = data.time_pt;
im = cell(num_frames, 1);
for i = data.image_index,
    % Initialization
    index_pattern = sprintf('%03d', i);
    file = strcat(data.path, data.prefix, channel_index, index_pattern); 
    processed_file = strcat(data.path, 'processed_im_', index_pattern, '.tiff');

    if ~exist(processed_file, 'file'),
        if exist(file, 'file');
        t_im = imread(file);
        if ~isfield(data,'bg_bw'),
            [data.bg_bw data.bg_poly] = get_background(t_im,...
                strcat(data.path, 'output/background.mat'));
            data.rectangle = get_rectangle(t_im, ...
                strcat(data.path, 'output/rectangle.mat'));
        end;
        temp = preprocess(t_im, data);
        im{i} = uint16(temp); 
%         im_sub = subtract_background_1(t_im, data.path);
%         im_filt = medfilt2(im_sub);
%         %im_rot =imrotate(im_filt, angle, 'bilinear');
%         im_crop = crop_image_1(im_filt, data.path);
%         im{i} = im_crop;
        clear t_im temp;        
        imwrite(im{i}, processed_file, 'tiff','Compression', 'none');
        end;
    else
        im{i} = imread(processed_file);
    end
    clear processed_file index_pattern file
end;

%% Apply threshold, detect cell edge, rotate the image, and calculate the average intensity
cell_info_file = strcat(data.path, 'cell_info.mat');
if ~exist(cell_info_file),
    th = data.threshold;
    sf = 3;
    bf = 1.0;
    distance = (0:0.002:1)';
    for i = 1:num_frames,
        if ~isempty(im{i}),
           if isfield(data, 'need_apply_mask')&& data.need_apply_mask,
               mask_bw = get_background(uint16(im{i}), strcat(data.path, 'output/mask.mat'));
           else
               mask_bw = [];
           end;  
           % 1/5/2016 should use detect_cell instead of get_cell_edge
        [bd, bw] = get_cell_edge(im{i}, 'brightness_factor', bf,...
           'threshold', th,'show_figure',0,'mask_bw', mask_bw);
        if isempty(bd),
            continue,
        end;
        % detect the angle and rotate the image and the mask
        if ~isfield(data, 'angle'),
            prop = regionprops(bw, 'Orientation');
            data.angle = - prop.Orientation;
            clear prop;
        end
        temp = imrotate(im{i}, data.angle);
        if data.flip_cell,
            im{i} = imrotate(temp, 180);
        else 
            im{i} = temp;
        end; clear temp;
        
        if ~isempty(mask_bw),
            temp = imrotate(mask_bw, data.angle);
            clear mask_bw; mask_bw = temp; clear temp;
            if data.flip_cell,
                temp = imrotate(mask_bw, 180);
                clear mask_bw; mask_bw = temp; clear temp;
            end;
        end;
        clear bd bw;
        show_figure = 0;
        if i==max(index_before)|| i == max(index_after),
            show_figure = 1; % show figure
        end;
        if show_figure,
            ss = size(im{i})/3*2;
            figure('color','w','Position', [100 100 ss(2) ss(1)]); 
            set(gca, 'FontSize', 12, 'FontWeight', 'bold','Box', 'off', 'LineWidth',2);
            imagesc(im{i}); hold on; axis off; 
            title(strcat('frame : ', num2str(i)));
        end;        
        [bd, bw] = detect_cell(im{i}, 'brightness_factor', bf,...
            'smoothing_factor', sf,'threshold', th,'mask_bw', mask_bw);
        if show_figure,
            plot(bd(:,2), bd(:,1),'r','LineWidth',2);
        end;
        clear mask_bw;
        % Quantify the normalized intensity on the cell.
        sum_bw = sum(bw);
        x_min = find(sum_bw, 1, 'first');
        x_max = find(sum_bw, 1, 'last');
        temp = sum(double(im{i}).*bw)./(sum_bw+~sum_bw);
        temp = (temp(x_min: x_max))';
        intensity = temp/sum(temp)*(x_max-x_min+1); % normalized intensity
        clear temp;
        x = (x_min:x_max)';
        norm_x = (x-x_min)/(x_max-x_min); % normalized cell length (0-1)
        cell_info(i).x = x;
        intensity_interp = interp1(norm_x, intensity, distance);
        intensity_smooth = smooth(distance, intensity_interp, 0.1, 'rloess');
        cell_info(i).intensity = intensity_smooth;
        clear intensity intensity_interp intensity_smooth
        end;
    end; %for i = 1:num_frames,
    
    
    save(cell_info_file, 'distance', 'cell_info', 'time');
    clear im;
else
    load(cell_info_file);
    %display(sprintf('cell_length = %f', (max(cell_info(1).x)-min(cell_info(1).x))/2.56));
end;

% make movie
if make_movie,
    info.path = data.path;
    info.first_file = 'movie_im_001';
    info.index_pattern = {'001', '%03d'};
    info.file_name = strcat(cell_name,'.avi');
    info.image_index =data.image_index;
    info.type = 1;
    info.time = time;
    info.event_text{1} = {'\downarrow PDGF'};
%     % PI3K_1
%     info.time_location = [300 10];
%     info.event_location = [300 30];
    %PI3K_4
    info.time_location = [350 15];
    info.event_location = [350 45];
    info.event_text{2} = '\downarrow LY';
%     % Rac1
%     info.time_location = [370 170];
%     info.event_location = [370 190];
    info.has_event = zeros(num_frames, 1);
    ii = find(info.image_index>=data.PDGF_add+1,1, 'first');
    info.has_event(ii:ii+5) = 1;
    if isfield(data, 'DRUG_add'),
        ii = find(info.image_index>=data.DRUG_add+1, 1, 'first');
        info.has_event(ii:ii+5) = 2;
    end;   
    
    movie = make_movie_3(info);
end

%% Draw the 3D plot and the surface of the fluorescence intensity.
time = time(image_index);
temp = cell_info(image_index); clear cell_info;
cell_info = temp; clear temp;
% 3D plot
figure('color', 'w'); hold on;
set(gca, 'FontSize',12, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth',2);
for i = 1:5:length(time),
    plot3(time(i)*ones(size(distance)), distance, cell_info(i).intensity, 'LineWidth', 2);
end;
axis([-10 40 0 1 0.3 2.5]);
set(gca,'YTick', [0; 0.5; 1], 'XTick', [-10; [0:20: 80]']);
az = -31; el = 48; view(az,el);

% surface
intensity_matrix = cat(2, cell_info.intensity); % put the intensity in rows 
figure('color','w'); set(gca, 'FontSize', 12, 'FontWeight', 'bold','Box', 'off', 'LineWidth',2);
axis([-10 40 0 1 0.3 2.5 0 2]);
set(gca,'YTick', [0; 0.5; 1], 'XTick', [-10; [0:20: 80]']);
surface(time,distance,intensity_matrix,'EdgeColor','none'); % surface plotting
shading interp;
colorbar('Box', 'off', 'FontSize', 12, 'FontWeight', 'bold','LineWidth', 2,...
    'YTick', [ 0; 0.5; 1.0; 1.5; 2.0]);
im_title= regexprep(cell_name, '_', '\\_');
title(im_title); %xlabel('Time (min)'); ylabel('Relative Distance to Junction');
zlabel('Normalized Average Fluorescent Intensity');
az = -31; el = 48; view(az,el);
hold on;
% planes indicating PDGF and additional chemicals time.
T_point = 0; InitY = -0.1; EndY = 1.1; InitZ = .7; EndZ = 1.3; PC = 'r';
h = surf([T_point T_point], [InitY EndY], [InitZ EndZ; InitZ EndZ]);
set(h, 'LineStyle', 'none','FaceColor', PC, 'FaceAlpha', 0.5);
if ~strcmp(data.DRUG_add,'none'), % check if the drug had been added
    T_point = (data.DRUG_time-data.PDGF_time)/6000; PC = 'b';
    h = surf([T_point T_point], [InitY EndY], [InitZ EndZ; InitZ EndZ]);
    set(h, 'LineStyle', 'none','FaceColor', PC, 'FaceAlpha', 0.5);
end;

clear cell_info intensity_matrix time distance;

return;   
    
