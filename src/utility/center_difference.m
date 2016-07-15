% y(1)= x(2)-x(1), y(i) = (x(i+1)-x(i-1))/2, y(n)= x(n)-x(n-1);
% if x is a matrix, do the center difference along the dimension 1.
% if x is a vector, x is required to be a column vector.
% function y=center_difference(x)
% y = zeros(size(x));
% n = length(x);
% t = diff(x);
% y(1) = t(1);
% y(n) = t(n-1);
% y(2:n-1) = t(2:n-1)+t(1:n-2);
% return;

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function y=center_difference(x)
n = size(x,1);
% if n ==1,
%     temp = x'; clear x;
%     x = temp; clear temp;
% end;
y = zeros(size(x));
n = size(x,1);
t = diff(x,1,1);
y(1,:) = t(1,:);
y(n,:) = t(n-1,:);
y(2:n-1,:) = (t(2:n-1,:)+t(1:n-2,:))/2;
return;
