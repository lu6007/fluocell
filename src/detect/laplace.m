% function [L] = laplace(n)

% Copyright: Kaiwen Zhang, Shaoying Lu and Yingxiao Wang 2013
function [L] = laplace(n)

N = n^2;  
irow = zeros(N*5, 1);
icol = irow; 
NZA = irow;

index = 0;
row = 0;

for j = 1:n
   for k = 1:n

      row = row + 1;

      if j > 1
         index = index + 1;
         NZA (index) = -1.0;
         irow(index) = row;
         icol(index) = row - n;   % elements on the left
      end

      if k > 1
         index = index + 1;
         NZA (index) = -1.0;
         irow(index) = row;
         icol(index) = row - 1;    % elements above
      end

      index = index + 1;
      NZA (index) = 4.0;
      irow(index) = row;
      icol(index) = row;           %elements in the middle

      if k < n
         index = index + 1;
         NZA (index) = -1.0;
         irow(index) = row;
         icol(index) = row + 1;    % elements below
      end

      if j < n 
         index = index + 1;
         NZA (index) = -1.0;
         irow(index) = row;
         icol(index) = row + n;   % elements on the right
      end
   end
end            

icol = icol(1:index); 
irow = irow(1:index);
NZA = NZA(1:index);

L = sparse (irow, icol, NZA, N, N);


% N = n^2;
% offDiags = -ones(N,1);
% offDiags(n:n:end)=0;
% L = spdiags([4*ones(N,1), flipdim(offDiags,1), offDiags , -ones(N,1), -ones(N,1)], [0,1,-1,n,-n], N, N);

end
