% function plot_box_with_error_bar(type, mean_v, err_v, pcr_v,varargin);

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function plot_box_with_error_bar(type, mean_v, err_v, pcr_v,varargin);
[shift] = parse_parameter({'shift'},{0},varargin); 
n = length(mean_v);
my_color = get_my_color();
tan_pink = my_color.tan_pink;
tan_blue = my_color.light_blue;
width = 1/3;
lw = 3; % line width
for i = 1:n,
    surf([i-width, i+width], pcr_v(i,1:2), zeros(2,2), 'EdgeColor', 'none',...
        'FaceColor',tan_blue );
    surf([i-width, i+width], pcr_v(i, 2:3), zeros(2,2),'EdgeColor', 'none',...
        'FaceColor', tan_pink);
    plot(i, mean_v(i), 'ko', 'LineWidth',lw, 'MarkerSize', 8);
    low = mean_v(i)-err_v(i);
    high = mean_v(i)+err_v(i);
    plot([i i], [low, high], 'k-', 'LineWidth', lw);
    plot([i-.25*width, i+.25*width], [low, low], 'k-','LineWidth', lw);
    plot([i-.25*width, i+.25*width], [high, high], 'k-','LineWidth', lw); 
%     text(i, high+shift, type{i},'FontSize', 16,'FontWeight', 'bold',...
%         'HorizontalAlignment', 'left','Rotation', 90);
end;

return;