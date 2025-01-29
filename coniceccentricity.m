function e = coniceccentricity(A,B,C,D,E,F)

% function e = coniceccentricity(A,B,C,D,E,F)
%
%   example call: e = coniceccentricity(1,0,1)
%
% conic eccentricity and type from coefficients in general form
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e:      eccentricity
%
%         *** see cov2conicparams.m ***

% CONIC TYPE
cncType = conictype(A,B,C,D,E,F);

%%%%%%%%%%%%%%%%%%%%%%%%
% COMPUTE ECCENTRICITY %
%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(cncType,'parabola') 
    e = 1;
else
    % SIGN OF ETA
    eta = -sign(det( [A B/2 D/2; B/2 C E/2; D/2 E/2 F ] ));
    % ECCENTRICITY
    e = sqrt( 2.*sqrt( (A-C).^2 + B.^2 )./(eta.*(A+C) + sqrt( (A-C).^2 + B.^2 )) );
end