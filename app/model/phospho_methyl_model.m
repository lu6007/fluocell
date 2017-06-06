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

max_phosphor_enzyme = data.max_phosphor_enzyme; 
num_histone = data.num_histone;  % 60M 60000; 
max_methyl_enzyme = data.max_methyl_enzyme;
dt = data.time_step;
min_kdm = data.min_demethylase;

tspan =[-50, 350]; %[-100; 800]; % min
time = (tspan(1): dt: tspan(2))';
num_dt = size(time, 1);

% Prepare the integer model system
% The kinase is 5 times of KDMs in interphase and
% 16 time of KDMs in mitosis
% State variable y
num_var = 6;
y = zeros(num_var, num_dt);
y(1, 1) = data.base_phosphor; % H3S10 phosphorylation
y(2, 1) = data.base_kinase; % kinase
y(3, 1) = data.base_phosphotase; % phosphotase
y(4, 1) = data.base_methyl; % K9 methylation
y(5, 1) = data.base_methyltransferase; % methyltransferaze
y(6, 1) = data.base_demethylase; % demethylase
y_min = [0; 0; 0; 0; 0; min_kdm];
y_max = [num_histone; max_phosphor_enzyme; max_phosphor_enzyme; ...
    num_histone; max_methyl_enzyme; max_methyl_enzyme];

% molecules/min were processed by each enzyme 
% considering recruiting and biochemical reaction. 
% phosphorylation repels methyltransferase and recruits demethylase
signal_matrix = zeros(num_var);
signal_matrix(1, [2 3]) = [b -1]*1.67;
signal_matrix(4, [5 6]) = [1 -1]*1.33;
M2 = eye(6);
M2(5, 1) = -a1;
M2(6, 1) = a2;
signal_matrix = M2*signal_matrix;
%
temp = sparse(signal_matrix); clear signal_matrix;
signal_matrix = temp; clear temp;
if show_figure
    test = full(signal_matrix);
    figure(100); imagesc(test); colormap jet;
    caxis([-0.5 0.5]); colorbar; 
    clear test;
end

%
data.time_phospho = 0;
data.num_var = 6;
ss = 0;
for i = 1:num_dt-1
    v = signal_matrix*y(:,i);
    
    temp = y(:,i)+dt*v; 
    data.time_i = time(i);
    data.y_i = temp;
    [ss, c_new, data] = model_state(ss, data);
    c = M2*c_new; clear c_new; 
    
    y(:,i+1) = y(:,i)+dt*v+c;

    % modulated by y_min and y_max
    y(:, i+1) = max(y(:, i+1), y_min);
    y(:, i+1) = min(y(:, i+1), y_max);
    clear v temp;
end

% Plot results
lw = 3;
if show_figure
    title_str = {'Phospho', 'Kinase', 'PTP', 'Methyl', 'Methyltrans', 'KDMS'};
    my_figure; hold on;
    for j = 1:num_var
        subplot(3, 2,j);
        plot(time, y(j,:)', 'LineWidth', lw); 
        xlabel('Time (min)'); ylabel(strcat('y', num2str(j), '-', title_str{j}));
        set(gca, 'FontSize', 24, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth',lw);
    end
    my_figure; hold on;
    plot(time, y(1,:)', 'LineWidth', lw);
    xlabel('Time (min)'); ylabel(strcat('y', num2str(j), '-', title_str{j}));
    set(gca, 'FontSize', 24, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth',lw);  
end

result.time = time;
result.phosphorylation = y(1,:)';
result.methylation = y(4,:)';
return;

