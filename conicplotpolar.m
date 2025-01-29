function [tDeg,r,x,y] = conicplotpolar(A,B,C,D,E,F,tDeg,bPLOT)

% function [tDeg,r,x,y] = conicplotpolar(A,B,C,D,E,F,tDeg,bPLOT)
%
%   example call: % ELLIPSE
%                   conicplotpolar(3,0,1,0,0,-1,[],1) 
%
%                 % PARABOLA
%                   conicplotpolar(3,0,0,0,1,-1,[],1) 
%
%                 % HYPERBOLA
%                   conicplotpolar(3,0,-1,0,0,0,[],1) 
%
% expession for conic in polar coordinates assuming center is at origin
%
% A:      coefficient on x-squared terms 
% B:      coefficient on xy  cross terms 
% C:      coefficient on y-squared terms 
% D:      coefficient on x terms
% E:      coefficient on y terms
% F:      constant
% tDeg:   polar angle of point(s) to plot  [ nPnt x 1 ]
%         [] -> plots the whole conic (default)
% bPLOT:  plot or not
%         1 -> plot
%         0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tDeg:   polar angle in deg
% r:      radius
% x:      x-position in cartesian coordinates
% y:      y-position in cartesian coordinates

% INPUT HANDLING
if ~exist('tDeg', 'var') || isempty(tDeg)  tDeg  = []; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT =  0; end

% ECCENTRICITY
e = coniceccentricity(A,B,C,D,E,F);

% CONIC TYPE
cncType = conictype(A,B,C,D,E,F);

% CONIC IN STANDARD FORM
[a,b,x0,y0,ortDeg] = conicgeneral2standard(A,B,C,D,E,F);

% CONIC ASYMPTOTES IN STANDARD FORM
% [amy,xcpta,ycpta,aFnc,aStr] = conicstandardasymptotesOLD(a,b,x0,y0);
[amy,aycpt,amx,axcpt,ayFnc,ayStr,axFnc,axStr] = conicstandardasymptotes(a,b,x0,y0);

% ORIENTATION OF ASYMPTOTES OF CONIC IN STANDARD FORM
oaDeg = atand(amy);

% ANGLE FOR POLAR PLOTS IN DEG AND RAD
if ~isempty(tDeg)
    % ADJUST ANGLES 
    tDeg = tDeg - ortDeg;
    tRad = tDeg.*pi./180;
else
    % SPACE SAMPLES BETWEEN ASYMPTOTES OF CONIC IN STANDARD (ROTATED) FORM
    tDeg = linspace(min(oaDeg),min(oaDeg)+720,5761)';
    tRad = tDeg.*pi./180;
end

% INDICES TO PLOT
if     strcmp(cncType, 'ellipse' ) 
    ind  = 1:numel(tDeg);
elseif strcmp(cncType,'hyperbola') 
    % HORIZONTAL HYPERBOLA
    if a^2 > 0 && b^2 < 0
    ind  = find( (tDeg > min(oaDeg) & tDeg < max(oaDeg)) | (tDeg > min(oaDeg)+180 & tDeg < max(oaDeg)+180));
    elseif a^2 < 0 && b^2 > 0
    ind  = find( (tDeg > max(oaDeg) & tDeg < min(oaDeg)+180) | (tDeg > max(oaDeg)+180 & tDeg < min(oaDeg)+360));    
    else
    error(['conicplot: WARNING! unhandled indexing for hyperbola with a^2=' num2str(a^2) ' and b^2=' num2str(b^2) ])
    end
elseif strcmp(cncType, 'parabola') 
    ind  = 1:numel(tDeg);
end

% POINTS ON CONIC
if strcmp(cncType,'ellipse')
    % RADIUS AS A FUNCTION OF ANGLE
    r = a.*b./sqrt( (a.*sind(tDeg)).^2 + (b.*cosd(tDeg)).^2 );
elseif strcmp(cncType,'parabola')
    % SEMI-LATUS RECTUM
    l = conicsemilatusrectum(A,B,C,D,E,F);
    if     isnan(b)  
    % VERTICAL PARABOLA
    r = 2.*l.*sind(tDeg)./(cosd(tDeg).^2);
    elseif isnan(a)  
    % HORIZONTAL PARABOLA
    r = 2.*l.*cosd(tDeg)./(sind(tDeg).^2);
    end
elseif strcmp(cncType,'hyperbola')
    % HORIZONTAL HYPERBOLA
    if sign(b.^2)<0 
        % RADIUS AS A FUNCTION OF ANGLE
        r = imag(b)./sqrt( (e.*cosd(tDeg)).^2 - 1 );  
	% VERTICAL HYPERBOLA
    elseif sign(a.^2)<0
        % RADIUS AS A FUNCTION OF ANGLE
        r = imag(a)./sqrt( (e.*sind(tDeg)).^2 - 1 ); 
    end
end
% SELECT VALID INDICES ONLY
r = r(ind);
tDeg = tDeg(ind);
tRad = tRad(ind);
% ROTATE BACK TO ORIGINAL ORIENTATION
tDeg = tDeg+ortDeg;

%%%%%%%%%%%%%%
% PLOT STUFF %
%%%%%%%%%%%%%%
if bPLOT == 1
   % SET AXIS LIMITS
    axlims = [0 360 0 1];
    if 2.*min(r)>max(axlims(end))
        disp(['conicplot: WARNING! min conic values greater than plot limits... expanding plot limits!']);
        axlims(end) = 2.*min(r);
    end 
	figure; 
    polarplot((tDeg).*pi./180,r,'k','linewidth',2)
    formatFigure([],[],cncType);
    axis(axlims);
end