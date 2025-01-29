function cncType = conicstandardtype(a,b,x0,y0)

% function cncType = conicstandardtype(a,b,x0,y0)
%
%   example call: conicstandardtype(1/sqrt(3),1i,0,0)
%
% conic discriminant and type from coefficients in standard form
%
%      GENERAL  FROM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
%
% a:       half length of conic in standard form along x-axis
%          imaginary ->  vertical  hyperbola
%          NaN       -> horizontal parabola
% b:       half length of conic in standard form along y-axis
%          imaginary -> horizontal hyperbola
%          NaN       ->  vertical  parabola
% x0:      x-center in standard form OR 
%          x-vertex if conic is a parabola
% y0:      y-center in standard form OR
%          y-vertex if conic is a parabola
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cncType: type of conic

% CONIC GENERAL TO TYPE
[A,B,C,D,E,F] = conicstandard2general(a,b,x0,y0);

% CONIC TYPE
cncType = conictype(A,B,C,D,E,F);


