%function fan_bw = get_fan(num_fans, im, cell_bw, fan_file,varargin)
% parameter_names = {'draw_figure'};
% default_values ={0};

% Copyright: Shaoying Lu and Yingxiao Wang 2011
% This is the previous fluocell3.1 function get_fan_2()
function [fan_bw fan_bd centroid] = get_fan(num_fans, im, cell_bw, fan_file,varargin)
parameter_name = {'draw_figure','center'};
label = bwlabel(cell_bw);
prop = regionprops(label, 'Centroid','Area');
[tt,ii] = max(cat(1, prop.Area));
cx = prop(ii).Centroid(1); cy = prop(ii).Centroid(2);
default_value ={0, [cx cy]};

[draw_figure center] = parse_parameter(parameter_name, default_value, varargin);
cx= center(1); cy = center(2);

cell_bd = find_longest_boundary(cell_bw); % cell bd is closed
diff_bd = diff(cell_bd);
mark = zeros(2,1);
fan_bw = false(size(im));
if ~exist(fan_file, 'file'),
    has_fan_file = 0;
    fan_node = cell(num_fans,1);
    draw_figure = 1;
else
    has_fan_file = 1;
    load(fan_file);
end;
if draw_figure,
    figure; imagesc(im); hold on;
    set(gca, 'FontSize', 16, 'Box', 'off', 'LineWidth',2); axis off;
    title('Please click on two points that define a fan (ClockWise).')
    plot(cx,cy, 'w*');
    plot(cell_bd(:,2), cell_bd(:,1),'w','LineWidth',2);
end;
for i =1:num_fans,
    num_points = 2;
    num_edge = length(cell_bd);
    for j=1:num_points,
        if ~has_fan_file,
            [fan_x(j),fan_y(j)] = ginput(1);
            fan_node{i}(j,:) = [fan_x(j)-cx fan_y(j)-cy];
        else
            fan_x(j) = fan_node{i}(j,1)+cx;
            fan_y(j) = fan_node{i}(j,2)+cy;
        end;
        for k = 1:num_edge-1,
            M = [fan_node{i}(j,1), -diff_bd(k, 2)
                    fan_node{i}(j,2), -diff_bd(k,1)];
             r = [cell_bd(k,2)-cx; cell_bd(k,1)-cy];
             v = M^(-1)*r;
             if v(1)>0 && v(2)>=0 && v(2)<=1,
                 mark(j) = k;
                 p(j, 2) = cx+(fan_x(j)-cx)*v(1);%x
                 p(j,1) = cy+(fan_y(j)-cy)*v(1);%y
                 if draw_figure,
                 plot(p(j,2), p(j,1),'r*');
                 end;
                 break;
             end;
        end;
    end; %j
    clear fan_x fan_y;
    if mark(2)>=mark(1),
          index = mark(1)+1:mark(2)-1;
    else
          index = [mark(1)+1:num_edge, 2:mark(2)-1];
    end;
    temp = roipoly(im, [cx; p(1,2); cell_bd(index,2); p(2,2);cx], ...
        [cy; p(1,1); cell_bd(index,1); p(2,1);cy]);
    fan_bw = fan_bw | temp;
end;

fan_bd = bwboundaries(fan_bw, 4, 'noholes');
if draw_figure,
    for i = 1:length(fan_bd),
        plot(fan_bd{i}(:,2), fan_bd{i}(:,1), 'b--','LineWidth',2);
    end;
end;
% draw figure
% This statement make it only work for one fan region
% This is different from Steven's version
% fan_bd = find_longest_boundary(fan_bw);
% 
% if draw_figure,
%     for i = 1:length(fan_bd),
%         plot(fan_bd(:,2), fan_bd(:,1), 'b--','LineWidth',2);
%     end;
% end;

if ~has_fan_file,
    save(fan_file, 'fan_node');
end;
centroid = [cx; cy];
return;