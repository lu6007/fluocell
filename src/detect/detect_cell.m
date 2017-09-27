% function [bd, bw] = detect_cell(im, varargin)

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function [bd, bw, label] = detect_cell(im, varargin)
parameter_name = {'method', 'with_smoothing', 'smoothing_factor','brightness_factor', 'multiple_object', 'min_area', 'segment_method'};
default_value = {'atsu',1, 9, 1.0, 0, 500, 0};
[method, with_smoothing, smoothing_factor, brightness_factor, multiple_object, min_area, segment_method] =...
    parse_parameter(parameter_name, default_value, varargin);

%
switch method
    case 'atsu'
        pn = {'threshold','mask_bw','show_figure'};
        dv = {0,[], 0};
        [~, mask_bw, show_figure] = parse_parameter(pn,dv, varargin);
        % sf =3;
        bf = brightness_factor;
%         [bd, ~] = get_cell_edge(im, 'brightness_factor', bf, 'threshold', th,...
%             'smoothing_factor', sf, 'show_figure', show_figure,'mask_bw', mask_bw);
        [bd, ~, ~] = get_cell_edge(im, 'brightness_factor', bf, ...
            'show_figure', show_figure, 'mask_bw', mask_bw, 'multiple_object', multiple_object,...
            'min_area', min_area, 'segment_method', segment_method);
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
end

%Checks if any objects were detected. -SJL 7/7/2017
if isempty(bd)
    bw = false(size(im)); %sets bw to an 'empty' (false) mask.
    bd = cell(0,1); %create empty 0x1 cell. Same output as clean_up_boundary.
    
else
[temp, ~] = clean_up_boundary(im, bd, with_smoothing,...
    smoothing_factor);
 bw = detect_watershed(uint16(im), temp, 'segment_method', segment_method);
 if ~any(any(bw))
     bw = temp;
 end
 
 [bd, label] = bwboundaries(bw, 8,'noholes');
 clear temp;
end
%temp = bw; clear bw; bw{1} = temp;

return;