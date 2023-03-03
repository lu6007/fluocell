% function data=get_boundary(im, data)
% This function detect the mask of the cell (data.cell_bw), 
% and add the boundary to the image and save the detected boundary

% Copyright: Shaoying Lu and Yingxiao Wang 2014
function data=get_boundary(im, data)
% There is another function called get_boundary() in the utrack package. So
% if there is a confusion in MATLAB, the fluocell package need to be put on the top of the
% search path of MATLAB
show_figure = (isfield(data, 'show_figure') && data.show_figure) || ~isfield(data, 'show_figure');

if isfield(data, 'need_apply_mask')&& data.need_apply_mask
    %if ~isfield(data,'mask_bw') || isempty(data.mask_bw),
    [temp, temp2] = get_polygon(uint16(im), strcat(data.output_path, 'mask.mat'),...
        'Please Choose the Mask Region');
    data.mask_bw = temp{1}; clear temp;
    data.mask_bd = temp2{1}; clear temp2;
   %end;
   if show_figure
%     if show_figure_option,
        hold on;
        plot(data.mask_bd(:,1), data.mask_bd(:,2), 'w--');
        hold off;
    end
else
    data.mask_bw = [];
end
if isfield(data,'cell_bw')
    temp = rmfield(data,'cell_bw'); clear data;
    data = rmfield(temp,'cell_bd'); clear temp; 
end
if isfield(data, 'cell_label')
    temp = rmfield(data, 'cell_label'); clear data;
    data = temp; clear temp;
end


if ~isfield(data, 'multiple_object') || ~data.multiple_object 
    data.multiple_object = 0;
end
if ~isfield(data, 'min_area')
    data.min_area = 500;
end
if ~isfield(data, 'segment_method')
    data.segment_method = 0;
end
% If the file already exists, we can load the cell_bw files. 
if ~isempty(data.mask_bw)
    [data.cell_bd, data.cell_bw, data.cell_label] = detect_cell(uint16(im), ...
    'brightness_factor', data.brightness_factor, ...
       'mask_bw', data.mask_bw, 'multiple_object', data.multiple_object, ...
       'min_area', data.min_area, 'segment_method', data.segment_method);
else
    [data.cell_bd, data.cell_bw, data.cell_label] = detect_cell(uint16(im), ...
    'brightness_factor', data.brightness_factor, ...
       'multiple_object', data.multiple_object, ...
       'min_area', data.min_area, 'segment_method', data.segment_method);
end

clear mask_bw;

if isfield(data, 'min_area') && data.min_area <= 250
    % use thin lines
    lw =1 ; % line_width 
else
    % use thick lines
    lw = 4;
end

if show_figure
    hold on;

    % Need to comment this due to the incompatability when the image is
    % cropped
%     % Draw background
%     if isfield(data, 'subtract_background') && data.subtract_background 
%         bg_bd = bwboundaries(data.bg_bw, 8, 'noholes');
%         plot(bg_bd{1}(:,2), bg_bd{1}(:,1), 'r', 'LineWidth', 2);
%     end 
    % Draw detected cells
    for n = 1 : length(data.cell_bd)
        plot(data.cell_bd{n}(:,2),data.cell_bd{n}(:,1),'r', 'LineWidth',lw);
    end
    hold off;
end

index_str = sprintf(data.index_pattern{2}, data.index);
output_file = strcat(data.output_path, 'cell_bw_', index_str);
if(isfield(data,'save_cell_bw')&& data.save_cell_bw)
    cell_bw = data.cell_bw;
    save([output_file, '.mat'], 'cell_bw');
    clear cell_bw
end

return;

