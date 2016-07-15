% delete the FAs marked as 1 in the vector fa_delete
% Input: fa_label is a label matrix for focal adhesions.
%            fa_delete is a vector of size num_fas and entries 0 and 1
%            fa_delete(i)=1 indicate that the ith FA needs to be deleted

% Copyright: Shaoying Lu and Yingxiao Wang 2011
% This function is the fluocell3.1/ function delete_fa_2()

function [fa_label, new_num_fas] = delete_fa(fa_label, fa_delete)
num_fas = length(fa_delete);
fa_prop = regionprops(fa_label, 'PixelIdxList');
curr_index = 1;
for i = 1:num_fas, 
    if fa_delete(i),
        fa_label(fa_prop(i).PixelIdxList) = 0;
    else
        fa_label(fa_prop(i).PixelIdxList) = curr_index;
        curr_index = curr_index+1;
    end;
end;
new_num_fas = curr_index-1;
return;