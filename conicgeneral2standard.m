function [a,b,x0,y0,ortDeg] = conicgeneral2standard(A,B,C,D,E,F,bPLOT)

% function [a,b,x0,y0,ortDeg] = conicgeneral2standard(A,B,C,D,E,F,bPLOT)
%
%   example call: % VERTICLE CIRCLE
%                 [a,b,x0,y0,ortDeg]=conicgeneral2standard(2,0,1,0,0,-1,1)
%
%                 % ROTATED HYPERBOLA IN STANDARD FORM
%                 [a,b,x0,y0,ortDeg]=conicgeneral2standard(0,1,0,[],[],-1,1);
%     
%                 % ROTATED ELLIPSE
%                 [a,b,x0,y0,ortDeg]=conicgeneral2standard(4,2,1,[],[],.5,1);
%
% rotates general conic about origin (0,0) to align with cardinal axes 
% and returns parameters of cardinal-axes-aligned conic in standard form
% 
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
%      PARABOLA FORM:   (y-y0) = ( (x-x0)/a )^2 OR (x-x0) = ( (y-y0)/b )^2
%
%   see ../VisionNotes/Proof_ConicGeneral2StandardForm.doc
% 
% A:      coefficient on x^2 term 
% B:      coefficient on xy  term 
% C:      coefficient on y^2 term 
% D:      coefficient on x   term
% E:      coefficient on y   term
% F:      constant
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a:      half length of conic along x-axis after rotation to cardinal axes
%         NaN -> indicates a horizontally oriented parabola
% b:      half length of conic along y-axis after rotation to cardinal axes
%         NaN -> indicates a  vertically  oriented parabola
% x0:     x-center after rotation in standard form OR 
%         x-vertex after rotation if conic is a parabola
% y0:     y-center after rotation in standard form OR
%         y-vertex after rotation if conic is a parabola
% ortDeg: orientation of original conic

% INPUT HANDLING
if ~exist('D','var')     || isempty(D)     D     =  0; end
if ~exist('E','var')     || isempty(E)     E     =  0; end
if ~exist('F','var')     || isempty(E)     F     = -1; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT =  0; end

% INPUT CHECKING
if D == 0 && E == 0 && F == 0, disp(['conicgeneral2standard: WARNING! D=0 & E=0 & F=0. Conversion to standard form is degenerate']); end

% TYPE OF CONIC
cncType = conictype(A,B,C,D,E,F);

% CONIC ORIENTATION
ortDeg = conicorientation(A,B,C,D,E,F)

% PARAMETERS OF ROTATED CONIC
[Ap,Bp,Cp,Dp,Ep,Fp] = conicrotate(A,B,C,D,E,F);

% PARAMETERS OF ROTATED CONIC IN STANDARD FORM
if strcmp(cncType,'ellipse') || strcmp(cncType,'hyperbola')
    a     = sqrt( ( (Ap./Cp).*Ep.^2 +           Dp.^2 - 4.*Ap.*Fp  )./( 4.*Ap.^2 ) );
    b     = sqrt( (           Ep.^2 + (Cp./Ap).*Dp.^2 - 4.*Cp.*Fp  )./( 4.*Cp.^2 ) );
    x0    = -Dp./(2.*Ap);
    y0    = -Ep./(2.*Cp);
    if F == 0
       disp(['conicgeneral2standard: WARNING! does not work well when F=0! Write code?!?']);
    end
elseif strcmp(cncType,'parabola')
    % VERTICAL PARABOLA
    if     Cp == 0 
    a     = sqrt( -Ep./Ap );
    b     = NaN;
    x0    = -Dp./(2.*Ap);
    y0    = (Dp.^2 - 4.*Ap.*Fp)./(4.*Ap.*Ep); 
    % HORIZONTAL PARABOLA
    elseif Ap == 0 
	a     = NaN;
    b     = sqrt( -Dp./Cp );
    x0    = (Ep.^2 - 4.*Cp.*Fp)./(4.*Cp.*Dp); 
    y0    = -Ep./(2.*Cp);
    end
end

% PLOT (OR NOT)
if bPLOT == 1
    conicplot(Ap, Bp, Cp, Dp, Ep, Fp,bPLOT); 
end
