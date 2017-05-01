% function data=show_detected_boundary(im, data)
% This function detect the mask of the cell (data.cell_bw), 
% and add the boundary to the image and save the detected boundary

% Copyright: Shaoying Lu and Yingxiao Wang 2014
function data=show_detected_boundary(im, data)
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
[data.cell_bd, data.cell_bw] = detect_cell(uint16(im), 'brightness_factor', data.brightness_factor, ...
       'show_figure', 1, 'mask_bw', data.mask_bw, 'multiple_object', data.multiple_object, ...
       'min_area', data.min_area, 'segment_method', data.segment_method);

clear mask_bw;

if show_figure
    hold on;
    % For Molly's data on multiple region detection, Lexie on 10/19/2015
    if ~isfield(data, 'multiple_object') || ~data.multiple_object 
        plot(data.cell_bd(:,2),data.cell_bd(:,1),'r', 'LineWidth',2);
    else
        for n = 1 : length(data.cell_bd)
            plot(data.cell_bd{n}(:,2),data.cell_bd{n}(:,1),'r', 'LineWidth',4);
        end
    end
    hold off;
end

index_str = sprintf(data.index_pattern{2}, data.index);
output_file = strcat(data.output_path, 'cell_bw.', index_str);
if(isfield(data,'save_processed_image')&& data.save_processed_image)
    cell_bw = data.cell_bw;
    save([output_file, '.mat'], 'cell_bw');
    clear cell_bw
%     imwrite(logical(data.cell_bw), output_file, 'tiff');
end

return;

