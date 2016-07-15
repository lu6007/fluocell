%%
%cell_name = 'fak_pax';
% cell_name = 'ct01';
% cell_name = 'sh01';
% cell_name = 'ct06';
% cell_name = 'ct03';
cell_name = '09_08';

data = init_data(cell_name);

%%
movie_info = get_movie_info(data, 'load_file',0);
frame_index = 1:length(data.image_index);
tracksFinal = get_track(cell_name, movie_info(frame_index), 'load_file', 1, 'save_file', 0);
frame_with_track = get_frame_track(tracksFinal,movie_info(frame_index));
track_with_frame= get_track_frame(cell_name, tracksFinal, movie_info(frame_index));
frame_with_track = get_cc_peak(cell_name, frame_with_track, track_with_frame,...
    'max_lag', 20);
track_index = data.track_index;
%track_index = 1:length(track_with_frame);
overlay_image_track(cell_name, frame_with_track,...
  'image_index', data.image_index,'load_file', 1, 'track_index', track_index, 'save_file', 0);
plot_track(cell_name, track_index, track_with_frame, 'max_lag', 20, 'debug', 0);

% %% Make movie
% file_prefix = 'fa_track';
% %file_prefix = 'fa_track_sub';
% %info.movie_frame = data.movie_frame;
% info.path = data.path;
% info.image_index = data.image_index;
% info.index_pattern = cell(2,1);
% info.index_pattern{1} = sprintf(data.index_pattern, data.image_index(1));
% info.index_pattern{2} = data.index_pattern;
% info.first_file = strcat(file_prefix, info.index_pattern{1}, '.tiff');
% info.file_name = strcat(file_prefix, '.avi');
% movie = make_movie_3(info);


%% invapodia analysis 6/20/2013
% cd app/fa_analysis
%% Initialization
cell_name = '5_18_control2';
data = init_data('5_18_control2');

%% Detect cell and invapodia
batch_detect_cell(cell_name, data);
batch_detect_fa(cell_name, data);

%% Compute tracking
movie_info = get_movie_info(cell_name, 'load_file',0,'save_file', 1);
frame_index = data.image_index;
tracksFinal = get_track(cell_name, movie_info(frame_index));
frame_with_track = get_frame_track(tracksFinal,movie_info(frame_index));

%% Make a movie of the fluorescence image with tracking
overlay_image_track(cell_name, frame_with_track,...
    'image_index', data.image_index,'load_file', 0,'save_file',1 );
info.path = strcat(data.path, 'output\');
info.first_file = 'T00001.tiff';
info.index_pattern = data.index_pattern;
info.image_index = data.image_index;
info.file_name = strcat(data.path, 'output\tracking.avi');
movie = make_movie(info);

