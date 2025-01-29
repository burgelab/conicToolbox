function [x0,y0] = conicvertex2center(vxy1,vxy2)

% function [x0,y0] = conicvertex2center(vxy1,vxy2)
%
%   example call: 
%
% conic center from vertices
%
% vxy1: vertex 1
% vxy2: vertex 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x0:   x-position of center
% y0:   y-position of center

% CONIC CENTER HALFWAY BETWEEN VERTICES
xy0 = (vxy1+vxy2)./2;

% CONIC CENTER
x0 = xy0(:,1);
y0 = xy0(:,2);