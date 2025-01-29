function [x,y,tDeg,r] = conicstandardplot(a,b,x0,y0,bPLOT)

% function [x,y,tDeg,r] = conicstandardplot(a,b,x0,y0,bPLOT)
%
%   example call: conicstandardplot(1/2,sqrt(3)/2,0,0,1);
%
% plot conic from parameters in general form and return points
% in cartesian (x,y) or in polar coordinates (tDeg,r)
%
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
%
% ONLINE VERIFICATION THAT CONIC PARAMETERS ARE PLOTTED ACCURATELY:
% https://www.desmos.com/calculator
% ONLINE VERIFICATION THAT CONIC PARAMETERS ARE CALCULATED ACCURATELY:
% https://www.emathhelp.net/calculators/algebra-2/hyperbola-calculator/
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x:       x-positions  in cartesian coordinates
% y:       y-positions  in cartesian coordinates
% tDeg:    angle in deg in   polar   coorindates
% r:       radius       in   polar   coorindates

if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% CONVERT STANDARD TO GENERAL
[A,B,C,D,E,F] = conicstandard2general(a,b,x0,y0);

% PLOT
[x,y,tDeg,r] = conicplot(A,B,C,D,E,F,bPLOT); 
