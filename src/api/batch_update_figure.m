% function data = batch_update_figure(data)

% Copyright: Shaoying Lu, Shannon Laub and Yingxiao Wang 2011

function data = batch_update_figure(data)
%Store initial index value for later retrieval for consistency.
if isfield(data,'index')
    temp_index = data.index;
end;

% Compatibility with previous version of Quanty.
if isfield(data, 'ratio') && ~iscell(data.ratio)
    data = rmfield(data, 'ratio');
    data = rmfield(data, 'channel1');
    data = rmfield(data, 'channel2');
    data = rmfield(data,'time');
    data = rmfield(data, 'cell_size');
end
% data = close_button_callback(data);

%% Option for parallel processing. - Shannon 8/10/2016
data.parallel_processing = 1;
if ~(isfield(data,'parallel_processing') && data.parallel_processing == 1)
    % Parallel processing disabled. Default procedure.
    % loop through the row vector image_index
    for i = data.image_index 
        data.index = i;
        if  i == data.image_index(1) 
           data = get_image(data,1);
        else
            data = get_image(data,0);
        end;
        %%% Main sub-function %%%
        data = update_figure(data);
        %%% 
    end;
    
else %Parallel processing enabled.
    
    %Consider moving data.show_figure = 0 and the warning message to the
    %Java GUI. i.e. using a checkbox to turn parallel_processing to 1 and then
    %displaying the warning at that time. -Shannon 8/23/2016
    %Parallel processing does not update MATLAB figures well, if at all.
    %Hence, data.show_figure is set to 0 to disable figure updates.
    data.show_figure = 0;
    disp('Function batch_update_figure() warning: fluocell_data.show_figure has been set to 0 for parallel processing.');

    %Get the data at the initial time point.
    %get_image() handles the first image differently than the following images.
    data.index = data.image_index(1);
    data = get_image(data,1);
    data = update_figure(data);

    %Multiple object handling in case there is more than one cell in an image.
    % Kathy: I feel that multiple object handing should be in some other
    % functions. But we can merge first and see how it goes. 09/13/2016
    num_objects = length(data.ratio);
    for j = 1:num_objects
        %Initialization of temp_data. Interface with variable: data.
        temp_ratio = inf(length(data.ratio{1}),1);
        temp_time = inf(size(data.time));
        temp_channel1 = inf(length(data.channel1{1}),1);
        temp_channel2 = inf(length(data.channel2{1}),1);
        temp_channel1_bg = inf(size(data.channel1_bg));
        temp_channel2_bg = inf(size(data.channel2_bg));

        %Collect the data at the initial time point.
        temp_ratio(1) = data.ratio{j}(1);
        temp_time(1,:) = data.time(1,:);
        temp_channel1(1) = data.channel1{j}(1);
        temp_channel2(1) = data.channel2{j}(1);
        temp_channel1_bg(1,:) = data.channel1_bg(1,:);
        temp_channel2_bg(1,:) = data.channel2_bg(1,:);

        %loop through the row vector image_index
        
        % Kathy: there is a warning which says that the range of parfor
        % has to be consecutive numbers. 09/13/2016
        parfor i = data.image_index(2:end) 
            %Update temp_data.index to the new index point based on image_index
            temp_data = data;
            temp_data.index = i;
            
            %Process the data.
            temp_data = get_image(temp_data,0);
            temp_data = update_figure(temp_data);
            
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
            temp_channel1_bg(i,:) = temp_data.channel1_bg(i,:);
            temp_channel2_bg(i,:) = temp_data.channel2_bg(i,:);
        end % parfor i = data.image_index(2:end),
        %Collect the data output.
        data.ratio{j} = temp_ratio;
        data.channel1{j} = temp_channel1;
        data.channel2{j} = temp_channel2;
        clear temp_ratio temp_channel1 temp_channel2
    end;
    %Output the collected data from temp_data back to data.
    data.time = temp_time;
    data.channel1_bg = temp_channel1_bg;
    data.channel2_bg = temp_channel2_bg;
    clear temp_time temp_channel1_bg temp_channel2_bg
    
end %End of batch data processing and collection of data output.

%%
if exist('temp_index','var')
    data.index = temp_index; % return data.index to the initial value for consistency.
end;
return;