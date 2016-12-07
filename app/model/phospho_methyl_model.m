% Model the relation between methylation and phosphorylation, 
% assuming that phosphorylation drives methylation. 
%
% function result = methyl_phospho_model(data, varargin)
% para_name = {'a1', 'a2', 'show_figure','b'};
% para_default = {data.a(1), data.a(2), 0, data.b};
%
% Example:
% >> data = model_init_data('phospho_with_recruit');
% >> res = phospho_methyl_model(data, 'b',1);
% >> my_figure(11); hold on;
% >> plot(res.time, res.methylation. 'LineWidth', 3);
% let b = 1 0.5, 0.25, 0.2 and make plots. 
% >> 

% Authors: Shaoying Lu , shaoying.lu@gmail.com
% Copyright (2016) The Regents of the University of California
% All Rights Reserved

function result = phospho_methyl_model(data, varargin)
para_name = {'a1', 'a2', 'show_figure','b'};
para_default = {data.a(1), data.a(2), 0, data.b};
[a1, a2, show_figure, b] = parse_parameter(para_name, ...
    para_default, varargin);

max_mols = data.max_mols;
num_histones = data.num_histones;  % 6M 60000; % 60M
max_methyl_plus = 200;

tspan =[-50, 200]; %[-100; 800]; % min
step =  1/2.5; % 24s %1.0/10;            % 6s 
time = (tspan(1): step: tspan(2))';
num_time_steps = size(time, 1);

% Initializaton
phospho = 0; % phosphorylated H3S10
phospho_plus = 50; % kinase = 50K 
phospho_minus = 50; % phospotas
methyl = num_histones/2; % methylated H3K9
methyl_minus = 10 ; % demethylase
methyl_plus = 10; % methyltransferase

% Prepare the integer model system
y = zeros(6, num_time_steps);
y_min = zeros(6,1);
y_max = [num_histones; max_mols; max_mols; ...
    num_histones; max_methyl_plus; max_methyl_plus];
signal_matrix = zeros(6, 6);
signal_matrix(1, [1 2 3]) = [1 b -1];
signal_matrix(4, [4 5 6]) = [1 1 -1];
signal_matrix(5, [1 5]) = [-a1 0]; % h3s10p repels methyl_plus
signal_matrix(6, [1 6]) = [a2 0];  % h3s10p recruits methyl_minus
temp = sparse(signal_matrix); clear signal_matrix;
signal_matrix = temp; clear temp;
c = zeros(6,1);
c([2 3 5 6]) = [phospho_plus; phospho_minus; methyl_plus; methyl_minus];
%
y(1, 1) = phospho;
y(4, 1) = methyl;
y(:, 1) = signal_matrix*y(:,1)+c;
y(:, 1) = max(y(:, 1), y_min);
y(:, 1) = min(y(: ,1), y_max);

%
data.c = c;
data.time_phospho = 0;
data.step = step;
ss = 0;
for i = 1:num_time_steps-1,
    data.time_i = time(i);
    data.y_i = y(:,i:num_time_steps);
    [ss, data] = model_state(ss, data);
    c([2 5]) = data.c([2 5]);
    %
    y(:, i+1) = signal_matrix*y(:, i)+c;
    y(:, i+1) = max(y(:, i+1), y_min);
    y(:, i+1) = min(y(:, i+1), y_max);
end;

% Plot results
lw = 3;
if show_figure,
    for j = 1:6,
        my_figure('handle', j); hold on; 
        plot(time, y(j,:)', 'LineWidth', lw); 
        xlabel('Time (min)'); ylabel(strcat('Y --- ', num2str(j)));
        set(gca, 'FontSize', 24, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth',lw);
    end;
end

result.time = time;
result.phosphorylation = y(1,:)';
result.methylation = y(4,:)';
return;

% function [s, num_mols] = model_state(t, s, num_mols, data)
% Determine the state of the model and the number of triggering molecules
% s = 0, for t<=0, interphase
% s = 1, for 0<t<=dt1, mitosis starts
% s = 2, for t>dt1, exit mitosis
% Outside these time frames, the model state and number of triggering molecules remain unchained. 
function [s, data] = model_state(s, data)
t = data.time_i;
y = data.y_i;
c = data.c;
time_phospho = data.time_phospho;
step = data.step;
max_time_phospho = data.max_time_phospho; 
more_methyl = data.more_methyl;

tt = mod(t, data.dt(2)); % make tt>=0 && tt<data.dt(2)
if tt>0 && tt<=data.dt(1) && s==0,
    s = 1; 
    c(2)  = c(2)+ data.num_mols;
    c(5) = c(5) + more_methyl;
elseif time_phospho < max_time_phospho && s == 1,
    data.time_phospho = time_phospho + y(1,1)*step;
elseif time_phospho >= max_time_phospho && s ==1,
    s = 2;
    data.time_phospho = 0;
    c(2) = c(2) - 2*data.num_mols;
elseif y(4)>= data.num_histones/2 && s ==2,
    s = 0;
    c(5) = c(5) - more_methyl;
end;
data.c = c;
return;

