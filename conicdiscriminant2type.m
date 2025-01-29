function cncType = conicdiscriminant2type(d)

% function cncType = conicdiscriminant2type(d)
%
%   example call: conicdiscriminant2type(conicdiscriminant(A,B,C))
%
% d:         conic discriminant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cncType: type of conic corresponding to parameter values
%            d < 0 -> 'ellipse'
%            d = 0 -> 'parabola'
%            d > 0 -> 'hyperbola'


if     d  < 0 cncType = 'ellipse';
elseif d == 0 cncType = 'parabola';
elseif d  > 0 cncType = 'hyperbola';
else
    killer = 1;
end