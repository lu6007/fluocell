% Function update the ratio image
% Allow the user to select the region of interest.
% And quantify the ratio within the roi
% (1) To start tracking: fluocell_data.quantify_roi = 2; 
% (2) To use subcellular layers instead of ROIs:
% fluocell_data.quantify_roi = 3;
% fluocell_data.num_layers = 3;
% To allow mask: fluocell_data.need_apply_mask = 1;
% To stop mask: fluocell_data.need_apply_mask = 0;
% (3) To stop quantification: fluocell_data.quantify_roi = 0;
% (4) To allow n regions: fluocell_data.num_rois = 3; 

% Copyright: Shaoying Lu and Yingxiao Wang 2014
function data = quantify_region_of_interest(data, ratio, cfp, yfp)
% Process data.quantify_roi
switch data.quantify_roi,
    case 0, % Do not quantify ROI
        display('Warning: function quantify_region_of_interest - data.quantify_roi = 0');
        return;
    case 1, % Quantify ROI without tracking cells
        roi_type = 'draggable';
    case 2, % 2 - Quantify ROI with tracking
        roi_type = 'undraggable';
    case 3, % 3 - Quantify subcellular regions without ROI, but with tracking
        roi_type = 'no roi';
end;

% When data.quantify_roi = 1 or 2
if data.quantify_roi == 1 || data.quantify_roi ==2,
    if isfield(data,'num_rois'),
        num_polygons = data.num_rois;
    else
        num_polygons = 1;
    end;


% When data.quantify_roi = 3
elseif data.quantify_roi == 3,
    if isfield(data, 'num_layers'),
        num_layers = data.num_layers;
    else
        num_layers = 1;
    end;
    num_polygons = num_layers;
end;
% 
if nargin == 2,
    cfp = ratio;
    yfp = ratio;
end;

% Get cell_bw
if data.quantify_roi == 2 || data.quantify_roi == 3,
    data.track_cell = 1;
    if isfield(data,'show_detected_boundary') && data.show_detected_boundary && ...
            isfield(data, 'cell_bw'),
        cell_bw = data.cell_bw;
    else 
        % detect the cell shape (this part should be moved too)
        % use the centroid of the cell to move the regions of interest
        im = cfp+yfp;
        if isfield(data, 'need_apply_mask') && data.need_apply_mask,
            temp = uint16(im).*uint16(data.mask); clear im;
            im = temp; clear temp;
        end;
        [~, cell_bw] = detect_cell(im, 'show_figure', 1, 'smoothing_factor',3,'brightness_factore', 1.1);
    end;
    % compute cell size
    data.cell_size(data.index) = sum(sum(double(cell_bw)));
    
    % need to save cell_bw in a file somewhere
    
end; % if data.quantify_roi ==2 || data.quantify_roi ==3,

% Get roi_bw
switch data.quantify_roi,
    case 1, % not track cell
        roi_bw = data.roi_bw;
        roi_poly = data.roi_poly;
    case 2, % move roi while tracking cell
        % use the centroid of the cell to track rois
        prop = regionprops(cell_bw);
        if ~isfield(data, 'ref_centroid'), % reference location
            data.ref_centroid = prop.Centroid;
            roi_bw = data.roi_bw;
            roi_poly = data.roi_poly;
        else % shift roi_bw and roi_poly
            this_c = prop.Centroid;
            c_diff = floor(this_c - data.ref_centroid+0.5);
            if length(data.roi_bw)<num_polygons,
                display('Warning: quantify_region_of_interest - ');
                display(sprintf('Reduce data.num_rois to %d', length(data.roi_bw)));
                data.num_rois = length(data.roi_bw);
                num_polygons = data.num_rois;
            end;
            roi_bw = cell(num_polygons, 1);
            roi_poly = cell(num_polygons, 1);
            for i = 1:min(num_polygons, length(data.roi_bw)),
                % shift bw by c_diff
                bw_shift = circshift(data.roi_bw{i}, [c_diff(2), c_diff(1)]);
                roi_bw{i} = bw_shift.*cell_bw;
                % shift the boundary by c_diff
                roi_poly{i} = data.roi_poly{i}+ones(size(data.roi_poly{i}))*[c_diff(1),0; 0, c_diff(2)];
                clear bw_shift;
            end; % for i
        end; % if ~isfield(data, 'ref_centroid')
    case 3, %switch data.quantify_roi,
        [roi_poly, label_layer] = divide_layer(cell_bw, num_layers, 'method',2, ...
            'xylabel', 'normal');
        % figure; imagesc(label_layer);
        % label = 1 outlayer; label = 3 inner layer
        roi_bw = cell(num_polygons, 1);
        for i = 1:num_polygons,
           roi_bw{i} = (label_layer == i);
        end;
end;


% Extract the time value,
% Draw the rois,
% Quantify the FI and ratio in the ROIs.
data.time(data.index,1) = data.index;
data.time(data.index, 2) = get_time(data.file{1}, 'method',2);
% Draw ROIs
figure(data.f(1)); hold on;
roi_file = strcat(data.output_path, 'roi.mat');
draw_polygon(gca, roi_poly, 'red', roi_file, 'type', roi_type);
%
% data.value, data.ratio etc were initialized in get_image()
data.value(data.index,1) = compute_average_value(ratio, roi_bw{1});
data.value(data.index,2) = compute_average_value(cfp, roi_bw{1});
data.value(data.index,3) = compute_average_value(yfp, roi_bw{1});
%
for i = 1:num_polygons,
    data.ratio(data.index, i) = compute_average_value(ratio, roi_bw{i});
    data.channel1(data.index, i) = compute_average_value(cfp, roi_bw{i});
    data.channel2(data.index, i) = compute_average_value(yfp, roi_bw{i});
end;
    
% quantify background
if isfield(data, 'subtract_background') && data.subtract_background,
    data.channel1_bg(data.index) = compute_average_value(cfp, data.bg_bw);
    data.channel2_bg(data.index) = compute_average_value(yfp, data.bg_bw);
end;


return;
