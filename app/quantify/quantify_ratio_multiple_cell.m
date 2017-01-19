% function intensity_value = quantify_ratio_multiple_cell(data, varargin)
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
%
% Sample data is in D:/sof/data/quantify/ 
% Copyright: Shaoying Lu 2015
% shaoying.lu@gmail.com
function [intensity_value, ratio_value] = quantify_ratio_multiple_cell(data, varargin)
para_name = {'add_channel'};
para_default = {0};
add_channel = parse_parameter(para_name, para_default, varargin);

max_ratio = 10.0;
min_intensity = 1000;
num_images = length(data.image_index);
switch data.detection
    case 'manual'
        manual_select = 1;
    case 'auto'
        manual_select = 0;
end;
intensity_value = inf*ones(500,4);
ratio_value = inf*ones(500,1);

% Protocol: 'FRET-Intennsity-DIC'; 
% file{1} - FI 1; 2 - FI 2 ;  3- FI 3, 4- DIC
num_cells  = 0;
file = cell(4,1);
im = cell(4,1);
ratio_im = cell(1,1);
for i = 1:num_images,
    index_i = sprintf(data.index_pattern{2}, data.image_index(i));
    % Load image and calulate ratio
    file{1} = regexprep(data.first_file, data.index_pattern{1}, index_i);
    temp = imread(strcat(data.path, file{1}));
    if ~exist(strcat(data.path, 'output/'), 'dir'),
        mkdir(strcat(data.path, 'output/'));
    end;
    bg_file = strcat(data.path, 'output/background_', index_i, '.mat');
    data.bg_bw = get_background(temp, bg_file, 'method', 'auto');
    im{1} = preprocess(temp, data); clear temp;
    file{2} = regexprep(file{1}, data.channel_pattern{1}, data.channel_pattern{2});
    temp = imread(strcat(data.path, file{2}));
    im{2} = preprocess(temp, data); clear temp;
    ratio = compute_ratio(im{1}, im{2});
    % ratio_im
    ratio_im{1} = get_imd_image(ratio, max(im{1}, im{2}), ...
            'ratio_bound', data.ratio_bound, 'intensity_bound', data.intensity_bound);
        
    if add_channel, % add 1 additional channel
        file{3} = regexprep(file{1}, data.channel_pattern{1}, data.channel_pattern{3});
        temp = imread(strcat(data.path, file{3}));
        im{3} = preprocess(temp,data); clear temp;
    end;
    
    i8 = mod(i,8);
    if i8 == 0,
        i8 = 8;
    end; 
    if i8 == 1,
        my_figure;
    end;
    subplot(2,4, i8); hold on;
    % display all detected object in red
    display_boundary(data.bg_bw, 'im', ratio_im{1}, 'line_color', 'r', 'new_figure', 0);

    % Select ROIs by hand
    % Kathy 02/21/2016 for manual selection, this need to update to allow user to input num_rois
    %temp = uint16(im{1});
    temp = uint16(im{2});
    if manual_select,
        % temp = uint16(temp);
        num_rois = 1; 
        display_text=strcat('Please Select : ',...
            num2str(num_rois), ' Regions of Interest');
        roi_file = strcat(p, 'output\ROI', '_', image_index, '.mat');
        [roi_bw, ~] = get_polygon(temp, roi_file, display_text, ...
            'num_polygons', num_rois);
        [~, label] = bwgoundaries (roi_bw, 8, 'noholes');
    else % Automatic detection
%         threshold = graythresh(temp); 
%         bw_image = im2bw(temp, threshold*data.brightness_factor);
%%% Modify here 11/3/2016 %%%
        bw_image = (temp>15000); 
        bw_image_open = bwareaopen(bw_image, data.min_area);
        [bd, label] = bwboundaries(bw_image_open,8,'noholes');
        num_rois = length(bd);
        clear bw_image bw_image_open bd temp; 
    end; % if manual_select
    clear temp;
    % display ob
    if max(max(label))>0,
        display_boundary(label, 'im', [], 'color', 'k', 'show_label', 1, 'new_figure', 0);
    end; 
   
    for j = 1:num_rois,
        mask = double(label==j);
        area = sum(sum(mask));
        rr = sum(sum(ratio.*mask))/area;
        fi1 = sum(sum(im{1}.*mask))/area;
        fi2 = sum(sum(im{2}.*mask))/area;
        if add_channel,
            fi3 = sum(sum(im{3}.*mask))/area;
        end;
        % if rr<max_ratio && fi1>= min_intensity && fi2>= min_intensity ,
        % A cell is detected if FRET > 15000
        % A cell is selected if the ratio values is less than 0.5 to exclude dead cells, 
        % CFP intensity > 1000; FRET intensity > 1000 and <=40000 to
        % exclude intensity saturated cells
        % mCherry intensity > 5000 to allow sufficient expression and overcoming autofluorescence. 
        % if rr<0.5 && fi1>= min_intensity && fi2<=40000 && fi3>5000, % && fi3>7000, 
        % cytosolic mCherry >5000
        % mCherry-Lck>500 
         if rr<0.5 && fi1>= min_intensity && fi2<=40000 && fi3>500, 
            num_cells = num_cells+1;
            ratio_value(num_cells,1) = rr;
            intensity_value(num_cells,1) = fi1;
            intensity_value(num_cells,2) = fi2;
            if add_channel,
                 intensity_value(num_cells,3) = fi3;
            end;
            display_boundary(mask, 'im', [], 'color', 'w', 'show_label', 0, 'new_figure', 0);
        end;
        clear mask;
    end;
    clear roi_poly roi_bw file im ratio ratio_im mask;
    % display_boundary(label, 'im', [], 'color', 'w', 'show_label',1,'new_figure', 0);
    title(strcat('Intensity Ratio - ', index_i));
    
end; %i
temp = intensity_value; clear intensity_value;
intensity_value = temp(1:num_cells,:); clear temp;
temp = ratio_value; clear ratio_value;
ratio_value = temp(1:num_cells, :); clear temp;
my_figure; hist(ratio_value(:,1), 20); 
xlabel('Ratio'); ylabel('Count'); 

return;
    
    

