% function bd = get_cell_edge_local(img, varargin)
% This function segments an image based on local thresholding.

% Copyright: Kaiwen Zhang, Shaoying Lu and Yingxiao Wang 2013

function bd = get_cell_edge_local(img, varargin)
parameter = {'window_size', 'rad_y','width_factor','brightness_factor','display'};
default = {0, 40, 1, 0.95, 0};
[window_size, rad_y,width_factor,brightness_factor,display] = parse_parameter(parameter,default,varargin);

%% Find rough boundary using single thresholding.
bd = cell_edge_thresh(img,'brightness_factor',brightness_factor);
%bd = cell_edge_kmean(img,3);
% [~,bd] = clean_up_boundary(img,bd,1,9);
% bd = bd{1};
% bd = ceil(bd);

%% Initialize the width(half) and height(half) of the rectangles.
img = double(img);

bd_x = bd(:,2);
bd_y = bd(:,1);
if ~window_size
    rad_y = min(floor((max(bd_y)-min(bd_y))/7),40);
    %rad_y = 30;
    width_factor = max(1,(max(bd_x)-min(bd_x))/(max(bd_y)-min(bd_y)));
    %width_factor = 1;
end
cent = 1;
ind = 1;
bd = zeros(size(img));
if display
    figure;imagesc(img);hold on;plot(bd_x,bd_y,'r','LineWidth',2)
end
%%
for i = 1:length(bd_x)
    if i > 1
        %% Keep searching for next rectangle center and calculate the threshold inside.
        if abs(bd_y(i) - bd_y(cent)) >= 0.5*rad_y || abs(bd_x(i) - bd_x(cent)) >= 0.5*rad_y
            
            cent = i;
            
            if bd_y(cent)-rad_y <= 0
                y_init = 1;
            else
                y_init = bd_y(cent)-rad_y;
            end
            if bd_x(cent)-rad_x <= 0
                x_init = 1;
            else
                x_init = bd_x(cent)-rad_x;
            end
            if bd_y(cent)+rad_y > size(img,1)
                y_end = size(img,1);
            else
                y_end = bd_y(cent)+rad_y;
            end         
            if bd_x(cent)+rad_x > size(img,2)
                x_end = size(img,2);
            else
                x_end = bd_x(cent)+rad_x;
            end
            
            mask = zeros(size(img));
            mask(y_init:y_end,x_init:x_end) = 1;
            local_img = mask.*img;
            
            rect = [x_init y_init 2*rad_x 2*rad_y];
            rect_img = imcrop(img,rect);
            thresh = my_graythresh(uint16(rect_img));
          
            %local_bd{ind} = cell_edge_thresh(local_img,'threshold',thresh,'min_area',floor(rad_y^2/10));
            local_bd{ind} = cell_edge_thresh(local_img,'threshold',thresh,'min_area',10);            
            temp = sparse(local_bd{ind}(:,1),local_bd{ind}(:,2),1,size(img,1),size(img,2));
            bd = bd + temp;
            clear temp
            
%             if display
%                 hold on;plot(local_bd{ind}(:,2),local_bd{ind}(:,1),'m');
%             end
            ind = ind + 1;
        else
            continue        
        end
    else
        %% Creates the first rectangle around the first boundary point.
        rad_x = floor(width_factor*rad_y);
        
        if bd_y(cent)-rad_y <= 0
            y_init = 1;
        else
            y_init = bd_y(cent)-rad_y;
        end
        if bd_x(cent)-rad_x <= 0
            x_init = 1;
        else
            x_init = bd_x(cent)-rad_x;
        end
        if bd_y(cent)+rad_y > size(img,1)
            y_end = size(img,1);
        else
            y_end = bd_y(cent)+rad_y;
        end
        if bd_x(cent)+rad_x > size(img,2)
            x_end = size(img,2);
        else
            x_end = bd_x(cent)+rad_x;
        end            
        mask = zeros(size(img));
        mask(y_init:y_end,x_init:x_end) = 1;
        local_img = mask.*img;
        
        rect = [bd_x(cent)-rad_y bd_y(cent)-rad_y 2*rad_y 2*rad_y];
        rect_img = imcrop(img,rect);
        thresh = my_graythresh(uint16(rect_img));           
        local_bd{ind} = cell_edge_thresh(local_img,'threshold',thresh,'min_area',10);
        temp = sparse(local_bd{ind}(:,1),local_bd{ind}(:,2),1,size(img,1),size(img,2));
        bd = bd + temp;
        clear temp
        
%         if display
%             hold on;plot(local_bd{ind}(:,2),local_bd{ind}(:,1),'m');
%         end
        ind = ind + 1;        
    end
end

bd = (bd>0);
bd = find_longest_boundary(bd);

if display
    hold on;plot(bd(:,2),bd(:,1),'m','LineWidth',2)
end

end
    
    
    