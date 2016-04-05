% model relation between methylation and phosphorylation
% function test_methyl_phospho_model_0402_2016()
%
% Example:
% >> test_methyl_phospho_model_0402_2016;

% Authors: Shaoying Lu , shaoying.lu@gmail.com
% Copyright (2016) The Regents of the University of California
% All Rights Reserved

function test_methyl_phospho_model_0402_2016()
show_figure = 1;

% WT cells
data.P0 = 0; data.P1 = 1; 
data.M0 = 1; data.M1 = 0; 
data.a = zeros(5,1); % reaches steady state in ~5 min
data.a(1) = 1;
data.a(2) = 1/3;
data.a(3) = 1/3;
data.a(4) = 1;
data.a(5) = 1;
data.dt1 = 50+200*data.M1; % min -> time to exit mitosis was delayed by increasing of methylation
data.dt2 = 300; % min , period

% % TCP treated cells changed methylation and phosphorylation levels
% % time to exit mitosis was delayed by increasing of methylation
% data.P0 = 0-0.1; data.P1 = 1-0.1; 
% data.M0 = 1+0.1; data.M1 = 0+0.1; 

% % Hesperadin inhibits Aurora kinase and keep phosphorylation level low
% data.a(1) = 0;
% data.a(5) = 0; 

% Run simulation
y0= [data.P0; data.M0];
tspan = [-100; 800]; % min
options = odeset('RelTol',1e-5,'MaxStep',1.0/60.0,'Stats','on'); 
[t,y] = ode15s(@rhs,tspan',y0',options,data);

phospho = y(:,1);
methyl = y(:,2);

% Plot results
lw = 1.5;
if show_figure,
    my_figure; plot(t, phospho, 'b','LineWidth', lw); hold on;
    plot(t, methyl, 'r','LineWidth', lw); legend('Phospho', 'Methyl'); xlabel('Time (min)');
    set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth',lw);
end
return;

function ydot = rhs(t, y, data)
% dp/dt = a(1)*(M0-m)*(P1-p), at states 0 and 1
%           = -a(5)*(p-P0),               at state 2
% dm/dt = 0,                                           at state 0
%             = (-a(2)-a(3)*(p-P0))*(P1-p), at state 1
%             = a(4)*(p-P0),                          at state 2
a = data.a;
s = state(t, data);
ydot = zeros(size(y));
m = y(2); p = y(1);
P0 = data.P0;
M0 = data.M0;
v1 = (M0-m)*(data.P1-p);
v2 = (p-P0);
switch s
    case 0, % initial state
        ydot(1) = a(1)*v1;
        ydot(2) = 0;
    case 1, % enter mitosis
        ydot(1) = a(1)*v1;
        ydot(2) = (-a(2)-a(3)*(p-P0))*(data.P1-p); % later try (m-data.M1)
    case 2, % exit mitosis
        ydot(1) = -a(5)*v2;
        ydot(2) = a(4)*v2;
end;
return;

function s = state(t, data)
% s = 0, for t<0, initial state
% s = 1, for 0<=t<=dt1, mitosis starts
% s = 2, for t>dt1
dt1 = data.dt1;
dt2 = data.dt2;
t = mod(t, dt2);
s = double(t>=0)+double(t>dt1);
return;
