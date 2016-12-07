% function [s, num_mols] = model_state(t, s, num_mols, data)
% Determine the state of the model and the number of triggering molecules
% s = 1, for 0<=t<=dt1, mitosis starts
% s = 2, for t>dt1, exit mitosis
% Outside these time frames, the model state and number of triggering molecules remain unchained. 
function [s, num_mols] = model_state(t, s, num_mols, data)
tt = mod(t, data.dt(2)); % make tt>=0 && tt<data.dt(2)
if tt<=data.dt(1) && s == 0,
    s = 1; 
    num_mols = data.num_mols;
elseif tt>data.dt(1) && tt<=data.dt(2) && s == 1, 
    s = 2;
    num_mols = -data.num_mols;
end;
return;
