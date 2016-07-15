% function [fa_label im_fa]= detect_focal_adhesion(im_fa, varargin)
% algorithm: 'water', 'segmentation'

% Copyright: Shaoying Lu and Yingxiao Wang 2011
% Email: shaoying.lu@gmail.com

function [fa_bw, fa_bd, im_filt]= detect_focal_adhesion(im_fa, varargin)
    parameter_name = {'mask_with_cell', 'cell_bw', 'filter_size',...
        'min_area','need_high_pass_filter', 'min_water',...
        'normalize', 'ref_pax_intensity'};
    default_value = {0, [], 61, 10, 1,100,1, 1,5000000};
    [mask_with_cell, cell_bw, filter_size,min_area, ...
        need_high_pass_filter, min_water, ...
        normalize, ref_pax_intensity] = ...
        parse_parameter(parameter_name, default_value, varargin);
    connection = 8;
    % Calculate total intensity
    if mask_with_cell,
        total_pax_intensity = sum(sum(double(im_fa).*double(cell_bw)));
    else
        total_pax_intensity = sum(sum(double(im_fa)));
    end;
    %total_pax_intensity
    if normalize,
        im_fa = double(im_fa)/total_pax_intensity*ref_pax_intensity;
    end;    
    % High pass filter
    if need_high_pass_filter,
        im_filt = high_pass_filter(im_fa, filter_size, 'method',1);
    else
        im_filt = im_fa;
    end;
    %figure; imagesc(im_fa);
    if mask_with_cell,
        temp = im_filt.*double(cell_bw); clear im_filt;
        im_filt = temp; clear temp;
    end;
    
%     min_im = min(min(im_filt));
%     if min_im<0,
%         im_filt = im_filt-min_im;
%     end;
%     im_16 = uint16(im_filt);
%    th = graythresh(im_filt);
%    temp = im2bw(im_filt, th*brightness_factor);
    temp = logical(im_filt>min_water);
    fa_bw = bwareaopen(temp, min_area, connection);
    fa_bd = bwboundaries(fa_bw, connection, 'nohole');
return;

