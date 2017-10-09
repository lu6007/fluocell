% Does not require the function to be run in the same directory as the data

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function draw_cell_with_detected_fa(h, i, info)
rfp_channel = info.channel;
rfp_file = regexprep(info.first_file, info.channel_pattern{1},...
    info.channel_pattern{rfp_channel});
index_pattern = sprintf(info.index_pattern{2}, i);
rfp_file = regexprep(rfp_file, info.index_pattern{1}, index_pattern);
rfp_im = imread(strcat(info.path,rfp_file)); temp = medfilt2(rfp_im);
clear rfp_im; rfp_im = temp; clear temp;
<<<<<<< HEAD
cell_bw_file = sprintf('%scell_bw.%s', info.path,index_pattern);
=======
cell_bw_file = sprintf('%scell_bw_%s', info.path,index_pattern);
>>>>>>> current/master
cell_bw = imread(cell_bw_file);
fa_label_file = sprintf('%sfa_label_water.%s', info.path, index_pattern);
fa_label = imread(fa_label_file);
figure(h); imagesc(rfp_im); caxis(info.cbound); hold on;
set(gca, 'FontSize', 14, 'FontWeight', 'bold', ...
    'Box', 'off', 'LineWidth',2); axis off;
cell_bd = find_longest_boundary(cell_bw);
plot(cell_bd(:,2), cell_bd(:,1), 'g','LineWidth',2);
bd = label2bd(fa_label);
num_fas = length(bd);
for j = 1:num_fas,
    plot(bd{j}(:,2), bd{j}(:,1), 'k', 'LineWidth', 1.5);
end;

% draw an indication of the outer layer. 
if info.has_layer,
    [bd_layer, ~] = divide_layer(cell_bw, 5, 'method',2);
    plot(bd_layer{2}(:,2), bd_layer{2}(:,1), 'w--', 'LineWidth', 2);
end;
% draw a indication of the fan region.
if info.num_fans,
    [~, fan_bd, c] = get_fan(movie_info.num_fans, rfp_im, cell_bw,...
        'fan_nodes.mat', 'draw_figure', 0);
    for j = 1:length(fan_bd),
        plot(fan_bd{j}(:,2), fan_bd{j}(:,1), 'b--', 'LineWidth',2);
    end;
    plot(c(1), c(2), 'r*', 'LineWidth', 2, 'MarkerSize', 6);
end;
return;