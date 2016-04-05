% function [new_x, new_y]= delete_duplicate_nodes(x,y)
% delete duplicated nodes from arrays describe a boundary

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function [new_x, new_y] = delete_duplicated_node(x,y,varargin);
parameter_name = {'look_ahead'};
default_value = {10};
[look_ahead, success] = parse_parameter(parameter_name,...
    default_value, varargin);
num_nodes = size(x,1);
num_extra_nodes = 0;
for i = 1: num_nodes-2,
    for j = 2:min(look_ahead, num_nodes-i),
%             if i+j>num_nodes,
%                 i
%                 j
%                 min(look_ahead, num_nodes-i)
%             end;
        if x(i) == x(i+j) && y(i)==y(i+j),
            num_extra_nodes = num_extra_nodes+j;
            for k = 1:j,
                x(i+k) = -1;
            end;
            i = i+k;
           break;
        end; % if
    end; % for j
end; % for i
if num_extra_nodes == 0,
    new_x = x; new_y = y;
    return;
end;

new_num_nodes = num_nodes -num_extra_nodes;
new_x = zeros(new_num_nodes, 1);
new_y = zeros(new_num_nodes,1);
j = 0;
for i = 1:num_nodes,
    if x(i)>=0,
        j = j+1;
        new_x(j) = x(i);
        new_y(j) = y(i);
    end;
end;

% [new_x, new_y ] = delete_duplicate_nodes(new_x, new_y);
return;
    
    
        