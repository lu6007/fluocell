% function [fa_bd, fa_bw] = get_boundary(fa_bw, file_fa, varargin)
% Get the boundaries of the islands in a mask image.
% Uses the MATLAB function bwboundaries() to find the 
% boundary of the focal adhesions of size bigger than
% 12 pixel.

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function [fa_bd, fa_bw] = get_boundary(fa_bw, file_fa, varargin)
parameter_name = {'connection', 'min_area','save_file'};
default_value = {4, 12, 1};
[connection, min_fa_area,save_file]...
    = parse_parameter(parameter_name, default_value, varargin);


if ~exist(file_fa,'file'),
    [~, fa_label, num_fas] = bwboundaries(fa_bw, connection, 'noholes');
    fa_prop = regionprops(fa_label, 'Area', 'PixelIdxList');
    % BoundingBox = [ul_corner, width]
    for j = 1:num_fas,
% delete fas with less than 12 pixels
        if fa_prop(j).Area<=min_fa_area,
            fa_bw(fa_prop(j).PixelIdxList) = 0;
        end;
    end;
    if save_file,
        save(file_fa, 'fa_bw');
    end;
else
    load(file_fa);
end;
fa_bd = bwboundaries(fa_bw, connection, 'noholes');
return;