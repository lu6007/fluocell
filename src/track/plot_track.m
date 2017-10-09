% plot_track
% input: track_index track_with_frame movie_info
% plot_track(cell_name, track_index, track_with_frame, movie_info, varargin)
% 
function plot_track(data, track_index, track_with_frame, varargin)
parameter = {'debug', 'max_lag', 'file_type', 'separation'};
default_values = {0, 60, 'cell', 0};
[debug, max_lag, file_type, separation] = parse_parameter(parameter, default_values, varargin);
my_color = get_my_color();
gray = my_color.gray;

% No lag information in multiple tracking, comment for now. Lexie on
% 02/08/2016
% if ~debug,
%     h_cc = figure('color', 'w'); hold on;
%     set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',2);
%     axis([-max_lag max_lag -0.5 1]);
% end;


num_cc_curves = 0;
<<<<<<< HEAD
num_tracks = length(track_index);
cc_curve = cell(num_tracks,1);
=======
num_track = length(track_index);
cc_curve = cell(num_track,1);
>>>>>>> current/master
figure_num_pixels = figure('color', 'w'); hold on;
set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',2);
title('Number of Pixels');
figure_amp = figure('color', 'w'); hold on;
set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',2);
title('Average Amp');


% User defined separation process
<<<<<<< HEAD
if separation,
    % Find the longest track and regard it as a main
    for i = 1 : num_tracks
=======
if separation
    % Find the longest track and regard it as a main
    for i = 1 : num_track
>>>>>>> current/master
        ii = track_index(i);
        frame_index = track_with_frame(ii).frame_index; 
        if length(frame_index) == length(data.image_index)
            main_track_index = i;
        end
    end

<<<<<<< HEAD
    for i = 1:num_tracks,
=======
    for i = 1:num_track
>>>>>>> current/master
        % initialize the track variables
        ii = track_index(i);
        frame_index = track_with_frame(ii).frame_index;      

        % For the separation process, assign the initiation of new track with
        % previous values. Lexie on 02/08/2016
        if length(frame_index) == length(data.image_index)
            fak_intensity = track_with_frame(ii).fak_intensity;
            pax_intensity = track_with_frame(ii).pax_intensity;
            ratio = track_with_frame(ii).ratio;
            velocity = track_with_frame(ii).velocity;
            num_pixels = track_with_frame(ii).num_pixels;
            average_amp = track_with_frame(ii).average_amp;
        end

        if length(frame_index) ~= length(data.image_index)
            if exist('main_track_index', 'var')
                for j = 1 : length(data.image_index)
                    if ~ismember(j, frame_index)
                        fak_intensity(j, 1) = track_with_frame(main_track_index).fak_intensity(j);
                        pax_intensity(j, 1)  = track_with_frame(main_track_index).pax_intensity(j);
                        ratio(j, 1)  = track_with_frame(main_track_index).ratio(j);
                        velocity(j, 1)  = track_with_frame(main_track_index).velocity(j);
                        num_pixels(j, 1)  = track_with_frame(main_track_index).num_pixels(j);
                        average_amp(j, 1)  = track_with_frame(main_track_index).average_amp(j);
                    else
                        temp_index = find(frame_index == j);
                        fak_intensity(j, 1) = track_with_frame(ii).fak_intensity(temp_index);
                        pax_intensity(j, 1)  = track_with_frame(ii).pax_intensity(temp_index);
                        ratio(j, 1)  = track_with_frame(ii).ratio(temp_index);
                        velocity(j, 1)  = track_with_frame(ii).velocity(temp_index);
                        num_pixels(j, 1)  = track_with_frame(ii).num_pixels(temp_index);
                        average_amp(j, 1)  = track_with_frame(ii).average_amp(temp_index); 
                    end
                end
            else
                fak_intensity = track_with_frame(ii).fak_intensity;
                pax_intensity = track_with_frame(ii).pax_intensity;
                ratio = track_with_frame(ii).ratio;
                velocity = track_with_frame(ii).velocity;
                num_pixels = track_with_frame(ii).num_pixels;
                average_amp = track_with_frame(ii).average_amp;
            end
                % find the separation point
                separation_index = frame_index(1) - 1;
                separation_num_pixels = num_pixels(separation_index);
                separation_average_amp = average_amp(separation_index);
        end


        % normalize the curves
        temp = fak_intensity/prctile(fak_intensity, 50); clear fak_intensity;
        fak_intensity = temp; clear temp;
        temp = pax_intensity/prctile(pax_intensity, 50); clear pax_intensity;
        pax_intensity = temp; clear temp;
        temp = ratio/prctile(ratio, 50); clear ratio;
        ratio = temp; clear temp;

        % Pad the curves with zeros before birth and after death.
        % These are essential in recognizing the birth and death events. 
<<<<<<< HEAD
        num_frames = length(data.image_index);
        z_before = zeros(frame_index(1)-1,1);
%         z_before = zeros(data.image_index(1)-1,1);
        z_after = zeros(num_frames-max(frame_index),1);
%         z_after = zeros(num_frames-max(data.image_index),1);
        temp = cat(1, (1:frame_index(1)-1)', frame_index,...
            (max(frame_index)+1:num_frames)'); clear frame_index;
=======
        num_frame = length(data.image_index);
        z_before = zeros(frame_index(1)-1,1);
%         z_before = zeros(data.image_index(1)-1,1);
        z_after = zeros(num_frame-max(frame_index),1);
%         z_after = zeros(num_frame-max(data.image_index),1);
        temp = cat(1, (1:frame_index(1)-1)', frame_index,...
            (max(frame_index)+1:num_frame)'); clear frame_index;
>>>>>>> current/master
        frame_index = temp; clear temp;
        time = (data.image_index(frame_index)-1)*3;
        temp = cat(1, z_before, velocity, z_after); clear velocity;
        velocity = temp; clear temp;
        temp = cat(1, z_before, fak_intensity, z_after); clear fak_intensity;
        fak_intensity = temp; clear temp;
        temp =cat(1, z_before, pax_intensity, z_after); clear pax_intensity;
        pax_intensity = temp; clear temp;
        temp =cat(1, z_before, ratio, z_after); clear ratio;
        ratio = temp; clear temp;
        temp =cat(1, z_before, num_pixels, z_after); clear num_pixels;
        num_pixels = temp; clear temp;
        temp =cat(1, z_before, average_amp, z_after); clear average_amp;
        average_amp = temp; clear temp;

        % plot the intensity and velocity for each track
<<<<<<< HEAD
        if debug,
=======
        if debug
>>>>>>> current/master
            figure('color', 'w'); hold on;
            set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',2);
            plot(frame_index, velocity, 'k', 'LineWidth',2);
            plot(frame_index, fak_intensity, 'g', 'LineWidth', 2);
            plot(frame_index, pax_intensity,'b', 'LineWidth',2);
            plot(frame_index, ratio, 'r', 'LineWidth',2);
            title(strcat('Track ', num2str(ii)));
            legend('Velocity', 'Fak', 'Pax', 'Fak/Pax Ratio');
            axis([0 90 0 3.5]);
            xlabel('Frame Number'); 
<<<<<<< HEAD
        end;
=======
        end
>>>>>>> current/master
        figure(figure_num_pixels); plot(frame_index, num_pixels,'k--','LineWidth', 2);
        figure(figure_amp); plot(frame_index, average_amp, 'b--','LineWidth',2);

        % plot the group intensity/velocity

        % cross correlation between fak and pax
        num_cc_curves = num_cc_curves+1;
    %     this_bound = [61 90];
    %     this_index = find(time>=this_bound(1) & time<=this_bound(2));
    %     [tt, cc] = cross_correlation_2(time(this_index), fak_intensity(this_index), ...
    %         pax_intensity(this_index), 'max_lag', max_lag);
    % No cross correlation analysis in general detection and tracking, Lexie on 01/11/2016
    %     [tt, cc] = cross_correlation(time, fak_intensity, pax_intensity,...
    %         'max_lag', max_lag);
    %         if debug,
    %             figure('color', 'w'); plot(tt,cc, 'LineWidth',2);
    %             set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',2);  
    %             plot(tt,cc,'LineWidth',2);
    %             axis([-max_lag max_lag -0.5 1]);
    %             xlabel('Lag Time (min)'); ylabel('Fak-pax cross correlation');
    %         else %~debug
    %             figure(h_cc); plot(tt, cc, 'o', 'color', gray, 'LineWidth', 2);
    %         end;
    %     cc_curve{num_cc_curves} = cc;
    %     if ~exist('cc_time', 'var'),
    %         cc_time = tt;
    %     end;
    %     clear tt cc;

        clear frame_index fak_intensity pax_intensity ratio velocity time this_index;
        clear num_pixels average_amp;
<<<<<<< HEAD
    end; % for i
=======
    end % for i
>>>>>>> current/master
    %Plot the separation point for the event
    figure(figure_num_pixels); plot(separation_index, separation_num_pixels,'ro','LineWidth', 2);
    figure(figure_amp); plot(separation_index, separation_average_amp, 'ro','LineWidth',2);
    clear separation_index separation_num_pixels separation_average_amp
end


% % plot the average CC curve with the sem curves
% if ~debug,
%     cc_curve_matrix = cat(2, cc_curve{1:num_cc_curves});
%     cc_curve_mean = mean(cc_curve_matrix,2);
%     %stadard error of mean is standard deviation divided by the square root
%     %of the sample size
%     cc_curve_sem = (std(cc_curve_matrix',1))'/sqrt(num_cc_curves);
%     figure; hold on;
%     plot(cc_time, cc_curve_mean, 'r-', 'LineWidth', 2);
%     plot(cc_time, cc_curve_mean+cc_curve_sem, 'r--', 'LineWidth', 2);
%     plot(cc_time, cc_curve_mean-cc_curve_sem,'r--', 'LineWidth',2);
%     xlabel('Lag Time (min)'); ylabel('Fak-pax cross correlation');
%     axis([-max_lag max_lag -0.5 1]);
% end


% plot the lag time and the peak values of cc_curve.
<<<<<<< HEAD
% peak_time = zeros(num_tracks,1);
% peak_value = zeros(num_tracks,1);
% for i = 1:num_tracks,
=======
% peak_time = zeros(num_track,1);
% peak_value = zeros(num_track,1);
% for i = 1:num_track,
>>>>>>> current/master
%     [cc_max, j] = max(abs(cc_curve{i}));
%     peak_time(i) = cc_time(j);
%     peak_value(i) = cc_curve{i}(j);
% end;
% figure; 
% set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',2);
% plot(peak_time, peak_value, 'k.', 'MarkerSize', 6, 'LineWidth',2);
% xlabel('Lag Time (min)'); ylabel('Peak Value');
% title(regexprep(data.cell_name,'\_', '\\_'));
% axis([-max_lag max_lag -1 1]);

return;
    
