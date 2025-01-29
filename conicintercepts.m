function [xcpt,ycpt]=conicintercepts(A,B,C,D,E,F)

% function [xcpt ycpt]=conicintercepts(A,B,C,D,E,F)
%
%   example call: % RECTANGULAR HYPERBOLA
%                 [xint,yint]=conicintercepts(1,0,-1,0,0,1)
%       
%                 % RECTANGULAR HYPERBOLA
%                 [xint,yint]=conicintercepts(3,0,-1,0,0,1)
%
% x and y intercepts of general conic from coefficients in general form
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xcpt:   x intercepts    [ 1 x 2 ]
%         if undefined -> [NaN NaN]
% ycpt:   y intercepts 
%         if undefined -> [NaN NaN]

% X-INTERCEPTS
if A ~= 0
    [xcpt(1),xcpt(2)] = quadraticRoots(A,D,F);
else
    % PARABOLA
    xcpt = (-F/D).*[1 1];
end

% Y-INTERCEPTS
if C ~= 0
    [ycpt(1),ycpt(2)] = quadraticRoots(C,E,F);
else
    % HANDLES PARABOLAS
    ycpt = (-F/E).*[1 1];
end