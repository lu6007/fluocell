% function [bw poly] = get_polygon(im, file_roi, title_str)
% define the region of interest.
% Allow the choice of more than 1 polygon. 
% The output are two cells of vectors.
% parameter_names = {'num_polygon', 'polygon_type','diameter','method'};
% default_values = {1, 'any', 200,'manual'};

% Copyright: Shaoying Lu and Yingxiao Wang 2011
% Modified by Lexie Qin Qin and Shaoyng Lu 2014

function [bw, poly] = get_polygon(im, file_roi, title_str, varargin)
parameter_names = {'num_polygon', 'polygon_type','diameter', ...
    'show_colorbar', 'cbound'};
default_values = {1, 'any', 200, 0, []};
[num_polygon, polygon_type, diameter, show_colorbar, cbound] = ...
    parse_parameter(parameter_names, default_values, varargin);
if ~exist(file_roi,'file')
    h = figure; imagesc(im); colormap jet; title(title_str); hold on;
    if show_colorbar
        colorbar;
    end
    if ~isempty(cbound)
        caxis(cbound);
    end
    bw = cell(num_polygon, 1);
    poly = cell(num_polygon, 1);
    for j = 1:num_polygon
        switch polygon_type
            case 'any'
                [bw{j}, x, y] = roipoly;
                poly{j} = [x y];
                plot(x, y, 'r', 'LineWidth', 1);
                clear x y;
                continue;
            case 'circle with fixed diameter'
                theta = (0:0.2:2*pi)';
                x = 200+diameter*cos(theta)/2;
                y = 50+diameter*sin(theta)/2;
                bw{j} = roipoly(im, x, y);
                poly{j} = [x y];                    
        end
    end
    close(h); 
    if ~isempty(file_roi)
        save(file_roi, 'bw', 'poly');  
    end
            
else %elseif exist(file_roi,'file'),
    load(file_roi);
    if ~exist('poly','var')
        if exist('p', 'var') % from the current dragable rois
            poly = p;
        elseif exist('boundary', 'var')
            poly = boundary;
        end
        [m, n] = size(im);
        bw = poly2mask(poly(:,1), poly(:,2), m,n);
    end
    % covert from cells of length 1 to normal vectors.
   if ~iscell(poly) && ~isempty(file_roi)
            temp = cell(1); temp{1}= poly; clear poly; poly = temp; clear temp;
            temp = cell(1); temp{1} = bw; clear bw; bw = temp; clear temp;
            save(file_roi, 'bw', 'poly');
   end        
end
% Lexie on 1/30/2015
if length(size(bw)) == 3
    bw = sum(bw,3);
end
return;