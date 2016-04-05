% function test_linescan_0119() 
% Detect the locations of two sister chromosomes
% Rotate the chromsomes so that they are horizontally oriented
% Calculate the linescan ratio values in the horizontal direction.
% Copyright: Shaoying (Kathy) Lu, shaoying.lu@gmail.com 2/18/2016

function test_linescan_0119()
data.path = 'D:/sof/data/linescan/';
data.first_file = '11.057';
data.index_pattern = {'057', '%03d'};
data.channel_pattern = {'11.0', '12.0', '13.0'};
data.subtract_background = 1;
data.median_filter = 1;
data.output = strcat(path, 'output');
data.intensity_bound = [0 1000];
data.ratio_bound = [1.3 1.8];
data.brightness_factor = 2.0;
data.crop_image = 1;


alpha = 1.5; %The average ratio between fret and ecfp images
min_area = 10; % The minimally detected area 
% The length and width of the linescan area.
min_value = 1.3; % background value for visualization
my_color = get_my_color();

first_fret_file = strcat(data.path, data.first_file);
% frames before 62 were not detected well. 
start_i = 62;
for i = start_i:67, % 62-67
    % read images and preprocess
    index_i = sprintf(data.index_pattern{2}, i);
    fret_file = regexprep(first_fret_file, data.index_pattern{1}, index_i);
    temp = imread(fret_file);
    fret = preprocess(temp, data);clear temp;
    ecfp_file = regexprep(fret_file, data.channel_pattern{1}, data.channel_pattern{2});
    temp = imread(ecfp_file);
    ecfp = preprocess(temp, data); clear temp
    im_intensity = uint16(alpha*ecfp+fret); %)/(1+alpha); 
    % figure; imagesc(im_intensity);
    ratio = compute_ratio(fret, ecfp);
    im_imd = get_imd_image(ratio, im_intensity, 'intensity_bound', data.intensity_bound,...
        'ratio_bound', data.ratio_bound);
    
    % detection of the chromosomes 
    th = graythresh(im_intensity);
    temp = im2bw(im_intensity, th* data.brightness_factor);
    bw = bwareaopen(temp, min_area); clear temp;
    % display_boundary(bw, 'im', im_imd); 
    
    % Rotate images
    % prop is an array of structures.
    prop = regionprops(bw, 'centroid','Orientation');
    cc = cat(1, prop.Centroid);
   %  plot(cc(:,1),cc(:,2), 'r');
    angle = atan((cc(1,2)-cc(2,2))/(cc(1,1)-cc(2,1)))*180/pi;
    im_rotate = imrotate(im_intensity, angle);
    temp = im2bw(im_rotate, th*data.brightness_factor);
    bw_rotate = bwareaopen(temp, min_area); clear temp;
    ratio_value =imrotate(ratio, angle).*bw_rotate+min_value*~bw_rotate;
    display_boundary(bw_rotate, 'im', imrotate(im_imd, angle)); 

    % Crop and quantify
    prop = regionprops(bw_rotate, 'Centroid'); clear cc;
    cc = cat(1, prop.Centroid);
    new_center = 0.5*(cc(1,:)+cc(2,:));
    plot(cc(:,1), cc(:,2), 'y','LineWidth', 1.5);
    [value, pixel] = get_horizontal_linescan(ratio_value, new_center, 'mask', bw_rotate);
     
%     figure(11); hold on; 
    my_figure('handle', 11); hold on; 
    xlabel('Distance to Center (Pixel)'); ylabel('FRET/ECFP Ratio');
    x1 =(pixel<100)&(value>min_value );
    plot(pixel(x1), value(x1), 'color', my_color.seq{i-start_i+1}, 'LineWidth', 1.5);
    x2 = (pixel>=101)&(value>min_value );
    plot(pixel(x2), value(x2), 'color', my_color.seq{i-start_i+1}, 'LineWidth', 1.5);
    
    my_figure('handle', 12); hold on; 
    xlabel('Distance to Center (\mu m)'); ylabel('FRET/ECFP Ratio');
    dist1 = scale_by_magnification(pixel(x1)-100, 100);
    dist2 = scale_by_magnification(pixel(x2)-100, 100);
    plot(dist1, value(x1), 'color', my_color.seq{i-start_i+1}, 'LineWidth', 1.5);
    plot(dist2, value(x2), 'color', my_color.seq{i-start_i+1}, 'LineWidth', 1.5);

    t1 = i*ones(size(value(x1))); 
    t2 = i*ones(size(value(x2)));
    my_figure('handle', 13); hold on; 
    set(gca, 'FontSize', 24, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth', 3);
    xlabel('Distance to Center (\mu m)'); ylabel('Time (min)'); zlabel('FRET/ECFP Ratio');
    plot3_color(dist1, (t1-60), value(x1), 'width', 0.3);
    plot3_color(dist2, (t2-60), value(x2), 'width', 0.3);
    shading interp; colormap jet;
    
    
end % for i = 62:65, 

return;

% function plot3_color(x, y, z, varargin)
%    para_name = {'line_color','width'};
%    para_default = {z, 0.3};
% Plot colored 3d lines using surface plots
function plot3_color(x, y, z, varargin)
   para_name = {'line_color','width'};
   para_default = {z, 0.3};
   [line_color, width] = parse_parameter(para_name, para_default, varargin);
   
   xx = [x, x];
   yy = [y-width/2, y+width/2];
   zz = [z, z];
   cc = [line_color, line_color];
   surf(xx,yy,zz,cc, 'EdgeColor','none');
return;

% function get_horizontal_linescan(im, center, varargin)
% calculated a horizontal linescan centered at the point "center"
% para_name = {'mask'};
% para_default = {[]};
% Output: value - linescan value
%                pixel - pixels where the mask the larger than 1/2 of the
%                width. pixel is an optional output
function [value, pixel] = get_horizontal_linescan(im, center,varargin)
para_name = {'mask'};
para_default = {[]};
mask = parse_parameter(para_name, para_default, varargin);

ll = 200;
width = 20;
rect = [center(1)-ll/2, center(2)-width/2, ll, width];
if ~isempty(mask),
    thickness = sum(imcrop(mask, rect),1);
    temp = sum(imcrop(im.*mask, rect), 1)./thickness; 
    pixel = find(thickness>width/2);
    value = temp(pixel')'; clear temp;
    temp = pixel; clear pixel;
    pixel = temp'; clear temp;
else
    value = sum(imcrop(im, rect))'/width;
    end;
return;
