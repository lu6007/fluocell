function data =init_data(experiment)
    root = 'D:\data\eddie\';
    data.is_donor_over_fret = 1;
    data.ratio_bound = [5 15];
    data.intensity_bound = [1 1000];
    data.threshold = 1000;
    data.filter_size = 61;
    data.donor_channel = 'DISH21';
    data.fret_channel = 'DISH22';
    data.dic_channel = 'DISH24';
    switch experiment,
        case '1118_nogm1',
            data.p = strcat(root, '1118\nogm1\');
            data.first_donor_file = strcat(data.p, 'DISH21.002');
            data.image = {{'002',1}, {'004',1}, {'006',1}, {'008',1}, {'010',1}, {'012',1}, ...
                {'014',1}, {'016',1}, {'018',1}, {'020',1}, {'022',1}, {'024',1}};
        case '1118_gm1',
            data.p = strcat(root, '1118\gm1\');
            data.first_donor_file = strcat(data.p, 'DISH21.002');
            data.image ={{'002',1}, {'004',1}, {'006',1}, {'008',1}, {'010',1}, {'012',1}...
              {'014',1}, {'016',1}, {'020',1}, {'022',1}, {'024',1}, {'026',1}, {'028',1}};
        case '1126_nogm2',
            data.p = strcat(root, '1126\nogm2\');
            data.first_donor_file = strcat(data.p, 'DISH21.002');
            % data.image = {{'002',1}};
            data.image ={{'002',1},{'004', 1}, {'006',1}, {'008',1}, {'010',1},...
               {'012',1}, {'014',1}, {'016',1},{'018',2}, {'020',1}};
        case '1126_gm2',
            data.p = strcat(root, '1126\gm2\');
            data.first_donor_file = strcat(data.p, 'DISH21.002');
            data.image ={{'002',1},{'006',1}, {'008',1}, {'010',1},...
                {'012',2}, {'014',1}, {'016',1},{'018',2}, {'020',1}, {'022',1}};

    end;
    data.output_file = strcat(data.p, 'output\result.mat');
return;