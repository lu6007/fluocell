% function display_boundary(bw, vargain)
% Display the boundary of the bw image, or bw = label, a label matrix
% Detect and display the boundary of the bw image
%     parameter_name = {'im', 'show_label', 'color', 'new_figure'};
%     parameter_default = {[], 0, 'r', 1};
%
% Copyright: Shaoying (Kathy) Lu, shaoying.lu@gmail.com 2/18/2016
function display_boundary(bw, varargin)
    parameter_name = {'im', 'show_label', 'color', 'new_figure', 'type'};
    parameter_default = {[], 0, 'r', 1, 1};
    [im, show_label, cr, new_figure, type] = parse_parameter(parameter_name, parameter_default, varargin);
    
    if new_figure 
        my_figure; 
    end
    if ~isempty(im)
        switch type
            case 1
                imshow(im);
            case 2
                imagesc(im);
        end
    end
    
    hold on; 

    if isempty(bw) 
        return;
    end
    
    bd_nohole = bwboundaries(bw, 8, 'noholes');
    bd = bwboundaries(bw, 8);
%     if length(bd_nohole)~=length(bd)
%         disp('function display_boundary: bd = bwboundaries(bw, 8);')
%     end
    num_object = length(bd);
    for j = 1:num_object
        plot(bd{j}(:,2), bd{j}(:,1), 'Color', cr);
    end
    
    if show_label
        prop = regionprops(bw,'Centroid');
        cc = cat(1, prop.Centroid);
        text(cc(:,1), cc(:,2), num2str((1:length(bd_nohole))'), 'Color', cr);
    end
return;
