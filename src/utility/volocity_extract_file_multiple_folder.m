% function extract_file_multiple_folder(path, varargin)
% Extract files from subfolders generaled by the 3D image visualization
% software "Volocity"
% (1) List the subfolders in the path folder
% (2) In each subfolder named 'XY point*', move the files outside from the 'T*' folders
% (3) Remove the 'T*' folders within the subfolders
% 
% Example:
% p = 'E:\sof\data\bristow\5_18_2013\shFAPa\shFAPa3 tiffs\';
% extract_file_multiple_folder(p);
% Note the '\' at the end of the line is necessary.
%

% Copyright: Shaoying Lu and Yingxiao Wang 2011-2013 
% Email: shaoying.lu@gmail.com
function volocity_extract_file_multiple_folder(path, varargin)
    parameter_name = {'folder_pattern'};
    default_value = {'XY point*'};
    % folder_pattern: the pattern is attached to the path for the list
    % of folder to be processed. It can be the default value or '' if
    % no special pattern needs to be attached.
    folder_pattern = parse_parameter(parameter_name, ...
    default_value, varargin);
    folder = dir(strcat(path, folder_pattern)); 
    subfolder_pattern = 'T0*';
    
    %%
    if ~isempty(folder),
        num_folders = length(folder);
        for i = 1:num_folders,
            p = strcat(path, folder(i).name,'\');
            subfolder = dir(strcat(p,subfolder_pattern));
            if ~isempty(subfolder),
                num_subfolders = length(subfolder);
                for j = 1:num_subfolders,
                    subname = strcat(p,subfolder(j).name);
                    movefile(strcat(subname,'\','*'),p);
                    rmdir(subname);
                end
            end %if ~isempty(subfolder),
        end;
    end; %if ~isempty(folder),
   
%%
return;