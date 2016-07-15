% function test_seq(lib_name, varargin)
% data = seq_init_data(lib_name);
% parameter_name = {'start_seq', 'num_seqs', 'get_info'};
% parameter_default = {data.start_seq, data.num_seqs, 'false'};
% Parameter priorities: (1) input from command line,  
% (2) specified in seq_init_data. 
%
% Example: 
% >> data = seq_init_data('LIB03');
% >> test_seq(data,'start_seq', 10e6+1, 'num_seqs', 1e3, 'get_info', false);

% Author: Shaoying Lu , shaoying.lu@gmail.com
% Date: 03/24/2016
function test_seq(data, varargin)
% Parameter priorities: (1) input from command line,  
% (2) specified in seq_init_data. 
parameter_name = {'start_seq', 'num_seqs', 'get_info'};
parameter_default = {data.start_seq, data.num_seqs, false};
[start_seq, num_seqs, get_info] = parse_parameter(parameter_name,...
    parameter_default, varargin);

output = true;
%% Load sequences
% Initialize library information
% 56 seconds for 1 million sequences of all three libraries
% Original sequece 
p = data.path;
library_file = data.library_file;
start_code = data.start_code;
num_codes = data.num_codes;

% Initialize the library
if output,
    display(strcat('Library file: ', library_file));
end;

% Extract the seq_array from start_seq and extract each sequence from
% start_code
seq_array = get_seq_array(strcat(p, library_file), 'start_seq', start_seq, 'num_seqs', num_seqs, ...
'start_code', start_code, 'num_codes', num_codes, 'get_info', get_info);


% % Counting the frequency of ATCG as sanger sequencing
% % Plot the counts. 
% freq = zeros(18, 4); % ' a t c g'  
% for j = 1:num_codes,
%     count = basecount(seq_array(:,j));
%     freq(1, j) = count.A;
%     freq(2, j) = count.T;
%     freq(3, j) = count.C;
%     freq(4, j) = count.G;
% end;
% figure; hold on; freq_color = ['rgbk'];
% title(library_file);
% for k= 1:4,
%     plot(freq(k,:),freq_color(k));
% end;
% legend('A', 'T', 'C', 'G');
% xlabel('Position'); ylabel('Count');
% 
% % Draw the sequence logo. 
% if num_codes<1000, 
%     aa_seq_array = nt2aa(seq_array, 'ACGTOnly', false);
%     seqlogo(aa_seq_array);
% end;


% Count the frequency of unique sequences. And list the squences
% in the order from the most to lease frequent upto 3 sequences. 
[seq_unique, index_unique, index_array] = unique(seq_array, 'rows');
count = hist(index_array, length(index_unique));
% sum(count == 1) + sum(count >=2) should be 1000
count_sort = sort(count, 'descend');
count_unique = unique(count_sort); % in ascending order
nn = length(count_unique);
for j =nn:-1:max(1, nn-10),
    cuj = count_unique(j);
    % Count
    display(strcat(num2str(cuj)));
    display(nt2aa(seq_unique(count == cuj,:), 'ACGTOnly', 'false') );
end;

clear lib_index library_file aa_seq_array;
return; 
