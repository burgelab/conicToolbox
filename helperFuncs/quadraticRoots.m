function [Rlo Rhi] = quadraticRoots(a,b,c)

% function [Rlo Rhi] = quadraticRoots(a,b,c)
%
% solves quadtratic equation, a*(x^2) + b*(x) + c = 0, for scalars or matrices
% a,b,c, must all be the same size or mixed between scalars and matrices
% 
% a:    coefficient on x^2
% b:    coefficient on x
% c:    constant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rlo:  low  root
% Rhi:  high root

Rlo = (-b - sqrt(b.^2 - 4*a.*c))./(2.*a);
Rhi = (-b + sqrt(b.^2 - 4*a.*c))./(2.*a);

