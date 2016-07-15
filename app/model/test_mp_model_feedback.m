% test_mp_model
my_color = get_my_color();

%% Feedback Model, the effect of triggering KDMS/histone ratio
data = model_init_data('with_feedback');
nk = [1; 2; 5; 10; 25; 50; 100];
%nk = [1; 2; 5; 10; 25; 50; 100; 150; 200];
num_sims = length(nk);
res = cell(num_sims,1);
for i = 1:num_sims,
    res{i} = methyl_phospho_model(data, 'num_kdms', nk(i));
end;
time = res{1}.time;
num_points = size(time, 1);
index = 1:10:num_points;
methyl = zeros(num_points, num_sims);
for i = 1:num_sims,
    methyl(:,i) = res{i}.methylation;
end;
my_figure('handle', 11, 'font_size', 24, 'line_width', 3); hold on;
plot(time(index), methyl(index,:), 'LineWidth', 3);
xlabel('Time (min)'); ylabel('Methylation Level');
title('Feedback Model: Triggering KDMS/Histone Ratio');
legend(strcat(num2str(nk), 'K:6M'));

%% No Feedback, the effect of triggering KDMS/histone ratio
data = model_init_data('no_feedback');
% nk = [60; 80; 100; 120; 140];
nk = [3; 4; 5; 10; 25; 50; 100];
num_sims = length(nk);
res = cell(num_sims,1);
for i = 1:num_sims,
    res{i} = methyl_phospho_model(data, 'num_kdms', nk(i));
end;
time = res{1}.time;
num_points = size(time, 1);
index = 1:10:num_points;
methyl = zeros(num_points, num_sims);
for i = 1:num_sims,
    methyl(:,i) = res{i}.methylation;
end;

my_figure('handle', 13, 'font_size', 24, 'line_width', 3); hold on;
plot(time(index), methyl(index,:), 'LineWidth', 3);
xlabel('Time (min)'); ylabel('Methylation Level');
title('No Feedback: Triggering KDMS/Histone Ratio');
legend(strcat(num2str(nk), 'K:6M'));

% %% Feedback Model, the effect of max KDMS/histone ratio
% data = model_init_data('with_feedback');
% mk = [100; 200; 400];
% num_sims = length(mk);
% res = cell(num_sims,1);
% for i = 1:num_sims,
%     res{i} = methyl_phospho_model(data, 'max_kdms', mk(i),'num_kdms', 100);
% end;
% time = res{1}.time;
% methyl = zeros(size(time, 1), num_sims);
% for i = 1:num_sims,
%     methyl(:,i) = res{i}.methylation;
% end;
% 
% my_figure('handle', 12, 'font_size', 24, 'line_width', 3); hold on;
% plot(time, methyl, 'LineWidth', 3);
% xlabel('Time (min)'); ylabel('Methylation Level');
% title('Feedback Model: Max KDMS/Histone Ratio');
% legend(strcat(num2str(mk), 'K:6M'));
% 
% %% No Feedback, the effect of max KDMS/histone ratio
% data = model_init_data('no_feedback');
% mk = [100; 200; 400];
% num_sims = length(mk);
% res = cell(num_sims,1);
% for i = 1:num_sims,
%     res{i} = methyl_phospho_model(data, 'max_kdms', mk(i));
% end;
% time = res{1}.time;
% methyl = zeros(size(time, 1), num_sims);
% for i = 1:num_sims,
%     methyl(:,i) = res{i}.methylation;
% end;
% 
% my_figure('handle', 14, 'font_size', 24, 'line_width', 3); hold on;
% plot(time, methyl, 'LineWidth', 3);
% xlabel('Time (min)'); ylabel('Methylation Level');
% title('No Feedback: Max KDMS/Histone Ratio');
% legend(strcat(num2str(mk), 'K:6M'));


%% Feedback Model, the effect of a1
data = model_init_data('with_feedback');
a1 = [0.2; 0.1; 0.05; 0.04; 0.03; 0.025; 0.02; 0.01; 0];
num_sims = length(a1);
res = cell(num_sims,1);
for i = 1:num_sims,
    res{i} = methyl_phospho_model(data, 'a1', a1(i),'num_kdms', 20);
end;
time = res{1}.time;
methyl = zeros(size(time, 1), num_sims);
for i = 1:num_sims,
    methyl(:,i) = res{i}.methylation;
end;

my_figure('handle', 16, 'font_size', 24, 'line_width', 3); hold on;
plot(time, methyl, 'LineWidth', 3);
xlabel('Time (min)'); ylabel('Methylation Level');
title('Feedback Model: a1');
legend(strcat('a1=', num2str(a1)));
