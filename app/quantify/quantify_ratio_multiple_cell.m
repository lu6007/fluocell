% function [intensity_value, ratio_value] = quantify_ratio_multiple_cell(data, varargin)
% para_name = {'add_channel','load_result', 'save_result'};
% para_default = {0, 0, 0};
% allows the quantification of many cells per image
% by manual selection or automatic detection. 
% Output: intensity_value, ratio_value: (channel 1 image)./(channel 2 image)
% intensity_value : 
% Column 1 - channel 1 average intensity
% Column 2 - channel 2 average intensity
% Column 3 - channel 3 average intensity
%
% Example: 
% >> data = quantify_ratio_init_data('sample');
% >> [intensity, ratio] = quantify_ratio_multiple_cell(data);
% >> figure; plot(intensity(:,3), ratio(:,1),'*'); 
% >> xlabel('FI 3'); ylabel('Ratio');
% >> figure; hist(ratio, 100); title('Ratio');
%
% Sample data is in D:/sof/data/quantify/ 
% Copyright: Shaoying Lu 2015-2023
% shaoying.lu@gmail.com
function [intensity_value, ratio_value] = quantify_ratio_multiple_cell(data, varargin)
para_name = {'add_channel','load_result', 'save_result', 'detect_type'};
para_default = {0, 0, 0, 4};
[add_channel, load_result, save_result, detect_type] = parse_parameter(para_name, para_default, varargin);
% detect_type: i-use channel i for detection; 4; % combine channels 1 and 2 for detection (default ch1 + ch2)

% Load file
result_file = strcat(data.path, 'output/result.mat');
if exist(result_file, 'file') && load_result
    res = load(result_file);
    intensity_value = res.intensity_value;
    ratio_value = res.ratio_value;
    return
end

%
my_fun = get_my_function();
qfun = quantify_fun();
max_num_cell = 1000;

num_image = length(data.image_index);
switch data.detection
    case 'manual'
        manual_select = 1;
    case 'auto'
        manual_select = 0;
end
intensity_value = inf*ones(max_num_cell,4);
ratio_value = inf*ones(max_num_cell,1);

% Protocol: 'FRET-Intensity-DIC'; 
% file{1} - FI 1; 2 - FI 2 ;  3- FI 3, 4- DIC
if isfield(data,'protocol')
    protocol = data.protocol;
else
    protocol = 'FRET-Intensity-DIC';
end
    
num_cell  = 0;
file = cell(4,1);
im = cell(4,1);
for i = 1:num_image
    image_index = data.image_index(i);
    index_i = sprintf(data.index_pattern{2}, image_index);
    % Load image and calulate ratio
    file{1} = regexprep(data.first_file, data.index_pattern{1}, index_i);
    bg_file = strcat(data.path, 'output/background_', index_i, '.mat');
    if ~exist(strcat(data.path, 'output/'), 'dir')
        mkdir(strcat(data.path, 'output/'));
    end
    
    switch protocol
        case {'FRET', 'FRET-Intensity', 'FRET-Intensity-DIC'}
            temp1 = imread(strcat(data.path, file{1}));
            file{2} = regexprep(file{1}, data.channel_pattern{1}, data.channel_pattern{2});
            temp2 = imread(strcat(data.path, file{2}));
        case 'FRET-Split-View'
            temp = imread(strcat(data.path, file{1}));
            temp1 = temp(1:512, :);
            temp2 = temp(513:1024, :);
            clear temp;
    end

    if isfield(data, 'subtract_background') && data.subtract_background
        data.bg_bw = get_background(temp1+temp2, bg_file, 'method', data.subtract_background); clear temp;
    end
    im{1} = preprocess(temp1, data); clear temp1;
    im{2} = preprocess(temp2, data); clear temp2;
    if strcmp(protocol, 'FRET-Split-View')
        %%% Now need to align the images in the x- and y-directions %%%
        if ~exist('shift', 'var')
            shift = my_fun.get_shift_align(im{1}, im{2});
        end
        temp2 = im{2};
        im{2} = imtranslate(temp2, shift, 'FillValues', 0);
        clear temp2;     
    end
    
    % ratio_im
    ratio = compute_ratio(im{1}, im{2});
    ratio_im = get_imd_image(ratio, max(im{1}, im{2}), ...
            'ratio_bound', data.ratio_bound, 'intensity_bound', data.intensity_bound);
            
    if add_channel % add 1 additional channel
        file{3} = regexprep(file{1}, data.channel_pattern{1}, data.channel_pattern{3});
        temp = imread(strcat(data.path, file{3}));
        im{3} = preprocess(temp,data); clear temp;
    end
    
    % im_detect
    temp = qfun.get_image_detect(im, data, 'type', detect_type);
    im_detect = uint8(preprocess(temp, data)); 
    clear temp;

    % Show the ratio image in a grid
    if num_image>1
        i8 = mod(i,8);
        if i8 == 0
            i8 = 8;
        end 
        if i8 == 1
            my_figure;
            tight_subplot(2, 4, [.01 .01], [.01 .01], [.01 .01]); hold on;
        end
        subplot(2,4,i8); % hold on;
    else
        my_figure; hold on
    end
    
    %%% Kathy 10/7/2020
%     type = 1;
%     this_im = ratio_im
    type = 2;
    this_im = im{3}; 

    if isfield(data, 'bg_bw') 
        display_boundary(data.bg_bw, 'im', this_im, 'line_color', 'r', 'new_figure', 0, 'type', type);
    else
        display_boundary([], 'im', this_im, 'line_color', 'r', 'new_figure', 0, 'type', type);
    end
    if type == 2
        colormap jet;
        caxis(data.intensity_bound);
    end
        
    %%% 
    if manual_select
        % temp = uint16(temp);
        num_roi = data.num_roi(i); 
        display_text=strcat('Please Select : ',...
            num2str(num_roi), ' Regions of Interest');
        roi_file = strcat(data.path, 'output/ROI', '_', num2str(image_index), '.mat');
        [roi_bw, ~] = get_polygon(im_detect, roi_file, display_text, ...
            'num_polygon', num_roi);
        label = zeros(size(roi_bw{1}));
        for j = 1:num_roi
            label = label + j.*roi_bw{j};
        end
    else % Automatic detection
        % for the watershed method to work, need to replace "graythresh" by
        % "detect_cell" 

        threshold = my_graythresh(im_detect);
        bw_image = imbinarize(im_detect, threshold*data.brightness_factor);
        bw_image_open = bwareaopen(bw_image, data.min_area);
        [bd, label] = bwboundaries(bw_image_open,8,'noholes');
        num_roi = length(bd);
        clear bw_image bw_image_open bd temp; 
    end % if manual_select else 
    clear temp;
    % display the detected cells
    if max(max(label))>0
        display_boundary(label, 'im', [], 'color', 'w', 'show_label', 0, 'new_figure', 0);
    end 
   
    %%% Kathy 10/7
    % Erode 6 pixels since 6.28 pixels = 1 um
    % The diameter of a sigle cell is about 100 pixels = 15.92 um
    % se = strel('diamond', 6);
    for j = 1:num_roi
        temp1 = double(label==j);
        mask = temp1; 
%         %%% Kathy 10/7/2020 % dilate mask for a fixed number of pixels here
%         % The width of the strip is 6. 
%         temp2 = imerode(temp1, se); 
%         mask = temp1 & (~temp2);
%         %%%
        area = sum(sum(mask));
        rr = sum(sum(ratio.*mask))/area;
        fi1 = sum(sum(im{1}.*mask))/area;
        fi2 = sum(sum(im{2}.*mask))/area;
        if add_channel
            fi3 = sum(sum(im{3}.*mask))/area;
        end
        % min_intensity = 500;
        % if rr<max_ratio && fi1>= min_intensity && fi2>= min_intensity ,
        % A cell is detected if FRET > 15000
        % A cell is selected if the ratio values is less than 0.5 to exclude dead cells, 
        % CFP intensity > 1000; FRET intensity > 1000 and <=40000 to
        % exclude intensity saturated cells
        % mCherry intensity > 5000 to allow sufficient expression and overcoming autofluorescence. 
        % if rr<0.5 && fi1>= min_intensity && fi2<=40000 && fi3>5000, % && fi3>7000, 
        % cytosolic mCherry >5000
        % mCherry-Lck>500 
        % if rr<0.5 && fi1>= min_intensity && fi2<=40000 && fi3>500 
            num_cell = num_cell+1;
            ratio_value(num_cell,1) = rr;
            intensity_value(num_cell,1) = fi1;
            intensity_value(num_cell,2) = fi2;
            if add_channel
                 intensity_value(num_cell,3) = fi3;
            end
            % end
        clear mask;
    end
    clear roi_poly roi_bw file im ratio ratio_im mask;
    title(strcat('Intensity Ratio - ', index_i));
end % for i = 1:num_image

if isfield(data, 'max_ratio')
    max_ratio = data.max_ratio;
    index = (ratio_value<=max_ratio);
    temp = intensity_value; clear intensity_value;
    intensity_value = temp(index,:); clear temp;
    temp = ratio_value; clear ratio_value;
    ratio_value = temp(index, :); clear temp;
%     my_figure; histogram(ratio_value(:,1));
%     xlabel('Ratio'); ylabel('Count'); 
    % % my_figure; histogram(intensity_value(:,2), 20);
    % xlabel('Channel 2 Intensity'); ylabel('Count');
end 

%
if save_result
    save(result_file, 'intensity_value', 'ratio_value');
end
return;
    
    

