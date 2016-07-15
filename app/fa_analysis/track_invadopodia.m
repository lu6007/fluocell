% Example cell_name
% 0518_control2 05_18_control8 0518_shFAPa4 0518_shFAPa6
%% Detect cell and invadopodia
cell_name = '0518_control2';
data = init_data(cell_name);
batch_detect_cell(cell_name, data,'save_file',0);
batch_detect_fa(cell_name, data);

%% Calculating tracking of the invadopodia
movie_info = get_movie_info(data,  'load_file',1);
frame_index = 1:length(data.image_index);
tracksFinal = get_track(data, movie_info(frame_index), 'load_file', 1, 'save_file', 0);
frame_with_track = get_frame_track(tracksFinal,movie_info(frame_index));
track_index = 1:length(tracksFinal);
overlay_image_track(data, frame_with_track,...
'image_index', data.image_index,'load_file', 0,'track_index', track_index, 'save_file', 0);

%% Plot the quantified results with the invadopodia
track_20 = 1:20;
track_with_frame= get_track_frame(data, tracksFinal, movie_info(frame_index));
%plot_track(data, track_20, track_with_frame, 'max_lag', 20, 'debug', 0);

% calculate the track lifetime
num_tracks = length(track_20);
track_lifetime = zeros(num_tracks,1);
for i = 1:num_tracks,
    f_index = track_with_frame(i).frame_index;
    track_lifetime(i) = max(f_index)-min(f_index)+1;
end

%% Next steps
% 1. make the plots work
%    a. quantify the size of the invadopodia.
%    b. Quantify the average intensity of the  invadopodia.
% 2. make an interface to the MATLAB data.
%    a. Write a function to convert MATLAB dataset into tiff images.
%       MATLAB_image_array_2_tiff, works in the current folder.
% 3. Analyze 5 cells in each group. 