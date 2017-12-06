% function movie=make_movie(movie_info);
% The function make_movie() takes pre-existing image and 
% assemble them into movies. The MATLAB video writer object is 
% used for MATLAB version 2010b and higher on windows 7 64 bit computers.
% Example:
%  
% info.path = 'C:\sof\fluocell_4.1\data\10_24_08_Src_fret_pax\';
% info.first_file = 'output\0.3-0.8\ratio.001.tiff';
% info.index_pattern = {'001', '%03d'};
% info.image_index = (1:10)';
% info.movie_name = strcat(info.path,'output\fret.avi');
% movie = make_movie(info);
%
% The files for making movie is saved before hand, this function
% is only used to make movie from existing files.
% Other parameters include the axis.
%
% To label the images with time and descriptive text, first run the above
% commands and figure out where your would like to put the text. Then
% specify the info text fields
% info.time = info.image_index;
% info.time_location = [700 100];
% info.event_location = [700 250];
% info.has_event(1:4) = 1;
% info.has_event(5:13) = 2;
% info.event_text = {'Test1', 'Test2'};
% movie = make_movie(info);
% 

% Copyright: Shaoying Lu and Yingxiao Wang 2011

% Most of the movies are made using the 
% vis/make_movie and vis/make_movie_2 functions. 
% The function make_movie_2() make the images and 
% then assemble them into movies.
% info.time = info.image_index;
% info.time_location = [700 100];
% info.event_location = [700 250];
% info.has_event(1:4) = 1;
% info.has_event(5:13) = 2;
% info.event_text = {'Test1', 'Test2'};
% movie = make_movie(info);

function my_movie=make_movie(movie_info, varargin)
parameter_name = {'color_bar', 'movie_name','ratio_bound'};
default_value = {0, 'FRET', [0.2, 0.5]};
[color_bar, movie_name, ratio_bound] = parse_parameter(parameter_name, default_value, varargin);

% Changed file_name to movie_name in the new versio of make_movie function
% This is for backward compatibility. 
if ~isfield(movie_info, 'movie_name') && isfield(movie_info, 'file_name')
    movie_info.movie_name = movie_info.file_name;
end

if isfield(movie_info, 'time')
    time = movie_info.time; %minute
else
    time = movie_info.image_index;
end

% Windows 64 bit, use VideoWriter
if strcmp(computer, 'PCWIN64') || strcmp(computer, 'MACI64')
    use_video_writer = 1;
    video_object = VideoWriter(movie_info.movie_name, 'Motion JPEG AVI');
    video_object.FrameRate = 10;
    video_object.Quality = 100;
    open(video_object);
else
    use_video_writer = 0;
end

%
num_frame = length(movie_info.image_index);
%h = figure('Position', [100, 100, 600, 600]);
screen_size = get(0,'ScreenSize');
h = figure('Position',[1 1 screen_size(4) screen_size(4)],'color', 'w');
first_file = strcat(movie_info.path, movie_info.first_file);
movie_F = cell(num_frame,2);
fields = {'cdata', 'colormap'};


 if isfield(movie_info, 'time_location')
    time_location = movie_info.time_location;
    event_location = movie_info.event_location;
 end

for j = 1:num_frame
    i = movie_info.image_index(j);
    pattern = movie_info.index_pattern;
    file_name = regexprep(first_file, pattern{1}, sprintf(pattern{2},i));
    if ~exist(file_name, 'file')
        continue
    end
    im = imread(file_name);
    if isfield(movie_info, 'resize_factor')>0
        tt = imresize(im, movie_info.resize_factor);
        clear im; im = tt; clear tt;
    end
    time_f = sprintf('%0.1f', time(j));
    % The insertText function is nice that it inserts directly in to the
    % pixels of an image. Alternatively, any polygon shape can be 
    % inserted using the insertShape function. 
    % insertText works for in MATLAB 2016b and higher,
    % but shows a problem with MATLAB 2014b or lower, although
    % movie making still works. 
     if isfield(movie_info, 'time_location')
        im_fig = insertText(im, time_location, [num2str(time_f), ' min'], ...
        'Boxcolor', 'Black', 'TextColor', 'white', 'FontSize', 30);
        event_j = movie_info.has_event(j);
        if event_j
            im_fig = insertText(im_fig, event_location, movie_info.event_text{event_j}, ...
            'Boxcolor', 'Black', 'TextColor', 'white', 'FontSize', 30);
        else
            im_fig = insertText(im_fig, event_location, movie_name, ...
                'Boxcolor', 'Black', 'TextColor', 'white', 'FontSize', 30);
        end
     else
         im_fig = im;
     end
    figure(h); imshow(im_fig);
%     % This is to correct some weird error in MATLAB on my Mac laptop
%     % Kathy 11/18/2017
%     temp = getframe(gcf);
%     figure(h); imshow(im_fig);
%     temp = getframe(gcf);
%     % The end
    
    if color_bar
        a1 = colorbar;
        colormap(jet);
        caxis(ratio_bound);
        ticks = get(a1, 'YTick');
        l = length(ticks);
        ticks = linspace(ratio_bound(1), ratio_bound(2), l);
        set(a1, 'YTickLabel', ticks, 'fontsize', 16);
    end
    if isfield(movie_info, 'axis')>0 
        axis(movie_info.axis);
    end
    temp =getframe(gcf);
    if isfield(movie_info, 'movie_frame')>0
        mf  = movie_info.movie_frame;
        this_frame = temp.cdata(mf(1):mf(2),  mf(3):mf(4), :);
        clear mf;
    else
        this_frame = temp.cdata;
    end
    movie_F{j,1} = this_frame;
    movie_F{j,2} = temp.colormap;
    if use_video_writer
        writeVideo(video_object, this_frame);
    end
    clear temp this_frame;
end
my_movie = cell2struct(movie_F, fields,2);

if use_video_writer
    close(video_object);
else % movie2avi has been removed on Mac64 4/26/2017
    if strcmp(computer, 'PCWIN32')
        movie2avi(my_movie, movie_info.movie_name, ...
        'compression', 'Cinepak', 'fps',3,'quality', 75);
    else
    % if 'Cinepak' not working, can switch to 'None'
        movie2avi(my_movie, movie_info.movie_name, ...
        'compression', 'None', 'fps',3,'quality', 75);
    end
    
end

beep;
return;

