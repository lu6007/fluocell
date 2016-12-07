% test_mp_model
my_color = get_my_color();

%% Recruit Model, the effect of triggering Molecule/histone ratio
% Recruit: phosphorylation recruits KDMS
% No Recruit: phosphorylation does not recruit KDMS
data = model_init_data('phospho_with_recruit');
b = [1; 0.5; 0.4; 0.3; 0.2];
num_sims = length(b);
res = cell(num_sims,1);
for i = 1:num_sims,
    res{i} = phospho_methyl_model(data, 'b', b(i), 'show_figure', 0);
end;
time = res{1}.time;
num_points = size(time, 1);
index = 1:10:num_points;
%
methyl = zeros(num_points, num_sims);
for i = 1:num_sims,
    methyl(:,i) = res{i}.methylation;
end;
my_figure('handle', 11, 'font_size', 24, 'line_width', 3); hold on;
plot(time(index), methyl(index,:), 'LineWidth', 3);
xlabel('Time (min)'); ylabel('Methylation Level (K Residual)');
title('Phosphorylaton Drives Methylation: Kinase Strength');
legend(strcat(num2str(b*100), '%'));
%
phospho = zeros(num_points, num_sims);
for i = 1:num_sims,
    phospho(:,i) = res{i}.phosphorylation;
end;
my_figure('handle', 12, 'font_size', 24, 'line_width', 3); hold on;
plot(time(index), phospho(index,:), 'LineWidth', 3);
xlabel('Time (min)'); ylabel('Phospho Level (K Residual)');
title('Phosphorylaton Drives Methylation: Kinase Strength');
legend(strcat(num2str(b*100), '%'));
