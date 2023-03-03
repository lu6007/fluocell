% function data =init_figure(data);
% Initialize the number of figures and is_channel1_over_channel2
% Figure location, size, fonts, axis

% Copyright: Shaoying Lu and Yingxiao Wang 2012
function data = init_figure(data)
switch data.protocol
    case {'FRET', 'Ratio','FLIM', 'STED', 'FRET-Split-View'}
        num_figures = 3;
    case 'FRET-Intensity'
        num_figures = 4;
    case 'FRET-Intensity-2'
        num_figures = 5;
    case 'FRET-DIC'
        num_figures = 4;
    case 'FRET-Intensity-DIC'
        num_figures = 5;
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
disp('Function init_figure: ')
disp(strcat('Input: data.protocol=', data.protocol))
disp(strcat('Output: data.num_figures=', num2str(num_figures)))
return;
