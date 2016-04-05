% Randomly pick the entries from the samples a and b
% Assign them to either a or b without repeats
% for M times.
% function [a_rand b_rand] = randomize_sample(a,b, M)
% a_rand, b_rand: cell(M,1);

% Copyright : Shaoying Lu & Yingxiao Wang 2011

function [a_rand b_rand] = randomize_sample(a,b, M, varargin)
param_name = {'dim'};
default_value = {2};
dim = parse_parameter(param_name, default_value, varargin);
assert(dim == 2|| dim ==3);
v = cat(1, a,b);
n1 = size(a, 1); n2 = size(b,1);
n = n1+n2;
a_rand = cell(M,1);
b_rand = cell(M,1);
for i = 1:M,
    % randomly pick n1 numbers to assign to group 1
    % then pick n2 numbers to assign to group 2
    r = rand(n, 1);
    r_sort = sort(r);
    r_index_1 = find(r<=r_sort(n1), n1, 'first');
    if dim ==2,
        a_rand{i} = v(r_index_1,:); % add these numbers to list 1
    elseif dim ==3,
        a_rand{i} = v(r_index_1,:,:);
    end;
    r(r_index_1) = r_sort(n)+1; % remove these numbers from list 2
    r_index_2 = find(r<=r_sort(n), n2, 'first');
    if dim ==2,
        b_rand{i} = v(r_index_2,:);
    elseif dim ==3,
        b_rand{i} = v(r_index_2,:,:);
    end;
%     figure(20); hold on;
%     plot(r_index_1, i*ones(size(r_index_1)), 'b+');
%     plot(r_index_2, i*ones(size(r_index_2)), 'r+');
    clear r r_sort r_index_1 r_index_2;
    
end;
return;