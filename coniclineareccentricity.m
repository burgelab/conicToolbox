function c = coniclineareccentricity(A,B,C,D,E,F)

% function c = coniclineareccentricity(A,B,C,D,E,F)
%
%   example call: c = coniclineareccentricity(0,1,0,0,0,-1)
%
% linear eccentricity... distance from conic center to each focus
%
% ONLINE VERIFICATION THAT CONIC PARAMETERS ARE CALCULATED ACCURATELY:
% https://www.emathhelp.net/calculators/algebra-2/hyperbola-calculator/
%
% A:        coefficient on x-squared terms 
% B:        coefficient on xy  cross terms 
% C:        coefficient on y-squared terms 
% D:        coefficient on x terms
% E:        coefficient on y terms
% F:        constant        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% c:        linear eccentricity

% CONIC CENTER
[x0,y0] = coniccenter(A,B,C,D,E,F);

% CONIC FOCUS
[fxy1,fxy2] = conicfocus(A,B,C,D,E,F);

% LINEAR ECCENTRICITY: DISTANCE FROM CENTER TO FOCUS
c = sqrt(sum( [fxy1 - [x0 y0]].^2));


