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
% cell_bw = imread(strcat(data.path, 'cell_bw_001'));
% n = 5
% [bd_layer, label_layer] = divide_layer(cell_bw, n);
% figure; imagesc(label_layer); hold on;
% for i = 1:5,
%     plot(bd_layer{i}(:,2), bd_layer{i}(:,1));
% end;

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function [bd_layer, label_layer]= divide_layer(cell_bw, n,varargin)
parameter_name = {'xylabel'};
% method 1 - relative distance to the centroid
% method 2 - distance transformation to the extracellular space
default_value = {'reverse'};
[xylabel] = parse_parameter(parameter_name, default_value, varargin);

iscell_cell_bw = iscell(cell_bw);
% Make cell_bw a cell and keep backward compatibility
if ~iscell_cell_bw
    temp{1} = cell_bw; clear cell_bw;
    cell_bw = temp;
end

num_roi = n; 
num_object = length(cell_bw);
bd_layer = cell(num_object, num_roi);
label_layer = cell(num_object, 1); 

% Multiple detections with num_object
for j = 1 : num_object
    im = bwdist(~cell_bw{j});
    max_v = max(max(im))+1;
    label_layer{j} = floor(im/max_v*num_roi)+double(cell_bw{j});
    for i = 1:num_roi
        bd = bw2bd(label_layer{j} >= i);  
        bd_layer{j, i} = bd{1};
        clear bd;
    end
end
    % need to update c for later, not needed for method = 2
% c = 0;
% end;

if strcmp(xylabel, 'normal')
    temp = cell(num_object, num_roi);
    for j = 1 : num_object
        for i = 1 : num_roi
            temp{j, i} = [bd_layer{j, i}(:,2), bd_layer{j, i}(:,1)];
        end
    end
    clear bd_layer;
    bd_layer = temp; clear temp;
end

% figure; imagesc(label_layer); colorbar; hold on;
% for i = 1:n, 
%     plot(bd_layer{i}(:,2), bd_layer{i}(:,1), 'w');
% end;

if ~iscell_cell_bw % backward compatible 
    temp = bd_layer{1}; clear bd_layer;
    bd_layer = temp; clear temp;
    temp = label_layer{1}; clear label_layer;
    label_layer = temp; clear temp;
end
return;