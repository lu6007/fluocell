% function ratio = compute_ratio(top, bottom);
% Compute the ratio image between images top and bottom with a 
% protection against zero denominator.
%
% parameter_name = {'shift', 'method'};
% default_value = {1.0e-4, 1};
%
% method --- 1: increment both top and bottom by the value of 'shift'
% method --- 2: only when the bottom entry is less than shift, increment by shift
% When the bottom entry is less than 1.0e-4, increment it by 1.0e-4

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function ratio = compute_ratio(top, bottom,varargin)
parameter_name = {'shift', 'method'};
default_value = {1.0e-4, 1};
[shift, method] = parse_parameter(parameter_name, default_value, varargin);
if method ==1,
    % increment both top and bottom by the value of 'shift'
    ratio = (double(top)+shift)./(double(bottom)+shift);
else % method ==2,
    % only when the bottom entry is less than shift, increment by shift.
    ratio = double(top)./(double(bottom)+double(bottom<shift)*shift);
end;
return;