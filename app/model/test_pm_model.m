% function test_pm_model(test_name, varargin)
% parameter_name = {'show_figure'};
% default_value = {0};
% For Figs. 4B and 4C, 
% >> data = model_init_data('model4');
% >> res = phospho_methyl_model(data, 'b',1, 'show_figure', 1);
% For Fig. 4D, >> test_pm_model('test4');
% For Fig. 4E, >> test_pm_model('test2');
% For Fig. 4F, >> test_pm_model('test3');
% For a simple run >> res=test_pm_model('test5');
function res = test_pm_model(test_name, varargin)
parameter_name = {'show_figure'};
default_value = {0};
show_figure = parse_parameter(parameter_name, default_value, varargin);

% Recruit Model, the effect of triggering Molecule/histone ratio
% Recruit: phosphorylation recruits KDMS
% No Recruit: phosphorylation does not recruit KDMS

switch test_name
    case 'test1'
        data = model_init_data('model1');
        % 1. Test the effect of inhibitor strength
        inhibitor = [0; 0.5; 0.6; 1.0];
        b = 1-inhibitor;
        num_sim =  length(b);
        res = cell(num_sim,1);
        for i = 1:num_sim
            res{i} = phospho_methyl_model(data, 'b', b(i), 'show_figure', show_figure);
        end
        title_str = 'Inhibitor Strength';
        legend_str = strcat(num2str(100*inhibitor), '%');
    case 'test2'
        data = model_init_data('model2');
        % 3. Test the effect of methyltransferase inhibitor
        inhibitor = [0; 0.35; 0.45; 0.5];
        b = 1-inhibitor;
        num_sim =  length(b);
        res = cell(num_sim,1);
        for i = 1:num_sim
            res{i} = phospho_methyl_model(data, 'b', b(i), 'show_figure', show_figure, ...
                'methyl_ko', 1);
        end
        title_str = 'No Methyltransferase at State 1';
        legend_str = strcat(num2str(100*inhibitor), '%');
    case 'test3'
        data = model_init_data('model2');
        % 2. The effect of phosphorylation in recruiting kdms and repelling
        % methyltransferase
        a = [0.005 0.005; 0 0.005; 0.005 0; 0 0];
        num_sim = size(a, 1);
        res = cell(num_sim, 1);
        for i = 1:num_sim
            res{i} = phospho_methyl_model(data, 'a1', a(i, 1), 'a2', a(i,2), ...
                'show_figure', show_figure);
        end
        title_str = 'Phospho Regulates Methyl';
        legend_str = {'WT', '-MT', '-KDM', '-/-'};

     case 'test4'
        data = model_init_data('model2');
        % 1. Test the effect of phosphorylation inhibitor strength
        inhibitor = [0; 0.35; 0.45; 0.5]; %0.425; 0.5];
        % inhibitor = [0; 0.45; 0.475; 0.5]; 
        b = 1-inhibitor;
        num_sim =  length(b);
        res = cell(num_sim,1);
        for i = 1:num_sim
            res{i} = phospho_methyl_model(data, 'b', b(i), 'show_figure', show_figure);
        end
        title_str = 'Inhibitor Strength';
        legend_str = strcat(num2str(100*inhibitor), '%');
        
      case 'test5'
        data = model_init_data('model2');
        % 0. Run the original model
        inhibitor = 0;
        b = 1-inhibitor; 
        num_sim = length(b);
        %res{1} = phospho_methyl_model(data, 'b', data.b, 'show_figure', show_figure);
        res{1} = phospho_methyl_model(data, 'b', b(1), 'show_figure', show_figure,...
            'methyl_ko', 0);
        title_str = 'Phosphor-methyl Model';
        legend_str = 'Simple Model';

end % switch model_name

% Making plots. 
time = res{1}.time;
num_point = size(time, 1);
index = 1:10:num_point;
methyl = zeros(num_point, num_sim);
for i = 1:num_sim
    methyl(:,i) = res{i}.methylation;
end

my_figure('handle', 12, 'font_size', 24, 'line_width', 3); hold on;
plot(time(index), methyl(index,:)/data.base_methyl, 'LineWidth', 3);
xlabel('Time (min)'); ylabel('Normal. Methyl. Level');
title(title_str);
legend(legend_str);
%
if strcmp(test_name, 'test4') || strcmp(test_name, 'test5')
    phospho = zeros(num_point, num_sim);
    for i = 1:num_sim
        phospho(:,i) = res{i}.phosphorylation;
    end
    my_figure('handle', 13, 'font_size', 24, 'line_width', 3); hold on;
    plot(time(index), phospho(index,:), 'LineWidth', 3);
    xlabel('Time (min)'); ylabel('Phospho Level');
    title(title_str);
    legend(legend_str);
end 
return;

