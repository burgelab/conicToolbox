function [A,B,C,D,E,F] = coniccov2params(MU1,COV1,MU2,COV2,bPLOT)

% function [A,B,C,D,E,F] = coniccov2params(MU1,COV1,MU2,COV2,bPLOT)
%
% NOTE! this function operates identical to cov2conicparams.m 
%
%   example call: % ORTHGONAL EQUAL VARIANCE ELLIPSES
%                   [A,B,C,D,E,F]=coniccov2params([0 0],[4 0; 0 1]./16,[0 0],[1 0; 0 4]./16,1);
%
%                 % ARBITRARY ANGLE BETWEEN RESPONSE DISTRIBUTIONS
%                   [A,B,C,D,E,F]=coniccov2params([0 0],[4 0; 0 1]./16,[0 0],[1 .5; .5 2]./16,1);
%
% convert ratio of 2D gaussians to parameters of conic with general form
%
%                LLR = ln(             L2 / L1             )
%                LLR = ln( gauss(MU2,COV2)/gauss(MU1,COV1) )
%                                        TO
%                       Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%  
% NOTE! IF det(COV2)>det(COV1) -> LLR>0 REGION WILL SUBTEND REGION > 90º
%       IF det(COV2)=det(COV1) -> LLR>0 REGION WILL SUBTEND REGION = 90º
%       IF det(COV2)<det(COV1) -> LLR>0 REGION WILL SUBTEND REGION < 90º
%
%        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        %   THE PRECEDING NOTE IS NOT GENERALLY TRUE!!!   %
%        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        % ALSO DEPENDS ON RELATIVE ANGLE BEWTEEN ELLIPSES %
%        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% e.g.: for t = (15/2):(15/2):(180-(15/2)), R = rotMatrix(2,t); coniccov2params([0 0],[6 0; 0 1],[0 0],R*[2 0; 0 1]*R',1); end
% 
% MU1:  mean vector       of 1st gaussian       [ 1 x 2 ]
% COV1: covariance matrix of 1st gaussian       [ 2 x 2 ]
% MU2:  mean vector       of 2nd gaussian       [ 1 x 2 ]  
% COV2: covariance matrix of 2nd gaussian       [ 2 x 2 ]   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A:    coefficient on x^2 term
% B:    coefficient on xy  term
% C:    coefficient on y^2 term
% D:    coefficient on  x  term
% E:    coefficient on  y  term
% F:    constant
%
%             *** see conicgeneral2standard.m ***
%             *** see    conicasymptotes.m    ***
%     *** see  conic*.m for other related functions   ***
%     

if ~exist('MU1'  ,'var') || isempty( MU1 ) MU1   =      [0 0]; end
if ~exist('MU2'  ,'var') || isempty( MU2 ) MU2   =      [0 0]; end
if ~exist('COV1' ,'var') || isempty( COV1) COV1  = [0 0; 0 0]; end
if ~exist('COV2' ,'var') || isempty( COV2) COV2  = [0 0; 0 0]; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT =         0 ; end

if numel(MU1) == 1, MU1 = MU1*ones(1,2); end
if numel(MU2) == 1, MU2 = MU2*ones(1,2); end
if size(COV1,1) ~= 2 || size(COV1,2) ~= 2 || size(COV2,1) ~= 2 || size(COV2,2) ~= 2
   error(['coniccov2params: WARNING! covariance matrices must both be [ 2 x 2 ]']); 
end

% INVERSE COVARIANCE MATRICES
Cinv1 = pinv(COV1);
Cinv2 = pinv(COV2); 

% DETERMININANTS OF COVARIANCE MATRICES
D1 = det(COV1);
D2 = det(COV2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GENERAL CONIC PARAMETERS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % COEFFICIENT ON x^2 TERM
A     = 0.5.*(Cinv1(1,1) - Cinv2(1,1));   
% COEFFICIENT ON xy  TERM
B     =      (Cinv1(1,2) - Cinv2(1,2));   
% COEFFICIENT ON y^2 TERM
C     = 0.5.*(Cinv1(2,2) - Cinv2(2,2));   
% COEFFICIENT ON  x  TERM
D     = MU2(1).*Cinv2(1,1) + MU2(2).*Cinv2(2,1) - MU1(1).*Cinv1(1,1) - MU1(2).*Cinv1(2,1);
% COEFFICIENT ON  y  TERM
E     = MU2(1).*Cinv2(1,2) + MU2(2).*Cinv2(2,2) - MU1(1).*Cinv1(1,2) - MU1(2).*Cinv1(2,2);
% CONSTANT
% F = 0.5.*(logdet(COV1) - logdet(COV2) + MU1*Cinv1*MU1' - MU2*Cinv2*MU2');  
F = -1;

% ASYMPTOTE INTERSECTION LOCATION
[x0,y0] = coniccenter(A,B,C,D,E,F);

if bPLOT == 1
    %%
    SDmax  = sqrt(max([diag(COV1); diag(COV2)]));
    xpos   = linspace(-3.*SDmax,3.*SDmax,101);
    [X,Y]  = meshgrid(xpos);
    
    % LIKELIHOODS
    try L1 = reshape(mvnpdf([X(:) Y(:)],MU1,COV1),size(X)); catch L1 = 1; end
    try L2 = reshape(mvnpdf([X(:) Y(:)],MU2,COV2),size(X)); catch L2 = 1; end
    
    % LOG-LIKELIHOOD RATIO
    LLR = log(L2./L1);
    
    % ASYMPTOTES 
    [my,ycpt,mx,xcpt,ayFnc,ayStr,axFnc,axStr]=conicasymptotes(A,B,C,D,E,F); 
    
    % LOG-LIKELHOOD RATIO EQUALS 1.0
    try
    K = 0.5.*(logdet(COV1) - logdet(COV2) + MU1*Cinv1*MU1' - MU2*Cinv2*MU2');  
    % LOG-LIKELIHOOD RATIO EQUALS 1.0 CONTOUR
    if K ~= 0                           % THIS CALL DOESN'T WORK IF K = 0
        [x,y] = conicplot(A,B,C,D,E,K); % B/C conicgeneral2standard BREAKS
    else
       x = linspace(-10,10,101)'; 
       y = ayFnc(x);  
    end
    catch
        x = []; y = [];
    end
    % CONIC ORIENTATION
    ortDeg= conicorientation(A,B,C,D,E,F);
    
    % PLOT LLR CONTOURS AND GAUSSIANS
    figure('position',[295   394   849   405]); 
    subplot(1,2,1); hold on;
    % PLOT LLR     CONTOURS
    contour(xpos,xpos,LLR,35); 
    % PLOT LLR=0.0 CONTOURS
    if sum(isnan(x)) == numel(x) && sum(isnan(y)) == numel(x)
        plot(xlim,ayFnc(xlim),'k','linewidth',3) 
    else
        plot(x,y,'k','linewidth',3);
    end
    % PLOT GAUSSIANS
    CIsz= 95;
    h(1)=plotEllipse(MU1,COV1,CIsz,[1 2],2,'b');
    h(2)=plotEllipse(MU2,COV2,CIsz,[1 2],2,'r');
    axis(repmat(minmax(xpos),[1 2])); axis square; 
    colormap(cmapBWR); 
    formatFigure([],[],['A=' num2str(A,'%.2f') ', B=' num2str(B,'%.2f') ',C=' num2str(C,'%.2f') '; \theta=' num2str(ortDeg,'%.1f')]);
    legend(h,'G1','G2','Location','NorthWest')
    % PLOT ASYMPTOTES
    plot(xlim,ayFnc(xlim),'k--')
    
    % PLOT LLR IMAGE
    subplot(1,2,2);
    imagesc(xpos,xpos,LLR); hold on
    % surf(xpos,xpos,LLR); %,'edgecolor','none'); 
    % PLOT LLR=1.0 CONTOURS
    if sum(isnan(x)) == numel(x) && sum(isnan(y)) == numel(x)
        plot(xlim,ayFnc(xlim),'k','linewidth',3) 
    else
        plot(x,y,'k','linewidth',3);
    end
    axis square; axis xy;
    colormap(cmapBWR(256)); h=colorbar;
    set(h,'position',[0.9203    0.1702    0.0253    0.6911]);
    % INEQUALITY SYMBOL
    if     D2>D1 gtORlt = '>'; 
    elseif D2<D1 gtORlt = '<'; 
    else         gtORlt = '='; 
    end
    formatFigure([],[],['LLR: ( |COV2|=' num2str(D2,'%.2f') ' ) ' gtORlt ' ( |COV1|=' num2str(det(D1),'%.2f') ' )' ]);
    set(gca,'xtick',get(gca,'ytick'))
    % PLOT ASYMPTOTES
    plot(xlim,ayFnc(xlim),'k--')
end