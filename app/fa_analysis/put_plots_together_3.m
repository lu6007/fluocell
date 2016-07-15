% function put_plots_together_3(handle, cell_name, data);
% The second input was removed.
% The third input was changed from data to group{i}.cell(j)
% Src activation, not the normalized ratio, was used for the colored
% curve plot.
% This plot function is preferred than the first version,
% to keep the consistency between
% the data and the figure plots.

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function put_plots_together_3(handle, this_cell)
time = this_cell.time;
ratio = this_cell.ratio;
disassembly = this_cell.disassembly;

% Src activation colored by paxillin disassembly
t = [time time];
y =[ratio-1-0.01 ratio-1+0.01];
c = [disassembly disassembly];

% Alternatively, paxillin disassembly colored by Src activation
% t = [time time];
% c =[ratio-1 ratio-1];
% y = [disassembly-0.01 disassembly+0.01];

% % Or, plot paxillin disassembly vs. Src activation, colored by time
% t = [disassembly, disassembly];
% y = [ratio-1-0.01, ratio-1+0.01];
% c = [time, time];

z = zeros(size(t));
figure(handle);
surf(t,y,z,c,'EdgeColor','none'); 
return;
