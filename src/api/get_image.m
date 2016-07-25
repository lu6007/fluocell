% function data = get_image(data,new_first_file)
% This is the file I/O interface of Fluocell
% Get image from files depending on different protols
% Initialize the result data structure. 
% When enabled, the get_image function also load background, the
% cropping rectangle, or the mask. 
% Initialize the global variable fluocell_data_roi_move


% Copyright: Shaoying Lu and Yingxiao Wang 2011

function data = get_image(data,new_first_file)
% A global variable spans all the functions where this variable is declared
% global.
global fluocell_data_roi_move
if isempty(fluocell_data_roi_move),
    fluocell_data_roi_move = 0;
end;

% update the first file
% pattern = data.index_pattern{2}; 
index_str = sprintf(data.index_pattern{2}, data.index);
if new_first_file
    data.first_file = strcat(data.path, data.prefix, data.postfix);
    data.file{1} = data.first_file;
else
    num_matching = length(regexp(data.first_file, data.index_pattern{1}));
    data.file{1} = regexprep(data.first_file, data.index_pattern{1}, ...
        index_str, num_matching);
end;
if exist(data.file{1}, 'file'),
    im = imread(data.file{1});
else
    data.im{1} = [];
    return;
end;

% Load background into data.bg_bw and data.bg_poly
if fluocell_data_roi_move,
    if isfield(data, 'bg_poly'),
        temp = rmfield(data,'bg_poly'); clear data;
        data = rmfield(temp, 'bg_bw'); clear temp;
    end;
    if isfield(data, 'roi_poly'),
        temp = rmfield(data, 'roi_poly'); clear data;
        data = temp; clear temp;
    end;
    fluocell_data_roi_move = 0;
end;
% Lexie on 02/18/2015
% 1. right method to choose bg
% 2. if there is already bg, load it directly
% original version
% if isfield(data,'subtract_background') && data.subtract_background...
%         && ~isfield(data, 'bg_bw'),
%     %im = imread(data.file{1});
%     bg_file = 'background.mat';
%     [data.bg_bw, data.bg_poly]= get_background(im, strcat(data.output_path, bg_file));
%     %clear im; 
% end;

if isfield(data,'subtract_background') && data.subtract_background,
    %im = imread(data.file{1})
    bg_file = strcat(data.output_path, 'background.mat');
    if exist(bg_file, 'file'),
        temp_poly = load(bg_file);
        [temp.bw{1}, temp.poly{1}] = get_background(im, bg_file);
%         temp = load(bg_file); % with no bg and bw field inside
        data.bg_bw = temp.bw{1};
        data.bg_poly = temp.poly{1};
        clear temp
    end
    
    if ~isfield(data,'bg_bw'),
        [data.bg_bw, data.bg_poly] = get_background(im, bg_file, 'method', data.subtract_background);
    end
    %clear im; 
end;



% load cropping rectangle and rotate_image if needed.
if isfield(data, 'crop_image') && data.crop_image...
        && ~isfield(data,'rectangle'),
    %im = imread(data.file{1});
    if isfield(data, 'rotate_image') && data.rotate_image,
         im_rot = imrotate(im, data.angle);
         clear im; im = im_rot; clear im_rot;
    end;
    data.rectangle = get_rectangle(im, strcat(data.output_path, 'rectangle.mat'));
    temp = imcrop(im, data.rectangle); clear im;
    im = temp; clear temp;
    %clear im;
elseif isfield(data, 'crop_image') && ~data.crop_image...
        && isfield(data, 'rectangle'),
    data = rmfield(data, 'rectangle');
end


% Initialize data.time, data.value, data.ratio, data.donor, data.acceptor
% set data.num_rois, and data.roi_poly

clear im_size
roi_file = strcat(data.output_path, 'roi.mat');
if isfield(data, 'quantify_roi') && data.quantify_roi,
    if isfield(data, 'num_rois') ,
        num_rois = data.num_rois;
    else
        num_rois = 1;
    end;
    % Lexie on 03/02/2015 default size might unavailable for long time
    % experiments
    % Lexie on 03/11, change the name temp to be num_points and also use
    % mas instead of length as Kathy suggested
%     if ~isfield(data,'value'),
    if ~isfield(data,'ratio'),  
        if ~isfield(data, 'image_index') || max(data.image_index) <= 200
            num_points = 200;
        elseif isfield(data, 'image_index') && max(data.image_index) > 200,
            num_points = max(data.image_index);
        end
        
        %%% Kathy 07/22/2016 need to concile the cases of 1 or n cells; and
        %%% 1 roi or n rois. 
        
        % Change all the initial data strcuture to be cells to fit the
        % multiple tracking and multiple layer functions
            data.time = Inf*ones(num_points, 2);
            data.value{1} = Inf*ones(num_points, 3);
            
            % kathy 07/24/2016 trying to fix the problem of slow
            % quantification, but did not work.
            % kept these changes to be compatible with
            % quantify_region_of_interest() functions. 
            % data.ratio{1, 1} = Inf*ones(num_points, num_rois);
            % data.cell_size{1, 1}  = Inf*ones(num_points,1); 
            data.ratio{1} = Inf*ones(num_points, num_rois);
            data.cell_size{1} = Inf*ones(num_points, 1);
            % end 07/24/2016
            
            data.channel1{1} = Inf*ones(num_points, num_rois);
            data.channel2{1} = Inf*ones(num_points, num_rois);
            data.channel1_bg = Inf*ones(num_points, 1);
            data.channel2_bg = Inf*ones(num_points, 1);

        % two column for time
        % one columns for value
    end;
    % if there is a cropped image, load the image and ROI on the cropped
    % on, Lexie on 02/20/2015
    if isfield(data, 'crop_image') && data.crop_image,
        if ~isfield(data,'rectangle'),
            data.rectangle = get_rectangle(im, strcat(data.path, 'output/rectangle.mat'));
        end;
        im_crop = imcrop(im, data.rectangle);clear im; 
        im = im_crop; clear im_crop;
    end;
    % 02/20/2015
    % Load the ROIs
    if ~isfield(data,'roi_poly'),
        %im = imread(data.file{1});
        [data.roi_bw, data.roi_poly] = ...
            get_polygon(im, roi_file, 'Please choose the ROI now.', ...
            'polygon_type', 'any', 'num_polygons', num_rois);
        %clear im;
    end;  
end;

% Load the mask if needed. 
if isfield(data, 'need_apply_mask') && data.need_apply_mask,
    file_name = strcat(data.output_path, 'mask.mat');
    if ~isfield(data, 'mask'),
        % Correct the title for mask selection
        % temp = get_polygon(data.im{1}, file_name, 'Please Choose the Mask Region');
            % Lexie on 10/28/2015
            if data.need_apply_mask == 1,
                temp = get_polygon(im, file_name, 'Please Choose the Mask Region');
            elseif data.need_apply_mask == 2,
                data.file{2} = regexprep(data.file{2}, data.channel_pattern{2}, data.channel_pattern{2});
                temp_im = imread(data.file{2});
                temp = get_polygon(temp_im, file_name, 'Please Choose the Mask Region');
                clear temp_im
            elseif data.need_apply_mask == 3,
                data.file{3} = regexprep(data.file{3}, data.channel_pattern{3}, data.channel_pattern{3});
                temp_im = imread(data.file{3});
                temp = get_polygon(temp_im, file_name, 'Please Choose the Mask Region');
                clear temp_im
            else
                temp = get_polygon(im, file_name, 'Please Choose the Mask Region');
            end   
        data.mask = temp{1}; clear temp;
    end;
end;
clear im;


% For different protocols,
% load the names of image files into data.file
% load images from data.file to data.im
switch data.protocol;
    case 'FRET',
        data.file{2} = regexprep(data.file{1}, data.channel_pattern{1},...
            data.channel_pattern{2});
        for i = 1:2,
            data.im{i} = my_imread(data.file{i}, data);
        end;
        % ratio_image_file and file_type
       fret_file = get_fret_file(data, data.file{1});
       data.file{3} = strcat(fret_file, '.', 'tiff');
       data.file{4} = 'tiff';

    case 'FRET-Intensity', 
        data.file{2} = regexprep(data.file{1}, data.channel_pattern{1},...
            data.channel_pattern{2});
        data.file{3} = regexprep(data.file{1}, data.channel_pattern{1}, ...
            data.channel_pattern{3});
        for i = 1:3,
            data.im{i} = my_imread(data.file{i}, data);
        end;
        % ratio_image_file and file_type
        fret_file = get_fret_file(data, data.file{1});
        data.file{4} = strcat(fret_file, '.', 'tiff');
        data.file{5} = 'tiff';

     case 'FRET-Intensity-2', 
        data.file{2} = regexprep(data.file{1}, data.channel_pattern{1},...
            data.channel_pattern{2});
        data.file{3} = regexprep(data.file{1}, data.channel_pattern{1}, ...
            data.channel_pattern{3});
        data.file{4} = regexprep(data.file{1}, data.channel_pattern{1}, ...
            data.channel_pattern{4});

        for i = 1:4,
            data.im{i} = my_imread(data.file{i}, data);
        end;
        % ratio_image_file and file_type
        fret_file = get_fret_file(data, data.file{1});
        data.file{5} = strcat(fret_file, '.', 'tiff');
        data.file{6} = 'tiff';

    case 'FRET-DIC',
        data.file{2} = regexprep(data.file{1}, data.channel_pattern{1},...
            data.channel_pattern{2});
        data.file{3} = regexprep(data.file{1}, data.channel_pattern{1}, ...
            data.channel_pattern{3});
        for i = 1:3,
            data.im{i} = my_imread(data.file{i}, data);
        end;
        % ratio_image_file and file_type
        fret_file = get_fret_file(data, data.file{1});
        data.file{4} = strcat(fret_file, '.', 'tiff');
        data.file{5} = 'tiff';

    case 'FRET-Intensity-DIC',
        data.file{2} = regexprep(data.file{1}, data.channel_pattern{1},...
            data.channel_pattern{2});
        data.file{3} = regexprep(data.file{1}, data.channel_pattern{1}, ...
            data.channel_pattern{3}); % 3- intensity
        data.file{4} = regexprep(data.file{1}, data.channel_pattern{1}, ...
            data.channel_pattern{4}); % 4- DIC        
        for i = 1:4,
            data.im{i} = my_imread(data.file{i}, data);
        end;
        % ratio_image_file and file_type
        fret_file = get_fret_file(data, data.file{1});
        data.file{5} = strcat(fret_file, '.', 'tiff');
        data.file{6} = 'tiff';

    case 'FLIM',
        data.file{2} = regexprep(data.file{1}, data.channel_pattern{1},...
            data.channel_pattern{2});
%         temp = regexprep(strcat(data.prefix, '.', index_str), data.channel_pattern{1},...
%         data.channel_pattern{2});
%         data.file{2} = strcat(data.path, temp); clear temp;
        for i = 1:2,
            %data.im{i} = my_imread(data.file{i});
%             temp = my_imread(data.file{i}); 
%             data.im{i} = temp(:,:,1); clear temp;
    if exist(data.file{i}, 'file') ==2,
        temp = my_imread(data.file{i}, data);
    else
        temp = [];
        display(sprintf('%s : %s\n', data.file{i}, 'This file does not exist!'));
    end;
    data.im{i} = uint16(temp); clear temp;

        end;
        % ratio_image_file and file_type
       fret_file = get_fret_file(data, data.file{1});
       data.file{3} = strcat(fret_file, '.', 'tiff');
       data.file{4} = 'tiff';
        
    case 'Intensity',
        data.file{2} = strcat(data.output_path, 'processed_im', index_str, '.tiff');
        data.file{3} = 'tiff';
        data.im{1} = my_imread(data.file{1}, data);
    case 'Intensity-DIC',
        % There is someproblem with the long path string with this, so
        % replace with the statements below instead
        data.file{2} = regexprep(data.file{1}, data.channel_pattern{1},...
            data.channel_pattern{2});
%         temp = regexprep(strcat(data.prefix, '.', index_str), data.channel_pattern{1},...
%             data.channel_pattern{2});
%         data.file{2} = strcat(data.path, temp); clear temp;
        data.file{3} = strcat(data.output_path, 'processed_im', index_str, '.tiff');
        data.file{4} = 'tiff';
        data.file{5} = strcat(data.output_path, 'dic_im', index_str,'.tiff');
        for i = 1:2,
            data.im{i} = my_imread(data.file{i}, data);
        end;
end
return;

