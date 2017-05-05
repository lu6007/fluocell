% batch_detect_cell(cell_name, data, varargin);
% Detect the cell boundaries in a video sequence.
% Save the masks of the cells into files.
% Please be aware the old data will be overwritten if this function is
% running with the option: save_file = 1.
%
% Parameters: 
% level 1 priority - command line input 
% level 2 priority - data input
% level 3 priority - default values in the function
% parameter_name = {'save_file', 'image_index','need_mask', 'cbound','protocol'};
% default_value = {1, image_index_default,need_mask_default, [0 10000],protocol_default};
%
% Examaple:
% >> cell_name = 'src_pax';
% >> data = sample_init_data('cell_name');
% >> batch_detect_cell(cell_name, data,'save_file',1);

% Copyright: Shaoying Lu and Yingxiao Wang 2013 
% Email: shaoying.lu@gmail.com

function batch_detect_cell(cell_name, data, varargin)

fprintf('Cell Name : %s\n',cell_name);

% level 1 priority - command line input 
% level 2 priority - data input
% level 3 priority - default values in the function
parameter_name = {'save_file', 'image_index','need_mask', 'cbound','protocol'};
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
if isfield(data, 'index')
    image_index_default = data.index;
else
    image_index_default = 1;
end
default_value = {1, image_index_default,need_mask_default, [0 10000],protocol_default};
[save_file, image_index,need_mask, cbound, protocol] =...
    parse_parameter(parameter_name, default_value, varargin);

if isfield(data, 'path_all') && iscell(data.path_all)
    multiple_cell_name = 1;
    num_acquisitions = length(data.path_all);
else 
    multiple_cell_name = 0;
    num_acquisitions = 1;
end

for k = 1:num_acquisitions
    if multiple_cell_name
        path = data.path_all{k};
        this_image_index = image_index{k}';
    else
        path = data.path;
        this_image_index = image_index';
    end
    output_path = strcat(path, 'output/');
    if ~exist(output_path, 'dir')
        mkdir(output_path);
    end
    
    data.multiple_cell_name = multiple_cell_name;
    data.this_path = path;
    for i = this_image_index
        index = sprintf(data.index_pattern{2},i);
        output_file = strcat(output_path, 'cell_bw.', index);
        data.multiple_cell_name = multiple_cell_name;
        [im, data] = get_image_detect_cell(data,index,protocol);
        if ~exist(output_file, 'file')% when the output is not there.
            if need_mask
                cell_mask_file = strcat(data.path, 'output\mask.mat');
                cell_mask = get_background(uint16(im), cell_mask_file);
                temp = double(im).*double(cell_mask); clear im;
                im = temp; clear temp;
                clear cell_mask cell_mask_file;
            end
            if ~isfield(data,'ref_pax_intensity')
                data.ref_pax_intensity =sum(sum(im)); % require the 1st image in the index to be 001
                th = data.threshold;
            else
                th = data.threshold*(double(sum(sum(im)))/double(data.ref_pax_intensity));
            end
            [~, cell_bw] = detect_cell(im, 'threshold', th, 'show_figure', 0);
             if save_file
                 imwrite(logical(cell_bw), output_file, 'tiff');
             end
        else %if ~exist(output_file, 'file'),
            cell_bw = imread(output_file, 'tiff');
        end %if ~exist(output_file, 'file'),

        % Calculate the cell boundary and find the cell with the longest
        % boundary.
         cell_bd = find_longest_boundary(cell_bw);
         figure; imagesc(im); hold on; caxis(cbound);
         set(gca, 'FontSize', 16, 'Box', 'off', 'LineWidth',2); axis off;
         title(strcat('Paxillin image overlayed with cell boundary',index));
         plot(cell_bd(:,2), cell_bd(:,1),'w', 'LineWidth', 2);
         if isfield(data, 'cbound')
             caxis(data.cbound);
         end
         % initialize ref_pax_intensity even if the first mask already
         % exists
         if ~isfield(data,'ref_pax_intensity')
             data.ref_pax_intesnity = sum(sum(im)); 
         end

         clear cfp_file yfp_file pax_file cfp yfp pax cell_bd output_file;
    
    end %i image_index

clear path this_image_index output_path;
end %k num_acquisitions

beep;
return;

function [im, data] = get_image_detect_cell(data, index, protocol)
        if strcmp(protocol, 'FRET-Intensity')
            if data.multiple_cell_name
                first_file = data.first_cfp_file_all{k};
            else
                first_file = data.first_cfp_file;
            end
            cfp_channel = data.cfp_channel;
            yfp_channel = data.yfp_channel;
            pax_channel = data.pax_channel;
            %
            cfp_file = regexprep(first_file, data.index_pattern{1}, index);
            yfp_file = regexprep(cfp_file, cfp_channel, yfp_channel);
            pax_file = regexprep(cfp_file, cfp_channel, pax_channel);
            pax = imread(strcat(data.this_path, pax_file));
            % subtract_background
            [pax, data] = preprocess(pax, data);
            yfp = imread(strcat(data.this_path, yfp_file));
            [yfp, data] = preprocess(yfp, data);
            fa_factor = 3;
            im = uint16(yfp)+fa_factor*uint16(pax);
            data.cbound = data.yfp_cbound;
        elseif strcmp(protocol, 'Intensity')
            first_file = data.first_file;
            pax_file = regexprep(first_file, data.index_pattern{1}, index);
            pax = imread(strcat(data.this_path, pax_file));
            temp = pax(:,:,1); 
            % subtract_background
            [im, data] = preprocess(temp, data);
            clear pax temp;
        else
            im = [];
        end
return;