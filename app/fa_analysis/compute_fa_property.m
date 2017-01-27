%% Load the label matrices
% Compute the average intensity of the pixels inside FAs.
% Compute the average FRET of the pixels inside FAs.
% Compute the average FRET of the pixels outside of FAs.
% function compute_fa_property(cell_name, varargin)
% cell_name = 'fakpax1';
%cell_name = '07_14_dish1';
% cell_name = '07_05_dish2';
% 
% Parameters:
% parameter_names = {'cfp_channel','yfp_channel','pax_channel'};
% default_values = {1,2,4};
%

% Copyright: Shaoying Lu and Yingxiao Wang 2011


function compute_fa_property(cell_name, data, varargin)
parameter_name = {'cfp_channel','yfp_channel','pax_channel', 'num_layers',...
    'save_file', 'remove_data'};
default_value = {1,2,4, 5, 1, 0};
[cfp_channel_input, yfp_channel_input, pax_channel_input, num_layers, ...
    save_file, remove_data] ...
= parse_parameter(parameter_name, ...
    default_value, varargin);

%data = init_data(cell_name);
result_file = strcat(data.path, 'output\result.mat');
if remove_data && exist(result_file, 'file')
    delete(result_file);
end;

%data = init_data(cell_name);
path = data.path;

image_index = data.index;
shift = 1.0e-4;
if isfield(data, 'num_layers'),
    num_layers = data.num_layers;
else
    num_layers = 5;
end;

if isfield(data, 'path_all') && iscell(data.path_all),
    multiple_cell_name = 1;
    num_acquisitions = length(data.path_all);
    num_images = max(image_index{1});
else 
    multiple_cell_name = 0;
    num_acquisitions = 1;
    num_images = max(image_index);
end;

if ~exist(result_file, 'file')

    for k = 2:num_acquisitions
        num_images = num_images+max(image_index{k});
    end;
    cell_bw = cell(num_images, 1);
    fa_labels = cell(num_images, 1);
    ratio_in_fa = zeros(num_images, 1);
    ratio_out_fa = zeros(num_images, 1);
    num_fas = zeros(num_images,1);
    total_intensity_fa = zeros(num_images, 1);
    average_intensity_fa = zeros(num_images,1);
    total_pixel_fa = zeros(num_images, 1);
    average_pixel_fa = zeros(num_images, 1);
    total_pax_intensity = zeros(num_images, 1);
    average_pax_intensity = zeros(num_images, 1);
    portion_pixel_fa = zeros(num_images,1);
    time =zeros(num_images, 1);
    
    cfp_channel = data.cfp_channel;
    yfp_channel = data.yfp_channel;
    pax_channel = data.pax_channel;
    ii = 0; % frame index
    for k = 1:num_acquisitions
        if multiple_cell_name
            path = data.path_all{k};
            first_cfp_file = data.first_cfp_file_all{k};
            this_image_index = image_index{k};
            output_path = strcat(data.path_all{1}, 'output/');
        else
            path = data.path;
            first_cfp_file = data.first_cfp_file;
            this_image_index = image_index;
            output_path = strcat(data.path, 'output/');
        end;
%         % get the pdgf time
%         if k ==2,
%             i = 1;
%             index = sprintf(data.index_pattern{2},i);
%             cfp_file = regexprep(first_cfp_file, data.index_pattern{1}, index);
%             pax_file = regexprep(cfp_file, cfp_channel, pax_channel);
%             this_time = get_time(strcat(data.path_all{k}, pax_file),'method',2);
%             pdgf_time = 0.5*(time(ii)+this_time);
%             clear index cfp_file pax_file;
%         end;
        % loop through the images, computing the ratio and intensity.
        %tic;
        %matlabpool open local 2;
       for kk = 1:length(this_image_index), % parfor for parallel for loop
            i = this_image_index(kk);
            %ii = ii+1;
             index = sprintf(data.index_pattern{2},i);
            cfp_file = regexprep(first_cfp_file, data.index_pattern{1}, index);
            yfp_file = regexprep(cfp_file, cfp_channel, yfp_channel);
            pax_file = regexprep(cfp_file, cfp_channel, pax_channel);
            pax = imread(strcat(path, pax_file));
            % subtract_background and filter
            if ~isfield(data, 'bg_bw'),
                data.bg_bw = get_background(pax, strcat(output_path, 'background.mat'));
            end;
            temp = subtract_background(pax, data.bg_bw, 'method', 3); clear pax;
            pax = medfilt2(temp); clear temp;
            cfp = imread(strcat(path, cfp_file));
            temp = subtract_background(cfp, data.bg_bw, 'method', 3); clear cfp;
            cfp = medfilt2(temp); clear temp;
            yfp = imread(strcat(path, yfp_file));
            temp = subtract_background(yfp, data.bg_bw, 'method', 3); clear yfp;
            yfp = medfilt2(temp); clear temp;

            % cell_bw;
            file = strcat(output_path, 'cell_bw.', index, '.mat');
%             cell_bw_ii = imread(strcat(output_path, 'cell_bw.',index),'tiff');
            % Backward compatible
            if exist(file, 'file'), 
                temp_cell_bw = load([output_path, 'cell_bw.',index, '.mat']);
                cell_bw_ii = temp_cell_bw.cell_bw;
            else
                 cell_bw_ii = imread(strcat(output_path, 'cell_bw.',index),'tiff');
            end;
            clear old_cell_bw; old_cell_bw{1} = uint16(cell_bw_ii);           
            % Take the out-most layer and quantify there.
            %[bd_layer, label_layer] = divide_layer(old_cell_bw, num_layers);
            [bd_layer, label_layer] = divide_layer(old_cell_bw, num_layers, ...
            'method', 2);

            cell_bw{i} = (label_layer{1}==1); 
            % mask with fans
            if isfield(data,'num_fans'),
                if data.num_fans>0,
                fan_bw = get_fan(data.num_fans, pax, old_cell_bw,...
                    strcat(output_path,'fan_nodes.mat'),'draw_figure',0);
                cell_bw{i} = cell_bw{i}.*double(fan_bw);
                clear fan_bw;
                end;
            end;
            
            % fa_labels
            temp = load(strcat(output_path, 'fa_', index, '.mat'));
            fa_labels_i = temp.fa_bw; clear temp;
            fa_labels{i} = double(fa_labels_i).*double(cell_bw{i});

            % Ratio
            if isfield(data, 'is_cfp_over_fret')&& ~data.is_cfp_over_fret,
                temp = compute_ratio(yfp, cfp);
            else
                temp = compute_ratio(cfp, yfp);
            end
            ratio_im = medfilt2(temp, [3 3]); clear temp;
            in_fa_mask = double(fa_labels{i}>0);
            out_fa_mask = double(cell_bw{i}&(fa_labels{i}==0));
            total_pixel_fa(i) = sum(sum(in_fa_mask));
            ratio_in_fa(i) = sum(sum(ratio_im.*in_fa_mask)/total_pixel_fa(i));
            sum_sum_out_fa_mask = sum(sum(out_fa_mask));
            ratio_out_fa(i) =sum(sum(ratio_im.*out_fa_mask)/sum_sum_out_fa_mask);
            fa_props =regionprops(fa_labels{i}, 'Area');
            num_fas(i) = length(fa_props);
            temp = zeros(num_fas(i),1);
            for j = 1:num_fas(i),
                temp(j) = fa_props(j).Area;
            end;
            %total_pixel_fa(ii) = sum(temp); 
            average_pixel_fa(i) = sum(temp)/num_fas(i);
            clear temp;
            average_intensity_fa(i) = sum(sum(double(pax).*in_fa_mask)/total_pixel_fa(i));
            total_pax_intensity(i) = sum(sum(double(pax).*double(old_cell_bw{1})));
            average_pax_intensity(i) = total_pax_intensity(i)/sum(sum(double(old_cell_bw{1})));
            total_intensity_fa(i) = sum(sum(double(pax).*in_fa_mask));
            portion_pixel_fa(i) = total_pixel_fa(i)/sum(sum(cell_bw{i}));
            
            time(i) = get_time_2(strcat(path, pax_file));
    
            clear cfp_file yfp_file pax_file cfp yfp pax cell_bw_ii bd_layer label_layer 
            clear fa_props in_fa_mask out_fa_mask index 
        end; % i image index
        %matlabpool close;
        %toc;
        clear path first_cfp_file this_image_index
    end; % k num_acquisitions
    time_ba = zeros(2,1);
    for j = 1:2
        if multiple_cell_name,
            k = data.pdgf_between_frame(j, 1);
            i = data.pdgf_between_frame(j,2);
            index = sprintf(data.index_pattern{2},i);
            cfp_file = regexprep(data.first_cfp_file_all{k}, data.index_pattern{1}, index);
            pax_file = regexprep(cfp_file, cfp_channel, pax_channel);
            pax_file = strcat(data.path_all{k}, pax_file);
        else 
            k = data.pdgf_between_frame(1);
            i = data.pdgf_between_frame(2);
            index = sprintf(data.index_pattern{2},i);
            cfp_file = regexprep(data.first_cfp_file, data.index_pattern{1}, index);
            pax_file = regexprep(cfp_file, cfp_channel, pax_channel);
            pax_file = strcat(data.path, pax_file);
        end;
        time_ba(j) = get_time(pax_file,'method',2);
        clear index cfp_file pax_file info;
        
        pdgf_time = 0.5*(time_ba(1)+time_ba(2));
    end;

    if save_file
        index = data.index;
        save(result_file, 'time', 'ratio_in_fa', 'ratio_out_fa', ...
            'average_intensity_fa', 'total_pax_intensity', 'total_intensity_fa',...
            'portion_pixel_fa', 'pdgf_time');
    end;
else % if exist result_file
    load(result_file);
end; % if exist result_file

% remove some nodes
if multiple_cell_name
    all_index = cell2mat(data.index);
    % something wrong here with multiple index.
else
    all_index = data.index;
end;
temp = ratio_in_fa(all_index); clear ratio_in_fa; ratio_in_fa = temp; clear temp;
temp = ratio_out_fa(all_index); clear ratio_out_fa; ratio_out_fa = temp; clear temp;
temp = average_intensity_fa(all_index); clear average_intensity_fa;
average_intensity_fa = temp; clear temp;
temp = total_pax_intensity(all_index); clear total_pax_intensity;
total_pax_intensity = temp; clear temp;
temp = total_intensity_fa(all_index); clear total_intensity_fa; 
total_intensity_fa = temp; clear temp;
temp =  portion_pixel_fa(all_index); clear portion_pixel_fa;
portion_pixel_fa = temp; clear temp;

if isfield(data, 'shift')
    n = length(average_intensity_fa);
    for i = 1:length(data.shift)
        j = find(data.index ==data.shift(i));
        if has_fret
            ratio_in_fa(j-1:n) = fix_shift (ratio_in_fa(j-1:n));
            ratio_out_fa(j-1:n) = fix_shift(ratio_out_fa(j-1:n));
        end;
        total_pax_intensity(j-1:n) = fix_shift(total_pax_intensity(j-1:n));
        average_intensity_fa(j-1:n) = fix_shift(average_intensity_fa(j-1:n));
        total_intensity_fa(j-1:n) = fix_shift(total_intensity_fa(j-1:n));
        portion_pixel_fa(j-1:n) = fix_shift(portion_pixel_fa(j-1:n));
    end;
end;

h =figure; hold on;
set(gca, 'FontSize', 16, 'Box', 'off', 'LineWidth',2 );
plot(all_index,ratio_in_fa/ratio_in_fa(1), 'r-','LineWidth',2);
plot(all_index, ratio_out_fa/ratio_in_fa(1), 'r--', 'LineWidth',2);
total_intensity_fa = total_intensity_fa./total_pax_intensity;
plot(all_index, total_intensity_fa/total_intensity_fa(1),'g','LineWidth',2);
plot(total_pax_intensity/total_pax_intensity(1), 'k', 'LineWidth',2);
plot(all_index,all_index/100+1,'k--', 'LineWidth',1);
legend('Ratio in FA', 'Ratio out FA', 'Norm. Total FA Intensity',...
    'Norm. Total Pax Intensity', 'Frame Number');
title(strcat(strrep(cell_name,'_','\_'), ' FA Layers\_', num2str(num_layers), '\_1'));
axis([1 60 0 2]);

return;

function v = fix_shift(v)
n = length(v);
v(2:n) = v(2:n)-(v(2)-v(1));
return;

