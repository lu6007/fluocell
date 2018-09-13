% function [s, c, data] = model_state(s, data)
% Determine the state of the model and the number of triggering molecules
% Outside these time frames, the model state and number of triggering molecules remain unchanged. 
function [s, c, data] = model_state(s, data, varargin)
para_name = {'type'};
para_default = {1};
type = parse_parameter(para_name, para_default, varargin);
switch type
    case 1
        [s, c, data] = model_state_1(s, data);
    case 2
        [s, c, data] = model_state_2(s, data); 
end
return

% s = 0, for t<=0, interphase
% s = 0.1, for t>0, late G2, sythesis starts
% s = 0.2, for phosphor > th1 , demethylation starts
% s = 1.0, for phosphor > th2, entering mitosis, recruit stage
% s = 1.1, for phosphor > th2, unbinding 
% s = 2.0, for phosphor > th1, exit mitosis, degrade 
% s = 2.1, for t>dt1, end degrading 
function [s, c, data] = model_state_2(s, data)
t = data.time_i;
y = data.y_i;
% h3s10p=y(1); kinase=y(2); ptp=y(3); 
% h3k9m=y(4); mt=y(5); kdm = y(6);
time_phospho = data.time_phospho; 
time_step = data.time_step;
max_time_phospho = data.max_time_phospho; 
more_methyl = data.more_methyl; %150
factor = data.more_b;
more_kinase = data.more_kinase;
methyl_ko = data.methyl_ko; % 0 or 1, 1 to knockout all the more_methyl specy. 
num_var = data.num_var;
a1 = data.a1;
a2 = data.a2; 

tt = mod(t, data.time); % make tt>=0 && tt<data.time
base_methyl = data.base_methyl;
c = zeros(num_var, 1);
phospho_th2 = data.base_phospho+data.num_histone/4; % number 4 estimated based on figure 3E. 
phospho_th1 = data.base_phospho+phospho_th2*2/3; 
more_kinase_1 = more_kinase/4; 
more_methyl_1 = more_methyl/2;
if s == 0 && tt>0 && tt<100
    % late G2
    % kinase and methyltransferace both increase
    s = 0.1; % activate kinase synthesis at tt = 0
    c(2) = more_kinase_1 * factor; 
    c(5) = more_methyl_1*(1-methyl_ko); %%% Small bump
    time_phospho = time_phospho + y(1)*time_step; 
elseif (s == 0.1 ) && y(1)>= phospho_th1 % && y(4)>= data.base_methyl  
    s = 0.2; % activate demethylation at phospho_th1
    c(2) = 0; % more_kinase_1 * factor; 
    c(6) = more_methyl*a2; 
    time_phospho = time_phospho + y(1)*time_step; 
elseif (s == 0.2) && y(1)>= phospho_th1 && y(1)<phospho_th2  
    time_phospho = time_phospho + y(1)*time_step;
elseif s == 0.2 && y(1)>=phospho_th2 
    % Activate kinase recruitment when methylation returns to basal value
    % Enter mitosis
    s = 1.0; 
    c(2) = more_kinase * factor ;
    c(5)= 0; 
    c(6) = more_methyl*a2; 
    time_phospho = time_phospho + y(1)*time_step;
elseif s==1.0 && time_phospho < max_time_phospho
    % mitosis starts when methylation stabilizes at a low level. 
    time_phospho = time_phospho + y(1)*time_step;
elseif s==1.0 && time_phospho >= max_time_phospho 
    % When the total phosphorylation accumulates for a certain period of time,
    % mitosis ends, and kinase decreases.
    s = 1.1; % disassembly
    time_phospho = 0;
elseif s ==1.1 && y(1)>=phospho_th2 % disassembly and remethylation
    c(2) = -more_kinase * (y(2)-data.base_kinase)/y(2) * factor; 
    c(3) = more_kinase * (3*data.base_phosphotase - y(3))/data.base_phosphotase; 
    c(5) = more_methyl*a1 ; 
    c(6) = -more_methyl*a2 ;  
elseif s ==1.1 && y(1)>= data.base_phospho && y(1)<phospho_th2 
    s = 2.0; % degrading 
    y1_gt_base_phospho = (y(1)-data.base_phospho)/max(abs(y(1)), 1);
    c(2) = -more_kinase_1 * y1_gt_base_phospho*factor;
elseif s == 2.0 && y(1)<phospho_th2 && y(1)>= data.base_phospho % degrading
    c(2) = 0; 
    c(3) = - more_kinase * (y(3)-data.base_phosphotase)/y(3);
    stabilize_factor = ((base_methyl-y(4))/base_methyl) * ...
        ((data.num_histone- y(4))/(data.num_histone-base_methyl)); 
    c(5) = more_methyl * stabilize_factor; 
    c(6) = -more_methyl * stabilize_factor;  
    if y(4)> base_methyl && y(5)>y(6)
        c(5) = (y(6)-y(5));
        c(6) = 0;
    elseif y(4)> base_methyl && y(5)<y(6)
        c(5) = 0;
        c(6) = (y(5)- y(6)); 
    end
elseif s ==2.0 && y(1)<=data.base_phospho
    % When the phosphorylation level recovers, exit mitosis; 
    % Kinase level recover to the interphase baseline.  
    s = 2.1; % interphase
    c(2) = y(3)-y(2); 
    %
    if y(4) >= base_methyl
        s = 0;
    end
elseif s==2.1 && y(4)>= base_methyl
    % Return to the basal state  
    s = 0;
elseif s==0 && (y(4)>base_methyl+10 || y(1)>10)
    c(2) = y(3)-y(2);
    c(5) = y(6)-y(5); % reset y(5) to y(6) again to stabilize the model
elseif s==0 && y(4)>= base_methyl
    c([2 5]) = 0; 
end

data.time_phospho = time_phospho;
return;


% s = 0, for t<=0, interphase
% s = 1, for t>0, mitosis starts
% s = 2, for t>dt1, exit mitosis
function [s, c, data] = model_state_1(s, data)
t = data.time_i;
y = data.y_i;
% h3s10p=y(1); kinase=y(2); ptp=y(3); 
% h3k9m=y(4); mt=y(5); kdm = y(6);
time_phospho = data.time_phospho; 
time_step = data.time_step;
max_time_phospho = data.max_time_phospho; 
more_methyl = data.more_methyl; %150
more_kinase = data.more_kinase;
methyl_ko = data.methyl_ko; % 0 or 1, 1 to knockout all the more_methyl specy. 
num_var = data.num_var;

tt = mod(t, data.time(2)); % make tt>=0 && tt<data.time(2)
base_methyl = data.base_methyl;
c = zeros(num_var, 1);
if s ==0 && tt>0 && tt<data.time(1)
    % mitosis starts
    % kinase and methyltransferace both increase
    s = 1; 
    c(2) = more_kinase;
    c(5) = more_methyl*(1-methyl_ko);
elseif s==1 && time_phospho < max_time_phospho
    time_phospho = time_phospho + y(1)*time_step;
    c([2 5]) = 0;
elseif s==1 && time_phospho >= max_time_phospho 
    % When the total phosphorylation accumulates for a certain period of time,
    % mitosis ends, and kinase decreases.
    s = 2;
    time_phospho = 0;
    c(2) = -2*more_kinase;
    c(5) = 0;
elseif s==2 && y(4)< base_methyl
    % c([2 5]) = 0;
    c(5) = more_methyl; 
    c(6) = -more_methyl;
% Additional measures to stabilize the model
% toward the end of simulation after the cell exits state 2. 
elseif s==2 && y(4)>= base_methyl
    % When the methylation level recovers, interphase starts.
    % Kinase and mehtyltransferace level recover to the interphase baseline.  
    s = 0;
    % c(2) = y(3)-y(2); % reset y(2) to y(3)
    % c(5) = y(6)-y(5); % reset y(5) to y(6)
    c([5 6]) = 0;
elseif s==0 && (y(4)>base_methyl+10 || y(1)>10)
    c(2) = y(3)-y(2);
    c(5) = y(6)-y(5); % reset y(5) to y(6) again to stabilize the model
elseif s==0 && y(4)>= base_methyl
    c([2 5]) = 0; 
end

data.time_phospho = time_phospho;
return;


