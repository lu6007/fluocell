% function put_plots_together(handle, cell_name, data);
% The second input was removed.
% The third input was changed from data to group{i}.cell(j)
% Src activation, not the normalized ratio, was used for the colored
% curve plot.
% This plot function is preferred than the first version,
% to keep the consistency between
% the data and the figure plots.

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function put_plots_together_2(handle, this_cell)
time = this_cell.time;
ratio = this_cell.ratio;
intensity = this_cell.intensity;
disassembly = this_cell.disassembly;

% two plots
my_color = get_my_color();
dark_red = my_color.dark_red;
dark_blue = my_color.dark_blue;

% dot-line plot
figure(handle(1)); plot(time, ratio,'Color', dark_red, 'LineWidth',4); 
plot(time, intensity, '.','MarkerSize', 24, 'Color', dark_blue, 'LineWidth',4);

% Src activation colored by paxillin disassembly
t = [time time];
y =[ratio-1-0.01 ratio-1+0.01];
c = [disassembly disassembly];
z = zeros(size(t));
figure(handle(2)); 
surf(t,y,z,c,'EdgeColor','none'); 
return;
