%exp = cell(2,1);
%cell_index = cell(2,1);
%
exp = {'1126_nogm2';...
     '1126_gm2'};
num_cells = 11;
cell_index{1} = ones(num_cells, 1);
% 
num_cells = 12;
cell_index{2} = ones(num_cells, 1);
% Two cells in frame 012 are outliers {'012', 1}
cell_index{2,1}(5) = 0;
cell_index{2,1}(6) = 0;

figure; hold on;
marker = {'b+', 'ro'};
for i = 1:2,
    %num_exps = size(exp,2);
    %for j = 1:num_exps,
        data = init_data(exp{i});
        res = load(strcat(data.p, 'output\result.mat'));
        cell_size = res.cell_size;
        % cellwise data
        average_ratio = res.average_ratio;
        norm_intensity = res.norm_intensity;
        % qd data
        num_dots = res.num_dots;
        qd_size = res.qd_size;
        qd_intensity = res.qd_intensity;
        qd_ratio = res.qd_ratio;
        % pixelwise data
        ratio_list = res.ratio_list;
        intensity_list = res.intensity_list;
        
        num_cells = length(average_ratio);
        this_index = find(cell_index{i}==1);
        for k = (this_index'),
            plot3(qd_ratio{k}, qd_intensity{k}, qd_size{k},marker{i});
        end; 
        
        clear data res cell_size average_ratio norm_intensity;
        clear num_dtos qd_size qd_ratio ratio_list intensity_list;
    %end; % for j = 1:num_exps,
end; % for i = 1:2,
xlabel('QD Ratio'); ylabel('QD Intensity'); zlabel('QD Size');

% plot histograms
% 1 --- nogm2 #7; 2 --- gm2 #4.
count = zeros(100,4);
value = zeros(100,4);
for i = 1:2,
    %num_exps = size(exp,2);
    %for j = 1:num_exps,
        data = init_data(exp{i});
        res = load(strcat(data.p, 'output\result.mat'));
        cell_size = res.cell_size;
        % pixelwise data
        ratio_list = res.ratio_list;
        intensity_list = res.intensity_list;
        
        if i ==1,
            figure;  
            %[count, ratio] = 
            [t1, t2] = hist(ratio_list{7},100);
            count(:,1) = t1'; value(:,1) = t2';
            xlabel('Ratio'); ylabel('Count');
            figure; 
            %[count, ratio] = 
            [t1, t2] = hist(intensity_list{7},100);
            count(:,2) = t1'; value(:,2) = t2';
            xlabel('Intensity'); ylabel('Count');
            display(strcat('No GM #7: cell size = ', num2str(cell_size(7))));
        end;
        if i ==2,
            figure; %[count, ratio]= 
            [t1, t2] =hist(ratio_list{4},100);
            count(:,3) = t1'; value(:,3) = t2';
            xlabel('Ratio'); ylabel('Count');
            figure; 
            [t1, t2] =hist(intensity_list{4},100);
            count(:,4) = t1'; value(:,4) = t2';
            xlabel('Intensity'); ylabel('Count');
            display(strcat('GM #4: cell size = ', num2str(cell_size(4))));
        end;
        
        
        clear data res cell_size ratio_list intensity_list;
        clear t1 t2;
    %end; % for j = 1:num_exps,
end; % for i = 1:2,


