% function data =init_figure(data);
% Initialize the number of figures and is_channel1_over_channel2
% Figure location, size, fonts, axis

% Copyright: Shaoying Lu and Yingxiao Wang 2012
function data = init_figure(data)
switch data.protocol
    case 'FRET'
        num_figures = 3;
%         if ~isfield(data,'is_channel1_over_channel2'),
%             data.is_channel1_over_channel2 = 1;
%         end;
    case 'FRET-Intensity'
        num_figures = 4;
%         if ~isfield(data,'is_channel1_over_channel2'),
%             data.is_channel1_over_channel2 = 1;
%         end;
    case 'FRET-Intensity-2'
        num_figures = 5;
%         if ~isfield(data,'is_channel1_over_channel2'),
%             data.is_channel1_over_channel2 = 1;
%         end;
    case 'FRET-DIC'
        num_figures = 4;
%         if ~isfield(data,'is_channel1_over_channel2'),
%             data.is_channel1_over_channel2 = 1;
%         end;
    case 'FRET-Intensity-DIC'
        num_figures = 5;
%         if ~isfield(data,'is_channel1_over_channel2'),
%             data.is_channel1_over_channel2 = 1;
%         end;
    case {'FLIM', 'STED'}
        num_figures = 4;
    case 'Intensity'
        num_figures = 2;
    case 'Intensity-DIC'
        num_figures = 3;
end
data.num_figures = num_figures;
if ~isfield(data, 'f')
    f = zeros(num_figures, 1);
    for i =1:num_figures
        f(i) = figure;
        set(gcf, 'ColorMap', jet);
        set(gca, 'FontSize', 12, 'FontWeight','bold',...
            'Box', 'off', 'LineWidth', 2);
    end
    data.f = f;
end
return;
