% function [bd] = cmean_outline(mem)

% Copyright: Kaiwen Zhang, Shaoying Lu and Yingxiao Wang 2013
function [bd] = cmeans_outline(mem)

min_area = 500;

l = size(mem,2);

if l < 3
    mem = reshape(mem(:,l),512,512);
elseif l == 3
    mem = reshape(mem(:,2)+ mem(:,3),512,512);
else
    mem = reshape(mem(:,l)+mem(:,l-1)+mem(:,l-2),512,512);
end

J = (mem>0.1);
J = bwareaopen(J, 600);
J = imfill(J, 'holes');

bw_image = bwareaopen(imclose(J, strel('disk',5)), 600);
se = strel('disk',1);
bw_image = imerode(bw_image,se);
bw_image = imdilate(bw_image,se);
bw_image = bwareaopen(bw_image, min_area);
bw_image = imclose(bw_image, strel('disk', 6));

bd = find_longest_boundary(bw_image);

% figure; hold on; imagesc(mem);plot(bd(:,2),bd(:,1),'g');hold off

end

