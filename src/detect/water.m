% The water algorithm

% Copyright: Shaoying Lu and Yingxiao Wang 2011
% This function is the fluocell_3.1 fucntion water_2()

function [fa_label, num_fas] = water(im, low_thresh, high_thresh, ...
    min_single_fa, min_fa_area)

min_water = low_thresh;
max_water = high_thresh;
single_min_fa_area = min_single_fa;
step_size = 20;

% high threshold
floor_matrix = floor(im);
bw_i = (floor_matrix > max_water);
%figure; imshow(bw_i);
connection =4 ;
[fa_bd, fa_label,num_fas] = bwboundaries(bw_i, connection, 'noholes');
fa_prop=regionprops(fa_label,'Area');
% order the pixels with intensity from high to low threshold
upper_bound = size(fa_label,1);
lower_bound = 1;
[r, c, intensity] = find(floor_matrix);
intensity = unique(min(max(intensity,min_water),max_water));
int_order = sort(intensity, 'descend');
num_int = size(int_order, 1);
for i = 1:step_size:num_int,
    i2= min(i+step_size, num_int);
    fa_i = (floor_matrix<=int_order(i))&(floor_matrix>int_order(i2));
    [bd_i, label_i, num_new_fas_i] = bwboundaries(fa_i, connection, 'noholes');
     % For each new fa island, find the focal adhesion that connect with it.
    for j = 1:num_new_fas_i,
        temp_j = (label_i==j);
        temp = imdilate(temp_j, strel('diamond', 1)).*~temp_j;
        [row, col, neighbors] = find(fa_label(find(temp)));
        num_neighbors = length(neighbors);
        if (num_neighbors ==0 ), %no connection
           num_fas = num_fas+1;
           fa_label = fa_label + temp_j.*num_fas;
           fa_prop(num_fas).Area = sum(sum(temp_j));
        else %(num_neighbors >=1), has connection to some fas
            n1 = neighbors(1);
            fa_label = fa_label + temp_j.*n1;
            fa_prop(n1).Area = fa_prop(n1).Area+sum(sum(temp_j));
        end % num_neighbors
   end;   % for j
end; % for i

%% Merge or delete FAs if the number of pixles<= min_fa_area
new_fa_prop=regionprops(fa_label,'Area', 'PixelList');
fa_delete = zeros(num_fas, 1);
for i = 1:num_fas,
    % Do nothing with the large FAs
    if fa_prop(i).Area>min_fa_area,
        continue;
    end;
    
    % Merge smaller FAs
    bw_i = (fa_label==i);
    x = new_fa_prop(i).PixelList(:,1); 
    y = new_fa_prop(i).PixelList(:,2);
    min_x = min(x)-1; min_y = min(y)-1;
    max_x = max(x)+1; max_y = max(y)+1;
    window = [min_x-1, min_y-1, max_x-min_x+2, max_y-min_y+2];
    im_i=imcrop(bw_i, window);
    label_i = imcrop(fa_label,window);
    temp = imdilate(im_i, strel('diamond',1))-im_i;
    [t_row, t_col, neighbor_list] =find(temp.*label_i);
    
    
%     temp = imdilate(bw_i, strel('diamond', 1))-bw_i;
%     [t_row, t_col, neighbor_list] = find(temp.*fa_label); % computationally cost

     unique_neighbor = unique(neighbor_list);
     num_neighbors = size(unique_neighbor,1);
    if num_neighbors >=1,
        merge_neighbor = unique_neighbor(1);
        fa_label = fa_label+bw_i*(merge_neighbor-i);
        fa_prop(merge_neighbor).Area = fa_prop(merge_neighbor).Area...
            +fa_prop(i).Area;
        fa_prop(i).Area = 0;
        fa_delete(i) = 1;
    end;
 end;       
 % Delete smaller FAs
 for i = 1:num_fas,
    % Do nothing with the large FAs
    if fa_prop(i).Area>single_min_fa_area,
        continue;
    end;
    % Mark smaller FAs for deletion
    % Because of the previous merge action, there should be no
    % neighbors to the small FAs.
        fa_delete(i) = 1;
 end;       

% Reorganize the focal adhesions, completely delete the unwanted FAs.
[fa_label, num_fas] = delete_fas(fa_label, fa_delete);
return;