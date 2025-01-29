function [mr,xcptr,ycptr,fncYMXBr,strYMXBr,fncXMYBr,strXMYBr] = linerotate(my,xcpt,ycpt,xC,yC,rotDeg,bPLOT)

% function [mr,xcptr,ycptr,fncYMXBr,strYMXBr,fncXMYBr,strXMYBr] = linerotate(my,xcpt,ycpt,xC,yC,rotDeg,bPLOT)
%
%   example call: % ROTATE AROUND ORIGIN
%                   linerotate(1,-1,1,0,0,90,1);
%                 
%                 % ARBITRARY CENTER OF ROTATION
%                   r = 0:10:180; for i = 1:length(r),linerotate(1,-1,1,-.5,.5,r(i),1); end
%
% rotate line by a given angle around the origin
%
%           y = my*x + ycpt OR x = (1/m)*y + xcpt 
% 
% my:        slope
% xcpt:     x-intercept
% ycpt:     y-intercept
% xC:       x-center of rotation 
%           [] -> xC = 0
% yC:       y-center of rotation
%           [] -> yC = 0
% rotDeg:   rotation angle
% bPLOT:    plot or not
%           1 -> plot
%           0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% myr:       slope of rotated line
% xcptr:    x-intercept
% ycptr:    y-intercept
% fncYMXBr: virtual function... y as a function of x
% strYMXBr: string  function... y as a function of x
% fncXMYBr: virtual function... x as a function of y
% strXMYBr: string  function... x as a function of y

% INPUT HANDLING
if ~exist('xC','var')    || isempty(xC)       xC = 0; end
if ~exist('yC','var')    || isempty(yC)       yC = 0; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% INPUT CHECKING 
% IF X-INTERCEPT DOESN'T EXIST, SET IT WITH Y-INTERCEPT
if ~exist('xcpt','var') || isempty(xcpt)
    if (~isnan(ycpt) && ~isinf(ycpt)) xcpt = -ycpt./my; 
    else error(['linerotate: WARNING! xcpt OR ycpt must exist and be real-valued']);
    end
end
if ~exist('ycpt','var') || isempty(ycpt)
    if (~isnan(xcpt) && ~isinf(xcpt)) ycpt = -xcpt.*my; 
    else error(['linerotate: WARNING! xcpt OR ycpt must exist and be real-valued']);
    end
end
% FORCE X-CPT AND Y-CPT TO BE CONSISTENT
if     (~isnan(ycpt) && ~isinf(ycpt)) xcpt = -ycpt./my; 
elseif (~isnan(xcpt) && ~isinf(ycpt)) ycpt = -xcpt.*my;  
else  error(['linerotate: WARNING! xcpt OR ycpt cannot both be NaN or Inf']);
end

% ROTATION MATRIX
R = rotMatrix(2,rotDeg);

% SLOPE OF ROTATED LINE
myr = tand(atand(my)+rotDeg);

% Y-INTERCEPT OF ROTATED LINE
ycptr = ( yC - xC.*sind(rotDeg) + (ycpt-yC).*cosd(rotDeg) ) - (   myr).*( xC - xC.*cosd(rotDeg) - (ycpt-yC).*sind(rotDeg) );

% X-INTERCEPT OF ROTATED LINE
xcptr = ( xC + yC.*sind(rotDeg) + (xcpt-xC).*cosd(rotDeg) ) - (1./myr).*( yC - yC.*sind(rotDeg) + (xcpt-xC).*sind(rotDeg) );

% ROTATED LINE: Y IS FUNCTION OF X-VALUE
fncYMXBr = @(x) myr.*x + ycptr;

% ROTATED LINE: X IS FUNCTION OF Y-VALUE
fncXMYBr = @(y) (1./myr).*y + xcptr;

% STRING Y IS FUNCTION OF X-VALUE
strYMXBr = ['y=' num2str(myr,'%.2f') 'x+' num2str(ycptr,'%.2f')]; 

% STRING X IS FUNCTION OF Y-VALUE
strXMYBr = ['x=' num2str(1./myr,'%.2f') 'y+' num2str(xcptr,'%.2f')]; 

if bPLOT == 1
    figure; hold on;
    x = linspace(-5,5,101);
    y = linspace(-5,5,101);
    if ~isnan(ycpt)  && ~isinf(ycpt)  plot(x, (   my).*x + ycpt, 'k--' ,'linewidth',2); 
    else                              plot((1./my).*y + xcpt, y, 'k--' ,'linewidth',2); 
    end
    if ~isnan(ycptr) && ~isinf(ycptr) plot(x, fncYMXBr(x), 'k-','linewidth',2); 
    else                              plot(fncXMYBr(y), y, 'k-','linewidth',2); 
    end
    axis([-5 5 -5 5]);
    % PLOT AXES
    plot(xlim,[0 0],'k',[0 0],ylim,'k');
    % PLOT CENTER OF ROTATION
    plot(xC,yC,'ko','markerface','w','markersize',10);
    axis square;
    if ~isnan(ycptr)  && ~isinf(ycptr)
    formatFigure('X','Y',['\theta_{rot}=' num2str(rotDeg,'%.1f') ': ' strYMXBr '; center=(' num2str(xC) ',' num2str(yC) ')']);
    else
	formatFigure('X','Y',['\theta_{rot}=' num2str(rotDeg,'%.1f') ': ' strXMYBr '; center=(' num2str(xC) ',' num2str(yC) ')']);
    end
        
end
