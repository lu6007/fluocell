function cc_peak_comparison(type)
switch type,
    case 'FN',
        group_index = [25 22 27];
        group_name = {'FN2.5', 'FN10 ', 'FN20 '};
    case 'Rac FN2.5',        
        group_index = [25 37];
        group_name = {'MEF FN2.5   ', 'RacV12 FN2.5'};
    case 'Rho', %FN10
        group_index = [36 22 39];
        group_name = { 'RhoN19 FN10', 'FN10       ', 'RhoV14 FN10'};
    case 'Rac', %FN10
        group_index = [31 22 30];
        group_name = {'RacN17 FN10', 'FN10       ', 'RacV12 FN10'};
    case 'Integrin'
        % 16G3 MAB LM609 FN10
        group_index = [57 60 59 22];
        group_name = {'Blocking', 'MAB     ', 'LM609   ', 'FN10    '};
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

p = 'D:\sof\fluocell_4.3\app\fa_analysis\';
load(strcat(p, 'results.mat'));

bootstrap_cc_parameter = 1;

% Calculate the CC Max Lag Time, Max Value and their
% corresponding parameters for the box plot.
num_groups = length(group_index);
max_value = cell(num_groups,1);
value_name = {'Time Lag (min)', 'CC Peak'};
perc = [0 25 50 75 100];
max_value_perc = zeros(num_groups, 7,2);
for j = 1:num_groups,
    i = group_index(j);
    cell_index = get_cell_index(group{i});
    dynamic_cell = group{i}.cell(cell_index);
    num_cells = length(cell_index);
    display(sprintf('number of cells = %d', num_cells));
    cc_time = dynamic_cell(1).cc_time;
    cc_peak = cat(2, dynamic_cell.cc_curve);
    [max_cc_peak max_index] = max(abs(cc_peak), [], 1);
    %[max_cc_peak max_index] = max(cc_peak, [], 1);
    max_value{j} = [cc_time(max_index) max_cc_peak']; %note this should not always be positive
    for k =1:2,
        max_value_perc(j,1,k) = mean(max_value{j}(:,k));
        max_value_perc(j,2,k) = std(max_value{j}(:,k))*sqrt(num_cells-1)...
            /(num_cells);
        max_value_perc(j,3:7,k) = prctile(max_value{j}(:,k), perc);
    end;
    clear cell_index dynamic_cell cc_time cc_peak num_cells;
end;

% % Box Error Plots
% for k = 1:2,
%     figure('color', 'w'); hold on; view(2);
%     set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',3 );
%     set(gca, 'XTick', [] );
%     title(value_name{k}); 
%     plot_box_with_error_bar(group_name, max_value_perc(:,1,k), ...
%         max_value_perc(:,2,k), max_value_perc(:,4:6,k));
% end;

% Bootstrap the Confidence Interval of the Smooth Curve and 
% Calculate the CI for the Max CC Value and Max Lag Time.
my_color = get_my_color();
dark_blue = my_color.dark_blue;
light_blue = my_color.light_blue;
for j = 1:num_groups,
    i = group_index(j);
    cell_index = get_cell_index(group{i});
    dynamic_cell = group{i}.cell(cell_index);
    num_cells = length(cell_index);
    all_time = cat(1, dynamic_cell.cc_time);
    all_curve = cat(1, dynamic_cell.cc_curve);
    [sm_time, time_index] = sort(all_time);
    span = 12*num_cells;
    sm_curve = smooth(sm_time, all_curve(time_index), span, 'loess');
    % added two components to the group{i} structure.
    [group{i}.max_cc_value max_index] = max(abs(sm_curve));
    group{i}.max_time_lag = sm_time(max_index);
    sm_residual = all_curve(time_index)-sm_curve;
    num_bootstraps = 200;
    my_mean = @(x) mean(abs(x));
    res_ci = bootci(num_bootstraps, {my_mean, sm_residual},'type', 'per');
    
    figure('Position', [100, 100, 800, 600], 'Color', 'w'); hold on;
    set(gca, 'FontSize', 32, 'Box', 'off', 'LineWidth',4);
    title(group{i}.name);
    ms = 8;
    plot(all_time, all_curve, 'o', 'MarkerSize', ms, ...
        'LineWidth',2, 'Color', light_blue);
    plot(sm_time, sm_curve, 'Color', dark_blue, 'LineWidth',4);
    plot(sm_time, sm_curve-res_ci(2), '--', 'Color', dark_blue, 'LineWidth', 4);
    plot(sm_time, sm_curve+res_ci(2), '--', 'Color', dark_blue, 'LineWidth', 4)
    axis([-30 30 -1.0 1.0]);
    xlabel('Time Lag (min)'); ylabel('Src - Pax Cross Correlation');
    
    if bootstrap_cc_parameter,
        % resample for the max time lag
        % my_max_time() is an inline function that can be used to generate
        % a boostrap sample. 
        my_max_time = @(x) max_time(x, sm_time, sm_curve, span);
        max_time_stat = bootstrp(num_bootstraps, my_max_time, sm_residual);
        display(strcat(group_name{j}, ' : ', 'Mean Max Time = ', ...
            sprintf('%10.4f', mean(max_time_stat))));
        alpha = 0.05;
        max_time_ci = get_confidence_interval(max_time_stat, alpha);
%        max_time_ci= bootci(num_bootstraps, {my_max_time, sm_residual}, ...
%             'type', 'per');
        % Also tried to resample all the variables : time, value, residual
        % together, this seems to reduce the CI for the case MEF FN2.5
        % However it may not be very correct because many samples are 
        % repeatative. So we stick with the resampling of the residual only.
    %     my_max_time = @(x, y, z) max_time(x, y, z, span);
    %     max_time_ci = bootci(num_bootstraps, {my_max_time, sm_residual, ...
    %         sm_time, sm_curve}, 'type', 'cper');


        display(strcat(group_name{j}, ' : ', ' Max Time CI [',  ...
           sprintf('%10.4f %10.4f ]', max_time_ci(1), max_time_ci(2))));
       my_max_value = ...
           @(x) max(smooth(sm_time, sm_curve+x, span, 'loess'));
       max_value_stat = bootstrp(num_bootstraps, my_max_value, sm_residual);
       display(strcat(group_name{j}, ' : ', 'Mean Max Value = ', ...
           sprintf('%10.4f', mean(max_value_stat)))); 
       max_value_ci = get_confidence_interval(max_value_stat, alpha);
%        max_value_ci = bootci(num_bootstraps, ...
%            {my_max_value , sm_residual}, 'type', 'per');
        % 1. The default confidence interval type 'bca' calls the 
        % jacknife function which fails if only the residual was
        % randomized.
        % To fix this problem, the my_max_value
        % function need to be modified to be similar to the max_time function.
        % 2. Another bug with the 'bca' type is that when score is a zero
        % vector, the CI will become [NAN NAN]. An 'if' statement need to be
        % added to set acc =0 when score is zero.
        % 3. There is a bug with the confidence interval type 'cper',
        % The correction confidence interval does not look like 2.5% to 97.5%,
        % instead it looked like 2.5% to 50%.
        % 4. So we decided to use the simple confidence interval type 'per'.
        % 5. The function bootci() with type 'per' does not work well with
        % bootstrap functions with two variables, so I wrote my own
        % version based on bootci.m type 'per'
       display(strcat(group_name{j}, ' : ', ' Max Value CI [', ...
           sprintf('%10.4f %10.4f ]', max_value_ci(1), max_value_ci(2))));
    end 
   
    clear cell_index dynamic_cell all_time all_curve sm_time time_index sm_curve;
    clear sm_residual res_ci max_time_ci max_value_ci max_time_stat max_value_stat;
end;

% Tried multiple comparison and KS test for the CC parameters,
% But they did not seem to be appropriate for this case. 

% % multiple comparison
% data = max_value{1};
% tag = get_tag(max_value{1}(:,1), group_name{1});
% for i = 2: num_groups,
%       temp = [data; max_value{i}]; 
%       clear data; data = temp; clear temp;
%       temp = [tag; get_tag(max_value{i}(:,1), group_name{i})];
%       clear tag; tag = temp; clear temp;
% end;
% for j = 1:2,
%     [p, a, stat] = anova1(data(:,j), tag);
%     [c, m, h, names] = multcompare(stat, 'ctype', 'bonferroni', 'alpha', 0.05);
%     p
%     names
%     clear p a stat c m h names
%     title(value_name{j});
% end;

% %% ks test
% % max_value{i} is a matrix of 2 columns.
% % The first column of max_value{i} represents the time lag
% % of group{i}; the second column represents the max CC
% % value of group{i}.
% col_name = {'Max Time Lag - ', 'Max_CC Value '};
% for i = 1:2,
%     title_str = strcat(col_name{i}, group_name{1}, ...
%         ' - ', group_name{2}, ' : ');
%     display_kstest(max_value{1}(:,i), max_value{2}(:,i),...
%         title_str); clear title_str;
%     title_str = strcat(col_name{i}, group_name{1}, ...
%         ' - ', group_name{3}, ' : ');
%     display_kstest(max_value{1}(:,i), max_value{3}(:,i),...
%         title_str); clear title_str;
%     title_str = strcat(col_name{i}, group_name{2}, ...
%         ' - ', group_name{3}, ' : ');
%     display_kstest(max_value{2}(:,i), max_value{3}(:,i),...
%         title_str); clear title_str;
% end;

% More statistics with the average curve using
% randomize sample to generate a distribution and p-value.
% See fa_statistical_comparison for refs.
for i = 1:num_groups,
    ii = group_index(i);
    cell_index_i = get_cell_index(group{ii});
    dynamic_cell_i = group{ii}.cell(cell_index_i);
    % tranpose and make time sequence in row direction
    % cell sequence in column direction.
    all_time_i = (cat(2, dynamic_cell_i.cc_time))';
    all_curve_i = (cat(2, dynamic_cell_i.cc_curve))';
    a = cat(3, all_time_i, all_curve_i);
    for j = i+1:num_groups,
        jj = group_index(j);
        cell_index_j = get_cell_index(group{jj});
        dynamic_cell_j = group{jj}.cell(cell_index_j);
        all_time_j = (cat(2, dynamic_cell_j.cc_time))';
        all_curve_j = (cat(2, dynamic_cell_j.cc_curve))';
        b = cat(3, all_time_j, all_curve_j);
        M = 5000;
        [a_rand b_rand] = randomize_sample(a,b, M, 'dim', 3);
        %
        t_diff = [group{ii}.max_time_lag-group{jj}.max_time_lag, ...
            group{ii}.max_cc_value-group{jj}.max_cc_value];
        diff = zeros(M,2);   
        for k = 1:M,
            % transpose back so that time sequence in 
            % column direction, 
            % cells sequence in row direction.
            x_matrix = a_rand{k};
            x_time_matrix = x_matrix(:,:,1)';
            x_curve_matrix = x_matrix(:,:,2)';
            [n_rows n_cols] = size(x_time_matrix);
            x_time_vec = reshape(x_time_matrix, n_rows*n_cols, 1);
            x_curve_vec = reshape(x_curve_matrix, n_rows*n_cols,1);
            span = 12*n_rows;
            x_curve_smooth = smooth(x_time_vec, x_curve_vec,span, 'loess');
            [x_curve_max x_index] = max(abs(x_curve_smooth));
            x_time_max = x_time_vec(x_index);
            
            y_matrix = b_rand{k};
            y_time_matrix = y_matrix(:,:,1)';
            y_curve_matrix = y_matrix(:,:,2)';
            [n_rows n_cols] = size(y_time_matrix);
            y_time_vec = reshape(y_time_matrix, n_rows*n_cols, 1);
            y_curve_vec = reshape(y_curve_matrix, n_rows*n_cols, 1);
            y_curve_smooth = smooth(y_time_vec, y_curve_vec, span, 'loess');
            [y_curve_max y_index] = max(abs(y_curve_smooth));
            y_time_max = y_time_vec(y_index);
            
            diff(k,:) = [x_time_max - y_time_max, x_curve_max-y_curve_max];
            clear x_matrix x_time_matrix x_curve_matrix;
            clear x_time_vec x_curve_vec x_curve_smooth;
            clear y_matrix y_time_matrix y_curve_matrix;
            clear y_time_vec y_curve_vec y_curve_smooth;
            
        end;
        p = [get_p_value(diff(:,1), t_diff(1)), ...  
            get_p_value(diff(:,2), t_diff(2))];
        name_str = strcat(group{ii}.name, '-', group{jj}.name, ':');
        display(sprintf('max_time_lag-%s  %d ', name_str, p(1)));
        display(sprintf('max_cc_value-%s %d ', name_str, p(2)));
        display(' ');
        
        clear cell_index_j dynamic_cell_j all_time_j all_curve_j b;
        clear a_rand b_rand diff t_diff;
    end % for j = ii+1:num_groups
    
    clear cell_index_i dynamic_cell_i all_time_i all_curv_i a;
end % for i = 1:num_groups


return;

% calculate the max time of a smooth curve
function max_time = max_time(sm_residual, sm_time, sm_value, span)
    if length(sm_residual)== length(sm_value),
        n = length(sm_residual);
    else
        n = min(length(sm_residual), length(sm_value));
    end;
    y = sm_value(1:n)+sm_residual(1:n);
    sm_y = smooth(sm_time(1:n), y, span, 'loess');
    [max_value max_i] = max(sm_y);
    max_time = sm_time(max_i);
return;

function vec_tag = get_tag(vec, tag_name)
n = size(vec,1);
vec_tag = tag_name;
for i = 1:n-1,
    vec_tag = [tag_name; vec_tag];
end;