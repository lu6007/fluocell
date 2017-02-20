% test_pm_model
function test_pm_model(model_name)
%% Recruit Model, the effect of triggering Molecule/histone ratio
% Recruit: phosphorylation recruits KDMS
% No Recruit: phosphorylation does not recruit KDMS
show_figure = 0;

switch model_name
    case {'model1', 'model2'}
        data = model_init_data(model_name);
        % 1. Test the effect of inhibitor strength
        inhibitor = [0; 0.5; 0.6; 1.0];
        b = 1-inhibitor;
        num_sim =  length(b);
        res = cell(num_sim,1);
        for i = 1:num_sim
            res{i} = phospho_methyl_model(data, 'b', b(i), 'show_figure', show_figure);
        end;
        title_str = 'Inhibitor Strength';
        legend_str = strcat(num2str(100*inhibitor), '%');
    case 'model3'
        data = model_init_data('model1');
        % 2. The effect of phosphorylation in recruiting kdms and repelling
        % methyltransferase
        a = [0.01 0.01; 0 0.01; 0.01 0];
        num_sim = size(a, 1);
        res = cell(num_sim, 1);
        for i = 1:num_sim
            res{i} = phospho_methyl_model(data, 'a1', a(i, 1), 'a2', a(i,2), ...
                'show_figure', show_figure);
        end
        title_str = 'Phospho Regulates Methyl';
        legend_str = {'WT', 'S10P Not Repels MTs', 'S10P Not Recruits KDMs'};

     case 'model4'
        data = model_init_data(model_name);
        % 1. Test the effect of inhibitor strength
        inhibitor = [0; 0.25; 0.325; 0.5];
        b = 1-inhibitor;
        num_sim =  length(b);
        res = cell(num_sim,1);
        for i = 1:num_sim
            res{i} = phospho_methyl_model(data, 'b', b(i), 'show_figure', show_figure);
        end; 
        title_str = 'Inhibitor Strength';
        legend_str = strcat(num2str(100*inhibitor), '%');
end % switch model_name

% Making plots. 
time = res{1}.time;
num_points = size(time, 1);
index = 1:10:num_points;
methyl = zeros(num_points, num_sim);
for i = 1:num_sim
    methyl(:,i) = res{i}.methylation;
end;
% my_figure('handle', 11, 'font_size', 24, 'line_width', 3); hold on;
% plot(time(index), methyl(index,:), 'LineWidth', 3);
% xlabel('Time (min)'); ylabel('Methylation Level');
% title(title_str);
% legend(legend_str);
% 
my_figure('handle', 12, 'font_size', 24, 'line_width', 3); hold on;
plot(time(index), methyl(index,:)/data.base_methyl, 'LineWidth', 3);
xlabel('Time (min)'); ylabel('Normal. Methyl. Level');
title(title_str);
legend(legend_str);
%
phospho = zeros(num_points, num_sim);
for i = 1:num_sim
    phospho(:,i) = res{i}.phosphorylation;
end;
my_figure('handle', 13, 'font_size', 24, 'line_width', 3); hold on;
plot(time(index), phospho(index,:), 'LineWidth', 3);
xlabel('Time (min)'); ylabel('Phospho Level');
title(title_str);
legend(legend_str);

return;

