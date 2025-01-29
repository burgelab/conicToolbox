function plotSquare(ctrXY,szXY,color,linwidth,linstyle,rotDeg)

% function plotSquare(ctrXY,szXY,color,linewidth,linstyle,rotDeg)
% 
%   example call: plotSquare([0 0],[32 32],'k',1,'-',0)
%
% plots square with user-specified center, size, color, and linewidth
%
% ctrXY:     position of center pixel in the patch
% szXY:      patch size in pixels (x , y) 
% color:     color of lines to plot square with
% linwidth: width of line
% linstyle: width of line

% INPUT HANDLING
if ~exist('linstyle','var') || isempty(linstyle) linstyle = '-'; end
if ~exist('rotDeg','var')   || isempty(rotDeg)   rotDeg   =   0; end

% ROTATION MATRIX
R = rotMatrix(2,rotDeg);

% GET X AND Y COORDINATES OF CENTER OF SQUARE
x0 = ctrXY(1);
y0 = ctrXY(2);

% VERTICES
xVtx = x0 + [0 szXY(1)]-szXY(1)/2;
yVtx = y0 + [0 szXY(2)]-szXY(2)/2;

% PLOT PATCH
plotPolygon(xVtx,yVtx,linstyle,[color],linwidth);