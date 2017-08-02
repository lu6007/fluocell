classdef multiple_object
    %multiple_object contains functions for tracking multiple objects in
    %one frame.
    methods (Static)
        function [data, cell_location] = simpletracking(data, coordInfo, varargin)
            %Parameters
            %data: fluocell_data
            %coordInfo: from multiple_object.getCoord()
            %remove_short_track: boolean
            %min_track_length: min. num. of timeframes a track must be.
            %plot_cell_split: boolean
            %max_distance: max distance between cells for cell splitting
            %detection
            %   Is a percentage of the total image size.
            
            % Priority of parameter values: (1) function input 
            % (2) data.track_option (3) default values
            default_remove_short_track = 0;
            default_min_track_length = ceil(0.5*length(coordInfo));
            default_plot_cell_split= 0;
            default_max_distance = 0.40;
            default_output_cell_location = 0;
            
            if isfield(data, 'track_option') 
                track_option = data.track_option;
                if isfield(track_option, 'remove_short_track')
                    default_remove_short_track = track_option.remove_short_track;
                    if ~isempty(track_option.min_track_length)
                        default_min_track_length = track_option.min_track_length;
                    end
                    default_plot_cell_split = track_option.plot_cell_split;
                    default_max_distance = track_option.max_distance;
                    default_output_cell_location = track_option.output_cell_location;
                end
            end

            %Initializing parameter/variable values.
            parameter_name = {'remove_short_track', 'min_track_length',...
                'plot_cell_split','max_distance','output_cell_location'};
            default_value = {default_remove_short_track, default_min_track_length, ...
                default_plot_cell_split, default_max_distance,default_output_cell_location};
            
            [remove_short_track, min_track_length,...
                plot_cell_split, max_distance, output_cell_location] =...
                parse_parameter(parameter_name, default_value, varargin);
            

            %Debug multiple_object.simpletracking() parameters
%             remove_short_track = 1;
% %             min_track_length = 8;
%             plot_cell_split = 1;
%             max_distance = 0.40;
                   
            %simpletracker parameters
            maxLinkingDistance = 5000;
            maxGapClosing = 3;
            debug = true;
%             maxLinkingDistance = 500000;
%             maxGapClosing = 30;
%             debug = true;
            
            %Convert coordInfo to a data structure that simpletracker can use.
            coordInfo = struct2cell(coordInfo)';
            numFrame = length(coordInfo);
            d = cell(numFrame,1);
            for i = 1:numFrame
                d{i,1}=cell2mat(coordInfo(i,:));
            end
            coordInfo = d; 
            clear i d;
            
            % Accounting for empty frames before running simpletracker().
%             removedFramesIndex = find(cellfun('isempty',coordInfo))'; %Getting the indices for empty frames.
% %             frameIndex = data.image_index(removedFramesIndex);
%             frameIndex = find(~cellfun('isempty',coordInfo))';
%             coordInfo = coordInfo(frameIndex);
            
            removedFramesIndex = get_data.nonexistant_frames(data); %Getting the indices for empty frames.
            image_index = data.image_index;
            frameIndex = image_index(~ismember(image_index,removedFramesIndex));
            coordInfo = coordInfo(frameIndex);
            
            % Running simpletracker.
            [ tracks, adjacency_tracks ] = simpletracker(coordInfo,...
                'MaxLinkingDistance', maxLinkingDistance, ...
                'MaxGapClosing', maxGapClosing, ...
                'Debug', debug);
            
            %% Reformatting the data using information from simpletracker(), Part 1 of 2.
            %Concatenate data the same way that simpletracker concatenates.
            
            %Initialize new data.ratio, channel1, channel2, etc.
            %num_track is the number of objects that simpletracker has determined!
            num_track = numel(tracks);
            
            %Initialize temp variables.
            temp_ratio = cell(1,num_track);
            temp_channel1 = cell(1,num_track);
            temp_channel2 = cell(1,num_track);
            temp_cellSize = cell(1,num_track);
            temp_location = cell(size(coordInfo,1),num_track);
            
            %Initialize variables.
            dataRatio = [];
            dataChannel1 = [];
            dataChannel2 = [];
            dataCellSize = [];

            allRatio = [];
            allChannel1 = [];
            allChannel2 = [];
            allCellSize = [];
            
            %Converting cell array to a double array.
            for i = 1:length(data.ratio)
                dataRatio = [dataRatio data.ratio{i}];
                dataChannel1 = [dataChannel1 data.channel1{i}];
                dataChannel2 = [dataChannel2 data.channel2{i}];
                dataCellSize = [dataCellSize data.cell_size{i}];
            end; clear i;
            
            %Concatenating values.
            for i = 1:numFrame
                allRatio = [allRatio horzcat(dataRatio(i,:))];
                allChannel1 = [allChannel1 horzcat(dataChannel1(i,:))];
                allChannel2 = [allChannel2 horzcat(dataChannel2(i,:))];
                allCellSize = [allCellSize horzcat(dataCellSize(i,:))];
            end; clear i;
            
            %Remove NaN values.
            allRatio(isnan(allRatio(:)) ) = [];
            allChannel1(isnan(allChannel1(:)) ) = [];
            allChannel2(isnan(allChannel2(:)) ) = [];
            allCellSize(isnan(allCellSize(:)) ) = [];

            %Convert row to column.
            allRatio = allRatio';
            allChannel1 = allChannel1';
            allChannel2 = allChannel2';
            allCellSize = allCellSize';
            allLocation = vertcat(coordInfo{:});

            %% Reformatting the data using information from simpletracker(), Part 2 of 2.
            %Reformat data using tracking information from simpletracker().
            for i = 1:num_track
               %Account for the different row indexing of tracks and adjacency_tracks.
               trackIndex = 1;
               adjIndex = 1;
               for j = 1:numFrame
                   %Adding NaN values where a frame was removed.
                   if any(removedFramesIndex == j)
                       for b = 1:num_track
                           temp_ratio{b}(j,1) = nan;
                           temp_channel1{b}(j,1) = nan;
                           temp_channel2{b}(j,1) = nan;
                           temp_cellSize{b}(j,1) = nan;
                           temp_location{j,b} = nan;
                       end
                   %Save NaN value if 'tracks' from simpletracker was NaN at frame number 'j'.
                   elseif isnan(tracks{i}(trackIndex))
                       temp_ratio{i}(j,1) = nan;
                       temp_channel1{i}(j,1) = nan;
                       temp_channel2{i}(j,1) = nan;
                       temp_cellSize{i}(j,1) = nan;
                       temp_location{j,i} = nan;
                       trackIndex = trackIndex + 1;
                   else %if 'tracks' is not NaN
                       temp_ratio{i}(j,1) = allRatio(adjacency_tracks{i}(adjIndex));
                       temp_channel1{i}(j,1) = allChannel1(adjacency_tracks{i}(adjIndex));
                       temp_channel2{i}(j,1) = allChannel2(adjacency_tracks{i}(adjIndex));
                       temp_cellSize{i}(j,1) = allCellSize(adjacency_tracks{i}(adjIndex));
                       temp_location{j,i} = allLocation(adjacency_tracks{i}(adjIndex),:);
                       adjIndex = adjIndex + 1;
                       trackIndex = trackIndex + 1;
                   end
               end
            end
            clear i j b trackIndex adjIndex
            
      
            %% Checking and plotting cell splitting.
            %Run two checks when a new cell appears:
            %Check cell size - seems to shrink ~half about 1-3 frames before split
            %Check cell location - ensure new and old cells are sufficiently close
            if plot_cell_split == 1
                if num_track > 1                    
                    track_cell_size = nan(numFrame,num_track);
                    for k = 1:num_track
                        track_cell_size(:,k) = temp_cellSize{k}(:);
                    end
                    clear k;
                    for i = 1:num_track
                        %Will only run splitting detection if a cell was not present in
                        %the first frame.
                        if isnan(temp_ratio{i}(1))
                            for j = 2:numFrame
                                %continue if current frame has NaN value in this track
                                if isnan(temp_ratio{i}(j))
                                    continue;
                                end
                                
                                
                                %>>Check if any other cells have shrunk in the same frame.
                                %Compare using the average of the last 3ish frames.
                                if j <= 3
                                    %Using 1:j-1 so there are at least 2 rows for nanmean.
                                    %Min j value is 2. Max j value is num of time frames.
                                    avg_pixel = nanmean(track_cell_size(1:j-1,:));
                                else
                                    avg_pixel = nanmean(track_cell_size(j-3:j-1,:));
                                end
                                %Difference between avg of last ~3 frames & current frame
                                %Positive > cell shrank. Negative > cell grew.
                                diff_pixel = avg_pixel - track_cell_size(j,:);
                                
                                
                                %>>Check distance between the cells.
                                if any(diff_pixel > 0) %&& any(diff_pixel > 0.2*avg_pixel)
                                    %Gets index of the cell w/ the max size difference.
                                    [~,I] = max(diff_pixel);
                                    % i is new cell, I is cell it split from
                                    
                                    % Check if cells are sufficiently close to each other.
                                    distance = pdist([temp_location{j,i}; temp_location{j,I}]);
                                    
                                    im_size = size(data.im{1});
                                    maximum_distance = max_distance * max(im_size);
                                    
                                    if distance < maximum_distance
                                        %"Merge" the plot of the new cell w/ the original cell.
                                        track_cell_size(1:j-1,i) = track_cell_size(1:j-1,I);
                                        temp_ratio{i}(1:j-1) = temp_ratio{I}(1:j-1);
                                        %Saving frame of split for plotting later.
%                                         split_pixel = [split_pixel; track_cell_pixel(j-1,i) j-1];
%                                         split_ratio = [split_ratio; temp_ratio(j-1,i) j-1];
                                        disp('An instance of cell splitting was detected.');
                                    end
                                end
                                
                                break;
                            end
                        end
                    end
                    clear i j;
                end
            end
            
            %% Option for removing very short tracks.
            %Function parameter: min_track_length >> default = 2
            if remove_short_track == 1
                k = 0; %Initialize for tracking the number of removed tracks.
                for i = 1:num_track
                    j = i - k; %Update index to account for removed tracks.
                    %Check if the track is shorter than the min track length.
                    if sum(~isnan(temp_ratio{j})) <= min_track_length
                        temp_ratio(j)=[]; %Remove short track.
                        temp_channel1(j)=[]; %Remove short track.
                        temp_channel2(j)=[]; %Remove short track.
                        temp_cellSize(j)=[]; %Remove short track.
                        k = k + 1; %Number of removed tracks.
                    end
                end
%                 num_track = num_track - k; %Updating value of num_track.
                clear i j k; %Clear counter variables.
            end
            
            %% Option for cell_location w/out simpletracking. (For Fluocell paper)
            %Convert coordInfo to a data structure that simpletracker can use.
            if output_cell_location
                numCoordFrames = length(coordInfo);
                d = cell(numCoordFrames,1);
                for i = 1:numCoordFrames
                    d{i,1}=cell2mat(coordInfo(i,:));
                end
                coordInfo = d;
                clear i d;
                
                % Accounting for empty frames before running simpletracker().
                % removedFramesIndex = find(cellfun('isempty',coordInfo))'; %Getting the indices for empty frames.
                % frameIndex = data.image_index(removedFramesIndex);
                frameIndex = find(~cellfun('isempty',coordInfo))';
                coordInfo = coordInfo(frameIndex);
                
                num_tracks = length(data.ratio);
                temp_location = repmat({nan},size(coordInfo,1),num_tracks);
                % temp_location = cell(size(coordInfo,1),num_tracks);
                
                for i = 1 : numCoordFrames
                    for j = 1 : size(coordInfo{i},1)
                        temp_location{i,j} = coordInfo{i}(j,:);
                    end
                end
                clear i j
            end
          
            %% Exporting the processed data.
            data.ratio = temp_ratio;
            data.channel1 = temp_channel1;
            data.channel2 = temp_channel2;
            data.cell_size = temp_cellSize;
            
            cell_location = temp_location;
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
        function coordInfo = getCoord(data)
            % Returns the coordinates of the centroid of each object
            % as a data structure. Fields are 'xCoord' and 'yCoord'.
            
            pattern = data.index_pattern{2};
%             pattern = 't%d';

            % initialize movie_info
            num_frame = length(data.image_index);
            field = {'xCoord', 'yCoord'};
            num_fields = length(field);
            c = cell(num_frame, num_fields);
                        
            for k = (data.image_index)'                
                data.index = data.image_index(k);
                data = get_image(data, 0);
                
                index_str = sprintf(pattern, data.index);
                file_name = strcat(data.path, 'output/cell_bw_', index_str, '.mat');

                if ~exist(file_name,'file')
                   continue; 
                end
                result = load(file_name);
                object_bw = result.cell_bw;
                clear result;
                
                [~, object_label] = bwboundaries(object_bw, 8, 'noholes');
                object_prop = regionprops(object_label, 'Centroid', 'PixelList');
                object_centroid = cat(1, object_prop.Centroid);
                
                %If frame does not exist, allow the tracker to skip the frame.
                if ~exist(data.file{1}, 'file')
                    continue;
                end
                clear first_file_path second_file_path
                if ~isempty(object_centroid)
                    c{k,1} = object_centroid(:,1);
                    c{k,2} = object_centroid(:,2);
                end
                clear im_fak im_object im_ratio object_centroid object_total_intensity object_label...
                    object_prop object_bd fak_total_intensity pax_total_intensity z
            end % for k = 1:5
            coordInfo = cell2struct(c, field, 2);
            return
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        function data = postprocessing(data)
            %Shortens data.--- if 
            
            %lengthen all cells of
            % data.channel1, channel2, ratio to 1 x image_index
            % change zeros to NaN
            % shorten the first cell to the length of image_index, instead of 200
            num_object = length(data.ratio);
            num_timeframe = length(data.image_index);
            
            %Updating length of each cell that contains an object.
            for i = 1:num_object
                num_indices = length(data.ratio{i});
                track_length = length(data.ratio{i}(:));
                
                %Truncates data.--- if it is longer than num_timeframe.
                %Currently, data.---{1} is set to 200 by default.
                if track_length > num_timeframe
                    data.ratio{i}(num_timeframe+1:num_indices,:) = [];
                    data.channel1{i}(num_timeframe+1:num_indices,:) = [];
                    data.channel2{i}(num_timeframe+1:num_indices,:) = [];
                    data.cell_size{i}(num_timeframe+1:num_indices,:) = [];
                    %at data.cell_size, "Matrix index is out of range for deletion."
                    %cell_size is not initialized to a longer length like
                    %data.ratio, channel1 and channel2
                    %cell_size is set in quantify_region_of_interest().
                    
                    %data.cell_size{1} is not set to 200 by default.
                    %Lengthens data.cell_size{1} if it is shorter than the
                    %other data.--- variables.
%                     if length(data.cell_size{i}(:)) < num_timeframe
%                         num_indices = length(data.cell_size{i});
%                         data.cell_size{i}(num_indices+1:num_timeframes,:) = nan;
%                     elseif length(data.cell_size{i}(:)) > num_timeframes
%                          num_indices = length(data.cell_size{i});
%                          data.cell_size{i}(num_timeframes+1:num_indices,:) = [];
%                     end
                else
                    %Lengthening truncated tracks. Make new entries NaN
                    data.ratio{i}(num_indices+1:num_timeframe,:) = nan;
                    data.channel1{i}(num_indices+1:num_timeframe,:) = nan;
                    data.channel2{i}(num_indices+1:num_timeframe,:) = nan;
                    data.cell_size{i}(num_indices+1:num_timeframe,:) = nan;
                end
            end
            
            for i = (data.image_index)'
                for j = 1:num_object
                    num_roi = size(data.ratio{j},2);%get the num of subcellular layers
                    % ^^ Could change this to if-statement for num_roi instead ^^
                    for k = 1:num_roi
                        %Converts any 0 values to NaN.
                        if data.ratio{j}(i,k) == 0
                            data.ratio{j}(i,k) = nan;
                            data.channel1{j}(i,k) = nan;
                            data.channel2{j}(i,k) = nan;
                            data.cell_size{j}(i,k) = nan;
                        end
                    end
                end
            end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function frame_with_track = create_frame_track(cell_location)
            % Creates frame_with_track to be used with overlay_image_track.
            
            %Parameters.
            fields = {'num_tracks','centroid','track_index'};
            num_fields = length(fields);
            num_frames = length(cell_location);
            
            %Initialize cell to hold data.
            frame_with_track = cell(num_frames, num_fields);
            frame_with_track = cell2struct(frame_with_track, fields, 2);
            
            for i = 1 : num_frames
                frame_with_track(i).num_tracks = sum(~cellfun(@(V) any(isnan(V(:))),cell_location(i,:)));
                for j = 1 : frame_with_track(i).num_tracks
                    frame_with_track(i).centroid(j,:) = cell_location{i,j};
                    frame_with_track(i).track_index(j,1) = j;
                end
            end
        end
        
    end
end