% Function update the ratio image

% Copyright: Shaoying Lu and Yingxiao Wang 2014-2017
function [data, ratio_im] = update_ratio_image(first_channel_im,...
    second_channel_im, data, file, handle, varargin)
<<<<<<< HEAD
parameter_name = {'save_bw_file'};
default_value = {0};
[save_bw_file] = parse_parameter(parameter_name, default_value, varargin);
=======
parameter_name = {'this_frame_with_track'};
default_value = {[]};
[this_frame_with_track] = parse_parameter(parameter_name, default_value, varargin);
>>>>>>> current/master

    % data.file{3} -> ratio_im -> data.im{3} -> data.f(1)
    if ~exist(file, 'file') || (isfield(data,'quantify_roi') && data.quantify_roi)
        ratio = compute_ratio(first_channel_im, second_channel_im);
    end
<<<<<<< HEAD
    
% 7/27/2016 Shannon: Quanty optimization so get_imd_image does not run
% under certain conditions. 
% i.e. when data.show_figure==0 && save_processed_image==0
    if isfield(data,'save_processed_image') && data.save_processed_image
        save_processed_image = 1;
    else
        save_processed_image = 0;
    end
    
    if ~exist(file, 'file')
        if (~isfield(data,'show_figure') ...
            || ( isfield(data,'show_figure') &&  data.show_figure==1 )) && ~save_processed_image
            ratio_im = get_imd_image(ratio, max(first_channel_im, second_channel_im), ...
                'ratio_bound', data.ratio_bound, 'intensity_bound', data.intensity_bound);
        elseif save_processed_image
            ratio_im = get_imd_image(ratio, max(first_channel_im, second_channel_im), ...
                'ratio_bound', data.ratio_bound, 'intensity_bound', data.intensity_bound);
            imwrite(ratio_im, file, 'tiff', 'Compression', 'none');
        else
            ratio_im = [];
        end
=======
        
    if ~exist(file, 'file')
        ratio_im = get_imd_image(ratio, max(first_channel_im, second_channel_im), ...
            'ratio_bound', data.ratio_bound, 'intensity_bound', data.intensity_bound);
>>>>>>> current/master
    else 
        ratio_im = imread(file, 'tiff');
    end
    
    if (isfield(data, 'show_figure') && data.show_figure == 1)...
        || ~isfield(data, 'show_figure') % option for displaying figure
            figure(handle); axis_vector = axis; 
            if max(axis_vector) == 1 % the image has not been initialized yet
                imshow(ratio_im);
            else % the figure was already initialized
                clf; imshow(ratio_im); axis(axis_vector);
            end
            %Modified to enable z-index use in title. See my_title() for further changes. - Shannon 8/24/2016
            axis off; my_title('Intensity Ratio', data.index, 'data', data);
            clear axis_vector;
    end
    
    % This part is needed for detecing cell_bw for quantifcation even when
    % show_figure = 0. 
    if isfield(data, 'show_detected_boundary') && data.show_detected_boundary
        if isfield(data, 'need_apply_mask')  && data.need_apply_mask == 3
<<<<<<< HEAD
            data = show_detected_boundary(data.third_channel_im * 2, data);
        else
            data = show_detected_boundary(first_channel_im + second_channel_im, data);
        end
    end
    pause(0.001); % pause to force updating the figure;
=======
            data = get_boundary(data.third_channel_im * 2, data);
        else
            data = get_boundary(first_channel_im + second_channel_im, data);
        end
    end
    
    if ~isempty(this_frame_with_track)
        fwt_k = this_frame_with_track;
        num_track = fwt_k.num_track;
        if num_track>0
            centroid = fwt_k.centroid(1:num_track,:);
            this_track_index = fwt_k.track_index(1:num_track);
            figure(handle); hold on; 
            plot(centroid(:,1), centroid(:,2), 'r+');
            text_str = num2str(this_track_index);
            text(centroid(:,1)+2, centroid(:,2),...
                text_str, 'color', 'r','FontWeight', 'bold','FontSize', 18);
        end % if num_traks>0   
    end
    
    if isfield(data, 'save_processed_image') && data.save_processed_image && ~exist(file,'file')
        if (isfield(data, 'show_figure') && data.show_figure == 1)...
           || ~isfield(data, 'show_figure') % option for displaying figure
            [process_im, ~] = frame2im(getframe);
            imwrite(process_im, file, 'tiff', 'Compression', 'none');
        else
           imwrite(ratio_im, file, 'tiff', 'Compression', 'none');
        end
    end
    
    pause(0.001); % pause to force updating the figure;
    
>>>>>>> current/master

    % quantification of roi
    if isfield(data,'quantify_roi') && data.quantify_roi
        data = quantify_region_of_interest(data, ratio, first_channel_im,...
<<<<<<< HEAD
            second_channel_im, 'save_bw_file', save_bw_file);
=======
            second_channel_im);
>>>>>>> current/master
    end
return;


