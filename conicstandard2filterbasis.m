function [A,B,C,D,E,F] = conicstandard2filterbasis(rhof,fOrtDeg,As,Bs,Cs,Ds,Es,Fs,bPLOT)

% function [A,B,C,D,E,F] = conicstandard2filterbasis(rhof,fOrtDeg,As,Bs,Cs,Ds,Es,Fs,bPLOT)
%
%   example call: % HYPERBOLA: STANDARD TO FILTER BASIS
%                   conicstandard2filterbasis(-0.5,45,-0.25,1,-0.25,0,0,-1,1)
%
%                 % HYPERBOLA: STANDARD TO FILTER BASIS 4 MULTIPLE FILTER CORRELATIONS
%                   for i = 90:5:160, conicstandard2filterbasis(cosd(-i),45,-0.25,1,-0.25,0,0,-1,1); end
%
% convert conic params in standard basis to conic params in filter basis
%           
%            GENERAL FORM: Ax^2  +  Bxy  +  Cy^2 +  Dx  +  Ey + Fs = 0
%           STANDARD FORM:      ((x-x0)/a)^2     +  ((y-y0)/b)^2  = 1
%     MATRIX GENERAL FORM:        xs'*Qs*xs      +  Ls'*xs   + K = 0
%        ...IN FLTR BASIS:   x'*M'*R'*Qs*R*M*x   +  L'*R*M*xf + K = 0
%
%      see /VisionNotes/Proof_ConicFilterBasis2StandardBasis.docx
%
% rhof:      filter correlation
% fOrtDeg:   average filter orientation
% As:        coefficient on x^2 in standard basis
% Bs:        coefficient on xy  in standard basis
% Cs:        coefficient on y^2 in standard basis
% Ds:        coefficient on x   in standard basis
% Es:        coefficient on y   in standard basis
% Fs:        constant           in standard basis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A:         coefficient on x^2 in filter   basis
% B:         coefficient on xy  in filter   basis
% C:         coefficient on y^2 in filter   basis
% D:         coefficient on x   in filter   basis
% E:         coefficient on y   in filter   basis 
% F:         constant           in filter   basis

% 'QUADRATIC' PARAMS IN STANDARD BASIS
Qs = [As Bs/2; Bs/2 Cs];
% 'LINEAR' PARAMS IN STANDARD BASIS
Ls = [Ds; Es];
% CONSTANT PARAMS
Ks = Fs;
%%
% MATRIX TRANSFORMING FILTER RESPONSES TO COORDS IN STANDARD BASIS 
M    = [ 1./sqrt(1+rhof) 1./sqrt(1+rhof); % ASSUMES AVG ANGLE = 0º
        -1./sqrt(1-rhof) 1./sqrt(1-rhof)]./sqrt(2);
              
% ROTATION MATRIX
R = [cosd(fOrtDeg) -sind(fOrtDeg);
     sind(fOrtDeg)  cosd(fOrtDeg)];
 
% MATRIX TO TRANSFORM COORDINATES IN STANDARD BASIS TO FILTER RESPONSES
% Minv = [sqrt(1+rhof) -sqrt(1-rhof);       % NOTE! Minv = inv(M);
%         sqrt(1+rhof) sqrt(1-rhof)]./sqrt(2); 
% INVERSE ROTATION MATRIX
% Rinv = [cosd(-fOrtDeg) -sind(-fOrtDeg);
%         sind(-fOrtDeg)  cosd(-fOrtDeg)];

% QUADARTIC COEFFICIENTS IN FILTER BASIS
Q = M'*R'*Qs*R*M;
% LINEAR COEFFICIENTS IN FILTER BASIS
L = M'*R'*Ls;

% CONIC PARAMS IN FILTER BASIS
A = Q(1,1);
B = Q(1,2).*2;
C = Q(2,2);
D = L(1);
E = L(2);
F = Fs;
%%
% CONIC PLOT
if bPLOT
    disp(['conicstandard2filterbasis: WARNING! improve plotting routines!!!']);
    % PLOT CONIC IN STANDARD BASIS
    conicplot(As, Bs, Cs, Ds, Es, Fs, 1); hold on;
    dffDeg = acosd(rhof);
    f12ortDeg = fOrtDeg+[-1 1].*dffDeg./2;
    f1 = [cosd(f12ortDeg(1)) sind(f12ortDeg(1))];
    f2 = [cosd(f12ortDeg(2)) sind(f12ortDeg(2))];
    plot([0 f1(1)],[0 f1(2)],'k','linewidth',4);
    plot([0 f2(1)],[0 f2(2)],'k','linewidth',4);
    axis([-3 3 -3 3]);
    text(-2.5,2.5,'Standard Basis \rightarrow','fontsize',20);
    
    % PLOT CONIC IN FILTER BASIS
    conicplot(A,B,C,D,E,F,1); 
    axis([-3 3 -3 3]);
    text(-2.5,2.5,'Filter Basis','fontsize',20);
    set(gcf,'position',[996     5   749   791]);
end
killer = 1;