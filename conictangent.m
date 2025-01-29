function [Dt,Et,Ft,my,ycpt,mx,xcpt]=conictangent(A,B,C,D,E,F,tDeg,xy1,bPLOT)

% function [Dt,Et,Ft,my,ycpt,mx,xcpt]=conictangent(A,B,C,D,E,F,tDeg,xy1,bPLOT)
% 
%    example call: % CONIC TANGENT 45º
%                   [Dt,Et,Ft,my,ycpt,mx,xcpt]=conictangent(0,1,0,0,0,-1,45,[],1)
%
% tangent line at point specified by polar angle of point wrt conic center
% tangent line is expressed in both general form and in standard form
%
% USEFULNESS: for computing integral curves to log-likelihood ratio in filter OR stimulus basis
% 
%      CONIC GENERAL  FORM:    Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
% 
%      LINE  GENERAL  FORM:    Dx + Ey + F = 0
%      LINE  STANDARD FORM:    y = my*x + ycpt  (y as function of x)
%                              x = mx*y + xcpt  (x as function of y)
% 
% REFERENCE #1: https://www.emathzone.com/tutorials/geometry/equation-of-tangent-to-conic.html
% 
% REFERENCE #2: ../Papers/BaloglouHelfgott_AMATYC_2004.pdf 
%               Baloglou G, Helfgott M (2004) 
%               "Finding Equations of Tangents to Conics" 
%               The AMATYC Review, 25(2), 35-45.
%
% A:        coefficient on x^2 term 
% B:        coefficient on xy  term 
% C:        coefficient on y^2 term 
% D:        coefficient on x   term
% E:        coefficient on y   term
% F:        constant
% tDeg:     polar angle (from center) of point of interest 
%           0º   -> +x-axis
%           90º  -> +y-axis
%           180º -> -x-axis
%           270º -> -y-axis
% xy1:      point on conic
% bPLOT:    plot or not
%           1 -> plot
%           0 -> not
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dt:       coefficient on x term of tangent line in general  form
% Et:       coefficient on y term of tangent line in general  form
% Ft:       constant         term of tangent line in general  form
% my:       tangent slope -> rise over run...     in standard form
% ycpt:     tangent y-intercept                   in standard form
% my:       tangent slope -> run over rise...     in standard form
% xcpt:     tangent x-intercept                   in standard form
%
%   *** NOTE      standard form params may be Inf or NaN       ***

if ~exist('D','var')     || isempty(D)     D     =  0; end
if ~exist('E','var')     || isempty(E)     E     =  0; end
if ~exist('F','var')     || isempty(E)     F     = -1; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT =  0; end
if numel(tDeg)>1 && size(tDeg,2) ~= 1, tDeg = tDeg(:); end


if ~isempty(tDeg) & (~exist('xy1','var') || isempty(xy1))
    % STANDARD FORM
    [a,b,x0p,y0p] = conicgeneral2standard(A,B,C,D,E,F);
    % CONIC ORIENTATION
    ortDeg = conicorientation(A,B,C,D,E,F);
    % GENERAL CONIC PARAMETERS ALIGNED WITH CARDINAL AXES 
    [Ap,Bp,Cp,Dp,Ep,Fp]=conicrotate(A,B,C,D,E,F,-ortDeg);
    % POLAR COORDINATES OF ROTATED CONIC SITTING AT ORIGIN
    [tDeg,r] = conicplotpolar(Ap,Bp,Cp,Dp,Ep,Fp,tDeg-ortDeg);
    % CORRESPONDING CARTESIAN COORDINATES 
    [xp,yp]  = pol2cartd(tDeg,r);
    % ROTATION MATRIX
    R        = rotMatrix(2,ortDeg);
    % ROTATED TO ORIGINAL ORIENTATION AND TRANSLATED TO ORIGINAL POSITION
    xy1      = (R*[xp'+x0p; yp'+y0p])';
    % SEPARATING X AND Y VARIABLES
    x1       = xy1(:,1); 
    y1       = xy1(:,2);
elseif ~isempty(xy1) && (~exist('tDeg','var') || isempty(tDeg))
    % POINT ON CONIC
    x1   = xy1(:,1);
    y1   = xy1(:,2);
    % CHECK THAT POINT IS ON CONIC
    tol = 1e-3;
    if abs(A.*x1.^2 + B.*x1.*y1 + C.*y1.^2 + D.*x1 + E.*y1 + F) > tol
        disp(['conictangent: WARNING! specified point [x1 y1]=[' num2str(x1,'%.3f') ' ' num2str(y1,'%.3f') '] is not actually on conic! Result is incorrect!']);
    end
else
    error(['conictangent: WARNING! you must specify either tDeg OR xy1... but not both and not neither!']);
end

% COEFFICIENTS FOR TANGENT LINE AT [x1 y1]
Dt =  A.*x1     +  (B./2).*y1 + D./2;
Et = (B./2).*x1 +       C.*y1 + E./2;
Ft = (D./2).*x1 +  (E./2).*y1 + F   ;

% TANGENT LINE IN STANDARD FORM
[my,ycpt,mx,xcpt]=linegeneral2standard(Dt,Et,Ft);

%%
%%%%%%%%%%%%%% 
% PLOT STUFF %
%%%%%%%%%%%%%%
if bPLOT == 1
    % PLOT CONIC
    conicplot(A,B,C,D,E,F,bPLOT);
    
    % PLOT TANGENT LINE(S)
    for i = 1:numel(x1)
        % COMPUTE POINTS ON TANGENT LINE
        if ~isinf(my(i)) && ~isnan(my(i)) && ~isinf(ycpt(i)) && ~isnan(ycpt(i))
            xplt = xlim; yplt = my(i).*xplt + ycpt(i);
        else
            yplt = ylim; xplt = mx(i).*yplt + xcpt(i);
        end
        % PLOT TANGENT LINE AT POINT
        if numel(x1) <= 2
        plot(xplt,yplt,'k','linewidth',2);
        end
        % PLOT POINT
        plot(x1,y1,'ko','linewidth',2,'markersize',15,'markerface','w')
    end
end

