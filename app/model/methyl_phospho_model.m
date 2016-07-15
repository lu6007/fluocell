% model relation between methylation and phosphorylation
% function result = methyl_phospho_model(data, varargin)
% para_name = {'num_kdms', 'a1', 'a2'};
% para_default = {data.num_kdms, data.a(1), data.a(2)};
%
% Example:
% >> data = model_init_data('with_feedback');
% >> res = methyl_phospho_model(data);
% >> my_figure(11); hold on;
% >> plot(res.time, res.methylation);

% Authors: Shaoying Lu , shaoying.lu@gmail.com
% Copyright (2016) The Regents of the University of California
% All Rights Reserved

function result = methyl_phospho_model(data, varargin)
para_name = {'num_kdms', 'max_kdms', 'a1', 'a2'};
para_default = {data.num_kdms, data.max_kdms, data.a(1), data.a(2)};
[num_kdms, max_kdms, a1, a2] = parse_parameter(para_name, ...
    para_default, varargin);

data.num_kdms = num_kdms;
num_histones = data.num_histones;  % 6M 60000; % 60M

h3k9 = ones(num_histones, 1);
h3s10 = zeros(num_histones, 1);
tspan =[-50, 200]; %[-100; 800]; % min
step =  1/2.5; % 24s %1.0/10;            % 6s 
time = (tspan(1): step: tspan(2))';
num_time_steps = size(time, 1);
y = zeros(num_time_steps, 3);
ss = 0;
% num_kdms is the different between the 
% number of KDMs and methyltransferase. 
% h3k9 = 1 --- methylated; 0 --- demethylated
% h3s10 = 1 --- phosphorylated;  0 --- dephosphorylated
num_kdms = -num_kdms;
for i = 1:num_time_steps,
    [ss, num_kdms] = state(time(i),ss, num_kdms, data);
    if num_kdms>0, % There are more KDMs
        index = find(h3k9==1, num_kdms);
        h3k9(index) = 0; 
        h3s10(index) = 1;
    elseif num_kdms<0, % There are more methyltransferases. 
        index = find(h3k9==0, -num_kdms);
        h3k9(index) = 1;
        h3s10(index) = 0;
    end;
    if num_kdms < max_kdms && num_kdms>=1,
        num_kdms = num_kdms +floor(length(index)*a1+0.5);
        num_kdms = min(num_kdms, max_kdms);
    elseif num_kdms>-max_kdms && (num_kdms <=(-1)),
        num_kdms = num_kdms-floor(length(index)*a2+0.5);
        num_kdms = max(num_kdms, - max_kdms); 
    end;
    y(i, 1) = sum(h3k9)/num_histones;
    y(i, 2) = sum(h3s10)/num_histones;
    y(i, 3) = num_kdms; 
end;

% Plot results
% lw = 3;
% if show_figure,
%     y(:,3) = y(:,3)/y(num_time_steps, 3);
%     my_figure('handle', 100); hold on; 
%     plot(time, y(:,1), 'LineWidth', lw,'Color', 'r'); 
%     plot(time, y(:,2), 'LineWidth', lw,'Color', 'b'); 
%     xlabel('Time (min)'); ylabel('Percentage');
%     set(gca, 'FontSize', 24, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth',lw);
%     legend('Methyl', 'Phosph');%, 'Demethylase');
% end

result.time = time;
result.methylation = y(:,1);
result.phosphorylation = y(:,2);
return;


function [s, num_kdms] = state(t, s, num_kdms, data)
% s = 0, for 0<=t<=dt1, mitosis starts
% s = 1, for t>dt1, exit mitosis
tt = mod(t, data.dt(2));
if tt<=data.dt(1) && s == 0,
    s = 1; 
    num_kdms = data.num_kdms;
elseif tt>data.dt(1) && tt<=data.dt(2) && s == 1, 
    s = 0;
    num_kdms = -data.num_kdms;
end;
return;
