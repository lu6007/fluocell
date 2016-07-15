% scale by magnification
% Input: pixel
% Output: um
% 40x magnification 1 pixel = 1/2.56 micrometer.
% 100x magnification 1 pixel = 1/6.4 micrometer.

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function p = scale_by_magnification(p_old, magnification)
switch magnification,
    case 40
      %factor = 10.0/60.0; % used before 2011
      % This would cause the estimated diffusion coefficient to be
      % 10 times smaller than it should have been.
      factor = 1/2.56;
    case 100
      %100 times, 60 pixels = 4 um
      %factor = 4.0/60.0; % used before 2011
      factor = 1/6.4; 
end;
p = p_old*factor;
return;
