% scale by magnification
% Input: pixel
% Output: um
% 40x magnification 1 pixel = 1/2.56 micrometer.
% 100x magnification 1 pixel = 1/6.4 micrometer.

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function p = scale_by_magnification(p_old, magnification)
switch magnification
    case 40
      %factor = 10.0/60.0; % used before 2011
      % This would cause the estimated diffusion coefficient to be
      % 10 times smaller than it should have been.
      factor = 1/2.56;
    case 60 % chien lab 60x confocal/frap
        % factor = 1/3.84; 3.84 pixels = 1 um
        factor = 0.391; % after 8/2019 % before used 0.114, why? 
    case 98
      %100 times, 60 pixels = 4 um
      factor = 4.0/60.0; % used before 2011
    case 99
      factor = 1/6.4; % 2011-7/21/2017  
    case 100
        factor = 1/6.28; % updated on 7/21/2017 now 1/6.28 
end
p = p_old*factor;
return;
