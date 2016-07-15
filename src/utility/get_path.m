
% Copyright: Shaoying Lu and Yingxiao Wang 2011

function default_path = get_path()
root_path = 'C:\sof\fluocell_4.1\';
last_path = strcat(root_path, 'src\utility\last_visited_path.mat');
if exist(last_path, 'file'),
    load(last_path);
    default_path= path;
else
    default_path = eval('pwd');
end;
return;