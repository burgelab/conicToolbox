function LD = logdet(A)

% function LD = logdet(A) 
%
% computes the log-determinant of a matrix A. 
% faster and more stable than log(det(A))
%
% A:   A must be square, symmetric, positive semi-definite [N x N]
% %%%%%%%%%%%%%
% LD:   log of determinant

% CHECK THAT MATRIX IS SYMMETRIC
if A ~= conj(A') error(['logdet: WARNING! A must be symmetric']); end

% CHOLESKY DECOMPOSITION
[R,p]= chol(A);

% CHECK THAT 'A' IS POSITIVE DEFINITE
if p ~= 0, error(['logdet: WARNING! A must be positive definite']); end

% COMPUTE LOG DETERMINANT OF A 
LD = 2*sum( log(diag(R)) );