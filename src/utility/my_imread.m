% read the image file and give a warning if the file does not exist.

% Copyright: Shaoying Lu, Shannon Laub and Yingxiao Wang 2011
function im = my_imread(file_name, data)
    % >> fluocell_data.image_type = 'z-stack';
    % %% insert these lines at >>> 1 >>>
    % if ~isfield(data,'image_type'), 
    %     im = imread(file_name);
    % elseif strcmp(data.image_type,'z-stack'),
    %      im = imread(file_name, data.index),
    % end;
    % 
    is_z_stack = data.is_z_stack;
    if exist(file_name, 'file') == 2
         if ~is_z_stack
            im = imread(file_name);

            % Solve the jpg format problem.
            if isfield(data, 'image_format') && strcmp(data.image_format, 'jpg1')
                temp = sum(im,3); clear im;
                im = temp; clear temp;
            end
         else % is_z_stack
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

