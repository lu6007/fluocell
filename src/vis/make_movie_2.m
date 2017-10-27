% function movie=make_movie_2(movie_info);
% Example:
% >> 
% data = init_data('10_24_dish21');
% image_index = [8:10, 12:14, 16:17, 19:24,28:36,43:55];
% movie.path = data.path;
% movie.first_file = data.first_cfp_file;
% movie.channel_pattern = data.channel_pattern;
% movie.index_pattern = data.index_pattern;
% movie.image_index = image_index;
% movie.cbound = data.pax_cbound;
%
% % Make movie showing the FRET of CFP/YFP and intensity of mcherry
% % 1: intensity;  2: fret; 3: fret and intensity;
% movie.type = 3; % fret and intensity
% movie.ibound = [0 3000];
% movie.rbound = [0.5, 0.8];
% movie.color_type = 'gray';
% movie.title = 'FRET (ECFP/Ypet) and mCherry paxillin';
% movie.file_name = 'output/src_paxillin.avi';
% movie.time_location = [500, 20];
% movie.event_location = [500, 60];
% movie.event_text = '\downarrow PDGF';
% movie.has_event = (data.index>data.before_pdgf);
% t = load(strcat(data.path, 'time.data')); time = t(:,2)/100; 
% time = (time-data.pdgf_time)/60; %minute
% movie.time = time;
% m = make_movie_2(movie);
%
% New features from make_movie_2();
% The make_movie_2() function also works with a general file pattern 
% and multiple folder data,
% in addition to the metafluo file pattern
%
% The funciton make_movie() takes pre-existing image and 
% assemble them into movies. 
% 

% Copyright: Shaoying Lu and Yingxiao Wang 2011


function movie=make_movie_2(movie_info)

if isfield(movie_info, 'time'),
time = movie_info.time; %minute
end;
%
if isfield(movie_info, 'path_all'),
    movie_info.multiple_folder = 1;
else
    movie_info.multiple_folder = 0;
end;
%

movie_info.median_filter = 1;
movie_info.subtract_background = 1;

if movie_info.multiple_folder,
    % initialize figure
    im = imread(strcat(movie_info.path_all{1}, movie_info.first_file{1}));
    [num_rows num_cols] = size(im);
    base = 100;
    switch movie_info.type,
        case 1, % intensity only
            h = figure('Position', [base,base,base+num_cols, base+num_rows]);
        case 2, % fret 
            h = figure('Position', [base,base,base+num_cols, base+num_rows]);
        case 3, % fret and intensity
            h = figure('Position', [base,base,base+2*num_cols, base+2*num_rows]);
        case 4, % intensity with detected cell boundary and FAs
            h = figure('Position', [base,base,base+num_cols, base+num_rows]);
    end;
    % draw each frame
    num_folders = length(movie_info.path_all);
    jj = 1;
    for kk = 1:num_folders,
        movie_info.current_folder = kk;
        num_frames = length(movie_info.image_index{kk});
        for j = 1:num_frames,
            i = movie_info.image_index{kk}(j);
            switch movie_info.type,
                case 1, % intensity only
                    draw_intensity_frame(h, i, movie_info);
                case 2, % fret only
                    draw_fret_frame(h, i, movie_info);
                case 3, % fret with intensity.
                    draw_fret_intensity_frame(h, i, movie_info);
                case 4,
                    draw_cell_with_detected_fas(h, i, movie_info);
            end;
            if isfield(movie_info, 'time_location'),
            tl = movie_info.time_location;
            el = movie_info.event_location;
            text(tl(1), tl(2), strcat(sprintf('%3.1f ', time(jj)), ' min'),...
                'Color', 'w','FontSize', 16,'FontWeight', 'bold');
            if movie_info.has_event(jj),
                text(el(1), el(2), movie_info.event_text, ...
                    'Color', 'w', 'FontSize', 16,'FontWeight', 'bold');
            end
            end
            if isfield(movie_info, 'title'),
            title(movie_info.title);
            end
            movie(jj) = getframe(h);
            jj = jj+1;
        end; % for j = 1:num_frames
    end; % for kk = 1:num_folders,
else % multiple_folder = 0;       
    num_frames = length(movie_info.image_index);
    im = imread(strcat(movie_info.path, movie_info.first_file));
    [num_rows num_cols] = size(im);
    base = 100;
    switch movie_info.type,
        case 1, % intensity only
            h = figure('Position', [base,base,base+num_cols, base+num_rows]);
        case 2, % fret 
            h = figure('Position', [base,base,base+num_cols, base+num_rows]);
        case 3, % fret and intensity
            h = figure('Position', [base,base,base+2*num_cols, base+2*num_rows]);
        case 4, % intensity with detected cell boundary and FAs
            h = figure('Position', [base,base,base+num_cols, base+num_rows]);
    end;
    for j = 1:num_frames,
        i = movie_info.image_index(j);
        switch movie_info.type,
            case 1, % intensity only
                draw_intensity_frame(h, i, movie_info);
            case 2, % fret only
                draw_fret_frame(h, i, movie_info);
            case 3, % fret with intensity.
                draw_fret_intensity_frame(h, i, movie_info);
            case 4,
                draw_cell_with_detected_fa(h, i, movie_info);
        end;
        if isfield(movie_info, 'time_location'),
        tl = movie_info.time_location;
        el = movie_info.event_location;
        text(tl(1), tl(2), strcat(sprintf('%3.1f ', time(i)), ' min'),...
            'Color', 'w','FontSize', 16,'FontWeight', 'bold');
        if movie_info.has_event(j),
            text(el(1), el(2), movie_info.event_text, ...
                'Color', 'w', 'FontSize', 16,'FontWeight', 'bold');
        end
        end
        if isfield(movie_info, 'title'),
        title(movie_info.title);
        end
        movie(j) = getframe(h);
    end;
end; % multiple_folder = 0;

% save the avi file
system_type = computer;
switch system_type,
    case 'PCWIN32'
        co = 'Cinepak';
    case 'PCWIN64',
        %co = 'FFDS';
        co = 'None';
    otherwise,
        co = 'Cinepak';
end;

movie2avi(movie, strcat(movie_info.path,movie_info.file_name), ...
    'Compression', co, 'fps',6, 'quality', 75);
beep;
return;

function draw_intensity_frame(h, i, info)
    this_index = sprintf(info.index_pattern{2}, i);
    if info.multiple_folder
        kk = info.current_folder;
        first_file = strcat(info.path_all{kk}, info.first_file{kk});
    else % info.multiple_foder = 0;
        first_file = strcat(info.path, info.first_file);    
    end; % if info.multiple_folder
    file_name = regexprep(first_file, info.index_pattern{1}, this_index);
%     if ~exist(file_name), ???
    im = imread(file_name); im = medfilt2(im);
    figure(h); imagesc(im); caxis(info.ibound); axis off;
    set(gca, 'FontSize', 14, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth',2 )
return;

function draw_fret_frame(h, i, info)
    this_index = sprintf(info.index_pattern{2}, i);
    if info.multiple_folder
        kk = info.current_folder;
        first_file = strcat(info.path_all{kk}, info.first_file{kk});
    else % info.multiple_foder = 0;
        first_file = strcat(info.path, info.first_file);    
    end; % if info.multiple_folder
    cfp_file = regexprep(first_file, info.index_pattern{1}, this_index);
    cfp_im = imread(cfp_file); cfp_im = medfilt2(cfp_im);
    yfp_file = regexprep(cfp_file, info.channel_pattern{1}, ...
        info.channel_pattern{2});
    yfp_im = imread(yfp_file); yfp_im = medfilt2(yfp_im);
    ratio = compute_ratio(cfp_im, yfp_im);
%     im = imd_create_image_2(ratio, max(cfp_im, yfp_im),...
%         info.rbound, info.ibound);
    im = get_imd_image(ratio, max(cfp_im, yfp_im),...
        'ratio_bound', info.rbound, 'intensity_bound', info.ibound);
    figure(h); imshow(im); axis off;
    set(gca, 'FontSize', 14, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth',2 )
return;

% only the draw_fret_intensity_frame function was tested for multiple
% folders of image data.
function draw_fret_intensity_frame(h, i, info)
    this_index = sprintf(info.index_pattern{2}, i);
    if info.multiple_folder
        kk = info.current_folder;
        first_file = strcat(info.path_all{kk}, info.first_file{kk});
        bg_file = strcat(info.path_all{1}, 'output\', 'background.mat');
    else % info.multiple_foder = 0;
        first_file = strcat(info.path, info.first_file);
        bg_file = strcat(info.path, 'output\', 'background.mat');
    end; % if info.multiple_folder
    cfp_file = regexprep(first_file, info.index_pattern{1}, this_index);
    cfp_im = imread(cfp_file); 
    info.bg_bw = get_background(cfp_im, bg_file);
    temp = preprocess(cfp_im, info); clear cfp_im;
    cfp_im = temp; clear temp;
    yfp_file = regexprep(cfp_file, info.channel_pattern{1}, ...
        info.channel_pattern{2});
    yfp_im = imread(yfp_file); 
    temp = preprocess(yfp_im, info); clear yfp_im;
    yfp_im = temp; clear temp;
    rfp_file = regexprep(cfp_file, info.channel_pattern{1}, ...
        info.channel_pattern{3});
    rfp_im = imread(rfp_file); 
    temp = preprocess(rfp_im, info); clear rfp_im;
    rfp_im = temp; clear temp;
    
    ratio = compute_ratio(cfp_im, yfp_im);
    %fret_rgb = imd_create_image(ratio, yfp_im, info.rbound, info.ibound);
    fret_rgb = get_imd_image(ratio, yfp_im, 'ratio_bound', info.rbound,...
        'intensity_bound', info.ibound);
    rfp_ind = floor(0.5+imscale(rfp_im, 1, 128, info.cbound));
    if strcmp(info.color_type, 'rgb'),
        rfp_rgb = ind2rgb(rfp_ind, jet(128));
    elseif strcmp(info.color_type, 'gray'),
        rfp_rgb = ind2rgb(rfp_ind, gray(128));
    else
        display('Function make_movie: Wrong color type\n');
    end;
    im = [fret_rgb rfp_rgb];
    %im = [fret_rgb(:,60:430, :) rfp_rgb(:, 60:430, :)];
    figure(h); 
    imshow(im);  axis off;
    set(gca, 'FontSize', 14, 'FontWeight', 'bold', 'Box', 'off', 'LineWidth',2 );
return;

