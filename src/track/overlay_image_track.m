
% function overlay_image_track(cell_name, frame_with_track, varargin)
% Overlay the ratio image of FAK/paxillin with a cross and the
% corresponding track number
% cell_name = 'fak_pax';
% movie_info = get_movie_info(cell_name);
% tracksFinal = get_track( movie_info);
% frame_with_track = get_frame_with_track(tracksFinal, movie_info);
% overlay_image_track need to have the same image_index as 
% the array frame_with_track. If frame_with_track was not extracted with
% image_index, then use frame_with_track(image_index) as the input.

% mode=1: overlay the ratio image with the track number
% mode = 2: overlay the lag time with the track number

function overlay_image_track(data, frame_with_track, varargin)
    parameter = {'mode', 'image_index', 'track_index','load_file', 'save_file',...
        'output_prefix'};
    default_value = {1, data.image_index, [], 0, 0, 'fa_track'};
    [mode, image_index, track_index, load_file, save_file, output_prefix]= ...
        parse_parameter(parameter, default_value, varargin);

    pattern = data.index_pattern{2};
    
    if isfield(data,'image_axis'),
        image_axis = data.image_axis;
    else
        image_axis = [];
    end;
    if isfield(data, 'image_frame');
        image_frame = data.image_frame;
    else
        image_frame = [];
    end;
    if mode ==1,
        ratio_bound = [0 2];
    elseif mode ==2,
        ratio_bound = [-5 5];
    end;
    %intensity_bound = [1 300];

    % load fa_bw    
    first_index_pattern = sprintf(pattern, data.image_index(1));
    first_file = strcat(data.path, data.first_file);
    screen_size = get(0,'ScreenSize');
    load my_hsv.mat;
    for k = 1:length(image_index), 
        i = image_index(k);
        index = sprintf(pattern, i);
        output_file = strcat(data.path, 'output/', index, '.tiff');
        if exist(output_file, 'file') && load_file, 
            im = imread(output_file);
            figure('Position',[1 1 screen_size(4) screen_size(4)],'color', 'w');
            set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',2);
            imshow(im);
            clear im;
        else %if ~exist(output_file, 'file'),
           fa_file = strcat(data.path, 'output/fa_', index, '.mat');
           fa_result = load(fa_file);
           fa_bw = fa_result.fa_bw;
            if mode ==1,
                im_file = regexprep(first_file,first_index_pattern, index);
                temp = imread(im_file);
                im = preprocess(temp(:,:,1),data);
                clear im_file temp;
%             elseif mode ==2,
%                 num_tracks = frame_with_track(k).num_tracks;
%                 im_ratio = -30*ones(size(fa_bw));
%                 if num_tracks>0,
%                     centroid = frame_with_track(k).centroid(1:num_tracks, :);
%                     for j = 1:num_tracks,
%                         ic= floor(centroid(j,:)+0.5);
%                         ybound = (max(ic(1)-5, 1): min(ic(1)+5, size(im_ratio,2)));
%                         xbound = (max(ic(2)-5, 1): min(ic(2)+5, size(im_ratio,1)));
%                         im_ratio(xbound, ybound) = frame_with_track(k).cc_peak(j,1);
%                     end;
%                     clear centroid;
%                 end;
            end;
% 
            % now overlay with a cross and the track number.
            % save image  
            figure('Position',[1 1 screen_size(4) screen_size(4)],'color', 'w');
            set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',2);
        %    im_imd = get_imd_image(im_ratio, double(im_fak)+factor*double(im_pax),...
        %          'ratio_bound', ratio_bound, 'intensity_bound', intensity_bound);
            if mode ==1,
                %imagesc(double(im).*double(fa_bw)); hold on;
                %colormap(my_hsv); nn = length(my_hsv);
                %colorbar('YTick', [1; nn], 'YTickLabel', ratio_bound');
                imagesc(double(im)); hold on;
                colormap(gray); caxis(data.cbound);
%             elseif mode ==2,
%                 imagesc(im_ratio); hold on; 
%                 caxis(ratio_bound); 
%                 colorbar;
            end; % if mode
                num_tracks = frame_with_track(k).num_tracks;
                if num_tracks>0,
                    centroid = frame_with_track(k).centroid(1:num_tracks,:);
                    this_track_index = frame_with_track(k).track_index(1:num_tracks);
                    if ~isempty(track_index),
                        this_track_index = frame_with_track(k).track_index(1:num_tracks);
                        temp = zeros(frame_with_track(k).num_tracks,1);
                        num_display_tracks = 0;
                        for kk = 1:length(track_index),
                            ii_index = find(this_track_index == track_index(kk),1);
                            if ~isempty(ii_index),
                                num_display_tracks = num_display_tracks+1;
                                temp(num_display_tracks) = ii_index;
                            end;
                            clear ii_index;
                        end;
                        tt = temp(1:num_display_tracks); clear temp;
                        temp = tt; clear tt;
                        tt = this_track_index(temp); 
                        clear this_track_index;
                        this_track_index = tt; clear tt;
                        tt = centroid(temp,:); clear centroid;
                        centroid = tt; clear tt temp;
                    end;                    
                    plot(centroid(:,1), centroid(:,2), 'r+');
                    text_str = num2str(this_track_index);
                    text(centroid(:,1)+2, centroid(:,2),...
                        text_str, 'color', 'r','FontWeight', 'bold');
                    % Display the FA index number for debugging purpose.
                %     clear text_str; text_str = num2str(frame_with_track(k).fa_index);
                %     text(centroid(:,1)+5, centroid(:,2), text_str, 'color', 'y');
                end; % if num_traks>0
            set(gca, 'FontSize', 32, 'FontWeight', 'bold','Box', 'off', 'LineWidth',2);
            if ~isempty(image_axis)
                axis(image_axis); 
            end;
            set(gca, 'YDir', 'reverse');
            if save_file,
                F = getframe(gcf);
                if isempty(image_frame),
                    imwrite(F.cdata, output_file);
                else 
                    imwrite(F.cdata(image_frame(1):image_frame(2),...
                        image_frame(3):image_frame(4),:), output_file);
                end;
                clear F;
            end;
            clear index im_ratio;
            clear output_file fak_fa_file fak_result pax_fa_file pax_result fa_bw text_str;
            clear im_imd  centroid h this_track_index;
    %     % Double check the index numbers by drawing the images with FA index.
    %     clear centroid;
    %     h = figure('Position',[1 screen_size(4) screen_size(3) screen_size(4)]);
    %     imshow(im_imd); hold on;
    %     centroid = [movie_info(k).xCoord(:,1) movie_info(k).yCoord(:,1)];
    %     plot(centroid(:,1), centroid(:,2), 'w+');
    %     num_fas = size(centroid,1);
    %     text_str = num2str([1:num_fas]');
    %     text(centroid(:,1), centroid(:,2), text_str, 'color', 'y');
    %     axis([47 411 90 495]); 
        end; % if exist file

    end; % for k 
    
return;