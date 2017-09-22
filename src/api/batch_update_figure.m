% function data = batch_update_figure(data)

% Copyright: Shaoying Lu, Shannon Laub and Yingxiao Wang 2011
function data = batch_update_figure(data)
%Store initial index value for later retrieval for consistency.
if isfield(data,'index')
    temp_index = data.index;
end

% Compatibility with previous version of Quanty.
if isfield(data, 'ratio') && ~iscell(data.ratio)
    data = rmfield(data, 'ratio');
    data = rmfield(data, 'channel1');
    data = rmfield(data, 'channel2');
    data = rmfield(data,'time');
    % data = rmfield(data, 'cell_size');
end
% data = close_button_callback(data);

if isfield(data,'multiple_object') && data.multiple_object == 1
    data.save_processed_image = 1;
    disp('Function batch_update_figure warning: ');
    disp('data.save_processed_image has been set to 1 for multiple object tracking.');
end

%% Option for parallel processing. - Shannon 8/10/2016
% data.parallel_processing = 1; 

% When parallel processing is disabled.
if ~(isfield(data,'parallel_processing') && data.parallel_processing == 1)
    % Parallel processing disabled. Default procedure.
    % loop through the row vector of image_index
    new_first_file = 1;
    for i = (data.image_index)' 
        data.index = i;
        data = get_image(data, new_first_file);
        if ~isempty(data.im{1})
            new_first_file = 0;
        end
        data = update_figure(data);
    end
    
else %Parallel processing enabled.
    
    %Consider moving data.show_figure = 0 and the warning message to the
    %Java GUI. i.e. using a checkbox to turn parallel_processing to 1 and then
    %displaying the warning at that time. -Shannon 8/23/2016
    %Parallel processing does not update MATLAB figures well, if at all.
    %Hence, data.show_figure is set to 0 to disable figure updates.
    data.show_figure = 0;
    disp('Function batch_update_figure() warning: ');
    disp('fluocell_data.show_figure has been set to 0 for parallel processing.');

    %Get the data at the initial time point.
    %get_image() handles the first image differently than the following images.
    data.index = data.image_index(1);
    data = get_image(data,1);
    data = update_figure(data, 'save_bw_file', save_bw_file);

    %Multiple object handling in case there is more than one cell in an image.
    % Kathy: I feel that multiple object handing should be in some other
    % functions. But we can merge first and see how it goes. 09/13/2016
    %This only works if new cells do not enter/exit the viewing area.
    num_object = length(data.ratio);
    for j = 1:num_object
        %Initialization of temp_data. Interface with variable: data.
        temp_ratio = nan(length(data.ratio{1}),1);
        %problem with time not being NaN
%         temp_time = inf(size(data.time));
        temp_time = nan(size(data.time));
        temp_channel1 = nan(length(data.channel1{1}),1);
        temp_channel2 = nan(length(data.channel2{1}),1);
        temp_channel1_bg = nan(size(data.image_index(end), 1));
        temp_channel2_bg = nan(size(data.image_index(end), 1));

        %Collect the data at the initial time point.
        temp_ratio(1) = data.ratio{j}(1);
%         temp_time(1) = data.time(1);
        temp_time(1,:) = data.time(1,:);
        temp_channel1(1) = data.channel1{j}(1);
        temp_channel2(1) = data.channel2{j}(1);
        temp_channel1_bg(1) = data.channel1_bg(1);
        temp_channel2_bg(1) = data.channel2_bg(1);


        %loop through the row vector image_index
        
        % Kathy: there is a warning which says that the range of parfor
        % has to be consecutive numbers. 09/13/2016
        for i = (data.image_index(2:end))' 
%         for i = data.image_index(2:end)
            %Update temp_data.index to the new index point based on image_index
            temp_data = data;
            temp_data.index = i;
            
            %Process the data.
            temp_data = get_image(temp_data,0);
            temp_data = update_figure(temp_data, 'save_bw_file', save_bw_file);
            
            %If a time point is missing, skip to the next time point.
            %i.e. if a time point has been deleted due to blurriness/collection error etc.
            if isempty(temp_data.im{1})
                continue;
            end
            
            %Collect the data output.
            temp_ratio(i) = temp_data.ratio{j}(i);
            temp_time(i,:) = temp_data.time(i,:);
            temp_channel1(i) = temp_data.channel1{j}(i);
            temp_channel2(i) = temp_data.channel2{j}(i);
            temp_channel1_bg(i) = temp_data.channel1_bg(i);
            temp_channel2_bg(i) = temp_data.channel2_bg(i);

        end % parfor i = (data.image_index(2:end))',
%         for k = 1 : num_roi
%             temp_ratio{k}(temp_ratio{k} == 0) = NaN;
%         end
        %Collect the data output.
        data.ratio{j} = temp_ratio;
        data.channel1{j} = temp_channel1;
        data.channel2{j} = temp_channel2;
        clear temp_ratio temp_channel1 temp_channel2
    end %for j = 1:num_object
    %Output the collected data from temp_data back to data.
    data.time = temp_time;
    data.channel1_bg = temp_channel1_bg;
    data.channel2_bg = temp_channel2_bg;
    clear temp_time temp_channel1_bg temp_channel2_bg
    
end %End of batch data processing and collection of data output.

%%
if exist('temp_index','var')
    data.index = temp_index; % return data.index to the initial value for consistency.
end
    
%Modify output w/ simpletracker() to get more accurate tracks.
%Output data in the same format so that compute_time_course() can plot.
if isfield(data, 'multiple_object') && data.multiple_object 
    data = multiple_object.prepareTrack(data);
    coordInfo = multiple_object.getCoord(data);
    [data, cell_location] = multiple_object.simpleTrack(data, coordInfo);
    if ~isfield(data, 'frame_with_track')
        data.frame_with_track = multiple_object.create_frame_track(cell_location);
    end
end

return;