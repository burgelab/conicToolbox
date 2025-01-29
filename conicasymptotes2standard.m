function [a,b,x0,y0] = conicasymptotes2standard(ma,x0,y0,xcpt,ycpt,bPLOT)

% function [a,b,x0,y0] = conicasymptotes2standard(ma,x0,y0,xcpt,ycpt,bPLOT)
%
%   example call: % HYPERBOLA
%                 [a,b,x0,y0] = conicasymptotes2standard(sqrt(3).*[-1 1],0,0,[-.25 .25],[],1)
%
% conic parameters in standard form from asymptote slopes, 
% conic center, and conic x- and/or y-intercepts
%
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
%
% ma:    slopes of asymptote                  [ 1 x 2 ]
%        (rise over run -> y/x)
% x0:    x-center of conic
% y0:    y-center of conic
% xcpt:  x-intercepts of asymptote            [ 1 x 2 ]
%        x-intercepts are imaginary if they don't exist
% ycpt:  y-intercepts of asymptote            [ 1 x 2 ] 
%        y-intercepts are imaginary if they don't exist
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a:      half length of conic in standard form along x-axis
%         imaginary ->   vertical hyperbola
%         NaN       -> horizontal parabola
% b:      half length of conic in standard form along y-axis
%         imaginary -> horizontal hyperbola
%         NaN       ->   vertical parabola
% x0:     x-center in standard form OR 
%         x-vertex if conic is a parabola
% y0:     y-center in standard form OR
%         y-vertex if conic is a parabola

disp(['conicasymptotes2standard: WARNING! not fully tested!!!']);

if ~exist('x0','var')    || isempty(  x0) x0    =      0; end
if ~exist('y0','var')    || isempty(  y0) y0    =      0; end
if ~exist('xcpt','var')                   xcpt  = [-1 1]; end
if ~exist('ycpt','var')                   ycpt  = [    ]; end
if ~exist('bPLOT','var')                  bPLOT =      0; end

% ELLIPSE OR HYPERBOLA
% xcpt = x0 + [-1 1].*a.*sqrt( 1 - (y0/b).^2 );
% ycpt = y0 + [-1 1].*b.*sqrt( 1 - (x0/a).^2 );

if x0 ~= 0 || y0 ~= 0
    error(['conicasymptotes2standard: WARNING! x0 ~= 0 or y0 ~= 0 are not handled. Update code?!?']);
end

% SET a & b BASED ON Y-INTERCEPT
if     ~isempty(ycpt)
    a  = 1i.*(1./max(ma)).*0.5.*diff(ycpt);
    b  =                   0.5.*diff(ycpt);
% SET a & b BASED ON X-INTERCEPT
elseif ~isempty(xcpt)
    a  =                   0.5.*diff(xcpt);
    b  = 1i.*(   max(ma)).*0.5.*diff(xcpt);
end

if bPLOT
    ortDeg = 0;
    [A,B,C,D,E,F] = conicstandard2general(a,b,x0,y0,ortDeg);
    conicplot(A,B,C,D,E,F,bPLOT);
end
