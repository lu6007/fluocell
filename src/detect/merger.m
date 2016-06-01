function [merge] = merger(extmin,fgm4,I)
%MERGER combines the masks of extmin and fgm4 but only
% uses the regions where the two intersect.
    Lfgm = bwlabel(fgm4);
    Lextmin = bwlabel(extmin);

    merge = false(size(I)); %Creates false logical array of size I.
    index = find(extmin & fgm4); %returns linear indices where extmin&fgm4 are one

    for i=1:max(max(Lextmin))
        list = Lextmin(index); %Gives values of Lextmin at index.
        if any(list(1:end) == i)
            merge(find(Lextmin==i)) = true;
        end
    end
    for i=1:max(max(Lfgm))
        list = Lfgm(index); %Gives values of Lfgm at index.
        if any(list(1:end) == i)
            merge(find(Lfgm==i)) = true;
        end
    end

end


