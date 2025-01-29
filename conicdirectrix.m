function [md,xcptd,ycptd,dFnc,dStr] = conicdirectrix(A,B,C,D,E,F,bPLOT)

% function [md,xcptd,ycptd,dFnc,dStr] = conicdirectrix(A,B,C,D,E,F,bPLOT)
%
%   example call: [md,xcptd,ycptd,dFnc,dStr] = conicdirectrix(3,0,-1,0,0,-1,1); 
% 
% directrix of conic from parameters in general form. conic sections are 
% loci of points w. distances to point(s) called the focus (or foci) that 
% are a multiple (eccentricity) of distance to a line called the directrix
%
% ONLINE VERIFICATION THAT CONIC PARAMETERS ARE CALCULATED ACCURATELY:
% https://www.emathhelp.net/calculators/algebra-2/hyperbola-calculator/
%
% A:      coefficient on x-squared terms 
% B:      coefficient on xy  cross terms 
% C:      coefficient on y-squared terms 
% D:      coefficient on x terms
% E:      coefficient on y terms
% F:      constant
% bPLOT:  plot or not
%         1 -> plot
%         0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% md:     slope of directrix
% xcptd:  x-intercepts of directrix   [ 1 x 2 ]
%         if undefined -> [NaN NaN]
% ycptd:  y-intercepts of directrix   [ 1 x 2 ] 
%         if undefined -> [NaN NaN]
% dFnc:   directrix 1 & 2 function
%         IF m ~= Inf THEN dFnc: y = mx + ycpt 
%         IF m == Inf THEN dFnc; x = (1/m) - b/m
% dStr:   directrix cell of strings {1,2}

% INPUT HANDLING
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% CONIC TYPE
cncType = conictype(A,B,C,D,E,F);

% CONIC ORIENTATION
ortDeg = conicorientation(A,B,C,D,E,F);

% ROTATION ANGLE TO ALIGN WITH CARDINAL AXES
rotDeg = -ortDeg;

% ROTATED CONIC PARAMETERS
[Ap,Bp,Cp,Dp,Ep,Fp] = conicrotate(A,B,C,D,E,F,rotDeg);

% ROTATED CONIC ECCENTRICITY
ep = coniceccentricity(Ap,Bp,Cp,Dp,Ep,Fp);

% ROTATED CONIC LINEAR ECCENTRICITY
cp = coniclineareccentricity(Ap,Bp,Cp,Dp,Ep,Fp);

% CONIC PARAMETERS IN STANDARD FORM
[a,b,x0,y0] = conicgeneral2standard(Ap,Bp,Cp,Dp,Ep,Fp);

if strcmp(cncType,'ellipse')
    % CIRCLE
    if a == b      
    mp    = [NaN NaN];
    xcptp = [NaN NaN];
    ycptp = [NaN NaN];
    % HORIZONTAL ELLIPSE
    elseif a > b    
    mp    = [Inf Inf];
    xcptp = x0 + [-1 1].*[a./cp];      %  VERTICAL  DIRECTRIX
    ycptp = [NaN NaN];
    %  VERTICAL  ELLIPSE
	elseif a < b   
    mp    = [0 0];
    xcptp = [NaN NaN];
    ycptp = y0 + [-1 1].*[b./cp];     % HORIZONTAL DIRECTRIX
    end
elseif strcmp(cncType,'parabola')
    %  VERTICAL  PARABOLA
    if Cp == 0
    mp    = [0 0];
    xcptp = [NaN NaN];
    ycptp = (y0 - (a.^2)./4)*[1 1];  % HORIZONTAL DIRECTRIX
    % HORIZONTAL PARABOLA
    elseif Ap == 0
    mp    = [Inf Inf];    
    xcptp = (x0 - (b.^2)./4)*[1 1]; %  VERTICAL  DIRECTRIX
    ycptp = [NaN NaN];
    end
elseif strcmp(cncType,'hyperbola')
    % HORIZONTAL HYPERBOLA
    if     sign(b^2) < 0        
    mp    = [Inf Inf];
    xcptp = x0 + [-1 1].*(a./ep); %  VERTICAL  DIRECTRIX
    ycptp = [NaN NaN];
    %  VERTICAL  HYPERBOLA
	elseif sign(a^2) < 0  
    mp    = [0 0];
    xcptp = [NaN NaN];
    ycptp = y0 + [-1 1].*(b./ep); % HORIZONTAL DIRECTRIX 
    end 
end

% ORIENTATION OF ORIGINAL CONIC
md = tand( atand(mp) + ortDeg ).*[1 1];

%%%%%%%%%%%%%%%%%%%%
% ROTATE DIRECTRIX %
%%%%%%%%%%%%%%%%%%%%
for i = 1:length(ycptp)
   [md(i),xcptd(i),ycptd(i)] = linerotate(mp(i),xcptp(i),ycptp(i),0,0,ortDeg);
end
if x0 ~= 0 || y0 ~=0 
    warning(['conicdirectrix: WARNING! not fully tested for D~=0 and/or E~=0']);
end
   
% DIRECTRIX FUNCTIONS
if sum(isinf(ycptd)) == 0 && sum(isnan(ycptd)) == 0
    % FUNCTIONS: EASY TO READ
    % dFnc1 = @(x)     md(1).*x + ycptd(1); dFnc2 = @(x)     md(2).*x + ycptd(2);
    % FUNCTIONS: HARD TO READ
    dFnc = @(x) bsxfun(@plus,bsxfun(@times,md,x(:)),ycptd);
    % FUNCTION STRINGS
    dStr{1} = ['Y=' num2str(md(1),'%.3f') 'X+' num2str(ycptd(1),'%.3f')];
    dStr{2} = ['Y=' num2str(md(2),'%.3f') 'X+' num2str(ycptd(2),'%.3f')];
elseif sum(isinf(xcptd)) == 0 && sum(isnan(xcptd)) == 0
    % FUNCTIONS: EASY TO READ, ANNOYING TO PROGRAM
    % dFnc1 = @(y) (1/md(1)).*y + xcptd(1); dFnc2 = @(y) (1/md(2)).*y + xcptd(2);
    % FUNCTIONS: HARD TO READ
    dFnc = @(y) bsxfun(@plus,bsxfun(@times,1./md,y(:)),xcptd);
    % FUNCTION STRINGS
    dStr{1} = ['X=' num2str(1/md(1),'%.3f') 'Y+' num2str(xcptd(1),'%.3f')];
    dStr{2} = ['X=' num2str(1/md(2),'%.3f') 'Y+' num2str(xcptd(2),'%.3f')];
end

if bPLOT
   conicplot(A,B,C,D,E,F,bPLOT) ; 
   ax=4.*axis; 
   if strcmp(dStr{1}(1),'Y') plot(ax(1:2),dFnc(ax(1:2)),'k'); end
   if strcmp(dStr{1}(1),'X') plot(dFnc(ax(3:4)),ax(3:4),'k'); end   
end
