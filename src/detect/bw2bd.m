% function bd=bw2bd(bw_im);
% output the boundaries of the mask image
% with the length of the boundary,
% in descending order.
% This function should reverse the function
% bd2im(im, x ,y).

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function bd=bw2bd(cell_bw)
bd = bwboundaries(cell_bw, 8, 'noholes');
num_cells = length(bd);
num_nodes = zeros(num_cells, 1);
for i = 1:num_cells,
    num_nodes(i) = length(bd{i});
end;
[~, index] = sort(num_nodes,'descend');
temp = bd;
%bd = temp{index};
for i = 1:num_cells,
    bd{i} = temp{index(i)};
end;
return;