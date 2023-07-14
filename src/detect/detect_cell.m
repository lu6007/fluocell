% function [bd, bw, label] = detect_cell(im, varargin)
% parameter_name = {'method', 'with_smoothing', 'smoothing_factor','brightness_factor',...
%     'multiple_object', 'min_area', 'segment_method'};
% default_value = {'otsu',1, 9, 1.0, 0, 500, 0};
% 

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function [bd, bw, label] = detect_cell(im, varargin)
parameter_name = {'method', 'with_smoothing', 'smoothing_factor','brightness_factor',...
    'multiple_object', 'min_area', 'segment_method'};
default_value = {'otsu',1, 9, 1.0, 0, 500, 0};
[method, with_smoothing, smoothing_factor, brightness_factor, multiple_object, ...
    min_area, segment_method] = parse_parameter(parameter_name, default_value, varargin);

%
switch method
    case 'otsu'
        pn = {'threshold','mask_bw','show_figure'};
        dv = {0,[], 0};
        [~, mask_bw, show_figure] = parse_parameter(pn,dv, varargin);
        % sf =3;
        bf = brightness_factor;
%         [bd, ~] = get_cell_edge(im, 'brightness_factor', bf, 'threshold', th,...
%             'smoothing_factor', sf, 'show_figure', show_figure,'mask_bw', mask_bw);
        [bd, ~, ~] = get_cell_edge(im, 'brightness_factor', bf, ...
            'show_figure', show_figure, 'mask_bw', mask_bw, 'multiple_object', multiple_object,...
            'min_area', min_area);
    case 'kmean'         
        p = {'num_cluster'};
        d = {3};
        num_cluster = parse_parameter(p, d, varargin);        
        bd = get_cell_edge_kmean(im, num_cluster);

    case 'c_means'
        p = {'num_cluster'};
        d = {3};
        num_cluster = parse_parameter(p, d, varargin);                
        bd = get_cell_edge_cmean(im, num_cluster);
    
    case 'local'
        p = {'rad_y','width_factor','brightness_factor'};
        d = {60,1.0,1.0};
        [rad_y, wf, bf] = parse_parameter(p, d, varargin);        
        bd = get_cell_edge_local(im, 'rad_y',...
            rad_y,'width_factor',wf,'brightness_factor',bf);
    
%     case 'gradient' % Use Otsu's method on pixels with gradient>1000
%         gradient = imgradient(im,'prewitt');
%         index = find(gradient>1000);
% %         [count,x] = histogram(im(index));
% %         T = otsuthresh(count);
% %         th = min(x)+T*(max(x)-min(x)); 
%         th = my_graythresh(im(index));
%         bf = brightness_factor; % bf = 0.2
%         [bd, bw, th] = get_cell_edge(im, 'brightness_factor', bf, ...
%             'multiple_object', multiple_object,'min_area', min_area);

end

%Checks if any objects were detected. -SJL 7/7/2017
if isempty(bd)
    bw = false(size(im)); %sets bw to an 'empty' (false) mask.
    bd = cell(0,1); %create empty 0x1 cell. Same output as clean_up_boundary.
    label = []; 
    
else 
%    if min_area >= 500
    [temp, ~] = clean_up_boundary(im, bd, with_smoothing,...
        smoothing_factor);
    bw = detect_watershed(uint16(im), temp, 'segment_method', segment_method);
%    end
    if ~any(any(bw))
        bw = temp;
    end
 
    [bd, label] = bwboundaries(bw, 8,'noholes');
    clear temp;
end
%temp = bw; clear bw; bw{1} = temp;

end


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