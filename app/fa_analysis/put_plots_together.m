% function put_plots_together(handle, cell_name, data);

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function put_plots_together(handle, cell_name, data)
time = data.time;
ratio_in_fa = data.ratio_in_fa;
total_intensity_fa = data.total_intensity_fa;
total_pax_intensity = data.total_pax_intensity;
disassembly = data.disassembly;
cell_data = initialize_data(cell_name);

time = (time-cell_data.pdgf_time)/60; %minutes
i = find(data.index<=cell_data.before_pdgf, 1, 'last');
ratio_in_fa = ratio_in_fa/ratio_in_fa(i);
% average_intensity = average_intensity_fa./total_pax_intensity;
% average_intensity = average_intensity/average_intensity(1);
total_intensity = total_intensity_fa./total_pax_intensity;
total_intensity = total_intensity/total_intensity(i);

% two plots
my_color = get_my_color();
dark_red = my_color.dark_red;
dark_blue = my_color.dark_blue;
figure(handle(1)); plot(time, ratio_in_fa,'Color', dark_red, 'LineWidth',4); 
%set(gca, 'Fontsize', 32, 'Box', 'off', 'LineWidth',4 ); axis on;
plot(time, total_intensity, '.','MarkerSize', 24, 'Color', dark_blue, 'LineWidth',4);
% Src activation colored by paxillin disassembly
t = [time time];
y =[ratio_in_fa-0.01 ratio_in_fa+0.01];
%c = 1.0-[total_intensity total_intensity];
c = [disassembly disassembly];
z = zeros(size(t));
figure(handle(2)); 
%set(gca, 'Fontsize', 32, 'Box', 'off', 'LineWidth',4 ); axis on;
surf(t,y,z,c,'EdgeColor','none'); 
return;
