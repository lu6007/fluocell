function data = track_init_data(cell_name)
%root = 'C:\sylu\copy_07_19_2009-xxx\sof\fluocell_2.1\data\fak_pax\';
root = 'F:\data\yingli_0307\';
switch cell_name,
    case 'fak_pax',
        % This cell is extending at the front with no flow
        data.path = strcat(root, 'fak_pax\fak_paxillin\');
        data.first_file = 'leona20x5_w1FITC_t01.TIF';
        data.pattern = {'1FITC', '2TRITC'}; 
        data.channel = {'FAK', 'Pax'};
        data.index_pattern = '%02d';
        data.image_index = [1:9, 11:53]';
        % For plotting
        data.lines = {'-', '--'};
        data.region_name = {'Nascent', 'Front', 'Intermediate', 'Body'};
        data.time_interval = 3;
        % For segmentation
        data.thresh = [60 30]; % fak - 60; paxillin - 30
        % For calculating FRET ratio
        data.factor = 2;
        % For displaying images and plotting tracks
        data.image_axis = [47 411 90 495]'; %front
        data.track_index = [333:335 341 383 385:386 387 389 414 415 448]';
        % data.track_index = [333:335 341 383 385:389 413:415 448 610 648]';
        %data.image_frame = [53 813 82 809]';
        % data.movie_frame = [35 791 83 809]';
        %data.image_axis = [264 455 247 448]; %body
        %data.track_index = [5 6 7 81 92 150 163 315 399 444]';
        % data.image_frame = ?
    case 'ct01',
        % This Cell is contracting at the back with no flow
        data.path = strcat(root, 'ct01\ct01\');
        data.first_file = 'fm02_w2EGFP Olympus_t002.TIF';
        data.pattern = {'2EGFP Olympus', '1RFP'};
        data.channel = {'FAK', 'Pax'};
        data.index_pattern = '%03d';
        data.image_index = [2:11, 15:44]';
        data.lines = {'-', '--'};
        data.region_name = {'Tail', 'Near Tail', 'Near Body', 'Body'};
        data.time_interval = 3;
        data.thresh = [30 60];
        data.factor = 0.5;
        data.image_axis = [90 340 300 600]';
        data.image_frame = [18 694 107 721]';
        data.track_index =  [28 31 33 36 37 49 51]';
        data.movie_frame = [31 709 83 696]';
    case 'ct06',
        data.path = strcat(root, 'ct06\');
        data.first_file = 'leona20x_w1FITC_t01.TIF';
        data.pattern = {'1FITC', '2TRITC'};
        data.channel = {'FAK', 'Pax'};
        data.index_pattern = '%02d';
        %data.image_index = 1;
        data.image_index = [1:13 15:66]';
        data.lines = {'-', '--'};
        data.region_name = {'Nascent', 'Front', 'Body', 'Tail'};
        data.time_interval = 3;
        data.thresh = [30 30];
        data.factor = 1;
        data.image_axis = [251 655 23 356]';
        %data.image_frame = [18 694 107 721]';
        data.track_index =...
            [462 478 569 600 482 724 313 423 498 330 361 1277]';
        %data.movie_frame = [31 709 83 696]';
    case 'ct03',
        data.path = strcat(root, 'ct03\');
        data.first_file = 'leona20x7_w1FITC_t01.TIF';
        data.pattern = {'1FITC', '2TRITC'};
        data.channel = {'FAK', 'Pax'};
        data.index_pattern = '%02d';
        data.image_index = [1:18]';
        data.lines = {'-', '--'};
        data.region_name = {'Tail', 'Near Tail', 'Near Body', 'Body'};
        data.time_interval = 2;
        data.thresh = [30 45];
        data.factor = 1;
        %data.image_axis = [90 340 300 600]';
        %data.image_frame = [18 694 107 721]';
        data.track_index =  [27 55 56 26 36 90 53 216 162]';
        %data.movie_frame = [31 709 83 696]';
    case 'sh01'
        % This cell is contracting under flow 
        data.path = strcat(root, 'sh01\sh01\');
        data.first_file = 'sh03_w2EGFP Olympus_t18.TIF';
        data.pattern = {'2EGFP Olympus', '1RFP'};
        data.channel = {'FAK', 'Pax'};
        data.index_pattern = '%02d';
        data.image_index = [18:21, 29:99]';
        data.lines = {'-', '--'};
        data.region_name = {'Tail', 'Near Tail', 'Near Body', 'Body'};
        data.time_interval = 2;
        data.thresh = [90 110]; % fak - 60; paxillin - 30
        data.factor = 1;
        data.image_axis = [110 450 50 320]';
        data.image_frame = [188 639 80 682]';
        data.track_index = [4 7 9 53 79]';
        data.movie_frame = [33 481 84 624]';
    case 'sh00'
        % This cell is first contracting then expanding under flow 
        % However the FAs appeared to be very big, and not in a 
        % puctuated pattern as in other cells. Maybe the FAs were not
        % well focused?
        data.path = strcat(root, 'sh00\');
        data.first_file = 'sh00_3m2_w2EGFP Olympus_t02.TIF';
        data.pattern = {'2EGFP Olympus', '3RFP'};
        data.channel = {'FAK', 'Pax'};
        data.index_pattern = '%02d';
        data.image_index = [2:19, 21:33]';
        data.lines = {'-','--'};
        data.region_name = {'Tail', 'Near Tail', 'Near Body', 'Body'};
        data.time_interval = 2;
        data.thresh = [90 110]; % fak - 60; paxillin - 30
    case 'sh11'
        data.path = strcat(root, 'sh11\sh11\');
        data.first_file = 'GFP11.001';
        data.pattern ={'GFP11', 'GFP12'};
        data.channel = {'FAK', 'Pax'};
        data.index_pattern = '%03d';
        data.image_index = (5:75)';
        data.lines = {'-', '--'};
        data.region_name ={'Front', 'Near Front', 'Near Body', 'Body'};
        data.time_interval = 3; % need to check with Yingli
        data.thresh = [60 30]; %Because the FAs was not very dynamics, 
        % these threshold values have not been adjusted yet. I only made
        % the filtered FAK and Pax images and looked at the FRET ratio.
    case '09_08', % This is a good cell with significant extension at the front
        data.path = strcat(root, '09_08_2010\');
        data.first_file = 'ct03_3m60x_w2FITC-EGFP 490-528 side_t01.TIF';
        data.pattern = {'w2FITC-EGFP 490-528', 'w3TRITC 555-617'};
        data.channel = {'FAK', 'Pax'};
        data.index_pattern = 't%02d';
        data.image_index = [1:9, 11:31, 33:41, 50:86]';
        %data.image_index = 1:86;
        data.lines = {'-', '--'};
        data.region_name = {'Front', 'Near Front', 'Near Body', 'Body'};
        data.time_interval = 3; % min, checked with imfinfo
        data.thresh = [60 30];
        data.image_axis = [781 1291 195 770]';
        data.track_index = [248 417 505 485 589 622 618 619 662 748 757 735 803]'; % front
    case 'ct31',
        data.path = strcat(root, '08_20_2011\');
        data.first_file = 'ct31_2m_w2488-528 FITC_t02.TIF';
        data.pattern = {'w2488-528 FITC', 'w3568-617 TRITC'};
        data.channel = {'FAK', 'Pax'};
        data.index_pattern = 't%02d';
        data.image_index = [2:4,8:27]';
        data.lines = {'-', '--'};
        data.region_name = {'Tail', 'Near Tail', 'Near Body', 'Body'};
        data.time_interval = 2;
        data.thresh = [30 45];
        data.factor = 1;
        %data.image_axis = [90 340 300 600]';
        %data.image_frame = [18 694 107 721]';
        %data.track_index =  [27 55 56 26 36 90 53 216 162]';
        %data.movie_frame = [31 709 83 696]';
end;
return;