% function [s, c, data] = model_state(s, data)
% Determine the state of the model and the number of triggering molecules
% s = 0, for t<=0, interphase
% s = 1, for t>0, mitosis starts
% s = 2, for t>dt1, exit mitosis
% Outside these time frames, the model state and number of triggering molecules remain unchanged. 
function [s, c, data] = model_state(s, data)
t = data.time_i;
y = data.y_i;
% h3s10p=y(1); kinase=y(2); ptp=y(3); 
% h3k9m=y(4); mt=y(5); kdm = y(6);
time_phospho = data.time_phospho; 
time_step = data.time_step;
max_time_phospho = data.max_time_phospho; 
more_methyl = data.more_methyl; %150
more_kinase = data.more_kinase;
num_var = data.num_var;

tt = mod(t, data.time(2)); % make tt>=0 && tt<data.time(2)
base_methyl = data.base_methyl;
c = zeros(num_var, 1);
if s ==0 && tt>0 && tt<data.time(1)
    % mitosis starts
    % kinase and methyltransferace both increase
    s = 1; 
    c(2) = more_kinase;
    c(5) = more_methyl;
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
    c([2 5]) = 0;
    
% Additional measures to stabilize the model
% toward the end of simulation after the cell exits state 2. 
elseif s==2 && y(4)>= base_methyl
    % When the methylation level recovers, interphase starts.
    % Kinase and mehtyltransferace level recover to the interphase baseline.  
    s = 0;
    c(2) = y(3)-y(2); % reset y(2) to y(3)
    c(5) = y(6)-y(5); % reset y(5) to y(6)
elseif s==0 && (y(4)>base_methyl+10 || y(1)>10)
    c(2) = y(3)-y(2); 
    c(5) = y(6)-y(5); % reset y(5) to y(6) again to stabilize the model
elseif s==0 && y(4)>= base_methyl
    c([2 5]) = 0; 
end

data.time_phospho = time_phospho;
return;


