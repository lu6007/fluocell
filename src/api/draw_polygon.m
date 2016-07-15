% Function draw_polygon(gca, this_poly, color, file_name)
% Draw the dragable polygon if version is higher than 2008a and 
% if there is only 1 polygon. Set the global variable fluocell_data_roi_move 
% to 1 if this roi has been moved. 

% Copyright: Shaoying Lu and Yingxiao Wang 2014
% function new_poly = draw_polygon(gca, this_poly, color, file_name)
function draw_polygon(gca, this_poly, color, file_name, varargin)
par_name = {'type','roi_label'};
default_value = {'draggable',1}; % 'draggable', 'undraggable', etc
[type, roi_label] = parse_parameter(par_name, default_value, varargin);

% For compatibility
    if ~iscell(this_poly),
        num_polygons = 1;
        temp{1} = this_poly; clear this_poly;
        this_poly = temp;
    else
        num_polygons = size(this_poly, 2);
        num_objects = size(this_poly, 1);
    end;
    
    v_str = version;
    if str2double(v_str(13:16))<2008 || num_polygons>1 ||...
            ~strcmp(type, 'draggable'),
        % lower than 2008a or more than 1 polygons or not draggable
        for j = 1 : num_objects,
            for i = 1:num_polygons,
                plot(this_poly{j, i}(:,1), this_poly{j, i}(:,2), color, 'LineWidth', 4);
                if num_polygons > 1
                    t = text(this_poly{j, i}(1,1), this_poly{j, i}(1,2), num2str(i));
                    set(t, 'Color', 'y', 'FontSize',16, 'FontWeight', 'Bold');
                    clear t;
                end
            end;
        end
        %new_poly = [];
    else % higher than 2008a && only 1 polygon && draggable
        h = impoly(gca, this_poly{1});
        setColor(h, color);
        addNewPositionCallback(h, @(p) save(file_name, 'p'));
        % The interactive function addNewPositionCallback does not allow
        % output variable to indicate. So we need to set the value of the
        % global variable fluocell_data_roi_move here to note that the ROI
        % has been moved interactively.
        addNewPositionCallback(h, @(p) set_roi_move);
        fcn = makeConstrainToRectFcn('impoly', get(gca, 'XLim'),...
            get(gca, 'YLim'));
        setPositionConstraintFcn(h,fcn);

    end;
return;

function set_roi_move(~)
    % A global variable is shared among all functions where the variable
    % is declared.
    global fluocell_data_roi_move; 
    fluocell_data_roi_move = 1;
return;

