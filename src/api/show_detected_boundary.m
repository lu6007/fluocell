% Function add the boundary to the image

% Copyright: Shaoying Lu and Yingxiao Wang 2014
% function data=show_detected_boundary(im, data, handle)
%     figure(handle); hold on; 
function data=show_detected_boundary(im, data)
if isfield(data, 'need_apply_mask')&& data.need_apply_mask,
    %if ~isfield(data,'mask_bw') || isempty(data.mask_bw),
    [temp, temp2] = get_polygon(uint16(im), strcat(data.output_path, 'mask.mat'),...
        'Please Choose the Mask Region');
    data.mask_bw = temp{1}; clear temp;
    data.mask_bd = temp2{1}; clear temp2;
   %end;
   hold on;
    plot(data.mask_bd(:,1), data.mask_bd(:,2), 'w--');
    hold off;
else
    data.mask_bw = [];
end;
if isfield(data,'cell_bw'),
    temp = rmfield(data,'cell_bw'); clear data;
    data = rmfield(temp,'cell_bd'); clear temp;           
end;
[data.cell_bd, data.cell_bw] = detect_cell(uint16(im), 'brightness_factor', data.brightness_factor, ...
    'show_figure', 1, 'mask_bw', data.mask_bw);
clear mask_bw;
show_figure = 1;
if show_figure,
    hold on;
    plot(data.cell_bd(:,2),data.cell_bd(:,1),'r', 'LineWidth',2);
    hold off;
end;
save_file = 1;
index_str = sprintf(data.index_pattern{2}, data.index);
output_file = strcat(data.output_path, 'cell_bw.', index_str);
if save_file,
    imwrite(logical(data.cell_bw), output_file, 'tiff');
end;

return;

