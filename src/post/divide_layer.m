% function [bd_layer, label_layer, c]= divide_layer(cell_bw, n,varargin)
% Divide the cell mask into n layers and output to 
% a label matrix label_layer.
%
% parameter_name = {'method'};
% method 1 - relative distance to the centroid
% method 2 - distance transformation to the extracellular space
% default_value = { 2};
%
% The mask of the cell was divided into n layers, which are named as the 
% layer 1, layer 2, ..., and layer n from the boundary toward the centroid. 
% The nodes forming the interface between two different layers were computed
% based on the line segment connecting the centroid and the cell boundary. 
% Briefly, this line segment was divided into n equal parts by (n-1) dividing 
% points. The ith dividing point from the cell boundary was hence used as 
% the correponding nodes forming the interface between the layers i and (i+1). 
% Based on these interface lines and the cell boundary, the label matrix was computed. 
% It has the value i in the layer i, and the value 0 outside of the cell.
%  
% Example:
% Load the cell mask and FA label matrix.
% Divide the cell mask into n layers.
% Calculate the FA property in each layer of the cell.
%
% data = initialize_data('07_29_dish1');
% cell_bw = imread(strcat(data.path, 'cell_bw.001'));
% n = 5
% [bd_layer, label_layer] = divide_layer(cell_bw, n);
% figure; imagesc(label_layer); hold on;
% for i = 1:5,
%     plot(bd_layer{i}(:,2), bd_layer{i}(:,1));
% end;

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function [bd_layer, label_layer, c]= divide_layer(cell_bw, num_layers,varargin)
parameter_name = {'method', 'xylabel'};
% method 1 - relative distance to the centroid
% method 2 - distance transformation to the extracellular space
default_value = { 2,'reverse'};
[method, xylabel] = parse_parameter(parameter_name, default_value, varargin);
% bd_layer= cell(num_objects, num_layers)
bd_layer = cell(num_layers, 1);
% we can remove method in the comments and the program 12/9/2015
% if method == 1,
%     % Compute the boundarys for the layers.
%     % The layers are labelled from 1 to n from outside to 
%     % the centroid.
%     bd = bw2bd(cell_bw);
%     bd_layer{1} = bd{1};
%     cell_prop = regionprops(bwlabel(cell_bw), 'Centroid', 'Area');
%     area = cat(1, cell_prop.Area);
%     [max_area i] = max(area);
%     c = cell_prop(i).Centroid;
%     for i = 2:n,
%         x = bd{1}(:,2);
%         y = bd{1}(:,1);
%         new_x = c(1)+(x-c(1))*(n-i+1)/n;
%         new_y = c(2)+(y-c(2))*(n-i+1)/n;
%         bd_layer{i} = [new_y new_x];
%     end;
% 
%     % Compute the label matrix for the layered structure of the cell
%     % the label matrix was numbered from 1 to n from
%     % outside to the centroid.
%     label_layer = zeros(size(cell_bw));
%     label_layer = label_layer+double(cell_bw);
%     for i = 2:n,
%         cell_i = bd2im(cell_bw, bd_layer{i}(:,2), bd_layer{i}(:,1));
%         label_layer = label_layer+double(cell_i).*double(cell_bw);
%     end;
% elseif method == 2,
% Alternatively the label matrix can be computed by the distance transformation
% function bwdist().
% Then we use the function bw2bd() to calculate the boundaryies.
%
% Multiple detections with num_objects
% label_layer = cell(num_objects, 1);
% for j = 1:num_objects
    im = bwdist(~cell_bw);
    max_v = max(max(im))+1;
    label_layer = floor(im/max_v*num_layers)+double(cell_bw);
    for i = 1:num_layers,
        bd = bw2bd(label_layer>=i);
        
        bd_layer{i} = bd{1};
        clear bd;
    end;
    % need to update c for later, not needed for method = 2
c = 0;
% end;

if strcmp(xylabel, 'normal'),
    temp = cell(num_layers,1);
    for i = 1:n,
        temp{i} = [bd_layer{i}(:,2), bd_layer{i}(:,1)];
    end;
    clear bd_layer;
    bd_layer = temp; clear temp;
end;

% figure; imagesc(label_layer); colorbar; hold on;
% for i = 1:n, 
%     plot(bd_layer{i}(:,2), bd_layer{i}(:,1), 'w');
% end;
return;