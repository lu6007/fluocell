% batch_detect_fa(cell_name, data,varargin);
% Detect the FAs in a video sequence.
% Save the mask of the FA label matrices into files.
% Please be careful on running this file if save_file = 1.
% 
% Parameters:
% parameter_name = {'save_file', 'image_index','has_yfp','need_mask','algorithm', ...
%     'pax_channel'};
% default_value = {[1], data.index,[1],[0],'segmentation', 4};
% 
% Example: 
% cell_name = 'src_pax';
% data = sample_init_data(cell_name, 'batch_detect_fa');
% batch_detect_fa(cell_name, data);
%

% New features:
% 1. Allow reading flexible file names.
% 2. Allow changing num_roi.
% 3. Removed the option of not have yfp files.

% Copyright: Shaoying Lu and Yingxiao Wang 2013
% Email: shaoying.lu@gmail.com
function batch_detect_fa(cell_name, data, varargin)
fprintf('Cell Name : %s\n',cell_name);
parameter_name = {'save_file', 'image_index','need_mask','algorithm', 'show_figure',...
    'protocol'};
if isfield(data,'protocol')
    protocol_default = data.protocol;
else
    protocol_default = 'FRET-Intensity';
end
if isfield(data,'need_mask')
    need_mask_default = data.need_mask;
else
    need_mask_default = 0;
end
default_value = {1, data.index,need_mask_default,'segmentation', 1,...
    protocol_default};
[save_file, image_index,need_mask,algorithm, show_figure, protocol] = ...
    parse_parameter(parameter_name, ...
    default_value, varargin);

if isfield(data, 'num_roi')
    num_roi = data.num_roi;
else
    num_roi = 5;
end

% if need_mask && ~exist(strcat(data.path, 'output\cell_mask'), 'file'),
%     index = sprintf('%03d',image_index{1}(1));
%     file = strcat(path, pax_prefix, index);
%     pax = imread(file);
%     figure; imagesc(pax);
%     cell_mask = roipoly();
%     imwrite(cell_mask, strcat(data.path, 'output\cell_mask'), 'tiff');
% end;

pax_cbound = data.pax_cbound;
fan_file = strcat(data.path, 'output\fan_nodes.mat');

if isfield(data, 'path_all') && iscell(data.path_all)
    multiple_cell_name = 1;
    num_acquisitions = length(data.path_all);
else 
    multiple_cell_name = 0;
    num_acquisitions = 1;
end

if isfield(data,'mask_with_cell')&& data.mask_with_cell==0
    mask_with_cell = 0;
else
    mask_with_cell = 1;
end

for k = 1:num_acquisitions
    if multiple_cell_name
        path = data.path_all{k};
        this_image_index = image_index{k}';
    else
        path = data.path;
        this_image_index = image_index'; 
    end
    data.multiple_cell_name = multiple_cell_name;
    data.this_path = path;
   for i = this_image_index
        % For each time point, detect FAs.
        index = sprintf(data.index_pattern{2},i);
        output_path = strcat(path, 'output/');
        [im, data] = get_image_detect_fa(data, index, protocol);
%         % detect fas
        fa_file = strcat(output_path, 'fa_', index,'.mat');
   
     
        if ~exist(fa_file, 'file')
            if ~mask_with_cell
               [fa_bw, ~, im_filt] = detect_focal_adhesion(im, 'mask_with_cell',mask_with_cell, ...
                   'min_area', data.fa.single_min_area,...
                   'min_water', data.fa.min_water,...
                   'normalize', 0,'need_high_pass_filter', 0);
            else     
               cell_bw = imread(strcat(output_path, 'cell_bw_',index),'tiff');            
               [fa_bw, ~, im_filt] = detect_focal_adhesion(im, 'mask_with_cell',1, ...
                   'cell_bw', cell_bw, 'min_area', data.fa.single_min_area,...
                   'min_water', data.fa.min_water, ...
                   'ref_pax_intensity', data.ref_pax_intensity);
            end
           fa_bd = get_boundary(fa_bw, fa_file);
%            if save_file,
%                 %imwrite(uint16(fa_label), fa_file, 'tiff');
%             end;
        else
             %fa_label = imread(fa_file,'tiff');
             fa_bd = get_boundary([], fa_file, save_file);
        end

        % show figure
        if show_figure
            %pax = medfilt2(pax);
             figure; imagesc(im); caxis(pax_cbound); hold on;
             %figure; imagesc(im_filt); caxis(pax_cbound); hold on;
             set(gca, 'FontSize', 16, 'Box', 'off', 'LineWidth',2); axis off;
             title(strcat('Paxillin image overlayed with boundary and FAs',index));
             if mask_with_cell
                 cell_bw = imread(strcat(output_path, 'cell_bw_',index),'tiff');
                 cell_bd = find_longest_boundary(cell_bw);
                 plot(cell_bd(:,2), cell_bd(:,1),'g', 'LineWidth', 2);
             end
             %bd = label2bd(fa_label);
             %bd = bwboundaries(fa_label, 8, 'nohole');
             bd = fa_bd;
             num_fas = length(bd);
             for j = 1:num_fas
                 plot(bd{j}(:,2), bd{j}(:,1), 'k-', 'LineWidth', 1.5);
             end
             % cell_bw
             if exist('cell_bw','file')
                 [bd_layer, ~] = divide_layer(cell_bw, num_roi, ...
                     'method',2);
                 plot(bd_layer{2}(:,2), bd_layer{2}(:,1), 'w--','LineWidth',2);
             end
             % fan regions
             if isfield(data,'num_fans') && data.num_fans>0
                 [~, fan_bd, c] = get_fan(data.num_fans, im, cell_bw, fan_file,...
                     'draw_figure', 0);
                 for j = 1:length(fan_bd)
                     plot(fan_bd{j}(:,2), fan_bd{j}(:,1), 'b--', 'LineWidth',2);
                 end
                 plot(c(1), c(2), 'r*', 'LineWidth', 2, 'MarkerSize', 6);
             end
        end % show_figure
        clear cfp_file pax_file pax fa_file bd_layer label_layer cell_bw fan_bd bd cell_bd;
        clear im_file;
   end % i, image_index;
end % k, num_acquisitions

beep;
return;

function [im, data] = get_image_detect_fa(data, index, protocol)
if strcmp(protocol, 'FRET-Intensity')
    if data.multiple_cell_name
        first_file = data.first_cfp_file_all{k};
    else
        first_file = data.first_cfp_file;
    end
    cfp_file = regexprep(first_file, data.index_pattern{1}, index);
    cfp_channel = data.cfp_channel;
    pax_channel = data.pax_channel;
    pax_file = regexprep(cfp_file, cfp_channel, pax_channel);
    temp = imread(strcat(data.this_path, pax_file));
    %subtract_background and filter
    [im, data] = preprocess(temp, data); clear temp;
elseif strcmp(protocol, 'Intensity')
    first_file = data.first_file;
    im_file = regexprep(first_file, data.index_pattern{1}, index);
    temp = imread(strcat(data.this_path, im_file));
    [im, data] = preprocess(temp(:,:,1), data); clear temp;
    % Normalize the threshold by the total intensity
    if ~isfield(data,'ref_pax_intensity')
        data.ref_pax_intensity = sum(sum(im));
    end
elseif strcmp(protocol, 'FAK-Pax')
    first_fak_file = strcat('FAK_filt_',data.index_pattern{1},'.tiff');
    fak_file = regexprep(first_fak_file, data.index_pattern{1}, index);
    temp = imread(strcat(data.this_path, fak_file));
    [fak_im, data] = preprocess(temp, data); clear temp;
    pax_file = regexprep(first_fak_file, data.channel{1}, data.channel{2});
    temp = imread(strcat(data.this_path, pax_file));
    [pax_im, data] = preprocess(temp, data); clear temp;
    im = fak_im+data.factor*pax_im;
else
    im = [];
end
return;


