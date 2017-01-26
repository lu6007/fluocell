% test_pm_model
function test_pm_model()
% my_color = get_my_color();

%% Recruit Model, the effect of triggering Molecule/histone ratio
% Recruit: phosphorylation recruits KDMS
% No Recruit: phosphorylation does not recruit KDMS
data = model_init_data('phospho_with_recruit');
inhibitor = [0; 0.6; 0.7; 1];
b = 1-inhibitor;
num_sims = length(b);
res = cell(num_sims,1);
for i = 1:num_sims
    res{i} = phospho_methyl_model(data, 'b', b(i), 'show_figure', 0);
end;
time = res{1}.time;
num_points = size(time, 1);
index = 1:10:num_points;
%
methyl = zeros(num_points, num_sims);
for i = 1:num_sims
    methyl(:,i) = res{i}.methylation;
end;
my_figure('handle', 11, 'font_size', 24, 'line_width', 3); hold on;
plot(time(index), methyl(index,:), 'LineWidth', 3);
xlabel('Time (min)'); ylabel('Methylation Level (K Residual)');
title('Inhibitor Strength');
legend(strcat(num2str(100*inhibitor), '%'));
%
phospho = zeros(num_points, num_sims);
for i = 1:num_sims
    phospho(:,i) = res{i}.phosphorylation;
end;
my_figure('handle', 12, 'font_size', 24, 'line_width', 3); hold on;
plot(time(index), phospho(index,:), 'LineWidth', 3);
xlabel('Time (min)'); ylabel('Phospho Level (K Residual)');
title('Inhibitor Strength');
legend(strcat(num2str(100*inhibitor), '%'));
return;

function data = model_init_data( name )
switch name
    case 'phospho_with_recruit'
        data.num_histones = 60000; % 6000K histone
        data.a(1) = 0.003; % phosphorylation repels methyltransferase
        data.a(2) = 0.01;  % phosphorylation recruit demethylase
        data.num_mols = 1500; % 1.5M more kinase binds to h3s10 during mitosis
        data.max_mols = 4000; % 4M aurora b kinase 
        data.b = 1; % the strength of kinase; 
        data.max_time_phospho = 40 * data.num_histones;  %max phosphorylation for 40 min
        data.more_methyl = 150; % 150K methyltransferase binds interacts with h3k9 during mitosis
        data.dt(1) = 45; % min, time to exit mitosis; enter mitosis at 0 min
        data.dt(2) = 300; % min, cell cycle duration
end

