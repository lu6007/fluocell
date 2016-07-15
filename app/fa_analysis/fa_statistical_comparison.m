%% Statistically compare the max disassembly among groups.
% function fa_statistical_comparison(type)
% type: 'FN', 'Rac FN2.5', 'Rho', 'Rac', 'Integrin'
function fa_statistical_comparison(type)
switch type,
    case 'FN',
        group_index = [25 22 27];
        group_name = {'FN2.5', 'FN10 ', 'FN20 '};
    case 'Rac FN2.5',        
        group_index = [25 62]; % 53- RacV12 NewMEF FN2.5
        group_name = {'MEF FN2.5   ', 'RacV12 FN2.5'};
    case 'Rho', %FN10
        group_index = [36 22 39];
        group_name = { 'RhoN19 FN10', 'FN10       ', 'RhoV14 FN10'};
    case 'Rac', %FN10
        group_index = [31 22 30];
        group_name = {'RacN17 FN10', 'FN10       ', 'RacV12 FN10'};
%     case 'Integrin'
%         % 16G3   MAB LM609 FN10
%         group_index = [25 57 60 59 22];
%         group_name = {'FN2.5   ', 'Blocking', 'MAB     ', 'LM609   ', 'FN10    '};
    case 'Integrin'
%         % 16G3 MAB LM609 FN10
%         group_index = [57 60 59 22];
%         group_name = {'Blocking', 'MAB     ', 'LM609   ', 'FN10    '};
        % MAB LM609 FN10
        group_index = [60 59 22];
        group_name = {'MAB  ', 'LM609', 'FN10 '};

    case 'KRas Src FN2.5'
        % Lyn-Src and KRas-Src FN2.5
        group_index = [25 66];
        group_name = {'MEF FN2.5     ', 'KRas-Src FN2.5'};
    case 'KRas-Src FN10' % not significantly different
        % Lyn-Src and KRas-Src FN10
        group_index = [22 67];
        group_name = {'Lyn-Src FN10 ', 'KRas-Src FN10'};
    case 'Lyn-FAK FN2.5',
        group_index = [25 77];% 67];
        group_name = {'Lyn-Src FN2.5 ', 'Lyn-FAK FN2.5 '};% 'KRas-Src FN2.5'};
    case 'Lyn-FAK FN10',
        group_index = [22 78];
        group_name = {'Lyn-Src FN10', 'Lyn-FAK FN10'};
    case 'Lyn-FAK FN20',
        group_index = [27 79];
        group_name = {'Lyn-Src FN20', 'Lyn-FAK FN20'};
end

path = 'E:\sof\fluocell_3.1\src\test\fa_analysis\';
load(strcat(path, 'results.mat'));

% Make Box plots
num_groups = length(group_index);
max_value = cell(num_groups, 1); 
value_name = {'Max Activation', 'Max Disassembly'};
perc = [0 25 50 75 100];
% 7 colums: 1- mean, 2-std err, 3- 0%, 4-25%, 5-50%, 6-75%, 7-100%.
max_value_perc = zeros(num_groups, 7, 2);
for i = 1:num_groups,
    index = group_index(i);
    temp = [group{index}.max_ratio-1 group{index}.max_disassembly];
    max_value{i} = temp; clear temp;
    for j = 1:2,       
         max_value_perc(i, 1, j) = mean(max_value{i}(:,j));
         %max_value_perc(i,2,j) = std(max_value{i}(:,j)); std
         max_value_perc(i,2,j) = std(max_value{i}(:,j))/sqrt(group{index}.num_cells); %sem
         max_value_perc(i, 3:7, j) = prctile(max_value{i}(:,j), perc);
    end;
end;

for j = 1:2,
    figure('color', 'w'); hold on; view(2);
    set(gca, 'FontSize', 32, 'FontWeight', 'bold','Box', 'off', 'LineWidth',4 );
    set(gca, 'XTick', [] );
    set(gca, 'XLim', [0.3 num_groups+0.5]);
    title(value_name{j}); 
    plot_box_with_error_bar(group_name, max_value_perc(:,1,j), ...
        max_value_perc(:,2,j), max_value_perc(:,4:6,j));
end;

% Make Wisker Plots
for j = 1:2,
    h(j) = figure('Color', 'w'); hold on;
    set(gca, 'FontSize', 12, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth',1.5);
    title(value_name{j});
end;
for i = 1:num_groups,
    for j = 1:2,
        figure(h(j));
        T=bplot(max_value{i}(:,j), i, 'whiskers', 10,'LineWidth', 1.5, 'nomean'); 
    end;
end;
for j = 1:2,
    figure(h(j));
    legend (T, 'location', 'eastoutside');
end;


% multiple comparison
data = max_value{1};
tag = get_tag(max_value{1}(:,1), group_name{1});
for i = 2: num_groups,
      temp = [data; max_value{i}]; 
      clear data; data = temp; clear temp;
      temp = [tag; get_tag(max_value{i}(:,1), group_name{i})];
      clear tag; tag = temp; clear temp;
end;
for j = 1:2,
    [p, a, stat] = anova1(data(:,j), tag, 'off');
    figure;
    [c, m, h, names] = multcompare(stat, 'ctype', 'bonferroni', 'alpha', 0.05);
    % p
    % names
    clear p a stat c m h names
    title(value_name{j});
end;

%calculate correlation coefficient and slope
for i = 1:num_groups,
    ii = group_index(i);
    group{ii}.corr_coef = corr(group{ii}.max_ratio-1,...
        group{ii}.max_disassembly);
%     xx = [ones(size(group{ii}.max_ratio)), group{ii}.max_ratio-1];
%     yy = group{ii}.max_disassembly;
%     beta = regress(yy, xx);
%     group{ii}.slope = beta(2);
    group{ii}.slope = get_slope(group{ii}.max_ratio-1, ...
        group{ii}.max_disassembly);
    clear xx yy;
end;

% display test results
% statistical interference
% (1) obtain M * random samples of X and Y
% (2) calculate the M * corr_coef and slope
% (3) Find the percentile p of the orginal corr_coef and slope
% in this M randomized corr_coef and slopes
% (4) p-value = p
% Ref: Manly BFJ Chapman & Hall 1997,
% Randomization, Bootstrap and Monte Carlo Methods in Biology
% (2nd ed.).

for i = 1:num_groups,
    ii = group_index(i);
    for j = i+1:num_groups,
        name_str = strcat(group_name{i}, '-', group_name{j}, ':');
        jj = group_index(j);
%         display_ttest(group{ii}.max_ratio, group{jj}.max_ratio,...
%             strcat('Max Ratio-', name_str));
%         display_ttest(group{ii}.max_disassembly, group{jj}.max_disassembly,...
%             strcat('Max Disassembly-', name_str));
        display_kstest(group{ii}.max_ratio, group{jj}.max_ratio,...
            strcat('Max Ratio-', name_str));
        display_kstest(group{ii}.max_disassembly, group{jj}.max_disassembly,...
            strcat('Max Disassembly-', name_str));

        % 
        a= [group{ii}.max_ratio-1 group{ii}.max_disassembly];
        b = [group{jj}.max_ratio-1 group{jj}.max_disassembly];
        M = 5000;
        [a_rand b_rand] = randomize_sample(a, b, M);
        % correlation coefficient (R)
        t_diff = group{ii}.corr_coef-group{jj}.corr_coef;
        corr_diff = zeros(M,1);
        for k = 1:M,
            corr_diff(k) = corr(a_rand{k}(:,1), a_rand{k}(:,2)) - ...
                corr(b_rand{k}(:,1), b_rand{k}(:,2));
        end;
        p = get_p_value(corr_diff, t_diff);
        display(sprintf('Corr Coef (R) - %s %d', name_str, p));
%         % Coefficient of determination (R-Square)
%         t_diff = (group{ii}.corr_coef)^2-(group{jj}.corr_coef)^2;
%         coef_diff = zeros(M,1);
%         for k = 1:M,
%             coef_diff(k) = (corr(a_rand{k}(:,1), a_rand{k}(:,2)))^2 - ...
%                 (corr(b_rand{k}(:,1), b_rand{k}(:,2)))^2;
%         end;
%         p = get_p_value(coef_diff, t_diff);
%         display(sprintf('Coef Det (R-Square) - %s %d', name_str, p));
        % slope
        t_diff = group{ii}.slope - group{jj}.slope;
        slope_diff = zeros(M,1);
        for k = 1:M,
            slope_diff(k) = get_slope(a_rand{k}(:,1), a_rand{k}(:,2)) - ...
                get_slope(b_rand{k}(:,1), b_rand{k}(:,2));
        end;
        p = get_p_value(slope_diff, t_diff);
        display(sprintf('Slope - %s %d', name_str, p));
%         display_ttest(group{ii}.corr_coef_stat(1:n1),...
%             group{jj}.corr_coef_stat(1:n2), strcat('Corr Coef-',name_str));
%         display_ttest(group{ii}.slope_stat(1:n1), group{jj}.slope_stat(1:n2), ...
%             strcat('Slope-',name_str));
        display(' ');
        
        
        
        clear name_str corr_diff coef_diff slope_diff;
    end;
end;
return;

function display_ttest(v1, v2, str)
n1 = length(v1); n2 = length(v2);
[h p] = ttest2(v1,v2);
display(strcat(str, num2str(h),', ', num2str(p), ', ', num2str(n1), ', ', num2str(n2)));
return;




% calculate slope by linear regression
function slope = get_slope(x, y)
    xx = [ones(size(x)), x];
    yy = y;
    beta = regress(yy, xx);
    slope = beta(2);
return;




