function [As,Bs,Cs,Ds,Es,Fs] = conicfilter2standardbasis(rhof,fOrtDeg,A,B,C,D,E,F,bPLOT)

% function [As,Bs,Cs,Ds,Es,Fs] = conicfilter2standardbasis(rhof,fOrtDeg,A,B,C,D,E,F,bPLOT)
%
%   example call: conicfilter2standardbasis(-0.5,45,0,1,0,0,0,-1,1)
%
% transform conic params in filter basis to conic params in standard basis
%
%            GENERAL FORM: Ax^2  +  Bxy  +  Cy^2  +  Dx  +  Ey + F = 0
%           STANDARD FORM:      ((x-x0)/a)^2      +  ((y-y0)/b)^2  = 1
%     MATRIX GENERAL FORM:          x'*Q*x        +  L'*x      + K = 0
%    ...IN STANDARD BASIS:     xs'*Mi'*Q*Mi*xs    +  L'*M*xs   + K = 0
% ...W ARBITRARY ROTATION: xs'*Ri'*Mi'*Q*Ri*Mi*xs +  L'*R*M*x  + K = 0
%                 where Ri=inv(R) is inverse rotation matrix 
%
%      see /VisionNotes/Proof_ConicFilterBasis2StandardBasis.docx
%
% rhof:     filter correlation
% fOrtDeg:  average filter orientation
% A:        coefficient on x^2 in filter   basis
% B:        coefficient on xy  in filter   basis
% C:        coefficient on y^2 in filter   basis
% D:        coefficient on x   in filter   basis
% E:        coefficient on y   in filter   basis 
% F:        constant           in filter   basis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% As:       coefficient on x^2 in standard basis
% Bs:       coefficient on xy  in standard basis
% Cs:       coefficient on y^2 in standard basis
% Ds:       coefficient on x   in standard basis
% Es:       coefficient on y   in standard basis
% Fs:       constant           in standard basis

% QUADRATIC COEFFICIENTS IN FILTER BASIS
Q = [A B/2; B/2 C];
% LINEAR COEFFICIENTS IN FILTER BASIS
L = [D; E];
% CONSTANT IN FILTER BASIS
K = F;
%%
% MATRIX TO TRANSFORM FILTER RESPONSES TO COORDINATES IN STANDARD BASIS 
% M = [ 1./sqrt(1+rhof) 1./sqrt(1+rhof);  % ASSUMES AVG FILTER ANGLE=0º
%      -1./sqrt(1-rhof) 1./sqrt(1-rhof)]./sqrt(2);
% ROTATION MATRIX
% R = [cosd(fOrtDeg) -sind(fOrtDeg);
%      sind(fOrtDeg)  cosd(fOrtDeg)];

% MATRIX TO TRANSFORM COORDINATES IN STANDARD BASIS TO FILTER RESPONSES
% NOTE! Mi = inv(M);
Mi = [sqrt(1+rhof) -sqrt(1-rhof);         % ASSUMES AVG FILTER ANGLE=0º
      sqrt(1+rhof)  sqrt(1-rhof)]./sqrt(2);

% INVERSE ROTATION MATRIX
Ri = [cosd(-fOrtDeg) -sind(-fOrtDeg);
      sind(-fOrtDeg)  cosd(-fOrtDeg)];

% QUADRATIC COEFFICIENTS IN STANDARD BASIS
Qs = Ri'*Mi'*Q*Mi*Ri;
% LINEAR COEFFICIENTS IN STANDARD BASIS
Ls = Ri'*Mi'*L;

% CONIC PARAMETERS IN STANDARD BASIS
As = Qs(1,1);
Bs = Qs(1,2).*2;
Cs = Qs(2,2);
Ds = Ls(1);
Es = Ls(2);
Fs = F;
%%
% CONIC PLOT
if bPLOT
    disp(['conicfilter2standardbasis: WARNING! improve plotting routines!!!']);
    % PLOT CONIC IN FILTER BASIS
    conicplot(A, B, C, D, E, F, 1);
    axis([-3 3 -3 3]);
    text(-2.5,2.5,'Filter Basis \rightarrow','fontsize',20);
    
    % PLOT CONIC IN STANDARD BASIS
    conicplot(As,Bs,Cs,Ds,Es,Fs,1);
    hold on;
    dffDeg = acosd(rhof);
    f12ortDeg = fOrtDeg+[-1 1].*dffDeg./2;
    f1 = [cosd(f12ortDeg(1)) sind(f12ortDeg(1))];
    f2 = [cosd(f12ortDeg(2)) sind(f12ortDeg(2))];
    plot([0 f1(1)],[0 f1(2)],'k','linewidth',4);
    plot([0 f2(1)],[0 f2(2)],'k','linewidth',4);
    axis([-3 3 -3 3]);
    text(-2.5,2.5,'Standard Basis','fontsize',20);
    set(gcf,'position',[996     5   749   791]);
end
killer = 1;