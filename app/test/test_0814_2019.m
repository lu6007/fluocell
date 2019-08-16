function [time, value] = test_0814_2019()
% for Piezo1+25Yoda1
dish_cell = {'dish5 25Yoda1', 1; 'dish5 25Yoda1', 5; 'dish5 25Yoda1', 52; 'dish5 25Yoda1', 7; ... %1-4
    'dish1 25Yoda1', 1; ... % 5
    'dish2 25Yoda1', 1; 'dish2 25Yoda1', 12; 'dish2 25Yoda1', 3; 'dish2 25Yoda1', 4}; % 6-9
ii = 7; 

% % for Piezo1+0.5Yoda1
% dish_cell = {'dish3 0.5Yoda1', 1; 'dish3 0.5Yoda1', 2; 'dish3 0.5Yoda1', 3; ... % 1-3
%     'dish3 0.5Yoda1', 4; 'dish3 0.5Yoda1', 5; 'dish3 0.5Yoda1', 6; 'dish3 0.5Yoda1', 7; ... % 4-7
%     'dish4 0.5Yoda1', 1; 'dish4 0.5Yoda1', 2; 'dish4 0.5Yoda1', 3; 'dish4 0.5Yoda1', 4; ... % 8-11
%     'dish4 0.5Yoda1', 5; 'dish4 0.5Yoda1', 6}; % 12-13
% ii = 13;

% % for paxillin only + 25Yoda1
% dish_cell = {'dish1 noPiezo1 25Yoda1', 1; 'dish1 noPiezo1 25Yoda1', 2; 'dish1 noPiezo1 25Yoda1', 4; ...% 1-3
%     'dish1 noPiezo1 25Yoda1', 6; 'dish1 noPiezo1 25Yoda1', 8; 'dish1 noPiezo1 25Yoda1', 9; ... % 4-6
%     'dish1 noPiezo1 25Yoda1', 10; 'dish1 noPiezo1 25Yoda1', 11}; % 7
% ii = 8; 

% % for paxillin only + 0.5Yoda1
% dish_cell = {'dish2 noPiezo1 0.5Yoda1', 1; 'dish2 noPiezo1 0.5Yoda1', 2; 'dish2 noPiezo1 0.5Yoda1', 3; ... % 1-3
%   'dish2 noPiezo1 0.5Yoda1', 4; 'dish2 noPiezo1 0.5Yoda1', 5; 'dish2 noPiezo1 0.5Yoda1', 6; ... % 4-6
%   'dish2 noPiezo1 0.5Yoda1', 7}; % 7
% ii = 7;

dish_name = dish_cell{ii,1};
cell_pos = dish_cell{ii,2}; % 52; % 5; % 1;
data = init_data(dish_name, cell_pos); 
disp({dish_name, cell_pos});
disp(data); 
[time, value] = get_fa_time_course(data);

% time = time - data.time_treat_drug; % min
return

function data = init_data(dish, cell_pos)
data.root = '/Users/kathylu/Google Drive/data/';
data.index_pattern = {'t1'  't%d'};
data.protocol = 'Intensity';
data.channel_pattern = {'w1GFP-FITC-10'  'w2Red-10'  'w3DIC'};
data.subtract_background=2;
data.median_filter=1;
data.quantify_roi=3;
data.multiple_object = 0; 
data.track_cell = 1;
data.num_roi = 4; 
data.path = strcat(data.root, 'paxillin_imaging_08112019/Piezo1+paxillin/dish5 25Yoda1/p1/');
switch dish
    case 'dish5 25Yoda1' % has Piezo1
        data.image_index = (1:30)';
        data.prefix='1_w1GFP-FITC-10--Yijia_s1_t1';
        data.postfix='.TIF';
        data.need_apply_mask = 1;
        data.brightness_factor = 0.8; 
        pos = num2str(cell_pos); 
        switch cell_pos
            case 1
                % do nothing
            case {4, 7}
                data.brightness_factor = 0.6; 
                data.path = regexprep(data.path, 'p1', ['p', pos]);
                data.prefix=regexprep(data.prefix, 's1', ['s', pos(1)]);
            case {5, 52}
                data.path = regexprep(data.path, 'p1', ['p', pos]);
                data.prefix=regexprep(data.prefix, 's1', ['s', pos(1)]);
        end
    case 'dish1 25Yoda1'
        data.path = regexprep(data.path, 'dish5 25Yoda1/p1', 'dish1 25Yoda1');
        data.image_index = (5:65)';
        data.prefix='11';
        data.postfix='.005';
        data.need_apply_mask = 1;
        data.brightness_factor = 0.8; 
        % pos = num2str(cell_pos); 
        data.index_pattern = {'005', '%03d'};
        data.channel_pattern = {'11', '13', '12'}; 
    case 'dish2 25Yoda1'
        data.path = regexprep(data.path, 'dish5 25Yoda1', 'dish2 25Yoda1');
        data.image_index = (1:43)';
        data.prefix='1_w1GFP-FITC-10--Yijia_s1_t1';
        data.postfix='.TIF';
        data.need_apply_mask = 1;
        data.brightness_factor = 0.8; 
        pos = num2str(cell_pos); 
        switch cell_pos
            case 1
                data.image_index = [1:11, 13:43]';
            case {12, 3, 4}
                data.path = regexprep(data.path, 'p1', ['p', pos]);
                data.prefix=regexprep(data.prefix, 's1', ['s', pos(1)]);
        end
    case 'dish3 0.5Yoda1'
        data.path = regexprep(data.path, 'dish5 25Yoda1', 'dish3 0.5Yoda1');
        data.image_index = (1:50)';
        data.prefix='1_w1GFP-FITC-10--Yijia_s1_t1';
        data.postfix='.TIF';
        data.need_apply_mask = 1;
        data.brightness_factor = 0.8; 
        pos = num2str(cell_pos); 
        data.path = regexprep(data.path, 'p1', ['p', pos]);
        data.prefix=regexprep(data.prefix, 's1', ['s', pos(1)]);
        switch cell_pos
            case 2
                data.brightness_factor = 0.8; 
            case 5
                data.brightness_factor = 1.0;
                data.image_index = [1:4, 6:20, 28:50]'; 
        end % switch cell_pos
    case 'dish4 0.5Yoda1'
        data.path = regexprep(data.path, 'dish5 25Yoda1', 'dish4 0.5Yoda1');
        data.image_index = (1:30)';
        data.prefix='1_w1GFP-FITC-10--Yijia_s1_t1';
        data.postfix='.TIF';
        data.need_apply_mask = 1;
        data.brightness_factor = 0.8; 
        pos = num2str(cell_pos); 
        data.path = regexprep(data.path, 'p1', ['p', pos]);
        data.prefix=regexprep(data.prefix, 's1', ['s', pos(1)]);
        switch cell_pos
            case 1
                data.brightness_factor = 0.6; 
                data.image_index = [1:23, 25:27, 29-30]';
            case 3
                data.brightness_factor = 0.6; 
            case 4
                data.image_index = [1:4, 6:29]'; 
            case 5
                data.brightness_factor = 0.6;
                data.image_index = (1:29)';
        end % switch cell_pos
    case 'dish1 noPiezo1 25Yoda1' %noPiezo1
    % data.path = strcat(data.root, 'paxillin_imaging_08112019/Piezo1+paxillin/dish5 25Yoda1/p1/');
        data.path = regexprep(data.path, 'Piezo1\+paxillin/dish5 25Yoda1', ...
            'paxillin/dish1 25uMYoda1');
        data.image_index = (1:30)';
        data.prefix='1_w1GFP-FITC-10--Yijia_s1_t1';
        data.postfix='.TIF';
        data.need_apply_mask = 1;
        data.brightness_factor = 0.8; 
        pos = num2str(cell_pos); 
        data.path = regexprep(data.path, 'p1', ['p', pos]);
        data.prefix=regexprep(data.prefix, 's1', ['s', pos(1)]);
        switch cell_pos
            case 1
                data.brightness_factor = 0.6; 
                data.image_index = [2:28, 30]';
            case {6, 8}
                data.brightness_factor = 0.6; 
            case 10
                data.prefix=regexprep(data.prefix, 's1', ['s', pos]);
            case 11
                data.prefix=regexprep(data.prefix, 's1', ['s', pos]);
                data.num_roi = 3;
                data.brightness_factor = 0.6; 
        end % switch cell_pos
    case 'dish2 noPiezo1 0.5Yoda1' %noPiezo1
        data.path = regexprep(data.path, 'Piezo1\+paxillin/dish5 25Yoda1', ...
            'paxillin/dish2 0.5uMYoda1');
        data.image_index = (1:30)';
        data.prefix='1_w1GFP-FITC-10--Yijia_s1_t1';
        data.postfix='.TIF';
        data.need_apply_mask = 1;
        data.brightness_factor = 0.8; 
        pos = num2str(cell_pos); 
        data.path = regexprep(data.path, 'p1', ['p', pos]);
        data.prefix=regexprep(data.prefix, 's1', ['s', pos(1)]);
        switch cell_pos
            case {5, 6, 7}
                data.brightness_factor = 0.6; 
                
        end % switch cell_pos
                
end % switch dish

data.output_path = strcat(data.path, 'output/');
data.first_file = strcat(data.path, data.prefix, data.postfix);

return

function [time, value] = get_fa_time_course(data)
if ~exist(data.output_path, 'dir')
    mkdir(data.output_path);
    fprintf('\nFunction test_0814_2019(): make dir %s\n------', data.output_path);
end

min_water = 2000;
min_area = 20;
filter_size = 51; 
image_index = data.image_index;
num_frame = size(image_index, 1);
time = zeros(num_frame, 1); 
total_intensity = zeros(num_frame, 1);
ref_pax_intensity = 1;
mask_with_cell = 1;

fprintf('\nFunction get_fa_time course(): \n')
fprintf('Use high pass filter to remove diffusive background. \n');
fprintf('filter_size = %f \n', filter_size);
fprintf('mask_with_cell = %d \n', 1);
fprintf('The cell was divided into %d layers. \n', data.num_roi);
fprintf('min_water = %d \n', min_water);
fprintf('min_area = %d \n', min_area);
fprintf('Choose a faned region on the cell. \n');
fprintf('Function detect_focal_adhesion(): Normalized against photobleach. \n');
fprintf('The total FA intensity in the fan region within the outer layer of the cell ');
fprintf('was quantified. \n\n'); 
fprintf('The real imaging time was recovered from data. \n\n');

for i =  (1:num_frame)
    data.index = image_index(i);
    new_first_file = (i==1); 
    if new_first_file
        data = init_figure(data);
    end
    data = get_image(data, new_first_file);
    data = update_figure(data);
    % divide cell into data.num_roi layers. 
    [~, label_layer] = divide_layer(data.cell_bw, data.num_roi, 'method',2, ...
            'xylabel', 'normal');
    % detect focal adhesions
    [fa_bw, ~, im_filt, total_pax_intensity] = detect_focal_adhesion(data.im{2}, ...
        'mask_with_cell', mask_with_cell, ...
        'cell_bw', data.cell_bw, 'need_high_pass_filter', 1, 'filter_size', filter_size, ...
        'min_area', min_area, ...
        'min_water', min_water, 'normalize', 1, 'ref_pax_intensity', ref_pax_intensity);
    if new_first_file
        ref_pax_intensity = total_pax_intensity; 
        fprintf('\nFunction test_0814_2019(): ref_pax_intensity = %d ---\n', ...
            ref_pax_intensity); 
        [fa_bw, ~, im_filt, ~] = detect_focal_adhesion(data.im{2}, 'mask_with_cell', 1, ...
            'cell_bw', data.cell_bw, 'need_high_pass_filter', 1, 'filter_size', filter_size, ...
            'min_area', min_area, ...
            'min_water', min_water, 'normalize', 1, 'ref_pax_intensity', ref_pax_intensity);
    end
    % define fan region
    last_file = (i==num_frame);
    [fan_bw, ~, ~] = get_fan(1, im_filt, data.cell_bw, strcat(data.output_path, 'fan.mat'), ...
        'draw_figure', new_first_file||last_file); 
    % quanify in the outer layer, in focal adhesions, and in the fan region
    temp = im_filt.*(label_layer ==1).*fa_bw.*fan_bw;
    total_intensity(i) = sum(sum(temp)); 
    % real imaging time
    time(i) = get_time(data.file{1}, 'method', 2); 
    clear temp;
    pause(0.1); 
end
value = total_intensity;
return

% function time_treat_drug = get_time_treat_drug(data, position, treat_drug_after_index)
%     pos = num2str(position); 
%     data.path = regexprep(data.path, 'p5', strcat('p', pos));
%     data.prefix=regexprep(data.prefix, 's5', strcat('s', pos));
%     data.output_path = strcat(data.path, 'output/');
%     data.first_file = strcat(data.path, data.prefix, data.postfix);
%     data.index = treat_drug_after_index;
%     new_first_file = 1;
%     % data = init_figure(data);
%     data = get_image(data, new_first_file); 
% return
