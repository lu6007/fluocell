% initialize data  for the various applications.
function data = polarity_init_data(name)
root = 'C:\sof\fluocell_4.2\data\';
switch name,
   case 'akt_1', 
        data.path = strcat(root, ...
            'PH-Akt-GFP_1\');
        data.prefix = 'AKT-PH-YFP_PDGF5';
        data.channel_number = 2;
        data.time_pt = 119; % the largest time point in the analysis.
        data.PDGF_add = 68; % the frame before PDGF was added.
        data.PDGF_time = 497160;
        data.DRUG_add = 'none';
        data.threshold = 0.01;
        data.flip_cell = 1;
        data.subtract_background = 1;
        data.median_filter = 1;
        data.crop_image = 1;
end;
return;