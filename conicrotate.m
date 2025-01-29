function [Ar,Br,Cr,Dr,Er,Fr,rotDeg] = conicrotate(A,B,C,D,E,F,rotDeg,bPLOT)

% function [Ar,Br,Cr,Dr,Er,Fr,rotDeg] = conicrotate(A,B,C,D,E,F,rotDeg,bPLOT)
%
%   example call: % PLOT ORIGINAL AND ROTATED ELLIPSE
%                 [Ar,Br,Cr,Dr,Er,Fr,rotDeg]=conicrotate(1,1,1,[],[],-1,[],1);
%     
%                 % PLOT ORIGINAL AND ROTATED HYPERBOLA
%                 [Ar,Br,Cr,Dr,Er,Fr,rotDeg]=conicrotate(0,1,0,[],[],-1,[],1);
%
% rotates general conic to align with cardinal axes OR by specified amount
% and returns parameters of rotated conic in general
% 
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
% 
% A:      coefficient on x^2 terms 
% B:      coefficient on xy  cross terms 
% C:      coefficient on y^2 terms 
% D:      coefficient on x   terms
% E:      coefficient on y   terms
% F:      constant
% rotDeg: angle in deg to rotate conic by
%         [] -> rotates conic to align with cardinal axes
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ar:     coefficient on x^2 terms after rotation
% Br:     coefficient on xy  terms after rotation... i.e. zero
% Cr:     coefficient on y^2 terms after rotation 
% Dr:     coefficient on x   terms after rotation
% Er:     coefficient on y   terms after rotation
% Fr:     constant           term  after rotation
% rotDeg: angle in deg conic was rotated by

if ~exist('D','var')      || isempty(D)      D     =   0; end
if ~exist('E','var')      || isempty(E)      E     =   0; end
if ~exist('F','var')      || isempty(F)      F     =  -1; disp(['conicrotate: WARNING! parameter F defaulting to ' num2str(F) '. Is this REALLY what you want?!?'],1); end
if ~exist('rotDeg','var') || isempty(rotDeg) rotDeg = []; end
if ~exist('bPLOT','var')  || isempty(bPLOT)  bPLOT =   0; end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ANGLE TO ROTATE CONIC BY TO ALIGN WITH AXES %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(rotDeg) 
    % ANGLE TO NULL ROTATION
    rotDeg = -conicorientation(A,B,C,D,E,F);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ROTATE CONIC BY DESIRED ANGLE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2nd ORDER (SQUARED & CROSS) TERMS
Ar =  A.*cosd(rotDeg).^2 -  B.*cosd(rotDeg).*sind(rotDeg) + C.*sind(rotDeg).^2;
Br =  B.*cosd(2.*rotDeg) - (C-A).*sind(2.*rotDeg);
Cr =  A.*sind(rotDeg).^2 +  B.*cosd(rotDeg).*sind(rotDeg) + C.*cosd(rotDeg).^2;
% 1st ORDER (LINEAR)  TERMS
Dr =  D.*cosd(rotDeg) -  E.*sind(rotDeg);
Er =  D.*sind(rotDeg) +  E.*cosd(rotDeg);
% CONSTANT
Fr =  F;  

% [Ar,Br,Cr,Dr,Er,Fr]
% % 2nd ORDER (SQUARED) TERMS
% Ar =  A.*cosd(-rotDeg).^2 +  B.*cosd(-rotDeg).*sind(-rotDeg) + C.*sind(-rotDeg).^2;
% Br =  B.*cosd(-2.*rotDeg) + (C-A).*sind(-2.*rotDeg);
% Cr =  A.*sind(-rotDeg).^2 -  B.*cosd(-rotDeg).*sind(-rotDeg) + C.*cosd(-rotDeg).^2;
% % 1st ORDER (LINEAR)  TERMS
% Dr =  D.*cosd(-rotDeg) +  E.*sind(-rotDeg);
% Er = -D.*sind(-rotDeg) +  E.*cosd(-rotDeg);
% % CONSTANT
% Fr =  F;
% [Ar,Br,Cr,Dr,Er,Fr]
