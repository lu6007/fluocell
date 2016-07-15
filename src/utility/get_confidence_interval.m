% Calculate the confidence interval based on a known sample vector
% with power alpha. alpha=0.05 gives the 95% confidence interval in a
% column vector. 
% 
% When sample is a maxtrix, the ith column of confidence_interval contains
% the CI of the ith column of the sample matrix.
function confidence_interval = get_confidence_interval(sample, alpha)
    pct1 = 100*alpha/2;
    pct2 = 100 - pct1;
    confidence_interval = prctile(sample, [pct1; pct2]);
return;