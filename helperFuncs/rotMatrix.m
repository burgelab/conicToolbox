function R = rotMatrix(dims,rotDeg,rotAxis)

% function R = rotMatrix(dims,rotDeg,rotAxis)
%
%   example call: rotMatrix(3,45,[0 1 0])  
%
% rotate matrix by specified angle about specified axis
% 
% dims:    number of dimensions
% rotDeg:  rotation angle
% rotAxis: axis about which to rotate through the specified angle
%%%%%%%%%%%%%% 
% R:       rotation matrix

if dims == 2
    R = [cosd(rotDeg) -sind(rotDeg); ...
         sind(rotDeg) cosd(rotDeg)];
elseif dims == 3
    if isequal(rotAxis,[1 0 0])
        R = [1 0            0           ; ...
            0  cosd(rotDeg) -sind(rotDeg); ...
            0  sind(rotDeg)  cosd(rotDeg)];
    elseif isequal(rotAxis,[0 1 0])
        R = [cosd(rotDeg) 0 -sind(rotDeg); ...
            0             1            0; ...
             sind(rotDeg) 0 cosd(rotDeg)];
    elseif isequal(rotAxis,[0 0 1])
        R = [cosd(rotDeg) -sind(rotDeg) 0; ...
             sind(rotDeg)  cosd(rotDeg) 0; ...
            0             0            1];
    else
        error(['rotMatrix: WARNING! unhandled rotAxis: [' num2str(rotAxis) ']'])
    end
else 
    error(['rotMatrix: WARNING! unhandled number of dimensions: ' num2str(dims)]);
end