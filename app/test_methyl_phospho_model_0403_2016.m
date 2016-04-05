% model relation between methylation and phosphorylation
% function test_methyl_phospho_model_0402_2016()
%
% Example:
% >> test_methyl_phospho_model_0402_2016;

% Authors: Shaoying Lu , shaoying.lu@gmail.com
% Copyright (2016) The Regents of the University of California
% All Rights Reserved

function test_methyl_phospho_model_0403_2016(varargin)
para_name = {'num_dms', 'a1', 'a2', 'show_figure'};
para_default = {5, 0.1, 0.1, 1};
[num_dms, a1, a2, show_figure] = parse_parameter(para_name, para_default, varargin);
data.a(1) = a1; 
data.a(2) = a2;
data.num_dms = num_dms;
data.max_dms = 3000;
num_histones = 60000; % 60M
data.dt1 = 50; % min, time to exit mitosis
data.dt2 = 300; % min, cell cycle duration

% % No phosphorylation feedback 
% data.a(1) = 0;
% num_dms = 200;
h3k9 = ones(num_histones, 1);
h3s10 = zeros(num_histones, 1);
tspan = [-100; 800]; % min
step = 1.0/10;            % 6s 
time = (tspan(1): step: tspan(2))';
num_time_steps = size(time, 1);
y = zeros(num_time_steps, 3);
ss = 0;
num_dms = -data.num_dms;
for i = 1:num_time_steps,
    [ss, num_dms] = state(time(i),ss, num_dms, data);
    if num_dms>0,
        index = find(h3k9==1, num_dms);
        h3k9(index) = 0;
        h3s10(index) = 1;
    elseif num_dms<0,
        index = find(h3k9==0, -num_dms);
        h3k9(index) = 1;
        h3s10(index) = 0;
    end;
    if num_dms < data.max_dms && num_dms>=1,
        num_dms = num_dms +floor(length(index)*data.a(1)+0.5);
        num_dms = min(num_dms, data.max_dms);
    elseif num_dms>-data.max_dms && (num_dms <=(-1)),
        num_dms = num_dms-floor(length(index)*data.a(2)+0.5);
        num_dms = max(num_dms, - data.max_dms); 
    end;
    y(i, 1) = sum(h3k9)/num_histones;
    y(i, 2) = sum(h3s10)/num_histones;
    y(i, 3) = num_dms; 
end;

% Plot results
lw = 1.5;
if show_figure,
    y(:,3) = y(:,3)/y(num_time_steps, 3);
    my_figure; plot(time, y(:,1:2), 'LineWidth', lw); xlabel('Time (min)');
    set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth',lw);
    legend('Methyl', 'Phosph');%, 'Demethylase');
end
return;


function [s, num_dms] = state(t, s, num_dms, data)
% s = 0, for 0<=t<=dt1, mitosis starts
% s = 1, for t>dt1, exit mitosis
tt = mod(t, data.dt2);
if tt<=data.dt1 && s == 0,
    s = 1; 
    num_dms = data.num_dms;
elseif tt>data.dt1 && tt<=data.dt2 && s == 1, 
    s = 0;
    num_dms = -data.num_dms;
end;
return;
