% Generate the movie_info data structure which contains the (x,y)
% coordinates and the total intensity of the focal adhesions. 
function movie_info = get_movie_info_single(cell_name, varargin)
parameter = {'load_file'};
default = {1};
load_file = parse_parameter(parameter,default, varargin);

data = init_data(cell_name);
mi_file_name = strcat(data.path, 'movie_info.mat');

if exist(mi_file_name, 'file') && load_file,
    result = load(mi_file_name);
    movie_info = result.movie_info;
    return;
else

    % load fa_bw   
    pattern = data.index_pattern{1};
    first_index_pattern = sprintf(pattern, data.image_index(1));
    first_file = strcat(data.path, data.first_file);    

    % initialize movie_info
    num_frames = length(data.image_index);
    fields = {'xCoord', 'yCoord', 'amp', 'fak_total_intensity',...
        'pax_total_intensity', 'total_ratio', 'num_pixels'};
    num_fields = length(fields);
    c = cell(num_frames, num_fields);

    for k = 1:num_frames, 
        i = data.image_index(k);
        index = sprintf(pattern, i);
        file_name = strcat(data.path, channel{1}, '_fa_', index, '.mat');
        result = load(file_name);
        fa_bw = result.fa_bw;
        clear result;
        pax_fa_file = regexprep(file_name, channel{1}, channel{2});
        result = load(pax_fa_file);
        temp = fa_bw | result.fa_bw; clear fa_bw;
        fa_bw = temp; clear temp file_name result pax_fa_file;
    %     figure; imagesc(fa_bw);

        % calculate the FA centroids
        [fa_bd, fa_label] = bwboundaries(fa_bw, 4, 'noholes');
        num_fas = length(fa_bd);
        fa_props = regionprops(fa_label, 'Centroid', 'PixelList');
        fa_centroids = cat(1, fa_props.Centroid);
    %     hold on; plot(fa_centroids(:,1), fa_centroids(:,2), 'g+');

        % calculate the FA total intensity
        % Here we use the filted image.
        % If we want to use the original image, need to crop
        % it to the correct size.
        file_name = regexprep(first_file, first_index_pattern, index);
        im_fak = imread(file_name);
        pax_file = regexprep(file_name, channel{1}, channel{2});
        im_pax = imread(pax_file);
        im_ratio = compute_ratio(im_fak, factor*double(im_pax),'shift', 1);
        clear file_name pax_file;
        num_rows = size(im_fak,1);
        fa_total_intensity = zeros(num_fas, 1);
        fak_total_intensity = zeros(num_fas, 1);
        pax_total_intensity = zeros(num_fas, 1);
        total_ratio = zeros(num_fas,1);
        num_pixels = zeros(num_fas, 1);
        for j = 1:num_fas,
            index = fa_props(j).PixelList; 
            % PixelList gives a num_fasx2 vector including 
            % (colum_number row_number)
            % MATLAB matrices are stored by columns in memory
            linear_index = (index(:,1)-1)*num_rows + index(:,2);
            fak_total_intensity(j) = sum(im_fak(linear_index));
            pax_total_intensity(j) = sum(im_pax(linear_index));
            fa_total_intensity(j) = fak_total_intensity(j)+factor*pax_total_intensity(j);
            num_pixels(j) = length(linear_index);
            total_ratio(j) = sum(im_ratio(linear_index));
            fa_label(linear_index) = fa_total_intensity(j);
            clear index linear_index
        end;
    %         figure; imagesc(fa_label); 
    %         hold on; plot(fa_centroids(:,1), fa_centroids(:,2), 'w+');
    % 
        % now convert all the information into the movie_info datastructure.
        z = zeros(num_fas, 1);
        c{k,1} = [fa_centroids(:,1) z];
        c{k,2} = [fa_centroids(:,2) z];
        c{k,3} = [fa_total_intensity z]; 
        c{k,4} = fak_total_intensity;
        c{k,5} = pax_total_intensity;
        c{k,6} = total_ratio;
        c{k,7} = num_pixels;
        % need to check here
        % alternatively we want to use
        % c{k,3} = [fak_total_intensity pax_total_intensity average_ratio
        % We can only define one column for the variable amp.
        % We need to generalize the get_track and its upstream functions to
        % allow the usage of multiple variables as tracking criteria.
    %         
    %         movie_info(k) = struct('xCoord', [fa_centroids(:,1) z], ...
    %             'yCoord', [fa_centroids(:,2) z], 'amp', [fa_total_intensity z],...
    %             'fak_total_intensity', fak_total_intensity,...
    %             'pax_total_intensity', pax_total_intensity,...
    %             'average_ratio', average_ratio);
            clear im_fak im_pax im_ratio fa_centroids fa_total_intensity fa_label...
                fa_props fa_bd fak_total_intensity pax_total_intensity z
        end; % for k = 1:5
    movie_info = cell2struct(c, fields, 2);
    save(mi_file_name, 'movie_info');
end; %if exist(mi_file_name, 'file') && load_file,

return;