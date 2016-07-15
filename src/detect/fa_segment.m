% The segmentation of focal adhesions.

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function [fa_label, num_fas] = fa_segment(im, low_thresh, min_single_fa)

min_water = low_thresh;
fa_bw = logical(im>min_water);
[fa_bd, fa_label] =bwboundaries(fa_bw, 8, 'nohole');


%% Delete FAs if the number of pixles<= min_fa_area
fa_prop=regionprops(fa_label,'Area', 'PixelList');
num_fas = max(max(fa_label));
fa_delete = zeros(num_fas, 1);

 % Delete smaller FAs
 for i = 1:num_fas,
    % Do nothing with the large FAs
    if fa_prop(i).Area>min_single_fa,% && fa_prop(i).Area<=1000,
        continue;
    end;
    % Mark smaller FAs for deletion
    % Because of the previous merge action, there should be no
    % neighbors to the small FAs.
        fa_delete(i) = 1;
 end;       

% Reorganize the focal adhesions, completely delete the unwanted FAs.
[fa_label, num_fas] = delete_fa(fa_label, fa_delete);
% figure; imagesc(fa_bw);
% figure; imagesc(fa_label);
return;