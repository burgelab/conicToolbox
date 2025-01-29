function [fxy1,fxy2] = conicfocus(A,B,C,D,E,F,bPLOT)

% function [fxy1,fxy2] = conicfocus(A,B,C,D,E,F,bPLOT)
%
%   example call: % ELLIPSE
%                   [fxy1 fxy2] = conicfocus(3,0,1,0,0,-1)
%
%                 % PARABOLA
%                   [fxy1 fxy2] = conicfocus(1,0,0,0,1,-1)
%
%                 % HYPERBOLA
%                   [fxy1 fxy2] = conicfocus(1,0,-1,0,0,-1)
%
% focus (or foci) from parameters of conic in general form
%
% algorithm:
%   i)   rotate conic to align w. cardinal axes
%   ii)  convert to standard (i.e vertex) form
%   iii) compute focus (or foci) using standard expressions
%   iv)  rotate back to original orientation
%
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
%
% ONLINE VERIFICATION THAT CONIC PARAMETERS ARE CALCULATED ACCURATELY:
% https://www.emathhelp.net/calculators/algebra-2/hyperbola-calculator/
% ONLINE VERIFICATION THAT CONIC PLOTTING IS WORKING CORRECTLY:
% https://www.desmos.com/calculator
% 
% A:      coefficient on x^2 term
% B:      coefficient on xy  term
% C:      coefficient on y^2 term
% D:      coefficient on x   term
% E:      coefficient on y   term
% F:      constant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fxy1:   focus 1 in XY        [ 1 x 2 ]
% fxy2:   focus 2 in XY        [ 1 x 2 ]

% INPUT HANDLING
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% CONIC TYPE
cncType = conictype(A,B,C,D,E,F);

% ROTATED CONIC PARAMETERS
[Ap,Bp,Cp,Dp,Ep,Fp] = conicrotate(A,B,C,D,E,F,[]);

% CONIC ORIENTATION
ortDeg = conicorientation(A,B,C,D,E,F);

% PARAMS IN STANDARD FORM: ROTATED ABOUT ORIGIN TO ALIGN W. CARDINAL AXES 
[a,b,x0,y0] = conicgeneral2standard(A,B,C,D,E,F);

% FOCUS (OR FOCI) OF CARDINAL-AXIS ALIGNED CONIC FROM PARAMS STANDARD FORM
[fxy1p,fxy2p] = conicstandardfocus(a,b,x0,y0);

% ROTATION MATRIX
R = rotMatrix(2,ortDeg);

% ROTATE BACK TO ORIGINAL ORIENTATION
fxy1 = (R*fxy1p')';
fxy2 = (R*fxy2p')';

if bPLOT == 1
    conicplot(A,B,C,D,E,F,bPLOT);
    subplot(1,2,1); 
    plot(fxy1(1),fxy1(2),'ko','markerface','k','markersize',8,'markeredge','none');
    plot(fxy2(1),fxy2(2),'ko','markerface','k','markersize',8,'markeredge','none');
end
