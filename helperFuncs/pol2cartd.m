function [X,Y,Z] = pol2cartd(thetaDeg,rho,z)

% function [X,Y,Z] = pol2cartd(thetaDeg,rho,z)
%
% polar coordiantes to cartesian coordinates where theta is in deg
%
% thetaDeg: angle in degrees
% rho:      radius
% z:        z coordinate (if dealing w. cylindrical coordinates)
% %%%%%%%%%%%%%%%%%%
% X:        x-coordinate in cartesian space
% Y:        y-coordinate in cartesian space
% Z:        z-coordinate in cartesian space

if nargin < 3
    [X Y]   = pol2cart(thetaDeg.*pi./180,rho);
else
    [X Y Z] = pol2cart(thetaDeg.*pi./180,rho,z);
end