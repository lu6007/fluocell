function [folder_name, success] = my_uigetdir(folder_name, title_str)
output = uigetdir(folder_name, title_str);
if isa(output,'numeric'),
    success = 0;
    folder_name = [];
else %output is a tring
    success = 1;
    folder_name = strcat(output,'\');
end