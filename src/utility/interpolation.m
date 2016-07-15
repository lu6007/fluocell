% interpolate in each pixel of the boundary defined by column vectors
% x and y,
% the step length is 0.5 pixels.

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function [new_x, new_y] = interpolation(x,y)
    step = 0.5;
t(1)=0;
for i = 1: length(x)-1,
    length_i = sqrt((x(i+1)-x(i))^2+(y(i+1)-y(i))^2);
    t(i+1) = t(i)+length_i;
end;
% get rid of duplicated nodes
index = find(diff(t));
n = length(index);
if n < length(x),
t = t(index);
x = x(index);
y = y(index);
end;
new_t = [t(1):step:t(2)];
for i = 2:n-1,
    new_t = [new_t, t(i):step:t(i+1)];
end;
new_t = new_t';
new_p = interp1(t, [x y], new_t);
new_x = new_p(:,1); 
new_y = new_p(:,2);
return;