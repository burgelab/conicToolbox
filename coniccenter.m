function [x0,y0]=coniccenter(A,B,C,D,E,F)

% function [x0,y0]=coniccenter(A,B,C,D,E,F)
%
%   example call: % HYPERBOLA ORIENTED AT 45º
%                   [x0,y0]=coniccenter(0,1,0,0,0,-1)
%
%                 % HYPERBOLA ORIENTED ARBITRARY ORIENTATION
%                   [x0,y0]=coniccenter(3,1,-1,1,1,-1)
%
% x and y center locations from general conic parameters
%
% ONLINE VERIFICATION THAT CONIC PARAMETERS ARE CALCULATED ACCURATELY:
% https://www.emathhelp.net/calculators/algebra-2/hyperbola-calculator/
%
% A:      coefficient on x^2 term
% B:      coefficient on xy  term
% C:      coefficient on y^2 term
% D:      coefficient on x   term
% E:      coefficient on y   term
% F:      constant *should be negative
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x0:     x-position center of conic
% y0:     y-position center of conic

% X AND Y CENTERS (see VisionNotes/Proof_ConicGeneral2Centers.docx)
x0 = (B.*E - 2.*C.*D)./(4.*A.*C - B.^2);
y0 = (B.*D - 2.*A.*E)./(4.*A.*C - B.^2);

% CONIC TYPE
cncType = conictype(A,B,C,D,E,F);

% CHECKING
if strcmp(cncType,'parabola')
    disp(['coniccenter: WARNING! conic center does not exist cncType = parabola. Setting center (x0,y0) equal to vertex (vx,vy)']);
    % CONIC VERTEX
    [vxy]=conicvertex(A,B,C,D,E,F);
    % ISOLATE x0 AND y0 COMPONENTS
    x0 = vxy(1);
    y0 = vxy(2);
end
