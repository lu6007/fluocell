% Find the boundary with the largest enclosed area detected by function
% bwboundaries().
% function bd = find_longest_boundary(bw);

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function bd = find_longest_boundary(bw)
[bd_all, ~] = bwboundaries(bw, 8, 'noholes');
max_length = 0;
index = 0;
for i = 1:length(bd_all)
    if length(bd_all{i})>max_length
        max_length = length(bd_all{i});
        index = i;
    end
end
% stats = regionprops(label, 'Area');
% area = cat(1, stats.Area);
% [max_area index] = max(area);
if index>0
    bd = bd_all{index};
else
    bd = [];
end
return;