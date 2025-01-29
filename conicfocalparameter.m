function p = conicfocalparameter(A,B,C,D,E,F)

% function p = conicfocalparameter(A,B,C,D,E,F)
%
%   example call: p = conicfocalparameter(3,0,-1,0,0,-1)
%
% focal parameter is the distance from a focus to the nearest directrix
%
% ONLINE VERIFICATION THAT CONIC PARAMETERS ARE CALCULATED ACCURATELY:
% https://www.emathhelp.net/calculators/algebra-2/hyperbola-calculator/
%
% A:      coefficient on x^2 terms 
% B:      coefficient on xy  terms 
% C:      coefficient on y^2 terms 
% D:      coefficient on x   terms
% E:      coefficient on y   terms
% F:      constant
% bPLOT:  plot or not
%         1 -> plot
%         0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p:      focal parameter

% ECCENTRICITY
e = coniceccentricity(A,B,C,D,E,F);

% SEMI-LATUS RECTUM
l = conicsemilatusrectum(A,B,C,D,E,F);

% FOCAL PARAMETER
p = l./e;