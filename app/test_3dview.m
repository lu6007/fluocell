% function test_3dview(data)
%
% Example: 
% data.root = '/Users/kathylu/Documents/sof/data/quanty_dataset_2/';
% data.path = strcat(data.root, 'fig5/1111_h3k9_3/p2/dconv9/');
% test_3dview(data)
function test_3dview(data)
% Initiate data
% % mef-1
% root = 'C:\Users\kathy\Desktop\data\qin_peng\';
% p = '1106_2014\MEF\5 0.5\dconv5\';
% z_dist = 0.5*15; % 0.5 um * 15 pixel/micron
% image_index = (7:38)'
% iso_value = 425;
% surface_file = 'surface';
% intensity_base = 50;
%
% Hela-WT1 t1, t5, t9
% root = 'E:\data\2014\qin_peng\';
% p = '1111\WTH3K9\3\p2\dconv9\';
%

p = data.path;
z_dist = 1.0*15; % 1um *15 pixel/um
image_index = (11:31)'; % (1:20)';
iso_value = 450; %3000
% surface_file = 't1surface';
intensity_base = 1.0e-4;
ratio_bound = [0.5 3.5]; 
ratio_factor = 1.5; % ratio_factor = (ratio_bound(1)+ratio_bound(2))/2;
% for t5 and t9, run after running this seciton
% >> data.first_file = strcat(data.path, 't5FRET1.001');
% >> sufrace_file = 't5surface';
% for t9, 
% >> isovalue = 200;

save_image = 0; % save images for movie
data_file = strcat(p, 'output/data.mat');
if exist(data_file, 'file')
    load(data_file);
    data.path = p;
    % data.first_file and data.output_path may need to be updated. 
    save(data_file, 'data');
else
    data = fluocell_data;
    save(data_file, 'data');
end
% data.first_file = regexprep(data.first_file, 't1', 't5');

%% load images in time frames
temp = imread(data.first_file);
% data.high_pass_filter = 61;
im = preprocess(temp, data); clear temp;
figure; imagesc(im);
rect = data.rectangle;
nsize = floor([rect(4); rect(3)]+0.5); 
num_frame = length(image_index);
fret_im = zeros(nsize(1), nsize(2), num_frame);
cfp_im = zeros(size(fret_im));

for i = 1:num_frame 
    j = image_index(i);
    j_str = sprintf(data.index_pattern{2}, j);
    file_name = regexprep(data.first_file, data.index_pattern{1}, j_str);
    temp = imread(file_name); 
    fret_im(:,:,i) = preprocess(temp, data); 
    clear temp; temp = file_name; clear file_name;
    file_name = regexprep(temp, data.channel_pattern{1}, data.channel_pattern{2});
    clear temp; temp = imread(file_name);
    cfp_im(:,:,i) = preprocess(temp, data);
    clear j_str temp file_name;
end
figure; imagesc(fret_im(:,:,8));

% Compute ratio and intensity images
ratio_im = compute_ratio(fret_im, cfp_im, 'shift', intensity_base);
intensity_im = 1/(1+ratio_factor)*fret_im+ratio_factor/(1+ratio_factor)*cfp_im; 
intensity_bound = [1 1023];

%% output files for 3d view in visIt
for i = 1:num_frame
    j = image_index(i);
    j_str = sprintf(data.index_pattern{2},j);
    file_name = strcat(p, 'output/im_rgb_',j_str,'.tiff');
    temp = floor(0.5+imscale(intensity_im(:,:,i), 1, 255, intensity_bound));
    im_red = ind2rgb(temp, gray(255)); clear temp;
    temp = floor(0.5+imscale(ratio_im(:,:,1), 1, 255, ratio_bound));
    im_green = ind2rgb(temp, gray(255)); clear temp; 
    im_blue = double(i/255)*ones(size(im_green));
    im_rgb = zeros(size(im_red));
    im_rgb(:,:,1) = im_red(:,:,1);
    im_rgb(:,:,2) = im_green(:,:,2);
    im_rgb(:,:,3) = im_blue(:,:,3);
    imwrite(im_rgb, file_name, 'tiff', 'Compression', 'none');  
    clear j_str file_name im_red im_green im_blue im_rgb;
end
disp('red - intensity; green - ratio; blue - z_index');
disp(strcat('z_dist = ', num2str(z_dist), '; 15 pixels - 1 um'));
disp(strcat('intensity_bound = ', num2str(intensity_bound)));
disp(strcat('ratio_bound = ', num2str(ratio_bound)));

%% Calculate visualize the ISO surface
% 15 pixel/micron in z-plane
[xx, yy, zz] = meshgrid(1:nsize(2), 1:nsize(1), (1:num_frame)*z_dist); 
screen_size = get(0, 'ScreenSize');
figure('Position', [50 50 screen_size(4) screen_size(4)], ...
    'color', 'w');
isosurface(xx, yy, zz, intensity_im, iso_value, ratio_im);
caxis(ratio_bound); shading interp; colormap jet;
axis tight; xlabel('x-pixel'); ylabel('y-pixel'); zlabel('z-pixel');
camlight right;
% view(0, 90) standard 2d view. % view(h_rotation, v_rotation);
% view(180, -90); lightangle(180,-90); view from the bottom

figure('Position', [50 50 screen_size(4) screen_size(4)], ...
    'color', 'w');
isosurface(xx/15, yy/15, zz/15, intensity_im, iso_value, ratio_im);
caxis(ratio_bound); shading interp; colormap jet;
axis tight; xlabel('x-\mu m'); ylabel('y-\mu m'); zlabel('z-\mu m');
set(gca, 'FontSize', 24, 'FontWeight', 'Bold');
set(gca, 'LineWidth', 3);
camlight right;
% view(0, 90) standard 2d view. % view(h_rotation, v_rotation);
% view(180, -90); lightangle(180,-90); view from the bottom

%%
% angle in degrees

if save_image
    horizontal_rotation = 15; 
    vertical_rotation = 30;
    step_size = 5; 
    num_frame = 180/step_size+1; % 25;
    light_handle = lightangle(0, 0);
    for i = 1:num_frame
        %for j = 1:2,
           % if j ==1,
            horizontal_rotation = horizontal_rotation+step_size;
            if horizontal_rotation >= 180
                horizontal_rotation = horizontal_rotation - 360;
            end
            vertical_rotation = vertical_rotation - step_size;
    %         if j == 1,
                i_str = sprintf('%03d', i);
    %         elseif j ==2,
    %             i_str = sprintf('%03d', i+num_frame);
    %        end;
        %end;
        figure(fig);
        view(horizontal_rotation, vertical_rotation);
        lightangle(light_handle, horizontal_rotation, vertical_rotation);
        temp = hardcopy(fig, '-dzbuffer', '-r0');
        % capture size is the middle 3/5 of the figure
        cs = size(temp); 
        this_frame = temp(floor(cs(1)/7:cs(1)*6/7+0.5), ...
           floor(cs(2)/7:cs(2)*6/7+0.5), :);
       file_name = strcat(data.output_path,surface_file, '_',i_str,'.tiff');
       imwrite(this_frame, file_name, 'tiff');
       %figure; imagesc(this_frame);
       clear temp cs this_frame i_str file_name;
    end
end % save image
disp('Done!');
% %% View of the chromesome. 
% figure; isosurface(x, y, z, fret_im+cfp_im, iso_value, x+z);
% shading interp;

return;