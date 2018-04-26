% function seq_array = get_seq_array( file_name, varargin)
% parameter_name = {'start_seq', 'num_seq', 'start_code', 'num_code', ...
%     'get_info','select_good_sequence'};
% default_value = {1, 1e3, 1, 1, false, 0}; 
%
% Extract [40, 61] from the whole sequence without alignment
% (1) load sequence
% (2) check alignment - realign, not doing for now
% (3) output the sequence
%
% Example: see the test_seq() function. 

% Author: Shaoying Lu , shaoying.lu@gmail.com
% Date: 03/24/2016
function [seq_array, total_num_seq] = get_seq_array(file_name, varargin )
parameter_name = {'start_seq', 'num_seq', 'start_code', 'num_code', ...
    'get_info','select_good_sequence'};
default_value = {1, 1e3, 1, 1, false, 0}; 
[start_seq, num_seq, start_code, num_code, get_info, select_good_sequence] = ...
    parse_parameter(parameter_name, default_value, varargin);

% read the library and check sequence
if get_info
    info = fastqinfo(file_name);
    fprintf('Number of squences is %d. \n', info.NumberOfEntries);
    total_num_seq = info.NumberOfEntries;
    clear info; 
else
    total_num_seq = 0;
end

end_seq = start_seq+ num_seq - 1;
% start_code = 40; num_code = 21;
end_code = start_code + num_code -1;
code_index = start_code:end_code;
% [header, seq_cell, score] = fastqread(library_file, 'blockread', [start_seq end_seq]);
[~, seq_cell, ~] = fastqread(file_name, 'blockread', [start_seq end_seq]);

temp = char(seq_cell); clear seq_cell;
seq_array_all = temp(:, code_index); clear temp good_seq;

% Align the sequence
% But Alignment is too slow. So skip alignment for now. 
%primer = 'AAGCCGGGTTCTGGTGAGGGTTCTGAGAAGATCNNNNNNNNNTAC';
% for i = 1:num_seq,
%         % [score, alignment, start] = swalign(seq_cell{i}, primer, 'Alphabet', 'NT');
%         [~, ~, start] = swalign(seq_cell{i}, primer, 'Alphabet', 'NT');
%         good_seq(i) = (start(1)-start(2)+1 == 7);
% %         shift = start(1)-start(2)+1;
% %         if shift~= 7,
% %             display( sprintf('Sequence %d is misaligned. Shift = %d, and Score = %f', i,shift, score));
% %             if score>=30 && shift>0 && shift<18,
% %                 display(strcat(seq_cell{i}(start(1)-start(2)+1: start(1)-start(2)+54)));
% %             end;
% %         end;
% end;

if select_good_sequence == 1
    num_Ns = sum(seq_array_all == 'N', 2); 
    good_seq = (num_Ns<=5); clear num_Ns;
    seq_array = seq_array_all(good_seq, :);
    fprintf('There are %d good sequences. \n', sum(good_seq));
    clear good_seq;
elseif select_good_sequence == 2
%      seq_cell = cellstr(seq_array_all); 
%      tac_location = strfind(seq_cell, 'TAC');
     seq_array = seq_array_all;
else
    seq_array = seq_array_all;
end
clear seq_array_all;

% seqlogo(seq_array);

return;

