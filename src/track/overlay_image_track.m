
% Usage w/ multiple object tracking.
% function overlay_image_track(data, frame_with_track, varargin)
%     parameter = {'mode', 'image_index', 'track_index','load_file', 'save_file',...
%         'output_prefix', 'file_type'};
%     default_value = {1, data.image_index, [], 0, 0, 'fa_track', 'cell'};
%
% Example: 
% fluocell_data = batch_update_figure(fluocell_data);
% coordInfo = multiple_object.getCoord(fluocell_data);
% [fluocell_data, cell_location] = multiple_object.simpleTrack(fluocell_data,coordInfo,'output_cell_location',1);
% frame_with_track = multiple_object.create_frame_track(cell_location);
% overlay_image_track(fluocell_data, frame_with_track);

% Copyright: Shannon Laub and Shaoying Lu 2017

function overlay_image_track(data, frame_with_track, varargin)
    parameter = {'mode', 'image_index', 'track_index','load_file', 'save_file',...
        'output_prefix', 'file_type'};
    default_value = {1, data.image_index, [], 0, 0, 'fa_track', 'cell'};
    [mode, image_index, track_index, load_file, save_file, output_prefix, file_type]= ...
        parse_parameter(parameter, default_value, varargin);

    pattern = data.index_pattern{2};
    
    if isfield(data,'image_axis')
        image_axis = data.image_axis;
    else
        image_axis = [];
    end
    if isfield(data, 'image_frame')
        image_frame = data.image_frame;
    else
        image_frame = [];
    end
    if mode ==1
        ratio_bound = [0 2];
    elseif mode ==2
        ratio_bound = [-5 5];
    end
    %intensity_bound = [1 300];

    % load fa_bw    
    first_index_pattern = sprintf(pattern, data.image_index(1));
    switch file_type
        case 'cell'
            first_file = data.first_file;
        case 'fa'
            first_file = strcat(data.path, data.first_file);
    end
    screen_size = get(0,'ScreenSize');
    load my_hsv.mat;
    
    %Removes nonexistant frames from image_index.
    absent_frame = get_data.absent_frame(data);
    image_index = image_index(~ismember(image_index,absent_frame));
    
    for k = 1:length(image_index) 
        i = image_index(k);
        index = sprintf(pattern, i);
        output_file = strcat(data.path, 'output/', index, '.tiff');
        if exist(output_file, 'file') && load_file 
            im = imread(output_file);
            figure('Position',[1 1 screen_size(4) screen_size(4)],'color', 'w');
            set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',2);
            imshow(im);
            clear im;
        else %if ~exist(output_file, 'file'),
%            fa_file = strcat(data.path, 'output/fa_', index, '.mat');
%            fa_result = load(fa_file);
%            fa_bw = fa_result.fa_bw;
           % For different file type, use a switch method, Lexie on
           % 01/08/2016
           switch file_type
               case 'cell'
                   object_file = strcat(data.path, 'output/cell_bw_', index, '.mat');
                   object_result = load(object_file);
                   object_bw = object_result.cell_bw;
               case 'fa'
                   object_file = strcat(data.path, 'output/fa_', index, '.mat');
                   object_result = load(object_file);
                   object_bw = fa_result.object_bw;
           end
            if mode ==1
                im_file = regexprep(first_file,first_index_pattern, index);
                temp = imread(im_file);
                im = preprocess(temp(:,:,1),data);
                clear im_file temp;
%             elseif mode ==2,
%                 num_track = frame_with_track(k).num_track;
%                 im_ratio = -30*ones(size(fa_bw));
%                 if num_track>0,
%                     centroid = frame_with_track(k).centroid(1:num_track, :);
%                     for j = 1:num_track,
%                         ic= floor(centroid(j,:)+0.5);
%                         ybound = (max(ic(1)-5, 1): min(ic(1)+5, size(im_ratio,2)));
%                         xbound = (max(ic(2)-5, 1): min(ic(2)+5, size(im_ratio,1)));
%                         im_ratio(xbound, ybound) = frame_with_track(k).cc_peak(j,1);
%                     end;
%                     clear centroid;
%                 end;
            end
% 
            % now overlay with a cross and the track number.
            % save image  
        %    im_imd = get_imd_image(im_ratio, double(im_fak)+factor*double(im_pax),...
        %          'ratio_bound', ratio_bound, 'intensity_bound', intensity_bound);
            figure(data.f(1)); 

            if mode ==1
                %imagesc(double(im).*double(fa_bw)); hold on;
                %colormap(my_hsv); nn = length(my_hsv);
                %colorbar('YTick', [1; nn], 'YTickLabel', ratio_bound');
                imagesc(double(im)); hold on;
                colormap(gray); %caxis(data.cbound); %Not used?
%             elseif mode ==2,
%                 imagesc(im_ratio); hold on; 
%                 caxis(ratio_bound); 
%                 colorbar;
            end % if mode
                num_track = frame_with_track(k).num_track;
                if num_track>0
                    centroid = frame_with_track(k).centroid(1:num_track,:);
                    this_track_index = frame_with_track(k).track_index(1:num_track);
                    if ~isempty(track_index)
                        this_track_index = frame_with_track(k).track_index(1:num_track);
                        temp = zeros(frame_with_track(k).num_track,1);
                        num_display_tracks = 0;
                        for kk = 1:length(track_index)
                            ii_index = find(this_track_index == track_index(kk),1);
                            if ~isempty(ii_index)
                                num_display_tracks = num_display_tracks+1;
                                temp(num_display_tracks) = ii_index;
                            end
                            clear ii_index;
                        end
                        tt = temp(1:num_display_tracks); clear temp;
                        temp = tt; clear tt;
                        tt = this_track_index(temp); 
                        clear this_track_index;
                        this_track_index = tt; clear tt;
                        tt = centroid(temp,:); clear centroid;
                        centroid = tt; clear tt temp;
                    end                    
                    plot(centroid(:,1), centroid(:,2), 'r+');
                    text_str = num2str(this_track_index);
                    text(centroid(:,1)+2, centroid(:,2),...
                        text_str, 'color', 'r','FontWeight', 'bold');
                end % if num_traks>0
            set(gca, 'FontSize', 32, 'FontWeight', 'bold','Box', 'off', 'LineWidth', 2);
            if ~isempty(image_axis)
                axis(image_axis); 
            end
            set(gca, 'YDir', 'reverse');
            my_title('FI', i, 'data', data);
            pause(0.3); 
            if save_file
                F = getframe(gcf);
                if isempty(image_frame)
                    imwrite(F.cdata, output_file);
                else 
                    imwrite(F.cdata(image_frame(1):image_frame(2),...
                        image_frame(3):image_frame(4),:), output_file);
                end
                clear F;
            end
            clear index im_ratio;
            clear output_file fak_fa_file fak_result pax_fa_file pax_result object_bw text_str;
            clear im_imd  centroid h this_track_index;
        end % if exist file

    end % for k 
    
return;