% Align Bounding Box of FA with FilledImage
% Recalculate the definition of BoundingBox
% For each focal adhesions,
% bb = fa_props{i}(j).BoundingBox;
% bb(1:2) = bb(1:2)+0.5; bb(3:4)= bb(3:4)-1;
% fa_props{i}(j).BoundingBox = bb;
% (1) global_pixel = local_pixel+[bb(1)-1, bb(2)-1];
% (2) local_image = imcrop(global_im, bb);

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function bb=align_bounding_box(bb);
bb(1:2) = bb(1:2)+0.5;
bb(3:4) = bb(3:4)-1;
return;
