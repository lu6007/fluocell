%This function segments an image into n clusters and assign each pixel of
%the image an relative degree of membership to each of these clusters.

% Copyright: Kaiwen Zhang, Shaoying Lu and Yingxiao Wang 2011

function [mem, mf, centroids] = adaptive_cmean(img, ncluster, varargin)

parameter = {'expo','niter','lambda'};
default_value = {2, 10, 1000};
[expo niter lambda] = parse_parameter(parameter, default_value, varargin);

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

%v1 = 1; v2 = 2;

%new_mf = vcycle(A,mf,f,v1,v2);
%new_mf = jacobian(mf,A,f,50);
new_mf = A\f;

%Calculate objective function
% weighted_cent = new_mf*new_centroids';
% 
% for i = 1:ncluster
%     dist(:,i) = abs(weighted_cent(:,i) - img(:));
% end
% 
% for i = 1:ncluster
%     obj(:,i) = mem(:,i).^2.*dist(:,i).^2;
% end
% 
% temp = lambda*(sum(sum((Di(sqrt(N),'i')*new_mf).^2+(Di(sqrt(N),'j')*new_mf).^2,2)));
% obj = sum(sum(obj,2))+temp;
% clear temp

end








