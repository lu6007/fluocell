% function average_value = quantify_ratio_multiple_cell(data, varargin)
% allows the quantification of many cells per image
% by manual selection or automatic detection. 
%
% Example: 
% >> data = quantify_ratio_init_data('sample');
% >> value = quantify_ratio_multiple_cell(data);
% >> figure; plot(value(:,1), value(:,2),'*');
%
% Sample data is in D:/sof/data/quantify/ 
% Copyright: Shaoying Lu 2015
% shaoying.lu@gmail.com
function average_value = quantify_ratio_multiple_cell(data, varargin)
para_name = {'add_channel'};
para_default = {0};
parse_parameter(para_name, para_default, varargin);

max_ratio = 10.0;
min_intensity = 1000;
num_images = length(data.image_index);
switch data.detection
    case 'manual'
        manual_select = 1;
    case 'auto'
        manual_select = 0;
end;
average_value = inf*ones(500,4);

% Protocol: 'FRET-Intennsity-DIC'; 
% file{1} - FRET; 2 - CFP ; 3- ratio; 4- YFP, 5- DIC
num_cells  = 0;
file = cell(5,1);
im = cell(5,1);
for i = 1:num_images,
    index_i = sprintf(data.index_pattern{2}, data.image_index(i));
    % Load image and calulate ratio
    file{1} = regexprep(data.first_file, data.index_pattern{1}, index_i);
    temp = imread(strcat(data.path, file{1}));
    bg_file = strcat(data.path, 'output/background_', index_i, '.mat');
    data.bg_bw = get_background(temp, bg_file, 'method', 'auto');
    im{1} = preprocess(temp, data); clear temp;
    file{2} = regexprep(file{1}, data.channel_pattern{1}, data.channel_pattern{2});
    temp = imread(strcat(data.path, file{2}));
    im{2} = preprocess(temp, data); clear temp;
    ratio = compute_ratio(im{1}, im{2});
    
    % 3 - ratio_im
    im{3} = get_imd_image(ratio, max(im{1}, im{2}), ...
            'ratio_bound', data.ratio_bound, 'intensity_bound', data.intensity_bound);
    if i == 1,
        my_figure;
    end;
    if i<=8,
        subplot(2,4, i); hold on;
        display_boundary(data.bg_bw, 'im', im{3}, 'line_color', 'r', 'new_figure', 0);
    else 
        display_boundary(data.bg_bw, 'im', im{3}, 'line_color', 'r', 'new_figure', 1);        
    end;

    % Select ROIs by hand
    if manual_select,
        num_rois = 1; % Kathy 02/21/2016 for manual selection, this need to update to allow user to input num_rois
        display_text=strcat('Please Select : ',...
            num2str(num_rois), ' Regions of Interest');
        roi_file = strcat(p, 'output\ROI', '_', image_index, '.mat');
        [roi_bw, ~] = get_polygon(im{1}, roi_file, display_text, ...
            'num_polygons', num_rois);
        [~, label] = bwgoundaries (roi_bw, 8, 'noholes');
    else % Automatic detection
        temp = uint16(im{1});
        threshold = graythresh(temp); 
        bw_image = im2bw(temp, threshold*data.brightness_factor);
        bw_image_open = bwareaopen(bw_image, data.min_area);
        [bd, label] = bwboundaries(bw_image_open,8,'noholes');
        num_rois = length(bd);
        clear bw_image bw_image_open bd temp; 
    end; % if manual_select
   
    for j = 1:num_rois,
        mask = double(label==j);
        area = sum(sum(mask));
        rr = sum(sum(ratio.*mask))/area;
        fi = sum(sum(im{1}.*mask))/area;
        ci = sum(sum(im{2}.*mask))/area;
        if rr<max_ratio && fi>= min_intensity && ci>= min_intensity ,
            num_cells = num_cells+1;
            average_value(num_cells,1) = rr;
            average_value(num_cells,2) = fi;
            average_value(num_cells,3) = ci;
        end;
        clear mask;
    end;
    clear roi_poly roi_bw file im ratio mask;
    display_boundary(label, 'im', [], 'color', 'w', 'show_label',1,'new_figure', 0);
    title(strcat('Intensity Ratio - ', index_i));
    
end; %i
temp = average_value; clear average_ratio;
average_value = temp(1:num_cells,:); clear temp;
my_figure; hist(average_value(:,1), 20); 
xlabel('Ratio'); ylabel('Count')

return;
    
    

