% delete extra nodes from edge if this nodes does not
% contain additional inforamtion of cell edge charactor
% i.e. if the angle at the node is very small.

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function [new_x, new_y] = delete_extra_node(x,y, alpha);
if nargin <3,
alpha = pi*10.0/180.0;
end;
alpha = cos(alpha);

num_nodes = size(x,1);
num_extra_nodes = 0;

for i = 1:num_nodes-2,
    a = [x(i+1); y(i+1)]-[x(i); y(i)];
    b = [x(i+2); y(i+2)]-[x(i+1); y(i+1)];
    if a'*b/(norm(a)*norm(b))>=alpha,
        num_extra_nodes = num_extra_nodes+1;
        x(i+1) = -1;
        i = i+1;
    end;
end;

if num_extra_nodes == 0,
    new_x = x;
    new_y = y;
    return;
end;

num_new_nodes = num_nodes - num_extra_nodes;
new_x = zeros(num_new_nodes, 1);
new_y = zeros(num_new_nodes,1);
j = 0;
for i = 1: num_nodes,
    if x(i)>=0,
        j= j+1;
        new_x(j) = x(i);
        new_y(j) = y(i);
    end;
end;

[new_x, new_y] = delete_extra_node(new_x, new_y);
return;
