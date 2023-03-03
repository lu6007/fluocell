% Close figures.
% --- Executes on button press in close_pushbutton.

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function [data, fun] = close_button_callback(data)
% internal function fun.clean_up(data)
% >> [~,fun] = close_buttom_callback([]);
% >> data = fun.clean_up(data);
fun.clean_up = @clean_up;

data = close_figure(data);
data = clean_up(data);
return;

% Close figures and clean up data
function data = close_figure(data)
if isfield(data, 'f')
    for i = 1:data.num_figures
        if ishghandle(data.f(i))
            close(data.f(i));
        end
    end
    data = rmfield(data,'f');
end
return;

%  Clean up data
function data = clean_up(data)
if isfield(data,'bg_bw')
    data = rmfield(data,'bg_bw');
    data = rmfield(data,'bg_poly');
end
if isfield(data,'bg_value')
    data = rmfield(data, 'bg_value');
end
if isfield(data,'rectangle')
    data = rmfield(data,'rectangle');
end
if isfield(data, 'roi_bw')
    data = rmfield(data, 'roi_bw');
    data = rmfield(data, 'roi_poly');
end

if isfield(data, 'ratio')
    data = rmfield(data, {'time','ratio', 'cell_size', 'channel1', 'channel2'}); 
end
% Lexie on 3/2/2015; delete im after close figure
if isfield(data, 'ref_centroid')
    data = rmfield(data, 'ref_centroid');
end
if isfield(data,'roi_poly')
    data = rmfield(data, 'roi_poly');
    data = rmfield(data, 'roi_bw');
end
if isfield(data, 'mask')
    data = rmfield(data, 'mask');
end
if isfield(data,'mask_bw')
    data = rmfield(data,'mask_bw');
end
if isfield(data,'mask_bg')
    data = rmfield(data,'mask_bg');
end
% For tracking information
if isfield(data, 'frame_with_track')
    data = rmfield(data,'frame_with_track'); 
end
% For alignment
if isfield(data, 'shift')
    data = rmfield(data, 'shift');
end
return;
