% function save_path(path);

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function save_path(path);
root_path = 'C:\sof\fluocell_4.1\';
last_path = strcat(root_path, 'src\utility\last_visited_path');
save(last_path, 'path');
return;