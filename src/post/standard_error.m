% function sem= standard_error(x)
% calculates the standard error of the mean (SEM).
% sem = s/sqrt(n), where
% s is the sample standard deviation and the std() function
% in MATLAB.
% Ref: The wiki page for standard error

% Copyright: Shaoying Lu and Yingxiao Wang 2011

function sem= standard_error(x)
sem =std(x)/sqrt(length(x));
return;