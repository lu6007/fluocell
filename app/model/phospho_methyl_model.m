% Model the relation between methylation and phosphorylation, 
% assuming that phosphorylation drives methylation. 
%
% function result = phospho_methyl_model(data, varargin)
% para_name = {'a1', 'a2', 'show_figure','b'};
% para_default = {data.a(1), data.a(2), 0, data.b};
%
% Example:
% >> data = model_init_data('model1');
% >> res = phospho_methyl_model(data, 'b',1, 'show_figure', 1);
% >> my_figure(11); hold on;
% >> plot(res.time, res.methylation, 'LineWidth', 3);
% let b = 1 0.5, 0.25, 0.2 and make plots. 

% Authors: Shaoying Lu , shaoying.lu@gmail.com
% Copyright (2016-2017) The Regents of the University of California
% All Rights Reserved

function result = phospho_methyl_model(data, varargin)
para_name = {'a1', 'a2', 'show_figure','b'}; 
para_default = {data.a(1), data.a(2), 0, data.b}; 
[a1, a2, show_figure, b] = parse_parameter(para_name, ...
    para_default, varargin);

max_mol = data.max_mol; 
num_histone = data.num_histone;  % 60M 60000; 
max_methyl = data.max_methyl;

tspan =[-50, 150]; %[-100; 800]; % min
step =  1/5; % min, 12s  
time = (tspan(1): step: tspan(2))';
num_time_steps = size(time, 1);

% Prepare the integer model system
% The kinase is 5 times of KDMs in interphase and
% 16 time of KDMs in mitosis
% State variable y
y = zeros(6, num_time_steps);
y(1, 1) = 0; % H3S10 phosphorylation
y(2, 1) = 500; % kinase/phospho_plus
y(3, 1) = 500; % phosphotase/phospho_minus
y(4, 1) = data.basal_methyl; % K9 methylation
y(5, 1) = 100; % methyltransferaze/methyl_plus
y(6, 1) = 100; % demethylase/methyl_minus
y_min = [0; 0; 0; 0; 0; 0];
y_max = [num_histone; max_mol; max_mol; ...
    num_histone; max_methyl; max_methyl];

% signal matrix 
signal_matrix = eye(6);
signal_matrix(1, [1 2 3]) = [1 b -1];
signal_matrix(4, [4 5 6]) = [1 1 -1];
temp = sparse(signal_matrix); clear signal_matrix;
signal_matrix = temp; clear temp;
if show_figure
    test = full(signal_matrix);
    figure(100); imagesc(test); colormap jet;
    clear test;
end

%
data.time_phospho = 0;
data.step = step;
c = zeros(6,1);
ss = 0;
for i = 1:num_time_steps-1
    data.time_i = time(i);
    data.y_i = y(:, i);
    [ss, c_new, data] = model_state(ss, c, data);
    c([2 5]) = c_new([2 5]); clear c_new; 
    y(:, i+1) = signal_matrix*y(:, i)+c;
    y(:, i+1) = max(y(:, i+1), y_min);
    y(:, i+1) = min(y(:, i+1), y_max);
    % phosphorylation repels methyltransferase and recruits demethylase
    delta_phospho = y(1,i+1)-y(1,i);
    y(5, i+1) = y(5,i+1) - a1*delta_phospho;
    y(6, i+1) = y(6, i+1) + a2*delta_phospho;
    y(:, i+1) = max(y(:, i+1), y_min);
    y(:, i+1) = min(y(:, i+1), y_max);
end;

% Plot results
lw = 3;
if show_figure
    title_str = {'Phospho', 'Kinase', 'PTP', 'Methyl', 'Methyltrans', 'KDMS'};
    for j = 1:6
        my_figure('handle', j); hold on; 
        plot(time, y(j,:)', 'LineWidth', lw); 
        xlabel('Time (min)'); ylabel(strcat('y', num2str(j), '-', title_str{j}));
        set(gca, 'FontSize', 24, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth',lw);
    end;
end

result.time = time;
result.phosphorylation = y(1,:)';
result.methylation = y(4,:)';
return;

