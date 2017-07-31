function fak_pax()
%%
cell_name = 'fak_pax';
% cell_name = 'ct01';
% cell_name = 'sh01';
% cell_name = 'sh00';
%cell_name = 'sh11';
% cell_name = 'ct06';
% cell_name = 'ct03';
% cell_name = '09_08';
% cell_name = 'ct31';
data = track_init_data(cell_name);
path = data.path;
first_file = data.first_file;
pattern = data.pattern;
channel = data.channel;
index_pattern = data.index_pattern;
index = data.image_index;
lines = data.lines;
%region_name = data.region_name;
region_name = {'Front', 'Body', 'Tail', 'Tail 2'};
time_interval = data.time_interval;
thresh = data.thresh;

im = imread(strcat(path, first_file));
figure; imagesc(im);
first_pattern = sprintf(index_pattern, index(1));

%% Define the background, cropping rectangle 
% and define regions of interest
file_bg = strcat(path, 'background.mat');
bw = get_background(im, file_bg);
file_crop = strcat(path, 'rectangle.mat');
rect = get_rectangle(im, file_crop);
im_crop = imcrop(im, rect);
region_file = strcat(path, 'region.mat');
[regions, region_bd] = get_roi(im_crop, region_file);
%num_roi = length(regions);
num_roi = length(regions)-1;
figure; imagesc(im_crop); hold on;
my_color = get_my_color();
color = {'r', my_color.dark_green, 'b', 'y'};
for i = 1:num_roi
    l = plot(region_bd{i}(:,1), region_bd{i}(:,2), 'LineWidth', 3);
    set(l, 'Color', color{i}); clear l;
end

%% Preprocessing image and adjust threshold
% subtract background, crop image, median filter and high pass filter
% The filtered images are saved as FAK_filt_xxx and pax_filt_xxx, which can
% be used to visualize the FRET ratio and generate the FAK/pax ratio
% images.
num_pixels= sum(sum(double(bw)));
for k =1:length(channel)
    file = regexprep(first_file, pattern{1}, pattern{k});
    im = imread(strcat(path, file));
    temp = im-sum(sum(double(bw).*double(im)/num_pixels));
    clear im; im = temp; clear temp;
    im_crop = imcrop(im, rect);
    temp = medfilt2(im_crop, [3,3]);
    clear im_crop; im_crop = temp; clear temp;
    file_filter = strcat(path, channel{k}, '_filt_', first_pattern,'.tiff');
    im_filt = get_im_filt(im_crop,file_filter, 'tiff');
    figure; imagesc(im_filt); 

    %Adjust threshold;
    fa_bw = im_filt>thresh(k);
    file_fa = strcat(path, channel{k}, '_fa_', first_pattern, '.mat');
    fa_bd = get_boundary(fa_bw, file_fa);
    num_fas = length(fa_bd);
    figure('color', 'w'); imshow(im_crop); caxis ([0 400]); hold on;
    set(gca, 'FontSize', 16, 'Box', 'off', 'LineWidth',2); axis off;
    for j = 1:num_fas
        plot(fa_bd{j}(:,2), fa_bd{j}(:,1), 'r','LineWidth',0.5);
    end
    colorbar('FontSize',16, 'Box', 'off','LineWidth',2);
    set(gca, 'FontSize', 16, 'Box', 'off', 'LineWidth',2);
    for i = 1:num_roi
        l = plot(region_bd{i}(:,1), region_bd{i}(:,2), 'LineWidth', 3);
        set(l, 'Color', color{i}); clear l;
    end
    
    clear file im imcrop file_filter im_filt fa_bw file_fa fa_bd;
end

%% Calculate the average_intensity and total_intensity in the regions.
file_intensity = strcat(path, 'intensity.mat');
if ~exist(file_intensity, 'file')
time = (index-index(1))*time_interval; % minutes
num_channels = length(channel);
num_images = length(index);
total_int = zeros(num_channels, num_images, num_roi);
ave_int = zeros(num_channels, num_images, num_roi);
port_pixels = zeros(num_channels, num_images, num_roi);
num_pixels_region = zeros(4,1);
shift = 0.1;
for i = 1:num_images
    str_index = sprintf(index_pattern, index(i));
    file = regexprep(first_file, first_pattern, str_index);
    for k = 1:num_channels
        file = regexprep(file , pattern{1}, pattern{k});
        im = imread(strcat(path,file));
        temp = im-sum(sum(double(bw).*double(im)/num_pixels));
        clear im; im = temp; clear temp;
        im_crop = imcrop(im, rect);
        temp = medfilt2(im_crop, [3,3]);
        clear im_crop; im_crop = temp; clear temp;
        file_filter = strcat(path, channel{k}, '_filt_',str_index,'.tiff'); 
        im_filt = get_im_filt(im_crop, file_filter, 'tiff');
        % figure; imagesc(im_filt)
        clear fa_bd fa_bw;
        fa_bw = im_filt>thresh(k);
        file_fa = strcat(path, channel{k}, '_fa_', str_index, '.mat');
        [~, fa_bw] = get_boundaries(fa_bw, file_fa);
%        [fa_bd, fa_bw] = get_boundaries(fa_bw, file_fa);
%         num_fas = length(fa_bd);
%         figure; imshow(im_crop); caxis auto; hold on;
%         for j = 1:num_fas,
%             plot(fa_bd{j}(:,2), fa_bd{j}(:,1), 'r', 'LineWidth', 0.5);
%         end;
        for j = 1:num_roi
           total_int(k, i, j) = sum(sum(double(im_crop).*double(fa_bw).*double(regions{j})));
           num_pixels_fa = sum(sum(double(fa_bw).*double(regions{j})));
           ave_int(k, i, j) = total_int(k,i,j)/(num_pixels_fa+shift);
        end
        clear im im_crop file_filter im_filt fa_bw file_fa fa_bd;
    end %k
end
for j = 1:4
    num_pixels_region(j) = sum(sum(double(regions{j})));
    total_int(:,:,j)/num_pixels_region(j);
end
save(file_intensity, 'time', 'total_int', 'ave_int','num_channels', 'num_roi');
else
    load(file_intensity);
end

%% Plot curves
gray = [0.39 0.47 0.64];
line_name = cell(num_channels, num_roi);
% Figure h1, Total Intensity
h1 = figure('color','w'); hold on;
set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',3); 
xlabel('Time (min)'); ylabel('Total Fluorescent Intensity');
% Figure h2, Average Intensity
h2 = figure('color','w'); hold on;
set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',3); 
xlabel('Time(min)'); ylabel('Average Fluorescent Intensity');
% Figure h3, Portion of Pixels
h3 = figure('color','w'); hold on;
set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',3); 
xlabel('Time(min)'); ylabel('Portion of Pixels');
% Figure h4, Ratio between FAK and paxillin
h4 = figure('color','w'); hold on;
set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',3); 
xlabel('Time(min)'); ylabel('FAK/Paxililn Total Intensity Ratio');

shift = 0.1;
for k = 1:num_channels
    for j = 1:num_roi
        marker = lines{k};
        figure(h1), l = plot(time, total_int(k, :, j), marker, 'LineWidth',3);
        set(l, 'Color', color{j}); clear l;
        figure(h2), l = plot(time, ave_int(k,:,j), marker, 'LineWidth',3);
        set(l, 'Color', color{j}); clear l;
        port_pixels(k,:,j) = (total_int(k,:,j)+shift)./(ave_int(k,:,j)+shift);
        figure(h3), l=plot(time, port_pixels(k,:,j), marker, 'LineWidth',3);
        set(l, 'Color', color{j}); clear l;
        line_name{k,j} = strcat(channel{k}, ' ', region_name{j});
        figure(h4), l =plot(time, total_int(1,:,j)./total_int(2,:,j), 'LineWidth',3);
        set(l, 'Color', color{j}); clear l;
    end
end
l = line_name;
figure(h1); legend(l{1,1}, l{1,2}, l{1,3}, l{1,4}, l{2,1}, l{2,2}, l{2,3}, l{2,4});
figure(h2); legend(l{1,1}, l{1,2}, l{1,3}, l{1,4}, l{2,1}, l{2,2}, l{2,3}, l{2,4});
figure(h3); legend(l{1,1}, l{1,2}, l{1,3}, l{1,4}, l{2,1}, l{2,2}, l{2,3}, l{2,4});
figure(h4); legend(region_name{1}, region_name{2}, region_name{3},region_name{4});


%% cross correlation
cc = zeros(2*length(time)-1, 3);
for j = 1:num_roi
[~, cc(:,1)] = cross_correlation(time, total_int(1,:,j)', total_int(2, :,j)'); 
[~, cc(:,2)] = cross_correlation(time, ave_int(1,:,j)', ave_int(2,:,j)'); 
[tt, cc(:,3)] = cross_correlation(time, port_pixels(1,:,j)', port_pixels(2,:,j)');
figure; hold on;
set(gca, 'FontSize', 16, 'FontWeight', 'bold','Box', 'off', 'LineWidth',3,...
    'Color', gray); 
xlabel('Time (min)'); ylabel('Cross Correlation');
plot(tt,cc(:,1), 'w-','LineWidth',3);
plot(tt, cc(:,2), 'w--','LineWidth',3);
plot(tt, cc(:,3), 'w.','LineWidth',3);
title(strcat(channel{1}, '-', channel{2}, '-',region_name{j}));
legend('Total Intensity', 'Average Intensity', 'Portion of Pixels');
end
return;

function [regions, region_bd] = get_roi(im, region_file)
num_roi = 4;
regions= cell(num_roi,1);
region_bd = cell(num_roi,1);
if ~exist(region_file, 'file')
    figure; imagesc(im); hold on;
    title('Please choose the regions of interest');
    for j= 1:num_roi
        [regions{j}, x,y] = roipoly();
        region_bd{j} = [x y];
        plot(x,y,'b','LineWidth',2);
        clear x y;
    end
    save(region_file, 'regions', 'region_bd');
else
    load(region_file);
end
return;



