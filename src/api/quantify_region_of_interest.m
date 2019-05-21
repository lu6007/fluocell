% Function update the ratio image
% Allow the user to select the region of interest.
% And quantify the ratio within the roi
% (1) To start tracking: fluocell_data.quantify_roi = 2; 
% (2) To use subcellular layers instead of ROIs:
% fluocell_data.quantify_roi = 3;
% fluocell_data.num_roi = 3;
% To allow mask: fluocell_data.need_apply_mask = 1;
% To stop mask: fluocell_data.need_apply_mask = 0;
% (3) To stop quantification: fluocell_data.quantify_roi = 0;
% (4) To allow n regions: fluocell_data.num_roi = 3; 
% Require the intensities be be higher than intensity_bound{1}.

% Copyright: Shaoying Lu and Yingxiao Wang 2014
function data = quantify_region_of_interest(data, ratio, cfp, yfp)
% Process data.quantify_roi
switch data.quantify_roi
    case 0 % Do not quantify ROI
        disp('Warning: function quantify_region_of_interest - data.quantify_roi = 0');
        return;
    case 1 % Quantify ROI without tracking cells
        roi_type = 'draggable';
    case 2 % 2 - Quantify ROI with tracking
        roi_type = 'undraggable';
    case 3 % 3 - Quantify subcellular regions without ROI, but with tracking
        roi_type = 'no roi';
end

% When data.quantify_roi = 1 or 2
% data.quantify_roi = 1: only one roi which can be manually moved around
% data.quantify_roi = 2: more than 1 roi which can only be automatically tracked.  
if data.quantify_roi == 1 || data.quantify_roi ==2
    num_object = 1;
end

if isfield(data, 'num_roi')
    num_roi = data.num_roi;
else
    num_roi = 1;
end

if nargin == 2
    cfp = ratio;
    yfp = ratio;
end

% Get cell_bw
if data.quantify_roi == 2 || data.quantify_roi == 3
    data.track_cell = 1;
    cell_bw = data.cell_bw;
    cell_bd = data.cell_bd;
    cell_label = data.cell_label;
    % [~, cell_label] = bwboundaries(cell_bw, 8, 'noholes');
    cell_prop = regionprops(cell_label, 'Area'); 
    num_object = length(cell_bd);
    obj = cell(num_object, 1);
    for i = 1:num_object
         obj{i} = bd2im(cell_bw, cell_bd{i}(:,2), cell_bd{i}(:,1));
    end
    
    for i = 1 : num_object
        data.cell_size{i}(data.index,1) = cell_prop(i).Area; %Column format -Shannon
    end
    % need to save cell_bw in a file somewhere
    clear cell_label cell_prop; % The value of num_object changed later
    
end % if data.quantify_roi ==2 || data.quantify_roi ==3,

% Get roi_bw
switch data.quantify_roi
    case 1 % not track cell
        roi_bw = data.roi_bw;
        roi_poly = data.roi_poly;
        if isfield(data,'need_apply_mask') && data.need_apply_mask ==4
            for i = 1:num_roi
                roi_bw{i} = roi_bw{i}.*data.mask;
            end
        end
    case 2 % move roi while tracking cell
        % use the centroid of the cell to track rois
        prop = regionprops(obj{1});
        if ~isfield(data, 'ref_centroid') % reference location
            data.ref_centroid = prop.Centroid;
            roi_bw = data.roi_bw;
            roi_poly = data.roi_poly;
        else % shift roi_bw and roi_poly
            this_c = prop.Centroid;
            c_diff = floor(this_c - data.ref_centroid+0.5);
            if length(data.roi_bw)<num_roi
                disp('Warning: quantify_region_of_interest - ');
                fprintf('Reduce data.num_roi to %d\n', length(data.roi_bw));
                data.num_roi = length(data.roi_bw);
                num_roi = data.num_roi;
            end
            roi_bw = cell(num_roi, 1);
            roi_poly = cell(num_roi, 1);
            for i = 1:min(num_roi, length(data.roi_bw))
                % shift bw by c_diff
                bw_shift = circshift(data.roi_bw{i}, [c_diff(2), c_diff(1)]);
                roi_bw{i} = bw_shift.*cell_bw;  % multiply by cell_bw to make sure ratio is calculated inside detected object
                % shift the boundary by c_diff
                roi_poly{i} = data.roi_poly{i}+ones(size(data.roi_poly{i}))*[c_diff(1),0; 0, c_diff(2)];
                clear bw_shift;
            end % for i
        end % if ~isfield(data, 'ref_centroid')
    case 3 %switch data.quantify_roi,
        [roi_poly, label_layer] = divide_layer(obj, num_roi, 'method',2, ...
            'xylabel', 'normal');
        % figure; imagesc(label_layer);
        % label = 1 outlayer; label = 3 inner layer
        num_object = length(obj);
        roi_bw = cell(num_roi, num_object); 
        for i = 1 : num_object
            for j = 1 : num_roi
               roi_bw{j, i} = (label_layer{i} == j);
            end
        end
end

% Extract the time value,
% Draw the rois,
% Quantify the FI and ratio in the ROIs.
data.time(data.index,1) = data.index;
data.time(data.index,2) = get_time(data.file{1}, 'method',2);
if(data.index > 50 && data.time(data.index, 2) < data.time(data.index-1,2))
    disp('Quqntify_region_of_interest(): ');
    disp('Automatically fixing the time variable if imaging past midnight.');
    data.time(data.index,2) = data.time(data.index,2) + 1440; %1440 min = whole day
end

% Draw ROIs
% provide option for displaying figure, Lexie in 03/06/2015
if (isfield(data, 'show_figure') && data.show_figure == 1)...
        || ~isfield(data, 'show_figure')
    figure(data.f(1)); hold on;
    roi_file = strcat(data.output_path, 'roi.mat');
    draw_polygon(gca, roi_poly, 'red', roi_file, 'type', roi_type);
end

%% Modified the following for the requirement of min_intensity
if isfield(data, 'enable_min_intensity') && data.min_intensity == 1
    disp('quantify_region_of_interest(): data.enable_min_intensity == 1');
    disp('Require the intensity values to be data.intensity_bound(1) or higher.');
    min_intensity = data.intensity_bound(1);
else
    min_intensity = 0;
end
for i = 1 : num_object
    for j = 1:num_roi %subcellular layers
        if data.is_z_stack
            ii = data.z_index;
        else
            ii = data.index;
        end
        % Require all intensity to be min_intensity or higher
        mask = (cfp>= min_intensity) & (yfp>= min_intensity)& roi_bw{j,i};
        data.ratio{i}(ii, j) = compute_average_value(ratio, mask);
        data.channel1{i}(ii, j) = compute_average_value(cfp, mask);
        data.channel2{i}(ii, j) = compute_average_value(yfp, mask);
        clear mask; 
    end
end; clear i j
%%
    
% quantify background
if isfield(data, 'subtract_background') && data.subtract_background
    switch data.subtract_background
%         case 0 
%             bg_value1 = 0;
%             bg_value2 = 0;
        case {1, 2}
            bg_value1 = compute_average_value(data.im{1}, data.bg_bw);
            bg_value2 = compute_average_value(data.im{2}, data.bg_bw);
        case 3
            bg_value1 = data.bg_value(1);
            bg_value2 = data.bg_value(2);
        case 4
            fun = get_my_function(); 
            bg_value1 = fun.get_image_percentile(data.im{1}, 50);
            bg_value2 = fun.get_image_percentile(data.im{2}, 50);
    end
    data.channel1_bg(data.index) = bg_value1;
    data.channel2_bg(data.index) = bg_value2;
end


return;
