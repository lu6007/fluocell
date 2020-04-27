% function [tt, cc] = cross_correlation(t, x, y, varargin)
% parameter_names = {'max_lag', 'step_per_lag'};
% max_lag should be given in the unit of the variable t.
% For example, max_lag = max(t)
% step_per_lag = 2;
% n = length(t);
% default_values = {n-1, 1};
% tt and cc are column vectors.
% shift x and y to the mean values.
% cc(m) = sum(x(n)y(n+m));
% Note this definite is reversed in the Lag Time compared 
% to the MATLAB function xcorr(). The vectors x and y are
% shifted to zero and normalized in the function. 
%
% The MATLAB cross-correlation function xcorr tends to error 
% and create an artificial peak at time = 0;
% This function aims to correct this error.
%
% This function was previously named cross_correlation_2 in
% fluocell_3.1

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function [tt, cc] = cross_correlation(t, x,y, varargin)
parameter_name = {'max_lag', 'step_per_lag'};
default_value = {length(x)-1, 1};
[max_lag, step_per_lag] = parse_parameter(parameter_name, default_value, ...
    varargin);

max_lag = max_lag*step_per_lag;
t_step = 1/step_per_lag;
min_t = min(t); max_t =  max(t);
t_interp = (min_t:t_step:max_t)';
x_interp = interp1q(t, x, t_interp);
y_interp = interp1q(t, y, t_interp);
clear x y;

% calculate the normalized cross correlation
index = (-max_lag:max_lag)';
tt = index*t_step;
n_cc = length(index);
cc = zeros(n_cc,1);
x = x_interp-mean(x_interp);
y = y_interp-mean(y_interp);
nx = length(x);
ny = length(y);
for i = 1:n_cc
    ii = index(i);
    if ii<0
        % extend x to the right, y to the left,
        x_value = value_fun(x, (1:nx-ii)');
        y_value = value_fun(y, (1+ii:ny)');
    elseif ii>0
        % extend x to the left, y to the right,
        x_value = value_fun(x, (1-ii:nx)');
        y_value = value_fun(y, (1:ny+ii)');
    else
        x_value = x;
        y_value = y;
    end
    % This allows the autocorrelation to be 1.
    if norm(x_value)~=0
        x_value = x_value/norm(x_value);
    end
    if norm(y_value)~=0
        y_value = y_value/norm(y_value);
    end
   cc(i) = sum(x_value.*y_value); 
   clear y_value x_value;
end
return;

% The function value_fun extend the vector x to the left with
% the value x(1) and to the right with the value x(n), where
% n is the length of the vector x. The input i can be a vector
% or a integer, which defines the position on the extended
% vector x. And value is a vector of x(i). 
function value = value_fun(x, i)
value = ones(size(x));
index = (i>=1 & i<=length(x));
value(index) = x(i(index)); clear index;
index = (i<1);
value(index) = x(1); clear index;
index = (i>length(x));
value(index) = x(length(x));
return;