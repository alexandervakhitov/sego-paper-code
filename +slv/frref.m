function [A,jb] = frref(A)
%FRREF   Fast reduced row echelon form.
%   R = FRREF(A) produces the reduced row echelon form of A.
%   [R,jb] = FRREF(A,TOL) uses the given tolerance in the rank tests.
%   [R,jb] = FRREF(A,TOL,TYPE) forces frref calculation using the algorithm
%   for full (TYPE='f') or sparse (TYPE='s') matrices.
%   
% 
%   Description: 
%   For full matrices, the algorithm is based on the vectorization of MATLAB's
%   RREF function. A typical speed-up range is about 2-4 times of 
%   the MATLAB's RREF function. However, the actual speed-up depends on the 
%   size of A. The speed-up is quite considerable if the number of columns in
%   A is considerably larger than the number of its rows or when A is not dense.
%
%   For sparse matrices, the algorithm ignores the tol value and uses sparse
%   QR to compute the rref form, improving the speed by a few orders of 
%   magnitude.
%
%   Authors: Armin Ataei-Esfahani (2008)
%            Ashish Myles (2012)
%
%   Revisions:
%   25-Sep-2008   Created Function
%   21-Nov-2012   Added faster algorithm for sparse matrices

[m,n] = size(A);

do_full = 1;


jbind = 1;
% tol = 1e-10;
tol = max(m,n)*eps(class(A))*norm(A,'inf');

if do_full
    % Loop over the entire matrix.
    i = 1;
    j = 1;
    jb = zeros(n, 1);
    % t1 = clock;
    while (i <= m) && (j <= n)
       % Find value and index of largest element in the remainder of column j.
       [p,k] = max(abs(A(i:m,j))); k = k+i-1;
       if (p <= tol)
          % The column is negligible, zero it out.
          A(i:m,j) = 0; %(faster for sparse) %zeros(m-i+1,1);
          j = j + 1;
       else
          % Remember column index
%           jb = [jb j];
%           jbind
%           n
          jb(jbind) = 1;
          jbind = jbind+1;
          % Swap i-th and k-th rows.
          A([i k],j:n) = A([k i],j:n);
          % Divide the pivot row by the pivot element.
          Ai = A(i,j:n)/A(i,j);    
          % Subtract multiples of the pivot row from all the other rows.
          A(:,j:n) = A(:,j:n) - A(:,j)*Ai;
          A(i,j:n) = Ai;
          i = i + 1;
          j = j + 1;
       end
    end
end

jb = jb(1:jbind-1);

