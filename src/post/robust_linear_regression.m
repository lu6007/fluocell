% >> p = 'D:\data\rongxue_1030\';
% >> load(strcat(p, 'result_1030_2016.mat'));
% >> fit1 = robust_linear_regression(wt_intensity(:,3), wt_ratio);
% >> fit2 = robust_linear_regression(yf_intensity(:,3), yf_ratio);
% Results: 
%      General model:
%      fit1(x) = a+b*x
%      Coefficients (with 95% confidence bounds):
%        a =      0.2507  (0.2262, 0.2752)
%        b =   5.962e-06  (3.109e-06, 8.815e-06)
% 
%      General model:
%      fit2(x) = a+b*x
%      Coefficients (with 95% confidence bounds):
%        a =      0.2497  (0.2297, 0.2698)
%        b =   1.585e-06  (3.2e-07, 2.851e-06)
function fit3 = robust_linear_regression(xdata, ydata)
line = fittype('a+b*x');
[fit1, gof,fitinfo] = fit(xdata, ydata, line, 'StartPoint', [1 1]);
residual = fitinfo.residuals;
% Exclude outliers with a residual of 2*std in both x and y directions. 
index1 = abs(residual)>2*std(residual);
[fit2, gof, fitinfo] = fit(ydata, xdata, line, 'StartPoint', [1 1]);
residual = fitinfo.residuals;
index2 = abs(residual)>2*std(residual);
index = index1 | index2;
% figure; plot(index, '+');

index = index1; 

outlier = excludedata(xdata, ydata, 'indices', index);
fit3 = fit(xdata, ydata, line, 'StartPoint', [1 1], 'Exclude', outlier);

figure; hold on;
plot(fit1, 'r-', xdata, ydata, 'k.', outlier,'m*');
plot(fit3, 'c--'); 
axis auto;

end

