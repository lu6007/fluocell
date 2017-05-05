% function data = update_figure(data)

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function data= update_figure(data, varargin)
parameter_name = {'save_bw_file'};
default_value = {0};
[save_bw_file] = parse_parameter(parameter_name, default_value, varargin);

%Lexie on 03/09/2015
show_figure_option = ~isfield(data, 'show_figure') || data.show_figure;

% if isfield(data,'quantify_roi') && ...
%         (data.quantify_roi == 2 ||data.quantify_roi == 3)
%     if ~isfield(data, 'show_detected_boundary') || data.show_detected_boundary == 0
%        data.show_detected_boundary = 1;
%        disp('Function update_figure warning: ');
%        disp('data.show_detected_boundary has been set to 1 for quantify_roi == 2 or 3.');
%        if ~isfield(data, 'brightness_factor')
%            data.brightness_factor = 1.0;
%        end
%     end
% end

if isfield(data, 'im') && ~isempty(data.im{1}) && isfield(data, 'f')

    switch data.protocol
        case 'FRET'
            first_channel_im = preprocess(data.im{1}, data);
            second_channel_im = preprocess(data.im{2}, data);

            % data.file{3}-> ratio_im -> data.im{3} -> data.f(1)
            
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{3}, data.f(1), 'save_bw_file', save_bw_file);
            data.im{3} = ratio_im;
            
            % Lexie on 3/2/2015
            if show_figure_option
                figure(data.f(2)); my_imagesc(second_channel_im); % clf was included in my_imagesc
                axis off; my_title(data.channel_pattern{2}, data.index, 'data', data);
            end

            clear first_channel_im second_channel_im ratio_im;
        case 'FRET-Intensity'
            first_channel_im = preprocess(data.im{1}, data);
            second_channel_im = preprocess(data.im{2}, data);
            im_3 = preprocess(data.im{3}, data);
            if isfield(data, 'need_apply_mask')  && data.need_apply_mask == 3
                data.third_channel_im =  im_3;
            end
            % file{4} -> ratio_im -> im{4} -> data.f(1)
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{4}, data.f(1), 'save_bw_file', save_bw_file);
            data.im{4} = ratio_im;
            
            if show_figure_option
                figure(data.f(2)); my_imagesc(second_channel_im); 
                axis off; my_title(data.channel_pattern{2}, data.index, 'data', data);
                figure(data.f(3)); my_imagesc(im_3);
                axis off; my_title(data.channel_pattern{3}, data.index, 'data', data);
            end

            figure(data.f(3)); save_image(data, data.file{6}, im_3, caxis, 'my_color_map', 'jet');

            clear first_channel_im second_channel_im im_3 ratio_im;

        case 'FRET-Intensity-2'
            first_channel_im = preprocess(data.im{1}, data);
            second_channel_im = preprocess(data.im{2}, data);
            im_3 = preprocess(data.im{3}, data);
            im_4 = preprocess(data.im{4}, data);
            if isfield(data, 'need_apply_mask')  && data.need_apply_mask == 3
                data.third_channel_im =  im_3;
            end
            % file{4} -> ratio_im -> im{4} -> data.f(1)
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{4}, data.f(1), 'save_bw_file', save_bw_file);
            data.im{5} = ratio_im;
            
            if show_figure_option
                figure(data.f(2)); my_imagesc(second_channel_im); 
                axis off; my_title(data.channel_pattern{2}, data.index, 'data', data);
                figure(data.f(3)); my_imagesc(im_3);
                axis off; my_title(data.channel_pattern{3}, data.index, 'data', data);
                figure(data.f(4)); my_imagesc(im_4);
                axis off; my_title(data.channel_pattern{4}, data.index, 'data', data);
            end

            clear first_channel_im second_channel_im im_3 im_4 ratio_im;

        case 'FRET-DIC'
            first_channel_im = preprocess(data.im{1}, data);
            second_channel_im = preprocess(data.im{2}, data);
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{4}, data.f(1), 'save_bw_file', save_bw_file);
            % file{4} -> ratio_im -> data.f(1)
            data.im{4} = ratio_im;

            if show_figure_option
                figure(data.f(2)); my_imagesc(second_channel_im); 
                axis off; my_title(data.channel_pattern{2}, data.index, 'data', data);
                figure(data.f(3)); my_imagesc(data.im{3});
                colormap gray; 
                axis off; my_title('DIC', data.index, 'data', data);
            end
        case 'FRET-Intensity-DIC'
            first_channel_im = preprocess(data.im{1}, data);
            second_channel_im = preprocess(data.im{2}, data);
            im_3 = preprocess(data.im{3}, data);
            % file{5} -> ratio_im -> data.f(1), im{5}
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{5}, data.f(1), 'save_bw_file', save_bw_file);
            data.im{5} = ratio_im;

            if show_figure_option
                figure(data.f(2)); my_imagesc(second_channel_im); 
                axis off; my_title(data.channel_pattern{2}, data.index, 'data', data);
                figure(data.f(3)); my_imagesc(im_3);
                axis off; my_title(data.channel_pattern{3}, data.index, 'data', data);
                figure(data.f(4)); my_imagesc(data.im{4});
                colormap gray; 
                axis off; my_title('DIC', data.index, 'data', data);
                clear first_channel_im second_channel_im ratio_im;
            end
            figure(data.f(3)); save_image(data, data.file{7}, im_3, caxis, 'my_color_map', 'jet');
		 clear im_3;

        case 'FLIM'
            first_channel_im = preprocess(data.im{1}, data);
            second_channel_im = preprocess(data.im{2}, data);

            % data.file{3}-> ratio_im -> data.im{3} -> data.f(1)
            [data, flim_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{3}, data.f(1), 'save_bw_file', save_bw_file); %'update_flim_image');
            data.im{3} = flim_im;
       
            figure(data.f(2)); my_imagesc(second_channel_im); % clf was included in my_imagesc
            axis off; my_title(data.channel_pattern{2}, data.index, 'data', data);

            clear first_channel_im second_channel_im ratio_im;
         case 'STED'
            first_channel_im = preprocess(data.im{1}(:,:,1), data);
            second_channel_im = preprocess(data.im{2}(:,:,3), data);

            % data.file{3}-> ratio_im -> data.im{3} -> data.f(1)
            [data, sted_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{3}, data.f(1), 'save_bw_file', save_bw_file);
            data.im{3} = sted_im;
       
            figure(data.f(2)); my_imagesc(second_channel_im); % clf was included in my_imagesc
            axis off; my_title(data.channel_pattern{2}, data.index, 'data', data);

            clear first_channel_im second_channel_im ratio_im;

       case 'Intensity'
            second_channel_im = data.im{1};
            figure(data.f(1)); imagesc(second_channel_im); 
            axis off; my_title('Intensity',data.index, 'data', data);
            data.im{2}  = preprocess(data.im{1}, data); 
            figure(data.f(2)); my_imagesc(data.im{2}); 
            axis off; my_title('Processed',data.index, 'data', data);

            if isfield(data, 'show_detected_boundary') && data.show_detected_boundary
                data = show_detected_boundary(data.im{2}, data); 
            end
            
             if isfield(data,'quantify_roi') && data.quantify_roi
                data = quantify_region_of_interest(data, data.im{2});
             end

             figure(data.f(2)); save_image(data, data.file{2}, data.im{2}, caxis, 'my_color_map', 'jet');
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
            my_imagesc(data.im{3});
            imagesc(data.im{3}); caxis(data.intensity_bound);
            axis off; my_title('Processed',data.index, 'data', data);

            %show_detected_boundary(data.im{3}, data, data.f(3));
            if isfield(data,'quantify_roi') && data.quantify_roi
                data = quantify_region_of_interest(data, data.im{3});
            end
            
             figure(data.f(3)); save_image(data, data.file{3}, data.im{3}, caxis);
             % The allows saving DIC images
             if isfield(data, 'save_processed_image') && data.save_processed_image == 2
                 figure(data.f(2)); save_image(data, data.file{5}, data.im{2}, caxis);
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

    % 1/27/2015 Lexie: when there is no field called 'crop_image', background
    % will be displayed

            if ~isfield(data, 'crop_image') || (isfield(data,'crop_image')&&...
                    ~data.crop_image)
                if isfield(data, 'quantify_roi') && data.quantify_roi == 1
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
else
    disp('Function update_figure warning: ');
    disp('Please load the images or check the range of index.')
end % if isfield(data, 'im'),
return;

% Keep the caxis from the previous plot
% Use caxis auto for a new figure
function my_imagesc(im)
temp = caxis;
axis_vector = axis;
clf;
if temp(1) ==0 && temp(2) ==1
    imagesc(im); 
else
    imagesc(im, temp);
    axis(axis_vector);
end
return;

% figure(data.f(3)); save_image(data, data.file{3}, data.im{3}, caxis);
function save_image(data, file, im, caxis, varargin)
para_name = {'my_color_map'};
para_default = {'gray'};
my_color_map = parse_parameter(para_name, para_default, varargin);

if ~exist(file, 'file') &&...
    isfield(data, 'save_processed_image')&& data.save_processed_image                
    temp = imscale(im, 0, 1, caxis);
    switch my_color_map
        case 'gray'
            imwrite(temp, file, 'tiff','compression', 'none');
        case 'jet'
            clear im;
            im = gray2ind(temp); 
            imwrite(im, jet, file, 'tiff', 'compression', 'none');
    end % switch
end
return;

