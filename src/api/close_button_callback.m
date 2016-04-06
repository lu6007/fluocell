% Close figures.
% --- Executes on button press in close_pushbutton.

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function data = close_button_callback(data)
data = close_figure(data);
return;

% Save the quantified results to data.value
% and data.time
function data = close_figure(data)
if isfield(data, 'f'),
    for i = 1:data.num_figures;
        close(data.f(i));
    end
    data = rmfield(data,'f');
end;
if isfield(data,'bg_bw'),
    data = rmfield(data,'bg_bw');
    data = rmfield(data,'bg_poly');
end;
if isfield(data,'rectangle'),
    data = rmfield(data,'rectangle');
end;
if isfield(data, 'roi_bw'),
    data = rmfield(data, 'roi_bw');
    data = rmfield(data, 'roi_poly');
end;
% if isfield(data, 'value'),
if isfield(data, 'ratio'), % Since value is already removed, we use ratio instead. Lexie on 12/21/2015
%     data = rmfield(data, {'value','time','ratio','donor', 'acceptor'});
    data = rmfield(data, {'time','ratio', 'cell_size', 'channel1', 'channel2'}); % delete value part cause it is already removed from data. 12/21/2015
%     data = rmfield(data, 'time');
%     data = rmfiled(data,'ratio');
%     data = rmfield(data,'donor');
%     data = rmfield(data,'acceptor');
end;
% Lexie on 3/2/2015; delete im after close figure
if isfield(data, 'ref_centroid'),
    data = rmfield(data, 'ref_centroid');
end;
if isfield(data,'roi_poly'),
    data = rmfield(data, 'roi_poly');
    data = rmfield(data, 'roi_bw');
end;
if isfield(data, 'mask'),
    data = rmfield(data, 'mask');
end;
if isfield(data,'mask_bw'),
    data = rmfield(data,'mask_bw');
end;
if isfield(data,'mask_bg'),
    data = rmfield(data,'mask_bg');
end;
return;