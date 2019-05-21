% function function_handle = get_my_function()
% fun.my_imwrite = @my_imwrite; 
% fun.fast_imread = @fast_imread;
%
% Example: 
% fun = get_my_function();
% fun.my_imwrite(process_im, file, data);

% Copyright: Shaoying Lu 2018, shaoying.lu@gmail.com 
function function_handle = get_my_function()
fun.my_imwrite = @my_imwrite; 
fun.fast_imread = @fast_imread;
fun.get_image_percentile = @get_image_percentile; 
%
fun.save_image = @save_image;
%
fun.get_compute_ratio_function = @get_compute_ratio_function; 
%
fun.get_R_square = @get_R_square;
%
function_handle = fun;
end

function my_imwrite(im, file, data)

if data.is_z_stack
    [pa, base_name, extension] = fileparts(file);
    temp = sprintf('%s/%s_z%d.%s', pa, base_name, data.z_index, extension);
    clear file; file = temp;
end
imwrite(im, file, 'tiff', 'Compression', 'none');

%     % reprocess and save ratio stack
%     info = imfinfo(file_name); 
%     num_z_plane = size(info,1);
%     for i = 2:num_z_plane
%         imwrite(im2, file, 'WriteMode', 'append');
%     end
end

% function save_image(data, file, im, caxis, varargin)
% Save gray images to "gray" or "jet" colormaps. Jet images will be stretched
% to the min and max of the current caxis. If you don't want to stretch
% choose the caxis = [0 65535]
function save_image(data, file, im, caxis, varargin)
para_name = {'my_color_map'};
para_default = {'gray'};
my_color_map = parse_parameter(para_name, para_default, varargin);

if isfield(data, 'save_processed_image')
    if data.save_processed_image && ~exist(file, 'file') ...
        || data.save_processed_image == 2 
        switch my_color_map
            case 'gray'
                temp = imscale(im, 0, 1, caxis);
                imwrite(temp, file, 'tiff','compression', 'none');
            case 'jet'
                % clear im;
                temp = imscale(im, 0, 1, caxis);
                im = gray2ind(temp, 65536); 
                imwrite(im, jet, file, 'tiff', 'compression', 'none');
        end % switch
    end
end
end

% Ref: Jerome, How to load Tiff stacks fast
% http://www.matlabtips.com/how-to-load-tiff-stacks-fast-really-fast/
% Kathy: don't seem to be used in fluocell yet. 
function test = fast_imread(file_name)
    FileTif=file_name;
    InfoImage=imfinfo(FileTif);
    mImage=InfoImage(1).Width;
    nImage=InfoImage(1).Height;
    NumberImages=length(InfoImage);
    FinalImage=zeros(nImage,mImage,NumberImages,'uint16');
    FileID = tifflib('open',FileTif,'r');
    rps = tifflib('getField',FileID,Tiff.TagID.RowsPerStrip);

    for i=1:NumberImages
        % commented as suggested by Jan Keij R2015b
        % Kathy current version is R2014b
       % tifflib('setDirectory',FileID,i); 
       % Go through each strip of data.
       rps = min(rps,nImage);
       for r = 1:rps:nImage
          row_inds = r:min(nImage,r+rps-1);
          stripNum = tifflib('computeStrip',FileID,r);
          % Some more change suggested by Jan Keij
          FinalImage(row_inds,:,i) = tifflib('readEncodedStrip',FileID,stripNum-1);
       end
    end
    tifflib('close',FileID);
    test = FinalImage;
end

function value = get_image_percentile(im, perc)
    [num_row, num_col] = size(im);
    im_vector = reshape(im, [num_row*num_col, 1]);
    value = prctile(double(im_vector), perc);
    clear im_vector; 
end

function compute_ratio_function = get_compute_ratio_function(data)
    if isfield(data, 'compute_ratio_function') 
        compute_ratio_function = data.compute_ratio_function; 
    else
        compute_ratio_function = @compute_ratio; 
    end 
end

function R_square = get_R_square(x, y)
% index = (death_time<2100 & base_ratio > 4.5);
% x = base_ratio(index);
% y = death_time(index);
poly = polyfit(x, y, 1);
y_fit = polyval(poly, x);
y_residual = y-y_fit;
SS_residual = sum(y_residual.^2);
SS_total = sum(length(y)-1)*var(y);
R_square = 1-SS_residual/SS_total;
end

