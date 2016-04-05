% function fret_file = get_fret_file(first_channel_file)
% get the file name for saving the FRET ratio images
% This is the file I/O interface of Fluocell
% Input: first_channel_file (file name with the full path)

% Copyright: Shaoying Lu 2014
function fret_file = get_fret_file(data, first_channel_file)
        % ratio_image_file and file_type
       ratio_str = strcat(num2str(data.ratio_bound(1)),'-', num2str(data.ratio_bound(2)),'/');
       [p, ~, post_fix] = fileparts(first_channel_file);
       l1 = length(p)+1; l2 = length(first_channel_file);
       pstr = strcat(first_channel_file(1:l1), 'output/', ratio_str);
       %
       if ~exist(pstr,'dir') && isfield(data, 'save_processed_image') && data.save_processed_image, 
           mkdir(pstr)
       end;
       temp_file = strcat(pstr, first_channel_file((l1 + 1) : l2));
       fret_file = regexprep(temp_file, data.channel_pattern{1}, 'ratio'); clear temp_file;
       %fret_file = regexprep(data.file{1}, data.channel_pattern{1}, 'ratio'); clear temp_file;
return;