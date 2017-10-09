% function quantify_ratio_multiple_cell_roi(cell_name, data)
% Customized function for Eddie Chung's project.
% The shape of the cell were manually drawn according to DIC image
% QD/FRET ratio was quantified afterward

% Copyright: Shaoying Lu 2013
% kalu@ucsd.edu
function res = quantify_ratio_multiple_cell_roi(exp_name, data)

display(exp_name);
p = data.p;
% donor - FRET donor
first_donor_file = data.first_donor_file;
image_data = data.image;

is_donor_over_fret = data.is_donor_over_fret; 
ratio_bound = data.ratio_bound;
threshold = data.threshold;
filter_size = data.filter_size;
donor_channel = data.donor_channel;
fret_channel = data.fret_channel;
dic_channel = data.dic_channel;
out_file = data.output_file;
intensity_bound = data.intensity_bound;

% if ~exit(output_file, 'file'),

num_images = length(image_data);
total_num_cells= 0;
<<<<<<< HEAD
for i = 1:num_images,
=======
for i = 1:num_images
>>>>>>> current/master
    total_num_cells = total_num_cells + image_data{i}{2};
end
average_ratio = zeros(total_num_cells, 1);
% total intensity normalized to cell area
norm_intensity = zeros(total_num_cells, 1); 
cell_size = zeros(total_num_cells, 1);
num_dots = zeros(total_num_cells,1);
ratio_list = cell(total_num_cells, 1);
intensity_list = cell(total_num_cells, 1);
qd_ratio = cell(total_num_cells, 1);
qd_intensity = cell(total_num_cells, 1);
qd_size = cell(total_num_cells, 1);


%
i_index = 1;
<<<<<<< HEAD
for i = 1:num_images,
=======
for i = 1:num_images
>>>>>>> current/master
    image_index = image_data{i}{1};
    num_cells = image_data{i}{2};

%%
    donor_file = regexprep(first_donor_file, image_data{1}{1}, image_index);
    fret_file = regexprep(donor_file, donor_channel, fret_channel);
    dic_file = regexprep(donor_file, donor_channel, dic_channel);
    qd_file = strcat(p, 'output\qd_bw_', image_index);
    donor = imread(donor_file);
    fret = imread(fret_file);
    dic = imread(dic_file);
%     figure; imagesc(donor);
%     figure; imagesc(fret);
    para.median_filter = 1;
    para.subtract_background = 1;
    [para.bg_bw, para.bg_poly] = get_background(fret, ...
        strcat(p, 'output\background.mat'));
    temp = preprocess(donor, para); clear donor;
    donor = temp; clear temp;
    temp = preprocess(fret, para); clear fret;
    fret = temp; clear temp;
    % figure; imagesc(fret); caxis([0 1000]);
    
    % Calculate the qd_rois
<<<<<<< HEAD
    if is_donor_over_fret,
        ratio = compute_ratio(donor, fret);
    else
        ratio = compute_ratio(fret,donor);
    end;
=======
    if is_donor_over_fret
        ratio = compute_ratio(donor, fret);
    else
        ratio = compute_ratio(fret,donor);
    end
>>>>>>> current/master
    
    % Detect QD dots
    donor_filt = high_pass_filter(donor, filter_size);
    qd_bw = (donor_filt>threshold)&(ratio<100); %figure; imagesc(qd_bw);
<<<<<<< HEAD
    [qd_bd, qd_bw] = get_boundary(qd_bw, qd_file);
=======
    [qd_bd, qd_bw] = get_fa_boundary(qd_bw, qd_file);
>>>>>>> current/master
   
    
    % show QD intensity image 
    figure; imagesc(donor); caxis([1 10000]); colormap gray; hold on;
    % plot the detected QD regions
<<<<<<< HEAD
    for j = 1:length(qd_bd),
        plot(qd_bd{j}(:,2), qd_bd{j}(:,1), 'r', 'LineWidth',2);
    end;
=======
    for j = 1:length(qd_bd)
        plot(qd_bd{j}(:,2), qd_bd{j}(:,1), 'r', 'LineWidth',2);
    end
>>>>>>> current/master
    
    
    % show ratio image
    ratio_im = get_imd_image(ratio, max(donor, fret), ...
        'ratio_bound', ratio_bound, 'intensity_bound', intensity_bound);
    figure; imshow(ratio_im); hold on;
    % plot background region
    plot(para.bg_poly(:,1), para.bg_poly(:,2), 'r', 'LineWidth', 2);
    % plot the detected QD regions
<<<<<<< HEAD
    for j = 1:length(qd_bd),
        plot(qd_bd{j}(:,2), qd_bd{j}(:,1), 'k', 'LineWidth',2);
    end;
=======
    for j = 1:length(qd_bd)
        plot(qd_bd{j}(:,2), qd_bd{j}(:,1), 'k', 'LineWidth',2);
    end
>>>>>>> current/master
    display_text=strcat('Please Select : ',...
        num2str(num_cells), ' Regions of Interest');
    roi_file = strcat(p, 'output\ROI', '_', image_index, '.mat');
    [roi_bw, roi_poly] = get_polygon(dic, roi_file, display_text, ...
        'num_polygons', num_cells);
    % plot the cell regions
<<<<<<< HEAD
    for j = 1:num_cells,
=======
    for j = 1:num_cells
>>>>>>> current/master
        plot(roi_poly{j}(:,1), roi_poly{j}(:,2), 'w', 'LineWidth', 2);
        prop = regionprops(roi_bw{j},'Centroid');
        cc = [prop.Centroid(1); prop.Centroid(2)];
        h=text(cc(1), cc(2), num2str(j));
        set(h, 'Color', 'w','FontSize',12,'FontWeight', 'bold');
        dd = 12; xx = [cc(1)-dd/2; cc(1)+dd; cc(1)+dd; cc(1)-dd/2;cc(1)-dd/2];
        yy = [cc(2)-dd; cc(2)-dd; cc(2)+dd; cc(2)+dd; cc(2)-dd];
        plot(xx,yy, 'w-','LineWidth',2);
        clear prop h;
        % Calculate Cell Size, Average Ratio and Normalized Intensity
        cell_mask = double(roi_bw{j});
        cell_size(i_index) = sum(sum(cell_mask));
        mask = cell_mask.*qd_bw;
        average_ratio(i_index) = sum(sum(ratio.*mask))/sum(sum(mask));
        norm_intensity(i_index) = sum(sum(donor.*mask))/cell_size(i_index);
        % Calculate QD Cluster Size, Average Ratio and Normalized Intensity
        qd_cc = bwconncomp(mask, 4);
        prop = regionprops(mask, 'PixelIdxList');
        pl = prop.PixelIdxList;
        qd_label = labelmatrix(qd_cc);
        pv = qd_label(pl);
        num_dots(i_index) = max(pv);
        %num_dots = max(max(qd_label));
        qd_size{i_index} = zeros(num_dots(i_index), 1);
        qd_intensity{i_index} = zeros(num_dots(i_index), 1);
        qd_ratio{i_index} = zeros(num_dots(i_index), 1);
<<<<<<< HEAD
        for k = 1:num_dots(i_index),
=======
        for k = 1:num_dots(i_index)
>>>>>>> current/master
            pl_k = pl(pv==k);
            num_pl_k = length(pl_k);
            qd_size{i_index}(k) = num_pl_k;
            qd_intensity{i_index}(k) = sum(donor(pl_k))/num_pl_k;
            qd_ratio{i_index}(k) = sum(ratio(pl_k))/num_pl_k;
            clear pl_k num_pl_k;
<<<<<<< HEAD
       end;
=======
        end
>>>>>>> current/master
        
        % Calculate pixelsize Ratio and Intensity
        %prop = regionprops(mask,'PixelIdxList');
        %pl = prop.PixelIdxList;
        ratio_list{i_index} = ratio(pl); 
        intensity_list{i_index} = donor(pl);
        %figure; hist(ratio_list{i_index},100); title('Ratio');
        %figure; hist(intensity_list{i_index}, 100); title('Intensity');
        i_index = i_index+1;
        clear mask cell_mask cc xx yy prop pl;
<<<<<<< HEAD
    end;
    clear roi_poly donor_file fret_file dic_file fret dic;
    
end; %i
=======
    end
    clear roi_poly donor_file fret_file dic_file fret dic;
    
end %i
>>>>>>> current/master
save(out_file, 'cell_size', 'average_ratio', 'norm_intensity', 'num_dots',...
    'ratio_list', 'intensity_list','qd_size','qd_intensity', 'qd_ratio');
clear cell_size average_ratio norm_intensity num_dots;
clear ratio_list intensity_list;
clear qd_size qd_intensity qd_ratio;
% end; % if ~exit(output_file, 'file'),

res = load(out_file);
    
return;
    
    

