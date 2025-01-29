function [x,y,tDeg,r]=conicplot(A,B,C,D,E,F,bPLOT)

% function [x,y,tDeg,r]=conicplot(A,B,C,D,E,F,bPLOT)               
%
%   example call: [A,B,C,D,E,F] = cov2conicparams([],[1 0; 0 4],[],[4 0; 0 1].*1,1)
%                 [x,y,tDeg,r]  = conicplot(A,B,C,D,E,F,1)
%
%                 % PLOT CONIC: HYPERBOLA
%                 [x,y,tDeg,r] = conicplot(0,1,0,0,0,-1,1);
%
%                 % PLOT CONIC: ELLIPSE
%                 [x,y,tDeg,r]=conicplot(2,0,1,0,0,-1,1);
%
% plot general conic section
%
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
% 
% ONLINE VERIFICATION THAT CONIC PARAMETERS ARE CALCULATED ACCURATELY:
% https://www.emathhelp.net/calculators/algebra-2/hyperbola-calculator/
%
% PLOT GENERAL CONIC: see http://www.math.fsu.edu/~bellenot/class/s10/cla/other/qform.pdf
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x:      x-positions  in cartesian coordinates
% y:      y-positions  in cartesian coordinates
% tDeg:   angle in deg in   polar   coorindates
% r:      radius       in   polar   coorindates


if ~exist('D', 'var')    || isempty(D)     D  =  0; end
if ~exist('E', 'var')    || isempty(E)     E  =  0; end
if ~exist('F', 'var')    || isempty(F)     F  = -1; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% CONIC TYPE
cncType = conictype(A,B,C,D,E,F); 
% CONIC ORIENTATION
ortDeg = conicorientation(A,B,C,D,E,F);
% CONIC CENTER
[x0,y0] = coniccenter(A,B,C,D,E,F);
% CONIC ASYMPTOTES
[amy] = conicasymptotes(A,B,C,D,E,F); 
% ASYMPTOTE ORIENTATIONS
aOrtDeg = atand(amy);
% STANDARD FORM
[a,b,x0p,y0p] = conicgeneral2standard(A,B,C,D,E,F);
% GENERAL CONIC PARAMETERS ALIGNED WITH CARDINAL AXES 
[Ap,Bp,Cp,Dp,Ep,Fp]=conicrotate(A,B,C,D,E,F,-ortDeg);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPUTE POLAR AND CARTESIAN COORDINATES %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% POLAR COORDINATES OF ROTATED CONIC SITTING AT ORIGIN
[tDeg,r] = conicplotpolar(Ap,Bp,Cp,Dp,Ep,Fp);
% CORRESPONDING CARTESIAN COORDINATES 
[xp,yp]  = pol2cartd(tDeg,r);
% ROTATION MATRIX
R        = rotMatrix(2,ortDeg);
% ROTATED TO ORIGINAL ORIENTATION AND TRANSLATED TO ORIGINAL POSITION
xy       = (R*[xp'+x0p; yp'+y0p])';
% SEPARATING X AND Y VARIABLES
x        = xy(:,1); y = xy(:,2);

%%%%%%%%%%%%%%
% PLOT STUFF %
%%%%%%%%%%%%%%
if bPLOT == 1
    % CONIC FOCI AND VERTICES
    [fxy1,fxy2] = conicfocus(A,B,C,D,E,F);
    [vxy1,vxy2] = conicvertex(A,B,C,D,E,F);
    % SET AXIS LIMITS
    axlims = 1.*[-1 1 -1 1];
    if 1.5.*max([sqrt(sum(fxy1.^2)) sqrt(sum(fxy2.^2))]) > max(axlims)
        disp(['conicplot: WARNING! min conic values greater than plot limits... expanding plot limits!']);
        axlims = 1.5.*max([sqrt(sum(fxy1.^2)) sqrt(sum(fxy2.^2))])*[-1 1 -1 1];
    end

    % OPEN FIGURE
    figure; set(gcf,'position',[296   5   749   791]);
    % figure; set(gcf,'position',[296   394   849   402]);
    
    % CARTESIAN COORDINATES %
    % subplot(1,2,1); hold on;
    plot(x,y,'k','linewidth',2); hold on;
    axis(axlims); axis square;
    % PLOT AYSMPTOTES
    if mod(min(aOrtDeg)+90,180) ~= 0 plot(xlim+x0,xlim.*tand(min(aOrtDeg))+y0,'k--');
    else                           plot([x0 x0],ylim,'k--');
    end
    if mod(max(aOrtDeg)+90,180) ~= 0 plot(xlim+x0,xlim.*tand(max(aOrtDeg))+y0,'k--');
    else                           plot([x0 x0],ylim,'k--');
    end
    % PLOT BOX (2*a,2*b)
    if ortDeg == 0
    plotSquare([x0 y0],[2.*abs(a) 2.*abs(b)],'k',0.5,'--');
    end
    % PLOT CENTER
    plot(x0,y0,'ks','markerface','w','markersize',8); 
    % PLOT VERTICES
    plot(vxy1(1),vxy1(2),'kd','markerface','w','markersize',8); plot(vxy2(1),vxy2(2),'kd','markerface','w','markersize',8);
    % PLOT FOCI
    plot(fxy1(1),fxy1(2),'ko','markerface','k','markersize',8); plot(fxy2(1),fxy2(2),'ko','markerface','k','markersize',8);
    % LABEL PLOT
    formatFigure([],[],{[cncType ': \theta=' num2str(ortDeg,'%.0f') '; amy=[' num2str(aOrtDeg(1)) 'º,' num2str(aOrtDeg(2)) 'º]'],['A=' num2str(A,'%.2f') ' B=' num2str(B,'%.2f') ' C=' num2str(C,'%.2f') ' D=' num2str(D,'%.2f') ' E=' num2str(E,'%.2f') ' F=' num2str(F,'%.4f') ],['a=' num2str(a,'%.3f') ' b=' num2str(b,'%.3f') ' x0=' num2str(x0,'%.2f') ' y0=' num2str(y0,'%.2f')] });
    % ENSURE XTICKS AND YTICKS ARE THE SAME
    xtck = get(gca,'xtick'); ytck = get(gca,'ytick'); 
    if     length(xtck)>length(ytck), set(gca,'ytick',xtck);
    elseif length(ytck)>length(xtck), set(gca,'xtick',ytck);
    end
    
    % POLAR COORDINATES %
%     subplot(1,2,2); 
%     polarplot((tDeg+ortDeg).*pi./180,r,'k','linewidth',2); hold on;
%     polarplot(    min(aOrtDeg).*[1 1].*pi./180,[ 0 1],'k--')
%     polarplot(    max(aOrtDeg).*[1 1].*pi./180,[ 0 1],'k--')
%     polarplot(    min(aOrtDeg).*[1 1].*pi./180,[-1 0],'k--')
%     polarplot(    max(aOrtDeg).*[1 1].*pi./180,[-1 0],'k--')
%     axis([0 360 0 axlims(2)]);    
%     
%     title([cncType ': \theta=' num2str(ortDeg,'%.0f') 'º; x0=' num2str(x0,'%.2f') '; y0=' num2str(y0,'%.2f') ],'fontsize',18,'fontweight','normal');
%     % formatFigure([],[],['A''=' num2str(A,'%.2f') ', B''=' num2str(B,'%.0f') ', C''=' num2str(C,'%.2f')]);
end