% function [intensity_value, ratio_value] = quantify_ratio_multiple_cell(data, varargin)
% para_name = {'add_channel','load_result', 'save_result'};
% para_default = {0, 0, 0};
% allows the quantification of many cells per image
% by manual selection or automatic detection. 
% Output: intensity_value, ratio_value
% intensity_value : 
% Column 1 - channel 1 intensity
% Column 2 - channel 2 intensity
% Column 3 - channel 3 intensity
%
% Example: 
% >> data = quantify_ratio_init_data('sample');
% >> [intensity, ratio] = quantify_ratio_multiple_cell(data);
% >> figure; plot(intensity(:,3), ratio(:,1),'*'); 
% >> xlabel('FI 3'); ylabel('Ratio');
% >> figure; hist(ratio, 100); title('Ratio');
%
% Sample data is in D:/sof/data/quantify/ 
% Copyright: Shaoying Lu 2015-2017
% shaoying.lu@gmail.com
function [intensity_value, ratio_value] = quantify_ratio_multiple_cell(data, varargin)
para_name = {'add_channel','load_result', 'save_result', 'detect_type'};
para_default = {0, 0, 0, 4};
[add_channel, load_result, save_result, detect_type] = parse_parameter(para_name, para_default, varargin);

% Load file
result_file = strcat(data.path, 'output/result.mat');
if exist(result_file, 'file') && load_result
    res = load(result_file);
    intensity_value = res.intensity_value;
    ratio_value = res.ratio_value;
    return
end

%
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
num_cell  = 0;
file = cell(4,1);
im = cell(4,1);
for i = 1:num_image
    index_i = sprintf(data.index_pattern{2}, data.image_index(i));
    % Load image and calulate ratio
    file{1} = regexprep(data.first_file, data.index_pattern{1}, index_i);
    temp1 = imread(strcat(data.path, file{1}));
    bg_file = strcat(data.path, 'output/background_', index_i, '.mat');
    file{2} = regexprep(file{1}, data.channel_pattern{1}, data.channel_pattern{2});
    temp2 = imread(strcat(data.path, file{2}));
    if ~exist(strcat(data.path, 'output/'), 'dir')
        mkdir(strcat(data.path, 'output/'));
    end
    if add_channel % add 1 additional channel
        file{3} = regexprep(file{1}, data.channel_pattern{1}, data.channel_pattern{3});
        temp3 = imread(strcat(data.path, file{3}));
    end

    temp = qfun.get_image_detect({temp1, temp2, temp3}, data, 'type', detect_type);
    if isfield(data, 'subtract_background') && data.subtract_background
        data.bg_bw = get_background(temp, bg_file, 'method', data.subtract_background); 
    end
    im{1} = preprocess(temp1, data); clear temp1;
    im{2} = preprocess(temp2, data); clear temp2;
    ratio = compute_ratio(im{1}, im{2});
    im_detect = uint8(preprocess(temp, data)); 
    % ratio_im
    ratio_im = get_imd_image(ratio, im_detect, ...
            'ratio_bound', data.ratio_bound, 'intensity_bound', data.intensity_bound);
    clear temp;
        
    if add_channel % add 1 additional channel
        im{3} = preprocess(temp3,data); clear temp3;
    end
    
    i8 = mod(i,8);
    if i8 == 0
        i8 = 8;
    end 
    if i8 == 1
        my_figure;
        tight_subplot(2, 4, [.01 .01], [.01 .01], [.01 .01]); hold on;
    end
    subplot(2,4, i8); % hold on;
    
    % im_detect is the image used for detection. 
    % im_detect = qfun.get_image_detect(im, data, 'type', detect_type);
    if isfield(data, 'bg_bw') 
        display_boundary(data.bg_bw, 'im', ratio_im, 'line_color', 'r', 'new_figure', 0, 'display', 2);
    % display_boundary(data.bg_bw, 'im', im{2}, 'line_color', 'r', 'new_figure', 0, 'type', 2);
    else
        display_boundary([], 'im', ratio_im, 'line_color', 'r', 'new_figure', 0, 'display', 2);
    end
       
    %%% 
    if manual_select
        % temp = uint16(temp);
        num_roi = 1; 
        display_text=strcat('Please Select : ',...
            num2str(num_roi), ' Regions of Interest');
        roi_file = strcat(p, 'output\ROI', '_', image_index, '.mat');
        [roi_bw, ~] = get_polygon(im_detect, roi_file, display_text, ...
            'num_polygon', num_roi);
        [~, label] = bwboundaries (roi_bw, 8, 'noholes');
    else % Automatic detection
        % for the watershed method to work, need to replace "graythresh" by
        % "detect_cell" 
        threshold = graythresh(uint8(im_detect));
        if strcmp(version, 'R2017')||strcmp(version, 'R2018')
            bw_image = imbinarize(im_detect, threshold*data.brightness_factor);
        else % older versions
            bw_image = im2bw(im_detect, threshold*data.brightness_factor);
        end
% % %%% Modify here 11/3/2016 %%%
% %         bw_image = (im_detect>15000); 
        bw_image_open = bwareaopen(bw_image, data.min_area);
        [bd, label] = bwboundaries(bw_image_open,8,'noholes');
        num_roi = length(bd);
        clear bw_image bw_image_open bd temp; 
    end % if manual_select
    clear temp;
    % display ob
    if max(max(label))>0
        display_boundary(label, 'im', [], 'color', 'w', 'show_label', 0, 'new_figure', 0);
    end 
   
    for j = 1:num_roi
        mask = double(label==j);
        area = sum(sum(mask));
        rr = sum(sum(ratio.*mask))/area;
        fi1 = sum(sum(im{1}.*mask))/area;
        fi2 = sum(sum(im{2}.*mask))/area;
        if add_channel
            fi3 = sum(sum(im{3}.*mask))/area;
        end
        % max_ratio = 10.0;
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
temp = intensity_value; clear intensity_value;
intensity_value = temp(1:num_cell,:); clear temp;
temp = ratio_value; clear ratio_value;
ratio_value = temp(1:num_cell, :); clear temp;
% my_figure; hist(ratio_value(:,1), 20); 
% xlabel('Ratio'); ylabel('Count'); 

%
if save_result
    save(result_file, 'intensity_value', 'ratio_value');
end
return;
    
    

