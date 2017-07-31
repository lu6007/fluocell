% Generate the movie_info data structure which contains the (x,y)
% coordinates and the total intensity of the focal adhesions. 
function movie_info = get_movie_info(data, varargin)
fprintf('Cell Name : %s\n',data.cell_name);

parameter = {'load_file', 'file_type'};
default = {1, 'cell'};
[load_file, file_type] = parse_parameter(parameter,default, varargin);

mi_file_name = strcat(data.path, 'output/movie_info.mat');

if exist(mi_file_name, 'file') && load_file
    result = load(mi_file_name);
    movie_info = result.movie_info;
    return;
else

% load fa_bw
    pattern = data.index_pattern{2};
    first_index_pattern = sprintf(pattern, data.image_index(1));
    
    switch file_type
        case 'cell'
            first_file = data.first_file;
            % second_file = data.file{2};
        case 'fa'
             first_file = strcat(data.path, data.first_file);
    end

    % initialize movie_info
    num_frames = length(data.image_index);
    field = {'xCoord', 'yCoord', 'amp', 'num_pixels'};
    num_fields = length(field);
    c = cell(num_frames, num_fields);
    
    for k = 1:num_frames
        data.index = data.image_index(k);
        data = get_image(data, 0);
        
        index_str = sprintf(pattern, data.index);
% For different file types, there are different mat files correspondingly.
% Lexie on 1/4/2016
        switch file_type
            case 'cell'
                file_name = strcat(data.path, 'output\cell_bw_', index_str, '.mat');
                result = load(file_name);
                object_bw = result.cell_bw;
            case 'fa'
                file_name = strcat(data.path, 'YFP_fa_', index_str, '.mat');
                result = load(file_name);
                object_bw = result.fa_bw;
        end
        clear result;
        
        % Modifications on parameter name for consistency, Lexie on
        % 01/04/2016
        
        switch file_type
            case 'cell'
                [object_bd, object_label] = bwboundaries(object_bw, 8, 'noholes');
            case 'fa'
                [object_bd, object_label] = bwboundaries(object_bw, 4, 'noholes');
        end
        num_object = length(object_bd);
        object_prop = regionprops(object_label, 'Centroid', 'PixelList');
        object_centroid = cat(1, object_prop.Centroid);

%         % calculate the FA centroids
%         [fa_bd, fa_label] = bwboundaries(fa_bw, 4, 'noholes');
%         num_fas = length(fa_bd);
%         fa_prop = regionprops(fa_label, 'Centroid', 'PixelList');
%         fa_centroid = cat(1, fa_prop.Centroid);
    %     hold on; plot(fa_centroids(:,1), fa_centroids(:,2), 'g+');

        % calculate the FA total intensity
        % Here we use the filtered image.
        % If we want to use the original image, need to crop
        % it to the correct size.
%         pax_file = regexprep(first_file, first_index_pattern, index);
%         im_pax = imread(pax_file);
        % For tracking in ratiometric case
        switch file_type
            case 'cell'
%                 first_file_path = regexprep(first_file, first_index_pattern, index);
%                 second_file_path = regexprep(second_file, first_index_pattern, index);
                im_object_1 = imread(data.file{1});
                im_object_2 = imread(data.file{2});
                im_object = im_object_1 + im_object_2;
%                 im_object = min(im_object_1 + im_object_2, 2^16-1);
                clear im_object_1 im_object_2 first_file_path second_file_path;
            case 'fa'
                pax_file = regexprep(first_file, first_index_pattern, index);
        %         im_pax = imread(pax_file);
                im_object = imread(pax_file);
                clear pax_file;
        end
        num_rows = size(im_object,1);
        object_total_intensity = zeros(num_object, 1);
        num_pixels = zeros(num_object, 1);
        for j = 1:num_object
            index = object_prop(j).PixelList; 
            % PixelList gives a num_pixelsx2 vector including 
            % (colum_number row_number)
            % MATLAB matrices are stored by columns in memory
            linear_index = (index(:,1)-1)*num_rows + index(:,2);
            num_pixels(j) = length(linear_index);
            object_total_intensity(j) = sum(im_object(linear_index));
            object_label(linear_index) = object_total_intensity(j);
            %num_pixels(j) = size(index, 1);
            %fa_total_intensity(j) = sum(sum(im_pax(index)));
            %fa_label(index) = fa_total_intensity(j);
            clear index linear_index
        end
%         figure; imagesc(fa_label); 
%         hold on; plot(fa_centroids(:,1), fa_centroids(:,2), 'w+');
% 
        % now convert all the information into the movie_info datastructure.
        z = zeros(num_object, 1);
        % field = {'xCoord', 'yCoord', 'amp', 'num_pixels'};
        c{k,1} = [object_centroid(:,1) z];
        c{k,2} = [object_centroid(:,2) z];
        c{k,3} = [object_total_intensity z];
        c{k,4} = num_pixels;
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
        clear im_fak im_object im_ratio object_centroid object_total_intensity object_label...
            object_prop object_bd fak_total_intensity pax_total_intensity z
    end % for k = 1:5
    % field = {'xCoord', 'yCoord', 'amp', 'num_pixels'};
    movie_info = cell2struct(c, field, 2);
    save(mi_file_name, 'movie_info');
end

return;