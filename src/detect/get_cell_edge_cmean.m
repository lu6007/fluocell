% function bd = get_cell_edge_cmean(img, ncluster, varargin)

% Copyright: Kaiwen Zhang, Shaoying Lu and Yingxiao Wang 2011
function bd = get_cell_edge_cmean(img, ncluster, varargin)

lambda = 500;
[mem, ~, ~] = adaptive_cmean(img, ncluster, 'lambda',lambda);
%[mem, ~, ~] = alter_afcm(img, ncluster, varargin);

bd = cmean_outline(mem);

end

%This function segments an image into n clusters and assign each pixel of
%the image an relative degree of membership to each of these clusters.

% Copyright: Kaiwen Zhang, Shaoying Lu and Yingxiao Wang 2011

function [mem, mf, centroids] = adaptive_cmean(img, ncluster, varargin)

parameter = {'expo','niter','lambda'};
default_value = {2, 10, 1000};
[expo, niter, lambda] = parse_parameter(parameter, default_value, varargin);

%Preprocessing
% data.median_filter = 1;
% data.subtract_background = 0;
% %[data.bg_bw ~] = get_background(img, 'background.mat');
% img = preprocess(img, data);
[m,n] = size(img);
imgsiz = m*n;
img = reshape(img,imgsiz,1);
img = double(img);

%Initialize multiplier field and cluster centroids
mf = ones(imgsiz, 1);
L = laplace(n);

[~, centroids] = kmeans(double(img(:)),ncluster, ...
        'distance','sqEuclidean', 'Replicates',1,'start','uniform');
centroids = sort(centroids);

%Adaptive fzzy c-means
for i = 1:niter
    [mem, mf, centroids] = minimize(img, mf, centroids, ncluster, expo, L, lambda);
    obj{i} = mem;
    %subplot(3,4,i),imagesc(reshape(mem(:,1),512,512))
    %imagesc(reshape(mem(:,2),512,512))
    if i > 1
        norm(obj{i} - obj{i-1})        
        if norm(obj{i} - obj{i-1}) < 0.01
            break;
        end
    end
end

end

function [mem, new_mf, new_centroids] = minimize(img, mf, centroids, ncluster, expo, L, lambda)

l = -2/(expo - 1);
N = size(img,1);

%Compute new memberships
weighted_cent = mf*centroids';

for i = 1:ncluster
    dist(:,i) = abs(weighted_cent(:,i) - img(:));
end

temp = sum(dist.^l,2);

for i = 1:ncluster
    mem(:,i) = (dist(:,i).^l)./temp;
end

clear temp weighted_cent dist;

%Compute new centroids
temp = mem.^2;

for i = 1:ncluster
    new_centroids(i,1) = (sum(temp(:,i).*mf.*img))/sum(temp(:,i).*(mf.^2));
end

%Compute new multiplier field
for i = 1:ncluster
    w(:,i) = temp(:,i)*(new_centroids(i))^2;
end

w = sum(w,2);
for i = 1:N
    row(i) = i;
    col(i) = i;
end
W = sparse(row,col,w,N,N);

for i = 1:ncluster
    f(:,i) = temp(:,i)*new_centroids(i);
end
f = img.*sum(f,2);

clear temp row col w;

% lambda = 50;
A = W+lambda*L;

new_mf = A\f;

end

% function [bd] = cmean_outline(mem)

% Copyright: Kaiwen Zhang, Shaoying Lu and Yingxiao Wang 2013
function [bd] = cmean_outline(mem)

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

