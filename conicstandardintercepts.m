function [xcpta,ycpta] = conicstandardintercepts(a,b,x0,y0)

% function [xcpta,ycpta] = conicstandardintercepts(a,b,x0,y0)
%
%   example call: % HYPERBOLA
%                 [xcpta,ycpta] = conicstandardintercepts(1/sqrt(3),1j,0,0)
%
%                 % PARABOLA
%                 [xcpta,ycpta] = conicstandardintercepts(1,NaN,0,0)
%
% conic intercepts from standard form parameters
%
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
%
% a:      half length of conic in standard form along x-axis
%         imaginary ->  vertical  hyperbola
%         NaN       -> horizontal parabola
% b:      half length of conic in standard form along y-axis
%         imaginary -> horizontal hyperbola
%         NaN       ->  vertical  parabola
% x0:     x-center in standard form OR 
%         x-vertex if conic is a parabola
% y0:     y-center in standard form OR
%         y-vertex if conic is a parabola
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xcpta:  x-intercepts of asymptote   [ 1 x 2 ]
%         x-intercepts are imaginary if they don't exist
% ycpta:  y-intercepts of asymptote   [ 1 x 2 ] 
%         y-intercepts are imaginary if they don't exist

if ~isnan(a) && ~isnan(b)
    % ELLIPSE OR HYPERBOLA
    xcpta = x0 + [-1 1].*a.*sqrt( 1 - (y0/b).^2 );
    ycpta = y0 + [-1 1].*b.*sqrt( 1 - (x0/a).^2 );
elseif isnan(a) 
    % HORIZONTAL PARABOLA
    xcpta = ((-y0./abs(b))^2  +  x0).*[ 1 1]; %  x = ( (y-y0)/b )^2 + x0;
    ycpta =    y0 +abs(b).*sqrt(-x0).*[-1 1]; %  y = (+,-)*abs(b).*sqrt(x-x0) + y0;
elseif isnan(b) 
    %  VERTICAL  PARABOLA
    xcpta =    x0 +abs(a).*sqrt(-y0).*[-1 1]; %  x = (+,-)*abs(a).*sqrt(y-y0) + x0;
    ycpta = ((-x0./abs(a))^2  +  y0).*[ 1 1]; %  y = ( (x-x0)/a )^2 + y0;
end