function [ma,xcpta,ycpta,aFnc,aStr] = conicstandardasymptotesOLD(a,b,x0,y0)

% function [ma,xcpta,ycpta,aFnc,aStr] = conicstandardasymptotesOLD(a,b,x0,y0)
%
%   example call: % HORIZONTAL HYPERBOLA
%                   conicstandardasymptotesOLD(1/sqrt(3),1j,0,0)
%
% conic asymptotes from standard equation
%
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
%      ASYMPOTES:     y = (-,+)*abs(b/a).*(x-x0) + y0;
%                     x = (-,+)*abs(a/b).*(y-y0) + x0;
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
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ma:     slope of asymptote
% xcpta:  x-intercepts of asymptote   [ 1 x 2 ]
%         if undefined -> [NaN NaN]
% ycpta:  y-intercepts of asymptote   [ 1 x 2 ] 
%         if undefined -> [NaN NaN]
% aFnc:   asymptote 1 & 2 function: 
%         IF m ~= Inf THEN aFnc: y = mx + ycpt 
%         IF m == Inf THEN aFnc; x = (1/m) - b/m
% aStr:   asymptote cell of strings {1,2}

if     ~isnan(a) && ~isnan(b)
    % SLOPE OF HYPERBOLA / ELLIPSE ASYMPTOTES 
    ma    = [-1 1].*abs(b)/abs(a);
    xcpta = -(1./ma).*y0 + x0;
    ycpta = -(   ma).*x0 + y0;
elseif isnan(a) || isnan(b) 
    % PARABOLA
    ma = [NaN NaN];
    xcpta = [0 0];
    ycpta = [0 0];
end
   
% ASYMPTOTE FUNCTIONS
if sum(isinf(ycpta)) == 0 && sum(isnan(ycpta)) == 0
    % FUNCTIONS: EASY TO READ
    % aFnc1 = @(x) ma(1).*x + ycpta(1); aFnc2 = @(x) ma(2).*x + ycpta(2);
    % FUNCTIONS: HARD TO READ
    aFnc = @(x) bsxfun(@plus,bsxfun(@times,ma,x(:)),ycpta);
    % FUNCTION STRINGS
    aStr{1} = ['Y=' num2str(ma(1),'%.3f') 'X+' num2str(ycpta(1),'%.3f')];
    aStr{2} = ['Y=' num2str(ma(2),'%.3f') 'X+' num2str(ycpta(2),'%.3f')];
elseif sum(isinf(xcpta)) == 0 && sum(isnan(xcpta)) == 0
    % FUNCTIONS: EASY TO READ
    % aFnc1 = @(y) (1/ma(1)).*y + xcpta(1); aFnc2 = @(y) (1/ma(2)).*y + xcpta(2);
    % FUNCTIONS: HARD TO READ
    aFnc = @(y) bsxfun(@plus,bsxfun(@times,1/ma,y(:)),xcpta);
    % FUNCTION STRINGS
    aStr{1} = ['X=' num2str(1/ma(1),'%.3f') 'Y+' num2str(xcpta(1),'%.3f')];
    aStr{2} = ['X=' num2str(1/ma(2),'%.3f') 'Y+' num2str(xcpta(2),'%.3f')];
end

