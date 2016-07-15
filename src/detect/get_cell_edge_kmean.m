% function bd = get_cell_edge_kmean(img, ncluster, varargin)

% Copyright: Kaiwen Zhang, Shaoying Lu and Yingxiao Wang 2013

function bd = get_cell_edge_kmean(img, ncluster, varargin)

parameter = {'mask_layer','min_area'};
default_value = {1, 500};
[mask_layer, min_area] = parse_parameter(parameter,...
    default_value, varargin);

[mem, cent] = kmeans(double(img(:)),ncluster, ...
        'distance','sqEuclidean', 'Replicates',3,'start','uniform');

[~, cidx] = sort(cent);
bg_cent = cidx(1:mask_layer);

J = (mem ~= bg_cent);
J = reshape(J, size(img));
J = bwareaopen(J, 600);
J = imfill(J, 'holes');

bw_image = bwareaopen(imclose(J, strel('disk',5)), 600);
se = strel('disk',1);
bw_image = imerode(bw_image,se);
bw_image = imdilate(bw_image,se);
bw_image = bwareaopen(bw_image, min_area);
bw_image = imclose(bw_image, strel('disk', 6));

bd = find_longest_boundary(bw_image);

end