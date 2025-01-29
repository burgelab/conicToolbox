function [d] = conicdiscriminant(A,B,C,D,E,F)

% function [d] = conicdiscriminant(A,B,C,D,E,F)
%
%   example call: [d] = conicdiscriminant(1,0,1)
%
% conic discriminant (B.^2 - 4.*A.*C) from coefficients in general form
%
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
%
% A:      coefficient on x^2 term
% B:      coefficient on xy  term
% C:      coefficient on y^2 term
% D:      coefficient on x   term
% E:      coefficient on y   term
% F:      constant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% d:         discriminant
%
%      *** see  cov2conicparams.m  ***
%      *** see  conic*.m  toolbox  ***     

% DISCRIMINANT
d = B.^2 - 4.*A.*C;

% % DISCRIMINANT IS THE DETERMINANT OF THE MATRIX
% M = [ A   B/2  D/2; 
%      B/2   C   E/2; 
%      D/2  E/2   F];
%  
% % DISCRIMINANT = DETERMINANT
% d = -det(M)