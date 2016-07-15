% function [level em] = my_graythresh(I)

% Copyright: Kaiwen Zhang, Shaoying Lu and Yingxiao Wang 2013
function [level em] = my_graythresh(I)

% One input argument required.
%iptchecknargin(1,1,nargin,mfilename);
% iptcheckinput(I,{'uint8','uint16','double','single','int16'},{'nonsparse'}, ...
%               mfilename,'I',1);
narginchk(1,1);
validateattributes(I,{'uint8','uint16','double','single','int16'},{'nonsparse'},'my_graythresh', 'I', 1);

if ~isempty(I)
  % Convert all N-D arrays into a single column.  Convert to uint8 for
  % fastest histogram computation.
  I = im2uint16(I(:));
  num_bins = 2048;
  counts = imhist(I,num_bins);
  
  % Variables names are chosen to be similar to the formulas in
  % the Otsu paper.
  p = counts / sum(counts);
  omega = cumsum(p);
  mu = cumsum(p .* (1:num_bins)');
  mu_t = mu(end);
  
  sigma_b_squared = (mu_t * omega - mu).^2 ./ (omega .* (1 - omega));

  % Find the location of the maximum value of sigma_b_squared.
  % The maximum may extend over several bins, so average together the
  % locations.  If maxval is NaN, meaning that sigma_b_squared is all NaN,
  % then return 0.
  maxval = max(sigma_b_squared);
  isfinite_maxval = isfinite(maxval);
  if isfinite_maxval
    idx = mean(find(sigma_b_squared == maxval));
    % Normalize the threshold to the range [0, 1].
    level = (idx - 1) / (num_bins - 1);
  else
    level = 0.0;
  end
else
  level = 0.0;
  isfinite_maxval = false;
end

% compute the effectiveness metric
if nargout > 1
  if isfinite_maxval
    em = maxval/(sum(p.*((1:num_bins).^2)') - mu_t^2);
  else
    em = 0;
  end
end