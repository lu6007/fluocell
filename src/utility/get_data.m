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
            frame_index = cell(2, 1); %{1} is old index, {2} is current index.
            
            %Bases file_name off of data.first_file. Not sure if this would
            %be robust?
            % filename = data.first_file;
            frame_index{1} = data.index_pattern{1};
            num_frame = size(data.image_index, 1);
            absent_index = zeros(num_frame, 1);
            for index = (data.image_index)'
                frame_index{2} = sprintf(data.index_pattern{2}, index);
                filename = regexprep(data.first_file, frame_index{1}, frame_index{2});
                
                %Check if file exists.
                if ~exist(filename,'file')
                   %Record index where file does not exist.
                   absent_index = [absent_index index]; 
                end
            end % for index = (data.image_index)'
        end % function [absent_index] = absent_frame(data)
    end % methods (Static)
end