% function [bw poly] = get_polygon(im, file_roi, title_str)
% define the region of interest.
% Allow the choice of more than 1 polygon. 
% The output are two cells of vectors.
% parameter_names = {'num_polygons', 'polygon_type','diameter','method'};
% default_values = {1, 'any', 200,'manual'};

% Copyright: Shaoying Lu and Yingxiao Wang 2011
% Modified by Lexie Qin Qin and Shaoyng Lu 2014

function [bw, poly] = get_polygon(im, file_roi, title_str, varargin)
parameter_names = {'num_polygons', 'polygon_type','diameter', 'method'};
default_values = {1, 'any', 200,'manual'};
[num_polygons, polygon_type, diameter, method] = ...
    parse_parameter(parameter_names, default_values, varargin);
if ~exist(file_roi,'file')
    switch method
        case {'manual','m'}
            h = figure; imagesc(im); colormap jet; title(title_str); hold on;
                bw = cell(num_polygons, 1);
                poly = cell(num_polygons, 1);
                for j = 1:num_polygons
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
        %     end;
            close(h);
        case {'auto','a'}
            [num_rows, num_cols] = size(im);
            bw = cell(num_polygons, 1);
            poly = cell(num_polygons, 1); 
            
            ss = 20; % size-1
            %first region
            x = [1; 1+ss; 1+ss; 1; 1];
            y = [1; 1; 1+ss; 1+ss; 1];
            bw{1} = roipoly(im,x,y); 
            poly{1} = [x y]; clear x y;
            
            %second region
            x = [num_cols-ss; num_cols; num_cols; num_cols-ss; num_cols-ss];
            y = [1; 1; 1+ss; 1+ss; 1];
            bw{2} = roipoly(im,x,y); 
            poly{2} = [x y]; clear x y;
            
            %third region
            x = [1; 1+ss; 1+ss; 1; 1];
            y = [num_rows-ss; num_rows-ss; num_rows; num_rows; num_rows-ss];
            bw{3} = roipoly(im,x,y); 
            poly{3} = [x y]; clear x y;
            
            %fourth region
            x = [num_cols-ss; num_cols; num_cols; num_cols-ss; num_cols-ss];
            y = [num_rows-ss; num_rows-ss; num_rows; num_rows; num_rows-ss];
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
           temp_bw = bw;
           temp_poly = poly;
           clear bw poly;
           bw{1} = temp_bw{min_index};
           poly{1} = temp_poly{min_index};
           
%            h = figure; imagesc(im); title(title_str); hold on;
%            plot(poly{1}(:,1), poly{1}(:,2), 'r', 'LineWidth', 1);
%            close(h);
           clear temp_bw temp_poly;
    end
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