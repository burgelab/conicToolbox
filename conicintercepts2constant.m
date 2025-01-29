function F = conicintercepts2constant(A,B,C,D,E,xcpt,ycpt,tol,bPLOT)

% function F = conicintercepts2constant(A,B,C,D,E,xcpt,ycpt,tol,bPLOT)
%
%   example call: % RECTANGULAR HYPERBOLA
%                 F = conicintercepts2constant(1,0,-1,0,0,[-0.25 0.25],[],[],1)
%       
%                 % VERTICALLY ENLOGATED HYPERBOLA
%                 F = conicintercepts2constant(3,0,-1,0,0,[-0.25 0.25],[],[],1)
%
% constant defined by coefficients of conic in general form 
% given the desired x and/or y intercepts 
%
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
% 
% A:      coefficient on x-squared terms 
% B:      coefficient on xy  cross terms 
% C:      coefficient on y-squared terms 
% D:      coefficient on x terms
% E:      coefficient on y terms
% xcpt:   desired x intercepts               [ 1 x 2 ]
% ycpt:   desired y intercepts               [ 1 x 2 ] 
% tol:    tolerance on |Fx - Fy|
%         [] -> 1e-6 (default)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% F:      constant

% INPUT HANDLING
if ~exist('xcpt','var')  || isempty(xcpt) xcpt =   []; bUseX =    0; end
if ~exist('ycpt','var')  || isempty(ycpt) ycpt =   []; bUseY =    0; end
if ~exist('tol','var')   || isempty(tol)               tol   = 1e-6; end
if ~exist('bPLOT','var') || isempty(bPLOT)             bPLOT =    0; end
% if D~=0 || E~=0 error(['conicintercepts2constant: WARNING! 

% CONSTANT BASED ON X-INTERCEPTS
if exist('xcpt','var') && ~isempty(xcpt)
    % REDUCED X-POLYNOMIAL COEFFICIENTS FROM INTECEPTS
    [Px]  = poly(xcpt);
    % SCALAR ON REDUCED X-POLYNOMIAL
    Kx    = A./Px(1);
    % MULTIPLY X-CONSTANT BY SCALAR
    Fx    = Kx.*Px(3);
    bUseX = 1;
end
% CONSTANT BASED ON Y-INTERCEPTS
if exist('ycpt','var') && ~isempty(ycpt)
    % REDUCED Y-POLYNOMIAL COEFFICIENTS FROM INTECEPTS
    [Py]  = poly(ycpt);
    % SCALAR ON REDUCED Y-POLYNOMIAL
    Ky    = C./Py(1);
    % MULTIPLY Y-CONSTANT BY SCALAR
    Fy    = Ky.*Py(3);
    bUseY = 1;
end

% FINALIZE CONSTANT
if bUseX == 1 && bUseY == 1
    F = (Fx+Fy)./2;
    % ERROR CHECKING: Fx AND Fy SHOULD BE CONSISTENT
    if abs(Fx-Fy) > tol
        error(['conicintercepts2constant: WARNING! Fx and Fy are not consistent... |Fx-Fy|>' num2str(tol)]);
    end
elseif bUseX == 1 && bUseY == 0
    F = Fx;
elseif bUseX == 0 && bUseY == 1
    F = Fy;
end

% PLOT OR NOT
conicplot(A,B,C,D,E,F,bPLOT);
