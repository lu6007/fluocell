% compute cell_bw based on cell image and fa_label if needed.
% if has_yfp, get_cell_bw can be called before get_fa_label
% if ~has_yfp, get_fa_label needs to be called before get_cell_bw.

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function [fa_label im_fa]= get_fa_label(cell_bw, im_fa, method, varargin)
if method ==1, % high pass filter
    parameter_name = {'fa', 'algorithm', 'mask_with_cell', 'ref_pax_intensity'};
    default_value = {[],'segmentation', 1, 50000000};
    [fa, algorithm, mask_with_cell, ref_pax_intensity] = ...
        parse_parameter(parameter_name, default_value, varargin);

    im_fa = medfilt2(im_fa, [3, 3]);

    % Normalized the FA images with total_pax_intensity
    if mask_with_cell, 
        total_pax_intensity = sum(sum(double(im_fa).*double(cell_bw)))
    else
        total_pax_intensity = sum(sum(double(im_fa)))
    end;
    im_fa = double(im_fa)/total_pax_intensity*ref_pax_intensity;
    % High pass filter
    im_fa = high_pass_filter(im_fa, fa.filter_size);
    %figure; imagesc(im_fa);
    if mask_with_cell,
        im_fa = im_fa.*double(cell_bw);
    end;
    % Here we use either the water algorithm or regular segmentation
    switch algorithm,
        case 'water',
            % The Water Algorithm
            fa_label = water(im_fa, fa.min_water, fa.max_water, ...
            fa.single_min_area, fa.min_area);
        case 'segmentation',
            % Regular segmentation
            fa_label = fa_segment(im_fa, fa.min_water, fa.single_min_area);
    end;
elseif method ==2,  % tophat highpass filter
    parameter_name = {'mask_with_cell', 'filter_size', 'threshold', 'min_area'};
    default_value = {1, 61, 30, 5};
    [mask_with_cell, filter_size, threshold, min_area] = ...
        parse_parameter(parameter_name, default_value, varargin);

    % tophat highpass filter
    se = strel('disk', filter_size);
    temp = imtophat(im_fa, se); clear im_fa;
    im_fa = temp; clear temp;
    if mask_with_cell,
        temp = im_fa.*double(cell_bw); clear im_fa;
        im_fa = temp; clear temp;
    end;
    fa_label= fa_segment(im_fa, threshold, min_area);   
end;
return;

