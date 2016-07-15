% find the p-value indicating the location of t_diff at
% the function diff One-way statistics.

% Copyright : Shaoying Lu & Yingxiao Wang 2011
function p = get_p_value(diff, t_diff)
mean_diff = mean(diff);
sort_diff = sort(diff);
M = length(diff);
if mean_diff<=t_diff,
    k = find(sort_diff>t_diff, 1, 'first');
    k = M-k;
else %mean_diff>0
    k = find(sort_diff<t_diff, 1, 'last');
end;
if isempty(k),
    p=0;
else
    p = double(k)/double(M);
end;

return;
