% function rect = get_rectangle(im, rectangle_file)

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function rect = get_rectangle(im, rectangle_file, varargin)
%
parameter_name = {'format'};
default_value = {'-mat'};
[format] = parse_parameter(parameter_name, default_value, varargin);
%
p = fileparts(rectangle_file); %path
if ~exist(p, 'dir'),
    mkdir(p);
end;

% define the cropping rectangle
if ~exist(rectangle_file, 'file'),
    h = figure; imagesc(im); title('Please draw the cropping rectangle.');
    [~, rect] = imcrop;
    save(rectangle_file, 'rect', format);
    clear im_crop; close(h);
else
    switch format,
        case '-mat',
            res = load(rectangle_file);
            rect = res.rect;
        case '-ascii',
            rect = load(rectangle_file);
    end;
end;
