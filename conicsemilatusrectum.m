function l = conicsemilatusrectum(A,B,C,D,E,F)

% function l = conicsemilatusrectum(A,B,C,D,E,F)
% 
%   example call: l = conicsemilatusrectum(3,0,-1,0,0,-1)
%
% length of semi-latus rectum from conic parameters in general form.
% the semi-latus rectum is the distance from the focus to the conic
% in the direction parallel to the directrix
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% l:        semi-latus rectum

% TYPE OF CONIC
cncType = conictype(A,B,C,D,E,F);

% CONIC IN STANDARD FORM
[a,b,x0,y0] = conicgeneral2standard(A,B,C,D,E,F);

% SEMI-LATUS RECTUM
if strcmp(cncType,'ellipse')
    % SPECIAL ELLIPSE (CIRCLE)
    if a == b, 
    l = a;
    % GENERAL ELLIPSE
    elseif a > b
    l = (b.^2)./a;
    elseif b > a
	l = (a.^2)./b;
    end
elseif strcmp(cncType,'parabola')
    % PARABOLA
    if     isnan(b) %  VERTICAL  PARABOLA
        l = abs(a.^2)./2;
    elseif isnan(a) % HORIZONTAL PARABOLA
        l = abs(b.^2)./2;
    end
elseif strcmp(cncType,'hyperbola')
    % HYPERBOLA
    if sign(b.^2)<0
    l = abs(b.^2)./a; % HORIZONTAL HYPERBOLA
    elseif sign(a.^2)<0
    l = abs(a.^2)./b; %  VERTICAL  HYPERBOLA
    else 
        error(['conicsemilatusrectum: WARNING! cncType=' cncType' ' and a^2=' num2str(sign(b.^2)) ' and b^2=' num2str(sign(a.^2)) '. Something is wrong']);
    end
else
    error(['cncType: WARNING! unhandled cncType= ' cncType '. Something is wrong. FIX IT!']);
end
