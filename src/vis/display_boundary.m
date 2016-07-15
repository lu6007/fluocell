% function display_boundary(bw, vargain)
% Display the boundary of the bw image.
% Detect and display the boundary of the bw image
%     parameter_name = {'im', 'show_label', 'color', 'new_figure'};
%     parameter_default = {[], 0, 'r', 1};
%
% Copyright: Shaoying (Kathy) Lu, shaoying.lu@gmail.com 2/18/2016
function display_boundary(bw, varargin)
    parameter_name = {'im', 'show_label', 'color', 'new_figure'};
    parameter_default = {[], 0, 'r', 1};
    [im, show_label, cr, new_figure] = parse_parameter(parameter_name, parameter_default, varargin);
    bd = bwboundaries(bw, 8, 'noholes');
    num_objects = length(bd);
    if new_figure, 
        my_figure; 
    end;
    if ~isempty(im),
        imshow(im);    
    end;
    
    hold on; 
    for j = 1:num_objects,
        plot(bd{j}(:,2), bd{j}(:,1), 'Color', cr);
    end;
    
    if show_label,
        prop = regionprops(bw,'Centroid');
        cc = cat(1, prop.Centroid);
        text(cc(:,1), cc(:,2), num2str((1:num_objects)'), 'Color', cr);
    end;
return;
