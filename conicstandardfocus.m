function [fxy1,fxy2] = conicstandardfocus(a,b,x0,y0,bPLOT)

% function [fxy1,fxy2] = conicstandardfocus(a,b,x0,y0,bPLOT)
%
%   example call: % ELLIPSE
%                   [fxy1 fxy2] = conicstandardfocus(1/sqrt(3),1,0,0,1)
%
%                 % HYPERBOLA
%                   [fxy1 fxy2] = conicstandardfocus(1/sqrt(3),1i,0,0,1)
%
% focus (or foci) from parameters of conic in general form
%
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
%
% ONLINE VERIFICATION THAT CONIC PARAMETERS ARE CALCULATED ACCURATELY:
% https://www.emathhelp.net/calculators/algebra-2/hyperbola-calculator/
%
% a:       half length of conic in standard form along x-axis
%          imaginary ->  vertical  hyperbola
%          NaN       -> horizontal parabola
% b:       half length of conic in standard form along y-axis
%          imaginary -> horizontal hyperbola
%          NaN       ->  vertical  parabola
% x0:      x-center in standard form OR 
%          x-vertex if conic is a parabola
% y0:      y-center in standard form OR
%          y-vertex if conic is a parabola
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fxy1:   focus 1 in XY
% fxy2:   focus 2 in XY

% INPUT HANDLING
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end
    
% CONIC TYPE
cncType = conicstandardtype(a,b,x0,y0);

% FOCUS (OR FOCI) OF CARDINAL-AXIS ALIGNED CONIC
if a==0 && b==0 && x0==0 && y0==0
    fxy1 = [0 0];
    fxy2 = [0 0];
else
    if strcmp(cncType,'ellipse')
        % CIRCLE
        if a == b      
        fxy1 = [x0 y0];
        fxy2 = [x0 y0];
        % HORIZONTAL ELLIPSE
        elseif a > b    
        fxy1 = [x0 - sqrt(a^2 - b^2), y0];
        fxy2 = [x0 + sqrt(a^2 - b^2), y0];
        %  VERTICAL  ELLIPSE
        elseif a < b   
        fxy1 = [x0, y0 - sqrt(b^2 - a^2)];
        fxy2 = [x0, y0 + sqrt(b^2 - a^2)];
        else
        error(['conicstandardfocus: WARNING! cncType=' cncType ' and something is wrong']);
        end
    elseif strcmp(cncType,'parabola')
        %  VERTICAL  PARABOLA
        if     isnan(b) || isinf(b)
        fxy1 = [x0, y0 + (a.^2)./4]; 
        fxy2 = [x0, y0 + (a.^2)./4];
        % HORIZONTAL PARABOLA
        elseif isnan(a) || isinf(a)
        fxy1 = [x0 + (b.^2)./4, y0]; 
        fxy2 = [x0 + (b.^2)./4, y0];
        else
        error(['conicstandardfocus: WARNING! cncType=' cncType ' and something is wrong']);
        end
    elseif strcmp(cncType,'hyperbola')
        % HORIZONTAL HYPERBOLA
        if     sign(b^2) < 0        
        fxy1 = [x0 - sqrt(a^2 - b^2), y0];
        fxy2 = [x0 + sqrt(a^2 - b^2), y0];
        %  VERTICAL  HYPERBOLA
        elseif sign(a^2) < 0  
        fxy1 = [x0, y0 - sqrt(b^2 - a^2)];
        fxy2 = [x0, y0 + sqrt(b^2 - a^2)];
        else
        error(['conicstandardfocus: WARNING! cncType=' cncType ' and something is wrong']);
        end
    end
end

% PLOT STUFF
if bPLOT == 1
    % CONIC STANDARD TO GENERAL
    [A,B,C,D,E,F]=conicstandard2general(a,b,x0,y0,0);
    % PLOT
    conicplot(A,B,C,D,E,F,bPLOT);
    subplot(1,2,1); 
    plot(fxy1(1),fxy1(2),'ko','markerface','k','markersize',8,'markeredge','none');
    plot(fxy2(1),fxy2(2),'ko','markerface','k','markersize',8,'markeredge','none');
end
