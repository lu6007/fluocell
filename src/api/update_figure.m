% Update figures.

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function data= update_figure(data)
%Lexie on 03/09/2015
show_figure_option = ~isfield(data, 'show_figure') || data.show_figure;
if isfield(data, 'im') && ~isempty(data.im{1}) && isfield(data, 'f'),

% move to get_image 09/03/2014
%     if isfield(data, 'need_apply_mask') && data.need_apply_mask,
%         file_name = strcat(data.output_path, 'mask.mat');
%         if ~isfield(data, 'mask'),
%             % Correct the title for mask selection
%             temp = get_polygon(data.im{1}, file_name, 'Please Choose the Mask Region');
%             data.mask = temp{1}; clear temp;
%         end;
%     end;

    switch data.protocol,
        case 'FRET',
            first_channel_im = preprocess(data.im{1}, data);
            second_channel_im = preprocess(data.im{2}, data);

            % data.file{3}-> ratio_im -> data.im{3} -> data.f(1)
            
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{3}, data.f(1));
            data.im{3} = ratio_im;
            
            % Lexie on 3/2/2015
            if show_figure_option,
                figure(data.f(2)); my_imagesc(second_channel_im); % clf was included in my_imagesc
                axis off; my_title(data.channel_pattern{2}, data.index);
            end

            clear first_channel_im second_channel_im ratio_im;
        case 'FRET-Intensity',
            first_channel_im = preprocess(data.im{1}, data);
            second_channel_im = preprocess(data.im{2}, data);
            im_3 = preprocess(data.im{3}, data);
            if isfield(data, 'need_apply_mask')  && data.need_apply_mask == 3,
                data.third_channel_im =  im_3;
            end
            % file{4} -> ratio_im -> im{4} -> data.f(1)
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{4}, data.f(1));
            data.im{4} = ratio_im;
            
            if show_figure_option,
                figure(data.f(2)); my_imagesc(second_channel_im); 
                axis off; my_title(data.channel_pattern{2}, data.index);
                figure(data.f(3)); my_imagesc(im_3);
                axis off; my_title(data.channel_pattern{3}, data.index);
            end

            clear first_channel_im second_channel_im im_3 ratio_im;

        case 'FRET-Intensity-2',
            first_channel_im = preprocess(data.im{1}, data);
            second_channel_im = preprocess(data.im{2}, data);
            im_3 = preprocess(data.im{3}, data);
            im_4 = preprocess(data.im{4}, data);
            if isfield(data, 'need_apply_mask')  && data.need_apply_mask == 3,
                data.third_channel_im =  im_3;
            end
            % file{4} -> ratio_im -> im{4} -> data.f(1)
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{4}, data.f(1));
            data.im{5} = ratio_im;
            
            if show_figure_option,
                figure(data.f(2)); my_imagesc(second_channel_im); 
                axis off; my_title(data.channel_pattern{2}, data.index);
                figure(data.f(3)); my_imagesc(im_3);
                axis off; my_title(data.channel_pattern{3}, data.index);
                figure(data.f(4)); my_imagesc(im_4);
                axis off; my_title(data.channel_pattern{4}, data.index);
            end

            clear first_channel_im second_channel_im im_3 im_4 ratio_im;

        case 'FRET-DIC',
            first_channel_im = preprocess(data.im{1}, data);
            second_channel_im = preprocess(data.im{2}, data);
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{4}, data.f(1));
            % file{4} -> ratio_im -> data.f(1)
            data.im{4} = ratio_im;

            if show_figure_option,
                figure(data.f(2)); my_imagesc(second_channel_im); 
                axis off; my_title(data.channel_pattern{2}, data.index);
                figure(data.f(3)); my_imagesc(data.im{3});
                colormap gray; 
                axis off; my_title('DIC', data.index);
            end
        case 'FRET-Intensity-DIC',
            first_channel_im = preprocess(data.im{1}, data);
            second_channel_im = preprocess(data.im{2}, data);
            im_3 = preprocess(data.im{3}, data);
            % file{5} -> ratio_im -> data.f(1), im{5}
            [data, ratio_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{5}, data.f(1));
            data.im{5} = ratio_im;

            if show_figure_option,
                figure(data.f(2)); my_imagesc(second_channel_im); 
                axis off; my_title(data.channel_pattern{2}, data.index);
                figure(data.f(3)); my_imagesc(im_3);
                axis off; my_title(data.channel_pattern{3}, data.index);
                figure(data.f(4)); my_imagesc(data.im{4});
                colormap gray; 
                axis off; my_title('DIC', data.index);
                clear first_channel_im second_channel_im im_3 ratio_im;
            end
        case 'FLIM',
            first_channel_im = preprocess(data.im{1}, data);
            second_channel_im = preprocess(data.im{2}, data);

            % data.file{3}-> ratio_im -> data.im{3} -> data.f(1)
            [data, flim_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{3}, data.f(1)); %'update_flim_image');
            data.im{3} = flim_im;
       
            figure(data.f(2)); my_imagesc(second_channel_im); % clf was included in my_imagesc
            axis off; my_title(data.channel_pattern{2}, data.index);

            clear first_channel_im second_channel_im ratio_im;
         case 'STED',
            first_channel_im = preprocess(data.im{1}(:,:,1), data);
            second_channel_im = preprocess(data.im{2}(:,:,3), data);

            % data.file{3}-> ratio_im -> data.im{3} -> data.f(1)
            [data, sted_im] = update_ratio_image(first_channel_im, second_channel_im, data,...
                data.file{3}, data.f(1));
            data.im{3} = sted_im;
       
            figure(data.f(2)); my_imagesc(second_channel_im); % clf was included in my_imagesc
            axis off; my_title(data.channel_pattern{2}, data.index);

            clear first_channel_im second_channel_im ratio_im;

       case 'Intensity',
            second_channel_im = data.im{1};
            figure(data.f(1)); imagesc(second_channel_im); 
            axis off; my_title('Intensity',data.index);
            data.im{2}  = preprocess(data.im{1}, data); 
            figure(data.f(2)); my_imagesc(data.im{2}); 
            axis off; my_title('Processed',data.index);

            if isfield(data, 'show_detected_boundary') && data.show_detected_boundary,
                data = show_detected_boundary(data.im{2}, data); 
            end;
            
             if isfield(data,'quantify_roi') && data.quantify_roi,
                data = quantify_region_of_interest(data, data.im{2});
            end;

            if isfield(data, 'save_processed_image') && data.save_processed_image,
                % use the factor 1.25 to adjust the image size and the save
                % file size. 100 for the frame size of windows xp.
                image_size = floor(size(data.im{2})*1.25+100);
                height = image_size(1); width = image_size(2);
                left = 50; bottom = 50;
                set(data.f(2), 'Position', [left bottom width height]);
                fr = getframe(data.f(2), [1 1 width height]); % [left low width height]
                im = frame2im(fr);
                imwrite(im, data.file{2}, data.file{3}, 'Compression', 'none');
                clear fr im;
             end;
             clear second_channel_im;
        case 'Intensity-DIC',
            figure(data.f(1)); my_imagesc(data.im{1}); 
            axis off; my_title('Intensity',data.index);
            figure(data.f(2)); 
            my_imagesc(data.im{2});
            colormap gray; 
            axis off; my_title('DIC',data.index);
            data.im{3} = preprocess(data.im{1}, data); 
            figure(data.f(3));
            my_imagesc(data.im{3});
            imagesc(data.im{3}); caxis(data.intensity_bound);
            axis off; my_title('Processed',data.index);

            %show_detected_boundary(data.im{3}, data, data.f(3));
            if isfield(data,'quantify_roi') && data.quantify_roi,
                data = quantify_region_of_interest(data, data.im{3});
            end;
            
            if ~exist(data.file{3}, 'file') &&...
                isfield(data, 'save_processed_image')&& data.save_processed_image,                
                figure(data.f(3)); im = imscale(data.im{3}, 0, 1, caxis);
                imwrite(im, data.file{3}, 'tiff','compression', 'none');
                clear im;
             end;


    end; %switch data.protocol
    
    % Lexie on 03/02/2015
    % Draw the background region
    if show_figure_option
        if isfield(data, 'subtract_background') && data.subtract_background,
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
                    ~data.crop_image),
                draw_polygon(gca, data.bg_poly, 'yellow', file_name);
            end;  
        end;

    end
else
    display('Function update_figure warning: ');
    display('Please load the images or check the range of index.')
end; % if isfield(data, 'im'),
return;

% Keep the caxis from the previous plot
% Use caxis auto for a new figure
function my_imagesc(im)
temp = caxis;
axis_vector = axis;
clf; 
if temp(1) ==0 && temp(2) ==1,
    imagesc(im);
else
    imagesc(im, temp);
    axis(axis_vector);
end;
return;



