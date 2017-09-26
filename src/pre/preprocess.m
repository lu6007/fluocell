% function [new_im, data] = preprocess(im, data)
% Perform the preprocess steps including
% median_filter, subtract_background,
% rotate_image, and crop_image.
%
% Example:
% data.median_filter = 1;
% data.subtract_background = 1;
% [new_im, data] = preprocess(im, data);

% Copyright: Shaoying Lu and Yingxiao Wang 2011-2013
% Email: shaoying.lu@gmail.com

function [new_im, data] = preprocess(im, data)
% need to add varargin to allow flexible median_filter window size
        if isfield(data, 'median_filter') && data.median_filter
            % filter_win = [3, 3];
            % im_filt = medfilt2(im, filter_win);
            im_filt = medfilt2(im);
            clear im; im = im_filt; clear im_filt;
        end
        
        if isfield(data,'high_pass_filter') && data.high_pass_filter
            hps = data.high_pass_filter; 
            temp = high_pass_filter(im, hps); clear im;
            im = temp; clear temp;
        end

        if isfield(data, 'subtract_background') && data.subtract_background
%             if ~isfield(data,'bg_bw'),
%                 data.bg_bw = get_background(im, strcat(data.path, 'output\background.mat'));
%             end;
            bg_file = strcat(data.path, 'output/background.mat');
            if ~isfield(data,'bg_bw')
                switch data.subtract_background
                    case 1
                        data.bg_bw = get_background(im, bg_file, 'method', 'manual');
                    case 2
                        data.bg_bw = get_background(im, bg_file, 'method', 'auto');
                end
            end
            %Performs background subtraction.
            im_sub = subtract_background(im, data, 'method', 1);
            clear im; im = max(im_sub, 0); clear im_sub; %remove any negatives if they occured
            clear bw bg_value bg_bd bg_index;
        end
        if isfield(data, 'rotate_image') && data.rotate_image
            im_rot = imrotate(im, data.angle);
            clear im; im = im_rot; clear im_rot;
%             temp = data.bg_bw;
%             data = rmfield(data, 'bg_bw');
%             data.bg_bw = imrotate(temp, data.angle); clear temp;
        end

        
        if isfield(data, 'crop_image') && data.crop_image
            if ~isfield(data,'rectangle')
                data.rectangle = get_rectangle(im, strcat(data.path, 'output/rectangle.mat'));
            end
            im_crop = imcrop(im, data.rectangle);
            clear im; im = im_crop; clear im_crop;
            

%             temp = data.bg_bw;
%             data = rmfield(data, 'bg_bw');
%             data.bg_bw = imcrop(temp, data.rectangle);
        end
        
        if isfield(data,'scale_image') && data.scale_image
            temp = im*data.scale_image; clear im;
            im = temp; clear temp;
        end
        new_im = im;
        clear im;
return;

