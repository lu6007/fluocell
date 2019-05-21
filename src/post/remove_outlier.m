% check whether the value at lindex is an outlier
% if yes, return 1, x_new is the array with outlier removed
% if not, return 0, x_new is just x
function x_new = remove_outlier(x, index)
num_outlier = size(index, 1);
x_new = x;
for i = 1: num_outlier
    ii = index(i);
    xr = [x_new(1:ii-1); x_new(ii+1:end)]; % the rest of x
    xr_mean = mean(xr);
    xr_std = std(xr);
    if (x_new(ii)<xr_mean - 3* xr_std) || (x_new(ii) > xr_mean +3*xr_std)
        % x(index) is an outlier
        fprintf('Remove an outlier: ');
        fprintf('xr_mean = %f, xr_std = %f, x_new(index) = %f\n', xr_mean, xr_std, x_new(ii));
        clear x_new; x_new = xr; clear xr;
        index = index-1; 
    else
        fprintf('Not an outlier: ');
        fprintf('xr_mean = %f, xr_std = %f, x_new(index) = %f\n', xr_mean, xr_std, x_new(ii));
    end
end

return