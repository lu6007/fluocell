% Function update_ratio_image
% local function : none. 

% Copyright: Shaoying Lu and Yingxiao Wang 2014
% 1/27/2015 Lexie: change all the cfp and yfp to be first_channel_im and
% second_channel_im;
function [data, ratio_im] = update_ratio_image(first_channel_im,...
    second_channel_im, data, file, handle, varargin)
    parameter_name = {'local_function'};
    parameter_default = {[]};
    local_function = parse_parameter(parameter_name, parameter_default, varargin);
    
    if ~isempty(local_function),
        fun_handle = str2func(local_function);
        [data, ratio_im] = fun_handle(first_channel_im, second_channel_im, data, file, handle);
    else
            % data.file{3} -> ratio_im -> data.im{3} -> data.f(1)
            if ~exist(file, 'file') || (isfield(data,'quantify_roi') && data.quantify_roi),
        %         if data.is_channel1_over_channel2,
                    ratio = compute_ratio(first_channel_im, second_channel_im);
        %         else
        %             ratio = compute_ratio(second_channel_im, first_channel_im);
        %         end;
            end;
            if ~exist(file, 'file'),
                ratio_im = get_imd_image(ratio, max(first_channel_im, second_channel_im), ...
                    'ratio_bound', data.ratio_bound, 'intensity_bound', data.intensity_bound);
                if isfield(data, 'save_processed_image') && data.save_processed_image,
                    imwrite(ratio_im, file, 'tiff', 'Compression', 'none');
                end;
            else 
                ratio_im = imread(file, 'tiff');
            end;
        %     figure(handle); clf; imshow(ratio_im); 
        %     axis off; my_title('FRET', data.index);
            figure(handle); axis_vector = axis; 
            if max(axis_vector) == 1 % the image has not been initialized yet
                imshow(ratio_im);
            else % the figure was already initialized
                clf; imshow(ratio_im); axis(axis_vector); 
            end;
            clear axis_vector;
            axis off; my_title('Intensity Ratio', data.index);
            if isfield(data, 'show_detected_boundary') && data.show_detected_boundary,
                data=show_detected_boundary(first_channel_im + second_channel_im, data);   
            end;

            % quantification of roi
            if isfield(data,'quantify_roi') && data.quantify_roi,
                data = quantify_region_of_interest(data, ratio, first_channel_im,...
                    second_channel_im);
            end;
    end;
return;




