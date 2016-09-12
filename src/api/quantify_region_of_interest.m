% Function update the ratio image
% Allow the user to select the region of interest.
% And quantify the ratio within the roi
% (1) To start tracking: fluocell_data.quantify_roi = 2; 
% (2) To use subcellular layers instead of ROIs:
% fluocell_data.quantify_roi = 3;
% fluocell_data.num_layers = 3;
% by change the value of parameter save_bw_file, you could 
% decide save the cell_bw file of not
% default save_bw_file = 0 ( not saving those file)
% save_bw_file = 1 (save cell_bw file)
% To allow mask: fluocell_data.need_apply_mask = 1;
% To stop mask: fluocell_data.need_apply_mask = 0;
% (3) To stop quantification: fluocell_data.quantify_roi = 0;
% (4) To allow n regions: fluocell_data.num_rois = 3; 

% Copyright: Shaoying Lu and Yingxiao Wang 2014
function data = quantify_region_of_interest(data, ratio, cfp, yfp, varargin)
parameter_name = {'save_bw_file'};
default_value = {0};
[save_bw_file] = parse_parameter(parameter_name, default_value, varargin);
%Lexie on 3/10/2015 make the show_figure option work for both situations,
%w/o show_figure field
show_figure_option = ~isfield(data, 'show_figure') || data.show_figure;
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
% data.quantify_roi =1: only one roi which can be manually moved around
% data.quantify_roi = 2: more than 1 roi which can only be automatically tracked.  
if data.quantify_roi == 1 || data.quantify_roi ==2,
    if isfield(data,'num_rois'),
        num_rois = data.num_rois;
    else
        num_rois = 1;
    end;
end;

% Multiple layers for multiple rois and
% tracking
%elseif data.quantify_roi == 3,
if isfield(data, 'num_layers'),
    num_layers = data.num_layers;
else
    num_layers = 1;
end;
%end;
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
        im = cfp + yfp;
        if isfield(data, 'need_apply_mask') && data.need_apply_mask,
            temp = uint16(im).*uint16(data.mask); clear im;
            im = temp; clear temp;
        end;
        % Lexie on 03/10/2015
%         temp_file = strcat(data.output_path, 'cell_bw.t', num2str(data.index));
        % Read mat file instead of tiff file, Lexie on 12/14/2015
        temp_file_mat = strcat(data.output_path, 'cell_bw.t', num2str(data.index), '.mat');
        temp_file_tiff = strcat(data.output_path, 'cell_bw.t', num2str(data.index));
        if exist(temp_file_mat, 'file')
%             cell_bw = imread(temp_file); clear temp_file
            % Load the mat file instead of the tiff file, Lexie on
            % 12/14/2115
            load(temp_file_mat); clear temp_file_mat
            
        % For backward compatibility of the tiff file, Lexie on 12/14/2015
        elseif exist(temp_file_tiff, 'file')
            cell_bw = imread(temp_file_tiff); 
            % delete the old tiff cell_bw file and save it to be new mat
            % file. Lexie on 12/21/2015
            delete(temp_file_tiff); clear temp_file_tiff
            save(temp_file_mat, 'cell_bw');
        else
            if ~isfield(data, 'multiple_object') || ~data.multiple_object
                [~, cell_bw] = detect_cell(im, 'show_figure', show_figure_option, 'smoothing_factor',3,'brightness_factore', 1.1);
            else
                [~, cell_bw] = detect_cell(im, 'show_figure', show_figure_option, 'smoothing_factor',3,'brightness_factore', 1.1, 'multiple_object', data.multiple_object);
            end
            % save cell_bw file to be mat file instead of tiff, Lexie on
            % 12/14/2015
            if save_bw_file 
                save(temp_file_mat, 'cell_bw');
            end
        end
    end;
    % compute cell size
%     for i = 1 : length(cell_bw)
%         data.cell_size{data.index, i} = sum(sum(double(cell_bw)));
%     end
    % Compute the cell size based on the new cell data structure, Lexie on
    % 12/16/2015
    [cell_bd, cell_label] = bwboundaries(cell_bw, 8, 'noholes');
    cell_prop = regionprops(cell_label, 'Area'); 
    num_objects = length(cell_bd);
    obj = cell(num_objects, 1);
    for i = 1:num_objects
         obj{i} = bd2im(cell_bw, cell_bd{i}(:,2), cell_bd{i}(:,1));
    end;
    
    for i = 1 : num_objects
%         %%% Kathy bug fix 07/22/2016
%         if num_objects ==1,
%             data.cell_size(data.index) = cell_prop(1).Area;
%         else
            %data.cell_size{i}(data.index) = sum(sum(uint16(obj{i})));
            data.cell_size{i}(data.index) = cell_prop(i).Area;
%        end
    end
    % need to save cell_bw in a file somewhere
    clear num_objects cell_label cell_prop; % The value of num_objects changed later
    
end; % if data.quantify_roi ==2 || data.quantify_roi ==3,

% Get roi_bw
switch data.quantify_roi,
    case 1, % not track cell
        roi_bw = data.roi_bw;
        roi_poly = data.roi_poly;
        % Since there is no cell_bw file, calculate the num_rois based on
        % roi_bw, Lexie on 12/15/2015
        if ~exist('cell_bw', 'var')
            num_rois = length(roi_bw);
        end
    case 2, % move roi while tracking cell
        % use the centroid of the cell to track rois
        prop = regionprops(obj{1});
        if ~isfield(data, 'ref_centroid'), % reference location
            data.ref_centroid = prop.Centroid;
            roi_bw = data.roi_bw;
            roi_poly = data.roi_poly;
        else % shift roi_bw and roi_poly
            this_c = prop.Centroid;
            c_diff = floor(this_c - data.ref_centroid+0.5);
            if length(data.roi_bw)<num_rois,
                display('Warning: quantify_region_of_interest - ');
                display(sprintf('Reduce data.num_rois to %d', length(data.roi_bw)));
                data.num_rois = length(data.roi_bw);
                num_rois = data.num_rois;
            end;
            roi_bw = cell(num_rois, 1);
            roi_poly = cell(num_rois, 1);
            for i = 1:min(num_rois, length(data.roi_bw)),
                % shift bw by c_diff
                bw_shift = circshift(data.roi_bw{i}, [c_diff(2), c_diff(1)]);
                roi_bw{i} = bw_shift.*cell_bw;  % multiply by cell_bw to make sure ratio is calculated inside detected object
                % shift the boundary by c_diff
                roi_poly{i} = data.roi_poly{i}+ones(size(data.roi_poly{i}))*[c_diff(1),0; 0, c_diff(2)];
                clear bw_shift;
            end; % for i
        end; % if ~isfield(data, 'ref_centroid')
        num_rois = length(data.roi_bw);
    % Lexie on 12/10/2015, change the roi data structure to fit mutiple tracking and multiple layers situation   
    case 3, %switch data.quantify_roi,
        [roi_poly, label_layer] = divide_layer(obj, num_layers, 'method',2, ...
            'xylabel', 'normal');
        % figure; imagesc(label_layer);
        % label = 1 outlayer; label = 3 inner layer
        num_rois = length(obj);
        roi_bw = cell(num_rois, num_layers); 
        for j = 1 : num_rois
            for i = 1 : num_layers,
               roi_bw{j, i} = (label_layer{j} == i);
            end;
        end
end;


% Extract the time value,
% Draw the rois,
% Quantify the FI and ratio in the ROIs.
data.time(data.index,1) = data.index;
data.time(data.index, 2) = get_time(data.file{1}, 'method',2);
% Draw ROIs
% provide option for displaying figure, Lexie in 03/06/2015
if (isfield(data, 'show_figure') && data.show_figure == 1)...
        || ~isfield(data, 'show_figure')
    figure(data.f(1)); hold on;
    roi_file = strcat(data.output_path, 'roi.mat');
    draw_polygon(gca, roi_poly, 'red', roi_file, 'type', roi_type);
end
%
% data.value, data.ratio etc were initialized in get_image()
% data.value(data.index,1) = compute_average_value(ratio, roi_bw{1});
% data.value(data.index,2) = compute_average_value(cfp, roi_bw{1});
% data.value(data.index,3) = compute_average_value(yfp, roi_bw{1});
%
% for i = 1:num_layers,
%     data.ratio(data.index, i) = compute_average_value(ratio, roi_bw{i});
%     data.channel1(data.index, i) = compute_average_value(cfp, roi_bw{i});
%     data.channel2(data.index, i) = compute_average_value(yfp, roi_bw{i});
% end;

% For multiple tracking and multiple layers, Lexie on 12/10/2015
% if there is only roi_bw instead of cell_bw

% remove the calculation of value from the fluocell_data, Lexie on
% 12/16/2015
% for j = 1 : num_rois
%     data.value{j}(data.index, 1) = compute_average_value(ratio, roi_bw{j});
%     data.value{j}(data.index, 2) = compute_average_value(cfp, roi_bw{j});
%     data.value{j}(data.index, 3) = compute_average_value(yfp, roi_bw{j});
% end

%% Modified the following for loop to shrink area of quantification. - Shannon 8/4/2016
for i = 1 : num_rois
    for j = 1:num_layers,
        %Modified to try to shrink the area that needs to be computed. - Shannon 8/4/2016
%         data.ratio{j}(data.index, i) = compute_average_value(ratio, roi_bw{j,i});
%         data.channel1{j}(data.index, i) = compute_average_value(cfp, roi_bw{j,i});
%         data.channel2{j}(data.index, i) = compute_average_value(yfp, roi_bw{j,i});

        %BoundingBox retrieves the upper left coordinates and the 
        %length and width of a rectangle bounding the region of interest.
        stat = regionprops(roi_bw{i,j},'BoundingBox');
        %Use fix to ensure values are greater than 0, but less than the max value.
        boundingBox = fix(stat.BoundingBox - 1) + 1; %[x_ul,y_ul,x_width,y_width]
        %Shrink the widths in case the BoundingBox is the entire width of the image.
        boundingBox(3:4) = boundingBox(3:4)-1;
        %Calculating coordinates of the bottom right corner.
        brCorner = [boundingBox(1) + boundingBox(3), boundingBox(2) + boundingBox(4)];%[x_br,y_br]
        yBound = boundingBox(2):brCorner(2); %y_ul:y_br
        xBound = boundingBox(1):brCorner(1); %x_ul:x_br
        %Using (yBound,xBound) since the image's matrix is stored as (col,row) 
        %i.e. (y-reversed,x) instead of (x,y).
        boundedRoiBw = roi_bw{i,j}(yBound,xBound);
        
        data.ratio{i}(data.index, j) = compute_average_value(ratio(yBound,xBound), boundedRoiBw);
        data.channel1{i}(data.index, j) = compute_average_value(cfp(yBound,xBound), boundedRoiBw);
        data.channel2{i}(data.index, j) = compute_average_value(yfp(yBound,xBound), boundedRoiBw);
    end;
end
%%
    
% quantify background
if isfield(data, 'subtract_background') && data.subtract_background,
%     data.channel1_bg(data.index) = compute_average_value(cfp, data.bg_bw);
%     data.channel2_bg(data.index) = compute_average_value(yfp, data.bg_bw);
% matrix didn't match, Lexie on 02/19/2015
    data.channel1_bg(data.index) = compute_average_value(data.im{1}, data.bg_bw);
    data.channel2_bg(data.index) = compute_average_value(data.im{2}, data.bg_bw);
end;


return;
