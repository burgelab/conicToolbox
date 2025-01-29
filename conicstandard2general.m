function [A,B,C,D,E,F] = conicstandard2general(a,b,x0,y0,ortDeg,bPLOT)

% function [A,B,C,D,E,F] = conicstandard2general(a,b,x0,y0,ortDeg,bPLOT)
%
%   example call: % HYPERBOLA 
%                 [A,B,C,D,E,F] = conicstandard2general(sqrt(1/3),sqrt(-1),0,0,0,1)          
%    
%                 % ROTATED HYPERBOLA
%                 [A,B,C,D,E,F] = conicstandard2general(sqrt(2),sqrt(-2),0,0,45,1)    
%
% rotates general conic to align with cardinal axes and returns 
% conic parameters of rotated conic in general and standard form...
% 
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
%      PARABOLA FORM:   (y-y0) = ( (x-x0)/a )^2 OR (x-x0) = ( (y-y0)/b )^2
%
% ONLINE VERIFICATION THAT CONIC PARAMETERS ARE CALCULATED ACCURATELY:
% https://www.emathhelp.net/calculators/algebra-2/hyperbola-calculator/
%
%  also see ../VisionNotes/Proof_ConicStandard2GeneralForm.doc
% 
% a:      half length of conic along x-axis after rotation to cardinal axes
%         NaN -> indicates a horizontally oriented parabola
%         major (or minor) radius
% b:      half length of conic along y-axis after rotation to cardinal axes
%         NaN -> indicates a  vertically  oriented parabola
%         minor (or major) radius
% x0:     x-mean after rotation in standard form 
% y0:     y-mean after rotation in standard form 
% ortDeg: orientation of desired conic in deg
% bPLOT:  plot or not
%         1 -> plot
%         0 -> not
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A:      coefficient on x^2 term 
% B:      coefficient on xy  term 
% C:      coefficient on y^2 term 
% D:      coefficient on x   term
% E:      coefficient on y   term
% F:      constant

if ~exist('x0',    'var') || isempty(x0)     x0     = 0; end
if ~exist('y0',    'var') || isempty(y0)     y0     = 0; end
if ~exist('ortDeg','var') || isempty(ortDeg) ortDeg = 0; end
if ~exist('bPLOT', 'var') || isempty(bPLOT)  bPLOT  = 0; end

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ELLIPSES AND HYPERBOLAS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isnan(a) && ~isnan(b)
    % CONSTANT TO HELP ENFORCE CONVENTION THAT Fp = -1.0
    Kp = (x0.*b).^2 + (y0.*a).^2 - (a.*b).^2;
    % FACTOR TO ENFORCE CONVENTION THAT Fp = -1.0
    if     Kp ~= 0, Zp = -sign(Kp)./abs(Kp);
    elseif Kp == 0, Zp = 1; 
    end

    % GENERAL CONIC PARAMETERS
    Ap =                                (b.^2).*Zp;
    Bp =                                    0     ;
    Cp =                                (a.^2).*Zp;
    Dp =                        -(2.*x0.*b.^2).*Zp;
    Ep =                        -(2.*y0.*a.^2).*Zp;
    Fp = ((x0.*b).^2 + (y0.*a).^2 - (a.*b).^2).*Zp;
else 
%%%%%%%%%%%%%
% PARABOLAS %
%%%%%%%%%%%%%
    if  isnan(b)
    %%%%%%%%%%%%%%%%%%%%%
    % VERTICAL PARABOLA % y = a*x^2 + b
    %%%%%%%%%%%%%%%%%%%%%
    % CONSTANT TO HELP ENFORCE CONVENTION THAT Fp = -1.0
    Kp    = (a.^2).*y0 + x0.^2;
    % FACTOR TO ENFORCE CONVENTION THAT Fp = -1.0
    if     Kp ~= 0, Zp = -sign(Kp)./abs(Kp); 
    elseif Kp == 0, Zp = 1; 
    end
    % GENERAL CONIC PARAMETERS
    Ap    =           Zp;
    Bp    =       0     ;
    Cp    =       0     ;
    Dp    = -(2.*x0).*Zp;
    Ep    =  -(a.^2).*Zp;
    Fp    =       Kp.*Zp;
    elseif isnan(a)
    %%%%%%%%%%%%%%%%%%%%%%%
    % HORIZONTAL PARABOLA % x = a*y^2 + b
    %%%%%%%%%%%%%%%%%%%%%%%
    % CONSTANT TO HELP ENFORCE CONVENTION THAT Fp = -1.0
    Kp    = (b.^2).*x0 + y0.^2;
    % FACTOR TO ENFORCE CONVENTION THAT Fp = -1.0
    if     Kp ~= 0, Zp = -sign(Kp)./abs(Kp); 
    elseif Kp == 0, Zp = 1; 
    end
    
    % GENERAL CONIC PARAMETERS
    Ap    =           0;
    Bp    =           0;
    Cp    =          Zp;
    Dp    = -(b.^2).*Zp;
    Ep    =  -2.*y0.*Zp;
    Fp    =      Kp.*Zp;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ROTATE CONIC TO DESIRED ANGLE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[A,B,C,D,E,F]=conicrotate(Ap,Bp,Cp,Dp,Ep,Fp,ortDeg);

% PLOT (OR NOT)
if bPLOT == 1
    conicplot(A,B,C,D,E,F,bPLOT); 
end
