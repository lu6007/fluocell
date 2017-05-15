% Calculate the circumscribing boundary
% for different object in a label matrix: label

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function bd = label2bd(label)
num_regions = max(max(label));
label_prop = regionprops(label, 'PixelList');
bd = cell(num_regions,1);
for i = 1:num_regions
    x = label_prop(i).PixelList(:,1);
    y = label_prop(i).PixelList(:,2);
    min_x = min(x)-1; min_y = min(y)-1;
    max_x = max(x)+1; max_y = max(y)+1;
    % will improve efficiency if crop first and then find (label==i)
    bw_i = (label==i);
    im_i=imcrop(bw_i, [min_x, min_y, max_x-min_x, max_y-min_y]);
%     if i==109,
%         imagesc(im_i);
%     end;
%     p = [min_x max_x max_x min_x min_x];
%     q = [min_y min_y max_y max_y min_y];
    %figure; imagesc(label); hold on; plot(p, q, 'g', 'LineWidth',2 );
     %figure; imagesc(im_i); hold on; plot(y-min_y+1, x-min_x+1, 'g', 'LineWidth',2);
    bd_i = bwboundaries(im_i,8, 'noholes');
    x = bd_i{1}(:,2)+ min_x-1;
    y = bd_i{1}(:,1)+ min_y-1;
    bd{i} = [y x];
end;
return;

