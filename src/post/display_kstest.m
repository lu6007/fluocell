% function display_kstest(v1, v2, str)

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function display_kstest(v1, v2, str)
n1 = length(v1); n2 = length(v2);
[h p] = kstest2(v1,v2);
display(strcat(str, num2str(p), ', ', num2str(n1), ', ', num2str(n2)));
return;