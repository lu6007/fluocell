% read the image file and give a warning if the file does not exist.

% Copyright: Shaoying Lu, Shannon Laub and Yingxiao Wang 2011
function [im, fun] = my_imread(file_name, data)
    % Internal subfunction fun.fast_imread()
    % Call the subfunction by
    % >> [~, fun] = my_imread('', []);
    % >> fun.fast_imread(file_name);
    fun.fast_imread = @fast_imread;    

    % >> fluocell_data.image_type = 'z-stack';
    % %% insert these lines at >>> 1 >>>
    % if ~isfield(data,'image_type'), 
    %     im = imread(file_name);
    % elseif strcmp(data.image_type,'z-stack'),
    %      im = imread(file_name, data.index),
    % end;
    % 
    if exist(file_name, 'file') == 2
         if ~isfield(data, 'image_type')|| ~strcmp(data.image_type, 'z-stack')
            im = imread(file_name);

            % Solve the jpg format problem.
            if isfield(data, 'image_format') && strcmp(data.image_format, 'jpg1')
                temp = sum(im,3); clear im;
                im = temp; clear temp;
            end
        elseif isfield(data, 'image_type') && strcmp(data.image_type,'z-stack')
            %try-catch to check for valid user input of the z-index value. -Shannon 8/23/2016
            try
                im = imread(file_name,data.z_index);
            catch exception
                if (strcmp(exception.identifier, 'MATLAB:imagesci:rtifc:invalidDirIndex'))
                    im = [];
                    disp('Function my_imread() warning: Please check the range of the z-index.'); 
                else
                    throw(exception)
                end
            end
         end
    else % not exist file 
            im = [];
            fprintf('%s : %s\n', file_name, 'This file does not exist!');
    end
return;

% Ref: Jerome, How to load Tiff stacks fast
% http://www.matlabtips.com/how-to-load-tiff-stacks-fast-really-fast/
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