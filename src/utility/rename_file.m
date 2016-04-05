% function rename_file(old_str, new_str)

% Copyright: Lexie Qin Qin and Shaoying (Kathy) Lu 2014
% Email: kalu@ucsd.edu
function rename_file(old_str, new_str)
dir_data = dir('*.*');
file_list = {dir_data.name};
new_name = regexprep(file_list, old_str, new_str);
for iFile = 1:numel(file_list)
    if ~strcmp(file_list{iFile}, new_name{iFile}),
        movefile(file_list{iFile},new_name{iFile});
    end;
end
return;