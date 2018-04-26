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
function_handle = fun;
return

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
return

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
return;