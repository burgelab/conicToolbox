function [vxy1,vxy2] = conicvertex(A,B,C,D,E,F)

% function [vxy1,vxy2] = conicvertex(A,B,C,D,E,F)
%
%   example call: % ELLIPSE
%                   [vxy1 vxy2] = conicvertex(3,0,1,0,0,-1)
%
%                 % PARABOLA
%                   [vxy1 vxy2] = conicvertex(1,0,0,0,1,-1)
%
%                 % HYPERBOLA 1
%                   [vxy1 vxy2] = conicvertex(1,0,-1,0,0,-1)
%
%                 % HYPERBOLA 2
%                   [vxy1 vxy2] = conicvertex(0,1,0,0,0,-1)
%
% vertex (or vertices) from parameters of conic in general form
% vertex-to-center distance equals 'a' if horizontal conic in standard form
% vertex-to-center distance equals 'b' if  vertical  conic in standard form
%
% algorithm:
%   i)   rotate conic to align w. cardinal axes
%   ii)  convert to standard (i.e vertex) form
%   iii) compute vertex (or vertices) using standard expressions
%   iv)  rotate back to original orientation
%
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
%
% ONLINE VERIFICATION THAT CONIC PARAMETERS ARE CALCULATED ACCURATELY:
% https://www.emathhelp.net/calculators/algebra-2/hyperbola-calculator/
%
% A:      coefficient on x-squared terms
% B:      coefficient on xy  cross terms
% C:      coefficient on y-squared terms
% D:      coefficient on x terms
% E:      coefficient on y terms
% F:      constant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vxy1:   focus 1 in XY
% vxy2:   focus 2 in XY

% CONIC TYPE
cncType = conictype(A,B,C,D,E,F);

% CONIC ORIENTATION
ortDeg = conicorientation(A,B,C,D,E,F);

% ROTATED CONIC PARAMETERS
[Ap,Bp,Cp,Dp,Ep,Fp] = conicrotate(A,B,C,D,E,F);

% CONIC PARAMETERS IN STANDARD FORM & STORE ORIGINAL ORIENTATION
[a,b,x0,y0] = conicgeneral2standard(A,B,C,D,E,F);

% FOCUS (OR FOCI) OF CARDINAL-AXIS ALIGNED CONIC
if a==0 && b==0 && x0==0 && y0==0
    vxy1p = [0 0];
    vxy2p = [0 0];
else
    if strcmp(cncType,'ellipse')
        % CIRCLE
        if a == b
            vxy1p = [NaN NaN];
            vxy2p = [NaN NaN];
        elseif a > b
            % HORIZONTAL ELLIPSE
            vxy1p = [x0 - a, y0];
            vxy2p = [x0 + a, y0];
        elseif a < b
            %  VERTICAL  ELLIPSE
            vxy1p = [x0, y0 - b];
            vxy2p = [x0, y0 + b];
        end
    elseif strcmp(cncType,'parabola')
        % PARABOLA
        vxy1p = [x0, y0];
        vxy2p = [x0, y0];
    elseif strcmp(cncType,'hyperbola')
        if     sign(b^2) < 0
            % HORIZONTAL HYPERBOLA
            vxy1p = [x0 - a, y0];
            vxy2p = [x0 + a, y0];
        elseif sign(a^2) < 0
            %  VERTICAL  HYPERBOLA
            vxy1p = [x0, y0 - b];
            vxy2p = [x0, y0 + b];
        end
    end
end

% ROTATION MATRIX
R = rotMatrix(2,ortDeg);

% ROTATE BACK TO ORIGINAL ORIENTATION
vxy1 = (R*vxy1p')';
vxy2 = (R*vxy2p')';
