% function data = batch_update_figure(data)

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function data = batch_update_figure(data)
temp = data.index;
for i = data.image_index,
    data.index = i;
    data = get_image(data,0);
    data = update_figure(data);
end;
data.index = temp; % return data.index to the initial value for consistencey.
return;