% Function compute_average_value
% Calculate the average value in the roi defined by poly.

% Copyright: Shaoying Lu and Yingxiao Wang 2014
function v = compute_average_value(im, bw)
temp = double(bw);
v = sum(sum(double(im) .* temp)) ./ sum(sum(temp));
return;
