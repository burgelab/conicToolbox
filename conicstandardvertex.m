function [vxy1,vxy2] = conicvertex(a,b,x0,y0)

% function [vxy1,vxy2] = conicvertex(a,b,x0,y0)
%
%   example call: % ELLIPSE
%                   [vxy1 vxy2] = conicvertex(sqrt(1/3),1 ,0,0)
%
%                 % HYPERBOLA 1
%                   [vxy1 vxy2] = conicvertex(sqrt(1/3),1i,0)
%
%                 % HYPERBOLA 2
%                   [vxy1 vxy2] = conicvertex(1,1i,0,0)
%
% vertex (or vertices) from parameters of conic in general form
% vertex-to-center distance equals 'a' if horizontal conic in standard form
% vertex-to-center distance equals 'b' if  vertical  conic in standard form
%
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
%
% ONLINE VERIFICATION THAT CONIC PARAMETERS ARE CALCULATED ACCURATELY:
% https://www.emathhelp.net/calculators/algebra-2/hyperbola-calculator/
%
% a:      half length of conic along x-axis after rotation to cardinal axes
%         NaN -> indicates a horizontally oriented parabola
% b:      half length of conic along y-axis after rotation to cardinal axes
%         NaN -> indicates a  vertically  oriented parabola
% x0:     x-mean after rotation in standard form 
% y0:     y-mean after rotation in standard form 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vxy1:   focus 1 in XY
% vxy2:   focus 2 in XY

% FOCUS (OR FOCI) OF CARDINAL-AXIS ALIGNED CONIC
if a==0 && b==0 && x0==0 && y0==0
    vxy1 = [0 0];
    vxy2 = [0 0];
else
    if strcmp(cncType,'ellipse')
        % CIRCLE
        if a == b
            vxy1 = [NaN NaN];
            vxy2 = [NaN NaN];
        elseif a > b
            % HORIZONTAL ELLIPSE
            vxy1 = [x0 - a, y0];
            vxy2 = [x0 + a, y0];
        elseif a < b
            %  VERTICAL  ELLIPSE
            vxy1 = [x0, y0 - b];
            vxy2 = [x0, y0 + b];
        end
    elseif strcmp(cncType,'parabola')
        % PARABOLA
        vxy1 = [x0, y0];
        vxy2 = [x0, y0];
    elseif strcmp(cncType,'hyperbola')
        if     sign(b^2) < 0
            % HORIZONTAL HYPERBOLA
            vxy1 = [x0 - a, y0];
            vxy2 = [x0 + a, y0];
        elseif sign(a^2) < 0
            %  VERTICAL  HYPERBOLA
            vxy1 = [x0, y0 - b];
            vxy2 = [x0, y0 + b];
        end
    end
end

