function cncType = conictype(A,B,C,D,E,F)

% function cncType = conictype(A,B,C,D,E,F)
%
%   example call: % HYPERBOLA
%                   conictype(3,0,-1,0,0,-1)
%
% conic discriminant and type from coefficients in general form
%
%              Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%
% A:       coefficient on x^2
% B:       coefficient on xy
% C:       coefficient on y^2
% D:       coefficient on x   (NOT USED)
% E:       coefficient on y   (NOT USED)
% F:       constant           (NOT USED)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cncType: type of conic

% DISCRIMINANT
d = conicdiscriminant(A,B,C,D,E,F);

% TYPE
cncType = conicdiscriminant2type(d);
