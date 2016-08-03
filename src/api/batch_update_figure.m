% function data = batch_update_figure(data)

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function data = batch_update_figure(data)
temp = data.index;

if isfield(data, 'ratio'),
    data = rmfield(data, 'ratio');
    data = rmfield(data, 'value');
    data = rmfield(data,'time');
    data = rmfield(data, 'cell_size');
end

% loop through the row vector image_index
for i = data.image_index, 
    data.index = i;
    if  i == data.image_index(1), 
       data = get_image(data,1);
    else
        data = get_image(data,0);
    end;
    data = update_figure(data);
end;
data.index = temp; % return data.index to the initial value for consistencey.
return;