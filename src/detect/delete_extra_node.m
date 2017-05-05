% delete extra nodes from edge if this nodes does not
% contain additional inforamtion of cell edge charactor
% i.e. if the angle at the node is very small.

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function [new_x, new_y] = delete_extra_node(x,y, alpha)
if nargin <3
alpha = pi*10.0/180.0;
end
alpha = cos(alpha);

num_node = size(x,1);
num_extra_node = 0;

for i = 1:num_node-2
    a = [x(i+1); y(i+1)]-[x(i); y(i)];
    b = [x(i+2); y(i+2)]-[x(i+1); y(i+1)];
    % if a'*b/(norm(a)*norm(b))>=alpha, % Kathy 02/26/2017 Bug fix for the 
    % Boundary detection problem
    if -a'*b/(norm(a)*norm(b))>=alpha
        num_extra_node = num_extra_node+1;
        x(i+1) = -1;
        i = i+1;
    end
end

if num_extra_node == 0
    new_x = x;
    new_y = y;
    return;
end

num_new_nodes = num_node - num_extra_node;
new_x = zeros(num_new_nodes, 1);
new_y = zeros(num_new_nodes,1);
j = 0;
for i = 1: num_node
    if x(i)>=0
        j= j+1;
        new_x(j) = x(i);
        new_y(j) = y(i);
    end
end

[new_x, new_y] = delete_extra_node(new_x, new_y);
return;
