% function save_figure(figure_number, path, name, resolution)

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function save_figure(number, path, name, resolution)
h = figure(number);
saveas(h, strcat(path, name, '.fig'));
print(strcat('-r',num2str(resolution)), '-dtiff', strcat(path, name, '.tiff'));
return;