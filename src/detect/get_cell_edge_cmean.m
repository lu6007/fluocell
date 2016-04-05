% function bd = get_cell_edge_cmean(img, ncluster, varargin)

% Copyright: Kaiwen Zhang, Shaoying Lu and Yingxiao Wang 2011

function bd = get_cell_edge_cmean(img, ncluster, varargin)

lambda = 500;
[mem, ~, ~] = adaptive_cmean(img, ncluster, 'lambda',lambda);
%[mem, ~, ~] = alter_afcm(img, ncluster, varargin);

bd = cmean_outline(mem);

return;