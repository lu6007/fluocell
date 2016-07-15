% add a tail containing the string form of index
% into all the titles

% Copyright: Shaoying Lu and Yingxiao Wang 2014
function my_title(title_name, index)
title(strcat(title_name, '\_', num2str(index))); 
return;
