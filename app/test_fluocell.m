% test_Fluocell
% o   2.1.1   FRET ANALYSIS- Visualize the ECFP/FRET Ratio Images
% o   2.1.2   FRET ANALYSIS- Make Movies
% o   2.2     INTENSITY ANALYSIS- Polarity Analysis
% o   2.3.1   FRET ANALYSIS- Tracking Cells and Regions of Interest
% o   2.3.2   FRET ANALYSIS- FA Detection and Subcellular Quantification 

%%For each part, please right click and choose "Evaluate current section"
%%or use ctrl+enter.
enable_pause = 1;

%% o   2.1.1  FRET ANALYSIS- Visualize the ECFP/FRET Ratio Images   **********
% p = strcat(root, 'fluocell_sample/');
temp = sample_init_data('src_pax','');
% The data.mat file was generated by running fluocell using GUI.
% After a successful run, rung
% >> data = fluocell_data;
% >> save(strcat(data.path, 'output/data.mat'), 'data');
data_file = strcat(temp.path, 'output/data.mat');
res = load(data_file);
data = res.data;
data.path = temp.path;
data.first_file = strcat(data.path, '2-11.001');
save(data_file, 'data');
batch_update_figure(data);

%% o  2.1.2  FRET ANALYSIS- Make Movies   ********* Run the section 2.1.1 first;
data = sample_init_data('src_pax', 'make_movie');
make_movie(data); 
pause_str = 'test_fluocell: paused. Press any key to close current figures and continue.';
if enable_pause
    disp(pause_str);
    pause; 
end
close all; clear data; 

%% o   2.2  INTENSITY ANALYSIS-Polarity Analysis*********
temp = sample_init_data('akt_1', '');
data_file= strcat(temp.path, 'output/data.mat');
res = load(data_file);
data = res.data;
data.path = temp.path;
data.first_file = strcat(data.path, '2-11.001');
save(data_file, 'data');
batch_update_figure(data);

cell_name = 'akt_1';
data = sample_init_data(cell_name);
single_cell_analyzer('akt_1',data);
if enable_pause
    disp(pause_str);
    pause; 
end
close all; clear data;

%% o   2.3.1   FRET ANALYSIS- Tracking Cells and Regions of Interest ********
% temp = sample_init_data('src_pax','');
% data_file = strcat(temp.path, 'output/data.mat');
% res = load(data_file);
% data = res.data;
temp = sample_init_data('tracking_ex', '');
data_file =strcat(temp.path, 'output/data.mat');
res = load(data_file);
data = res.data; 
data.path = temp.path;
data.output_path = strcat(data.path, 'output/');
data.first_file = strcat(data.path, 'cfp_t1.tif');
save(data_file, 'data');
%
data = batch_update_figure(data);
disp('Check output, and confirm that the next two rows show same numbers.');
disp('[1.0172    1.0321    1.0541    1.0721    1.0825]');
disp(data.ratio{1}(1:5));
if enable_pause
    disp(pause_str);
    pause; 
end
close all; 

%% o   2.3.2   FRET ANALYSIS- FA Detection and Subcellular Quantification ***** 
% run 2.3.1 before this section
cell_name = 'src_pax';
data = sample_init_data(cell_name, 'batch_detect_cell');
batch_detect_cell(cell_name, data);

%% o   2.3.3   FRET ANALYSIS- FA Detection and Subcellular Quantification ***** 
% Run 2.3.2 before this section
clear data; 
cell_name = 'src_pax';
data = sample_init_data(cell_name, 'batch_detect_fa');
batch_detect_fa(cell_name, data);
compute_fa_property(cell_name, data, 'remove_data', 0, 'save_file', 0);      
      
