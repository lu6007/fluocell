% function data = update_figure(data)

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function data= update_figure(data)
show_figure_option = ~isfield(data, 'show_figure') || data.show_figure;
my_func = get_my_function();

if isfield(data,'quantify_roi') && ...
        (data.quantify_roi == 2 ||data.quantify_roi == 3)
    if ~isfield(data, 'show_detected_boundary') || data.show_detected_boundary == 0
       data.show_detected_boundary = 1;
       disp('Function update_figure warning: ');
       disp('data.show_detected_boundary has been set to 1 for quantify_roi == 2 or 3.');
       disp('To revert this, check and uncheck the related box under Tools/Adjust Brightness Factor.');
       disp('Or set data.show_detected_boundary = 0.');
       if ~isfield(data, 'brightness_factor')
           data.brightness_factor = 1.0;
       end
    end
end


if isfield(data, 'im') && ~isempty(data.im{1}) && isfield(data, 'f')
    if isfield(data,'frame_with_track') 
        frame_with_track_i = data.frame_with_track(data.index);
    else 
        frame_with_track_i = [];
    end
    
    % for subtract constant background
    if isfield(data, 'bg_value')
        bg_value = data.bg_value;
    else
        bg_value = zeros(10, 1);
    end

    switch data.protocol
        case {'FRET', 'Ratio', 'FLIM'}
            first_channel_im = preprocess(data.im{1}, data, 'bg_value', bg_value(1));
            second_channel_im = preprocess(data.im{2}, data, 'bg_value', bg_value(2));
            
%             % clean up images for ratio display
%             im1 = first_channel_im;
%             im2 = second_channel_im;
%             mask = (im1 + im2)>2*200;
%             mask_open = bwareaopen(mask, 25);
%             se = strel('disk', 3);
%             mask_smooth = imerode(imdilate(mask_open, se), se);
%             clear first_channel_im second_channel_im mask mask_open se;
%             first_channel_im = double(im1).*double(mask_smooth);
%             second_channel_im = double(im2).*double(mask_smooth);
%             clear mask_smooth im1 im2; 


            % data.file{3}-> ratio_im -> data.im{3} -> data.f(1)
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{3}, data.f(1), ...
                'this_frame_with_track', frame_with_track_i);
            data.im{3} = ratio_im;
            
            % Lexie on 3/2/2015
            if show_figure_option
                figure(data.f(2)); my_imagesc(first_channel_im); % clf was included in my_imagesc
                axis off; my_title(data.channel_pattern{1}, data.index, 'data', data);
                figure(data.f(3)); my_imagesc(second_channel_im); % clf was included in my_imagesc
                axis off; my_title(data.channel_pattern{2}, data.index, 'data', data);
            end

            clear first_channel_im second_channel_im ratio_im;
        case 'FRET-Intensity'
            first_channel_im = preprocess(data.im{1}, data, 'bg_value', bg_value(1));
            second_channel_im = preprocess(data.im{2}, data, 'bg_value', bg_value(2));
            im_3 = preprocess(data.im{3}, data, 'bg_value', bg_value(3));
            data.third_channel_im = im_3;
            % 
            % file{4} -> ratio_im -> im{4} -> data.f(1)
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{4}, data.f(1), ...
                'this_frame_with_track', frame_with_track_i);
            data.im{4} = ratio_im;
            
            if show_figure_option
                figure(data.f(2)); my_imagesc(first_channel_im); % clf was included in my_imagesc
                axis off; my_title(data.channel_pattern{1}, data.index, 'data', data);
                figure(data.f(3)); my_imagesc(second_channel_im); % clf was included in my_imagesc
                axis off; my_title(data.channel_pattern{2}, data.index, 'data', data);
                figure(data.f(4)); my_imagesc(im_3);
                axis off; my_title(data.channel_pattern{3}, data.index, 'data', data);
            end

            figure(data.f(3)); 
            my_func.save_image(data, data.file{6}, im_3, caxis, 'my_color_map', 'jet');

            clear first_channel_im second_channel_im im_3 ratio_im;

        case 'FRET-Intensity-2'
            first_channel_im = preprocess(data.im{1}, data, 'bg_value', bg_value(1));
            second_channel_im = preprocess(data.im{2}, data, 'bg_value', bg_value(2));
            im_3 = preprocess(data.im{3}, data, 'bg_value', bg_value(3));
            im_4 = preprocess(data.im{4}, data, 'bg_value', bg_value(4));
            data.third_channel_im = im_3;
            % file{4} -> ratio_im -> im{4} -> data.f(1)
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{4}, data.f(1), ...
                'this_frame_with_track', frame_with_track_i);
            data.im{5} = ratio_im;
            
            if show_figure_option
                figure(data.f(2)); my_imagesc(first_channel_im); % clf was included in my_imagesc
                axis off; my_title(data.channel_pattern{1}, data.index, 'data', data);
                figure(data.f(3)); my_imagesc(second_channel_im); % clf was included in my_imagesc
                axis off; my_title(data.channel_pattern{2}, data.index, 'data', data);
                figure(data.f(4)); my_imagesc(im_3);
                axis off; my_title(data.channel_pattern{3}, data.index, 'data', data);
                figure(data.f(5)); my_imagesc(im_4);
                axis off; my_title(data.channel_pattern{4}, data.index, 'data', data);
            end

            clear first_channel_im second_channel_im im_3 im_4 ratio_im;

        case 'FRET-DIC'
            first_channel_im = preprocess(data.im{1}, data, 'bg_value', bg_value(1));
            second_channel_im = preprocess(data.im{2}, data, 'bg_value', bg_value(2));
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{4}, data.f(1), ...
                'this_frame_with_track', frame_with_track_i);
            % file{4} -> ratio_im -> data.f(1)
            data.im{4} = ratio_im;

            if show_figure_option
                figure(data.f(2)); my_imagesc(first_channel_im); % clf was included in my_imagesc
                axis off; my_title(data.channel_pattern{1}, data.index, 'data', data);
                figure(data.f(3)); my_imagesc(second_channel_im); % clf was included in my_imagesc
                axis off; my_title(data.channel_pattern{2}, data.index, 'data', data);
                figure(data.f(4)); my_imagesc(data.im{3});
                colormap gray; 
                axis off; my_title('DIC', data.index, 'data', data);
            end
            
            % The allows saving DIC images
            if isfield(data, 'save_processed_image') && data.save_processed_image == 3
                figure(data.f(4)); my_func.save_image(data, data.file{6}, data.im{3}, caxis);
            end

        case 'FRET-Intensity-DIC'
            first_channel_im = preprocess(data.im{1}, data, 'bg_value', bg_value(1));
            second_channel_im = preprocess(data.im{2}, data, 'bg_value', bg_value(2));
            im_3 = preprocess(data.im{3}, data, 'bg_value', bg_value(3));
            data.third_channel_im = im_3;

            % file{5} -> ratio_im -> data.f(1), im{5}
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{5}, data.f(1), ...
                'this_frame_with_track', frame_with_track_i);
            data.im{5} = ratio_im;

            if show_figure_option
                figure(data.f(2)); my_imagesc(first_channel_im); % clf was included in my_imagesc
                axis off; my_title(data.channel_pattern{1}, data.index, 'data', data);
                figure(data.f(3)); my_imagesc(second_channel_im); % clf was included in my_imagesc
                axis off; my_title(data.channel_pattern{2}, data.index, 'data', data);
                figure(data.f(4)); my_imagesc(im_3);
                axis off; my_title(data.channel_pattern{3}, data.index, 'data', data);
                figure(data.f(5)); my_imagesc(data.im{4});
                colormap gray; 
                axis off; my_title('DIC', data.index, 'data', data);
                clear first_channel_im second_channel_im ratio_im;
            end
            figure(data.f(3)); 
            my_func.save_image(data, data.file{7}, im_3, caxis, 'my_color_map', 'jet');
		 clear im_3;

      case 'STED'
            first_channel_im = preprocess(data.im{1}, data, 'bg_value', bg_value(1));
            second_channel_im = preprocess(data.im{2}, data, 'bg_value', bg_value(2));

            % data.file{3}-> ratio_im -> data.im{3} -> data.f(1)
            [data, sted_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{3}, data.f(1), ...
                'this_frame_with_track', frame_with_track_i);
            data.im{3} = sted_im;
       
            figure(data.f(2)); my_imagesc(first_channel_im); % clf was included in my_imagesc
            axis off; my_title(data.channel_pattern{1}, data.index, 'data', data);
            figure(data.f(3)); my_imagesc(second_channel_im); % clf was included in my_imagesc
            axis off; my_title(data.channel_pattern{2}, data.index, 'data', data);

            clear first_channel_im second_channel_im ratio_im;

       case 'Intensity'
            second_channel_im = data.im{1};
            figure(data.f(1)); imagesc(second_channel_im); 
            axis off; my_title('Intensity',data.index, 'data', data);
            colormap jet; 
            data.im{2}  = preprocess(data.im{1}, data); 
            figure(data.f(2)); my_imagesc(data.im{2}, 'data', data); 
            axis off; my_title('Processed',data.index, 'data', data);
            colormap jet;

            if isfield(data, 'show_detected_boundary') && data.show_detected_boundary
                data = get_boundary(data.im{2}, data); 
            end
            
             if isfield(data,'quantify_roi') && data.quantify_roi
                data = quantify_region_of_interest(data, data.im{2});
             end

             figure(data.f(2)); 
             my_func.save_image(data, data.file{2}, data.im{2}, caxis, 'my_color_map', 'jet');
             clear second_channel_im;
        case 'Intensity-DIC'
            figure(data.f(1)); my_imagesc(data.im{1}); 
            axis off; my_title('Intensity',data.index, 'data', data);
            figure(data.f(2)); 
            my_imagesc(data.im{2});
            colormap gray; 
            axis off; my_title('DIC',data.index, 'data', data);
            data.im{3} = preprocess(data.im{1}, data); 
            figure(data.f(3));
            my_imagesc(data.im{3}, 'data', data);
            imagesc(data.im{3}); caxis(data.intensity_bound);
            axis off; my_title('Processed',data.index, 'data', data);

            if isfield(data,'quantify_roi') && data.quantify_roi
                data = quantify_region_of_interest(data, data.im{3});
            end
            
             figure(data.f(3)); 
             my_func.save_image(data, data.file{3}, data.im{3}, caxis);
             % The allows saving DIC images
             if isfield(data, 'save_processed_image') && data.save_processed_image == 3
                 figure(data.f(2)); my_func.save_image(data, data.file{5}, data.im{2}, caxis);
             end
                
    end %switch data.protocol
    
    % Lexie on 03/02/2015
    % Draw the background region
    if show_figure_option
        if isfield(data, 'subtract_background') && data.subtract_background
            figure(data.f(1)); hold on; 
    %         file_name = strcat(data.output_path, 'background.mat');
            % locate the right path for bg
            path_temp = strcat(data.path, 'output/');
            file_name = strcat(path_temp, 'background.mat'); %clear path_temp
            % draw_polygon is an interactive function 
            % If we move the roi with draw_polygon, the new roi will be saved
            % into the roi file. Meanwhile, the program will exit update_figure 
            % and return to the java interface. 
            % The background region is only shown if the image was not cropped.

            % When there is no field called 'crop_image', background
            % will be displayed
            if ~isfield(data, 'crop_image') || (isfield(data,'crop_image')&&...
                    ~data.crop_image)
                if ~isfield(data, 'quantify_roi') || data.quantify_roi <= 1
                    polygon_type = 'draggable';
                else
                    % Note that drawing draggable polygons are very slow
                    % (0.7sec/image), while undraggable polygons are much faster (<0.01
                    % sec/image). So use undraggable polygons whenever
                    % possible. 
                    polygon_type = 'undraggable'; 
                end
                draw_polygon(gca, data.bg_poly, 'yellow', file_name, 'type', polygon_type);
            end 
        end

    end
else % not if isfield(data, 'im') && ~isempty(data.im{1}) && isfield(data, 'f')
    disp('Function update_figure warning: ');
    disp('Please load the images or check the value of index.')
end % if isfield(data, 'im'),
return;

% Keep the caxis and colormap from the previous plot
% Use caxis auto for a new figure
function my_imagesc(im, varargin)
para_name = {'data'};
para_default = {[]};
data = parse_parameter(para_name, para_default, varargin);
temp = caxis; 
if (temp(1)==0 && temp(2) ==1) 
    keep_axis = 0;
elseif ~isempty(data) && isfield(data, 'crop_image') && data.crop_image
    keep_axis = 0;
else
    keep_axis = 1;
end
axis_vector = axis; % needed for keeping the zoom-in and out
this_colormap = colormap(gca); 
clf;
if ~keep_axis
    imagesc(im); 
else
    imagesc(im, temp);
    axis(axis_vector);
    colormap(this_colormap); 
end
return;


