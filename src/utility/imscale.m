% function new_im=imscale(im, a,b,cbound)
% scale image to the interval [a,b]
% input is double or int
% output is double

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function new_im=imscale(im, a,b,cbound)
imin = cbound(1);
imax = cbound(2);
if imin == imax,
    error('Imin should not equal to imax!');
end;
new_im = double(im-imin)/double(imax-imin)*(b-a)+a;
return;
