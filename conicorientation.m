function [ortDeg,cncType] = conicorientation(A,B,C,D,E,F)

% function [ortDeg,cncType] = conicorientation(A,B,C,D,E,F)
%
%   example call: [ortDeg,cncType] = conicorientation(1,2,1,0,0,-0.5)
%
% returns orientation of conic having the following general form
%
%         GENERAL: Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%
% A:      coefficient on x^2 term
% B:      coefficient on xy  term
% C:      coefficient on y^2 term
% D:      coefficient on x   term
% E:      coefficient on y   term
% F:      constant *should be negative*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ortDeg: orientation of conic

% TYPE OF CONIC
cncType = conictype(A,B,C,D,E,F);

% ORIENTATION OF THE CONIC
ortDeg = acotd( (A-C)/B )./2; 

% CATCH ORIENTATION FOR SYMMETRIC TERMS
if isnan(ortDeg) ortDeg = 0; end
