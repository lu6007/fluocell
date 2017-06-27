% function track_with_frame = get_track_frame(tracksFinal, movie_info)
function track_with_frame = get_track_frame(data, tracksFinal, movie_info)

% initialize track_with_frame (twf)
num_tracks = length(tracksFinal);
twf_fields = {'num_subtracks', 'subtrack', 'frame_index', ...
    'fak_intensity', 'pax_intensity', 'ratio', 'velocity', 'time','average_amp','num_pixels'}; 
num_twf_fields = length(twf_fields);
twf_c = cell(num_tracks, num_twf_fields);
% subtrack_fields  = {'num_frames', 'frame_index', 'fa_index'};
subtrack_fields  = {'num_frames', 'frame_index', 'object_index'};
num_subtrack_fields = length(subtrack_fields);
has_fak_total_intensity = 1;
has_pax_total_intensity = 1;

% Now populate track_with_frame with subtracks
for i = 1:num_tracks
%     fa_index = tracksFinal(i).tracksFeatIndxCG; 
    object_index = tracksFinal(i).tracksFeatIndxCG; 
%     num_subtracks = size(fa_index, 1);
    num_subtracks = size(object_index, 1);
    first_frame = tracksFinal(i).seqOfEvents(1,1);
    twf_c{i,1} = num_subtracks; 
    subtrack_c = cell(num_subtracks, num_subtrack_fields);
    for ii = 1:num_subtracks
%         frame_index = find(fa_index(ii,:))';
        frame_index = find(object_index(ii,:))';
%         this_fa_index = fa_index(ii, frame_index);
        this_object_index = object_index(ii, frame_index);
        num_dots = size(frame_index, 1);
        this_frame_index = first_frame+frame_index-1;
        % subtrack
        subtrack_c{ii,1} = num_dots;
        subtrack_c{ii, 2} = this_frame_index;
%         subtrack_c{ii, 3} = this_fa_index;
        subtrack_c{ii, 3} = this_object_index;
        clear frame_index num_dots index centroid this_object_index temp ...
            this_frame_index;
    end %ii
    % subtrack
    twf_c{i,2}= cell2struct(subtrack_c, subtrack_fields, 2);
    clear subtrack_c;
end %i

% Now populate additional field: frame_index, fak_intensity, pax_intensity,
% ratio, velocity, time, etc
if ~isfield(movie_info(1),'fak_total_intensity')
    has_fak_total_intensity = 0;
    disp('Warning: get_track_frame - No fak_total_intensity');
end
if ~isfield(movie_info(1), 'pax_total_intensity')
    has_pax_total_intensity = 0;
    disp('Warning: get_track_frame - No pax_total_intensity');
end
for i = 1:num_tracks
    % initialize the track variables
    num_subtracks = twf_c{i,1};
    frame_index = cell(num_subtracks,1);
    for k = 1:num_subtracks
        subtrack = twf_c{i,2}(k);
        frame_index{k} = subtrack.frame_index;
        clear subtrack;
    end
    long_frame_index = cat(1, frame_index{:}); 
    unique_frame_index = unique(long_frame_index);
    clear frame_index long frame_index;
    frame_index = sort(unique_frame_index, 'ascend'); 
    clear long_frame_index unique_frame_index;
    
    num_frames = length(frame_index);
    fak_intensity = zeros(num_frames,1); % total  intensity
    pax_intensity = zeros(num_frames,1); % total intensity
    ratio = zeros(num_frames,1); % average ratio
    average_amp = zeros(num_frames, 1); % average_amp
    num_pixels = zeros(num_frames, 1); 
    centroid = zeros(num_frames,2);
%     num_fas = zeros(num_frames, 1);
    num_object = zeros(num_frames, 1);
    
    % Now populate the track variables
    for j = 1:num_frames
        jj = frame_index(j);
        for k = 1:num_subtracks
            subtrack = twf_c{i,2}(k);
            index = find(subtrack.frame_index==jj);
            if isempty(index)
                continue;
            else
                %assert(length(index)==1);
%                 num_fas(j) = num_fas(j)+1;
                num_object(j) = num_object(j)+1;
%                 fa_index = subtrack.fa_index(index); % a number, not a vector
                object_index = subtrack.object_index(index); % a number, not a vector
%                 centroid(j,:) = centroid(j,:)+[movie_info(jj).xCoord(fa_index), ...
%                     movie_info(jj).yCoord(fa_index)];
                centroid(j,:) = centroid(j,:)+[movie_info(jj).xCoord(object_index), ...
                    movie_info(jj).yCoord(object_index)];
                if has_fak_total_intensity
%                     fak_intensity(j) = fak_intensity(j)+...
%                         movie_info(jj).fak_total_intensity(fa_index);
                    fak_intensity(j) = fak_intensity(j)+...
                        movie_info(jj).fak_total_intensity(object_index);
                end
                if has_pax_total_intensity
%                     pax_intensity(j) = pax_intensity(j)+...
%                         movie_info(jj).pax_total_intensity(fa_index);
                    pax_intensity(j) = pax_intensity(j)+...
                        movie_info(jj).pax_total_intensity(object_index);
                end
%                 average_amp(j) = average_amp(j)+movie_info(jj).amp(fa_index);
                average_amp(j) = average_amp(j)+movie_info(jj).amp(object_index);   
%                 num_pixels(j) = num_pixels(j) +movie_info(jj).num_pixels(fa_index);
                num_pixels(j) = num_pixels(j) +movie_info(jj).num_pixels(object_index);
            end % if 
            clear subtrack;
        end % for k
%         centroid(j,:) = centroid(j,:)/num_fas(j);
        centroid(j,:) = centroid(j,:)/num_object(j);
        ratio(j) = fak_intensity(j)/(pax_intensity(j)+1.0); %+1 eliminate the division by zero problem
        average_amp(j) = average_amp(j)/num_pixels(j);
    end % for j
    time = (data.image_index(frame_index)-1)*3; % min
    dt = center_difference(time);
    dc = center_difference(centroid);
    dc(:,1) = dc(:,1)./dt; dc(:,2) = dc(:,2)./dt;
    velocity = sqrt(dc(:,1).*dc(:,1)+dc(:,2).*dc(:,2));
    
    twf_c{i,3} = frame_index;
    twf_c{i,4} = fak_intensity; 
    twf_c{i,5} = pax_intensity;
    twf_c{i,6} = ratio;
    twf_c{i,7} = velocity;
    twf_c{i, 8} = time;
    twf_c{i,9} = average_amp;
    twf_c{i,10} = num_pixels;
    
    clear frame_index fak_intensity pax_intensity ratio centroid dt dc velocity ...
       num_object num_pixels time amp;
end % for i

%
track_with_frame = cell2struct(twf_c, twf_fields, 2);
return;