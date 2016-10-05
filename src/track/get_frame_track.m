% function frame_with_track = get_frame_track(tracksFinal, movie_info)

% Copyright Shaoying Lu 2016, shaoying.lu@gmail.com
function frame_with_track = get_frame_track(tracksFinal, movie_info)
% initialize frame_with_track
num_frames = length(movie_info);

% For general tracking purpose, change all the name with "fa" to be
% "object", Lexie on 01/11/2016
% fields = {'num_tracks', 'centroid', 'track_index', 'fa_index'};
fields = {'num_tracks', 'centroid', 'track_index', 'object_index'};
num_fields = length(fields);
c = cell(num_frames, num_fields);
for i = 1:num_frames, 
%     num_fas = size(movie_info(i).xCoord,1);
    num_objects = size(movie_info(i).xCoord,1);
    c{i, 1} = 0;
%     c{i, 2} = zeros(num_fas, 2);
%     c{i, 3} = zeros(num_fas, 1);
%     c{i, 4} = zeros(num_fas, 1);
    c{i, 2} = zeros(num_objects, 2);
    c{i, 3} = zeros(num_objects, 1);
    c{i, 4} = zeros(num_objects, 1);
end;
frame_with_track = cell2struct(c, fields, 2);
num_tracks = length(tracksFinal);

% Now populate frame_with_track and track_with_frame
for i = 1:num_tracks,
%     fa_index = tracksFinal(i).tracksFeatIndxCG; 
    object_index = tracksFinal(i).tracksFeatIndxCG;
%     num_subtracks = size(fa_index, 1);
    num_subtracks = size(object_index, 1);
    first_frame = tracksFinal(i).seqOfEvents(1,1);
    for ii = 1:num_subtracks,
%         frame_index = find(fa_index(ii,:))';
        frame_index = find(object_index(ii,:))';
%         this_fa_index = fa_index(ii, frame_index);
        this_object_index = object_index(ii, frame_index);
        % centroid
        index = [(frame_index-1)*8+1 (frame_index-1)*8+2];
        temp = tracksFinal(i).tracksCoordAmpCG(ii, :);
        centroid = temp(index); clear temp; clear index;
        num_dots = size(frame_index, 1);
        this_frame_index = first_frame+frame_index-1;
        for j = 1:num_dots,
            k = this_frame_index(j);
            kk = frame_with_track(k).num_tracks+1;
            frame_with_track(k).num_tracks = kk;
            frame_with_track(k).centroid(kk,:) = centroid(j, :);
            frame_with_track(k).track_index(kk) = i;
%             frame_with_track(k).fa_index(kk) = this_fa_index(j);
            frame_with_track(k).object_index(kk) = this_object_index(j);
        end;
        clear frame_index num_dots index centroid this_object_index temp ...
            this_frame_index;
    end; %ii
end; %i
return;