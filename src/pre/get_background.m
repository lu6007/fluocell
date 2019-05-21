% function bw =get_background(im, file_bg)
% parameter_name = {'method'};
% default_value = {'manual'};
% 0 - no background subtraction
% 1 - manually choose background
% 2 - automatically select background
% 3 - automatically select background to calculate a constant value
% 4 - (beta) the background value is chosen as a given percentile of the histogram   
% 5 - (beta) the background is read from the TIFF image file output/background.tif

% provide two methods to get the background:
% method "auto": Automatically select a background region with the minimal 
% intensity value among the four corners.
% method "manual": Manually choose the region as the background.

% Copyright: Shaoying Lu and Yingxiao Wang 2011
% Modified by Lexie Qin Qin and Shaoyng Lu 2014 and 2018

function [bw, poly, value] =get_background(im, file_bg, varargin)
parameter_name = {'method', 'percentile'};
default_value = {'manual', 1};
[method, percent] = parse_parameter(parameter_name, default_value,varargin);

switch method
    case {'manual','m', 1}        
        [bw_cell, poly_cell] = get_polygon(im, file_bg,...
            'Please choose the background region.');
        bw = bw_cell{1};
        poly = poly_cell{1};
        
    case {'auto','a', 2, 3}       
        %Automatically select a background region with the minimal 
        %intensity value among the four corners.
        [bw_cell, poly_cell] = get_background_auto(im, file_bg); 
        bw = bw_cell{1};
        poly = poly_cell{1};
        
    case 4 % constant percentile background subtraction
        bw = []; poly = [];
        fun = get_my_function();
        value = fun.get_image_percentile(im, percent);
        return;
        
    case 5 % flatfield correction by an image file
        % The background is provided by the image file of file_bg.  
        % Output is saved in the bw file. 
        bw = imread(file_bg); poly = [];
        return;
end

% 1 2 or 3
double_bw = double(bw);
sum_bw = sum(sum(double_bw));
value = sum(sum(double(im)/sum_bw.*double_bw));

return

function [bg_bw, bg_poly] = get_background_auto(im, file_bg)
if exist(file_bg, 'file')
    res = load(file_bg);
    bg_bw = res.bw;
    bg_poly = res.poly;
else
    num_polygon = 4;
    [num_row, num_col] = size(im);
    bw = cell(num_polygon, 1);
    poly = cell(num_polygon, 1); 

    ss = 20; % size-1
    %first region: top left corner
    x = [1; 1+ss; 1+ss; 1; 1];
    y = [1; 1; 1+ss; 1+ss; 1];
    bw{1} = roipoly(im,x,y); 
    poly{1} = [x y]; clear x y;

    %second region: top right corner
    x = [num_col-ss; num_col; num_col; num_col-ss; num_col-ss];
    y = [1; 1; 1+ss; 1+ss; 1];
    bw{2} = roipoly(im,x,y); 
    poly{2} = [x y]; clear x y;

    %third region: lower left corner
    x = [1; 1+ss; 1+ss; 1; 1];
    y = [num_row-ss; num_row-ss; num_row; num_row; num_row-ss];
    bw{3} = roipoly(im,x,y); 
    poly{3} = [x y]; clear x y;

    %fourth region: lower right corner
    x = [num_col-ss; num_col; num_col; num_col-ss; num_col-ss];
    y = [num_row-ss; num_row-ss; num_row; num_row; num_row-ss];
    bw{4} = roipoly(im,x,y); 
    poly{4} = [x y]; clear x y;

    %             for j = 1:4,
    %                 plot(poly{j}(:,1),poly{j}(:,2),'k','LineWidth',1);
    %             end

    % calculate the intensity at 4 corners and pick the region with
    % the minimal value
    min_index = 0;
    min_intensity = 10^10;
    for j = 1:4
       intensity = sum(sum(double(im).*double(bw{j})))/sum(sum(double(bw{j})));
       if intensity< min_intensity
           min_index = j;
           min_intensity = intensity;
       end
    end

    bg_bw{1} = bw{min_index};
    bg_poly{1} = poly{min_index};
    %            h = figure; imagesc(im); title(title_str); hold on;
    %            plot(poly{1}(:,1), poly{1}(:,2), 'r', 'LineWidth', 1);
    %            close(h);
    clear bw; clear poly;
    bw = bg_bw; poly = bg_poly;
    save(file_bg, 'bw', 'poly');  
end

return