classdef get_data
    %multiple_object contains functions for tracking multiple objects in
    %one frame.
    methods (Static)
        function [absent_index] = absent_frame(data)
            %Returns index of absent frames.
            %Example use of output:
            %image_index = image_index(~ismember(image_index,absent_frames));
            %Removes absent frames from image_index array.
            
            %Initialize variables.
            absent_index = [];
            frame_index = cell(1,2); %{1} is old index, {2} is current index.
            
            %Bases file_name off of data.first_file. Not sure if this would
            %be robust?
            filename = data.first_file;
            frame_index{1} = data.index_pattern{1};
            for index = data.image_index(2:end)'
                frame_index{2} = sprintf(data.index_pattern{2}, index);
                
                %Find index where channel name occurs.
                channel_index = strfind(filename,data.channel_pattern{1});
                channel_index = channel_index(end)+length(data.channel_pattern{1});
                
                %Find index where frame pattern occurs.
                pattern_index = strfind(filename(channel_index:end),frame_index{1}) - 1;
                pattern_index = pattern_index + channel_index;
                
                %Truncate filename, then concatenate the frame_index and
                %postfix back onto the end of the filename.
                filename = filename(1:pattern_index-1);
                filename = strcat(filename,frame_index{2},data.postfix);
                %filename(channel_index:end) = regexprep(filename(channel_index:end),frame_index{1},frame_index{2}); %old
                
                %Check if file exists.
                if ~exist(filename,'file')
                   %Record index where file does not exist.
                   absent_index = [absent_index index]; 
                end
                
                frame_index{1} = frame_index{2};
            end
        end
    end
end