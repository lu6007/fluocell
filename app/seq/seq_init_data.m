function data = seq_init_data( lib_name )
root = 'E:/data/2015/mint_1029/';

switch lib_name, 
    case 'LIB03' % Additiona libraries LIB01 and LIB02
        data.path = strcat(root, 'mutseq_firstrun/');
        data.library_file = 'LIB03_R1.fastq';
        data.start_seq = 1;         % 4e6+1
        data.num_seqs = 1e3; % 2e6
        data.start_code = 40;
        data.num_codes = 21;
    case 'LIB02' % Additiona libraries LIB01 and LIB02
        data.path = strcat(root, 'mutseq_firstrun/');
        data.library_file = 'LIB02_R1.fastq';
        data.start_seq = 1;         % 4e6+1
        data.num_seqs = 1e3; % 2e6
        data.start_code = 40;
        data.num_codes = 21;
    case 'aligned_lib3' % Aligned sequence of mutation region only
        data.path = strcat(root, 'mutregion/');
        data.library_file = 'lib3.mutregion.fastq';
        data.start_seq = 4e6+1;
        data.num_seqs = 1e3; % 2e6
        data.start_code = 1;
        data. num_codes = 21;
        % Results of 'aligned_lib3' in 12/2/2015 email. 
        % (1) The high-frequency counts are much lower in frequency
        % 20/2M in comparison to the original sequence which had 
        % about 1000 counts/2M. 
        % (2) Most of the identified sequences had many 3-5 Xs out 
        % of 7 residues in them. 
        % (3) The only good one "EGTYGVV" could not find a match 
        % in blast. 
        % Therefore, I suspect that there is some kind of 
        % mis-alignment. 

end;

return;

