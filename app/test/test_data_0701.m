% function colocalize_value = test_data_0701(data)
% calulate the colocalization value based on fluocell_data information. 
%
% Normalized cross-correlation (normxcorr2) was used. The reference can be found here
% https://www.mathworks.com/help/images/ref/normxcorr2.html
% 
% Example:
% Image analysis protocol
% Use fluocell to open the images following the FRET-Intensity protocol 
% Follow instructions and draw crop rectangles
% >> my_fun = test_data_0701;
% >> data = fluocell_data
% >> cell_index = 1;  % 2 , 3, 4, 5
% >> my_fun.move_rectangle_file(data, cell_index);
% 
% 2. Run the scripts below by copy and paste the the MATLAB command window
% >> data = fluocell_data
% >> data = my_fun.update_rectangle(data, cell_index);
% >> v = my_fun.compute_colocalize(data)
%
% 3. Use fluocell to close figures before moving on to next cell. 
%
% Sample data: data/yilan_0701_2019

% Author: Shaoying Kathy Lu, email: shaoying.lu@gmail.com
function my_fun = test_data_0701()
    my_fun.compute_colocalize = @compute_colocalize;
    my_fun.update_rectangle = @update_rectangle; 
    my_fun.move_rectangle_file = @move_rectangle_file; 
return

% Variables slightly affect colocalization_value
% (1) The cropping rectangle. (2) The size of high_pass_filter. 
function colocalize_value = compute_colocalize(data)
% Enable high_pass_filter to remove the diffusive background 
% and focus on the punctured structures.
% fprintf('data.rectangle = ');
% disp(data.rectangle); 
data.high_pass_filter = 41;
fprintf('data.high_pass_filter=%d \n', data.high_pass_filter); 
green = preprocess(data.im{1}, data);
red = preprocess(data.im{2}, data); 
my_figure('font_size', 18); imagesc(green); 
% set(gca,'visible','off')
title('Channel 0 + High Pass Filter'); colormap jet;
my_figure('font_size', 18); imagesc(red); 
% set(gca,'visible','off')
title('Channel 1 + High Pass filter'); colormap jet; 
v = normxcorr2(green, red);
[num_row, num_col] = size(v);
xm = floor(num_row/2); ym = floor(num_col/2);
[xx, yy] = meshgrid((1:num_row)-xm, (1:num_col)-ym);
my_figure('font_size', 18, 'line_with', 2); 
surf(xx',yy', v); shading flat; view(2); 
colormap jet; colorbar; 
xlabel('Vertical Shift'); ylabel('Horizontal Shift')
title('Spatial Cross-correlation Surface');
[num_row, num_col]= size(green);
% The location of max value may change a little due to mis alignment of images
colocalize_value = max(max(v(num_row-4:num_row+4, num_col-4:num_col+4))); 
return

function data = update_rectangle(data, cell_index)
rectangle_file = ...
    strcat(data.path, 'output/rectangle', num2str(cell_index), '.mat');
if ~exist(rectangle_file, 'file')
    disp('The rectangle file does not exist.')
else
    test = load(rectangle_file);
    data.rectangle = test.rect; 
end
return

function move_rectangle_file(data, cell_index)
output_path = strcat(data.path, 'output/');
rectangle_file = strcat(output_path, 'rectangle', '.mat');
dest_file = strcat(output_path, 'rectangle', num2str(cell_index), '.mat');
if ~exist(rectangle_file, 'file')
    disp('The rectangle file does not exist.')
else
    movefile(rectangle_file, dest_file);
end
return