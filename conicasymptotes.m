function [amy,aycpt,amx,axcpt,ayFnc,ayStr,axFnc,axStr] = conicasymptotes(A,B,C,D,E,F,bPLOT)

% function [amy,aycpt,amx,axcpt,ayFnc,ayStr,axFnc,axStr] = conicasymptotes(A,B,C,D,E,F,bPLOT)
%   
%   example call: % RECTANGULAR HORIZONTAL HYPERBOLA
%                   [amy,aycpt,amx,axcpt,ayFnc,ayStr,axFnc,axStr] = conicasymptotes(3,0,-1,1,0,-1,1)
%
%                 % RECTANGULAR ORIENTED HYPERBOLA
%                   [amy,aycpt,amx,axcpt,ayFnc,ayStr,axFnc,axStr] = conicasymptotes(0,1,0,0,0,-1,1)
%
%                 % RECTANGULAR ORIENTED ELLIPSE
%                   [amy,aycpt,amx,axcpt,ayFnc,ayStr,axFnc,axStr] = conicasymptotes(3,0,1,0,0,-1,1)
%
% compute asymptote slopes and orientations from conic parameters
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
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% amy:     asymptote slope -> rise over run...                    [ 1 x 2 ]
% aycpt:   y-intercepts of asymptote                              [ 1 x 2 ] 
% amx:     asymptote slope -> run over rise... amx   = 1./amy     [ 1 x 2 ]
% axcpt:   x-intercepts of asymptotes ->       axcpt = -aycpt/amy [ 1 x 2 ]
% ayFnc:   asymptote 1 & 2 function of form... y = amy*x + aycpt  
% ayStr:   asymptote cell of strings {1,2}
% axFnc:   asymptote 1 & 2 function of form... x = amx*y + axcpt;  
% axStr:   asymptote cell of strings {1,2}

if ~exist('D','var')     || isempty(D)     D     =  0; end
if ~exist('E','var')     || isempty(E)     E     =  0; end
if ~exist('F','var')     || isempty(F)     F     = -1; disp(['conicasymptotes: WARNING! parameter F defaulting to ' num2str(F) '. Is this REALLY what you want?!?'],1); end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT =  0; end
% CONIC TYPE
cncType = conictype(A,B,C,D,E,F);

% CONIC CENTER
[x0,y0] = coniccenter(A,B,C,D,E,F);

if strcmp(cncType,'hyperbola') || strcmp(cncType,'ellipse') 
    if strcmp(cncType,'hyperbola')
        % SLOPE OF HYPERBOLA ASYMPTOTES 
        amy = ( -B + [1 -1].*sqrt(B.^2 - 4.*A.*C) )./(2.*C);
        amx = 1./amy;
    elseif strcmp(cncType,'ellipse')
        % SLOPE OF ELLIPSE ASYMPTOTES 
        if B == 0
        amy = ( -B + [1 -1].*sqrt(B.^2 + 4.*A.*C) )./(-2.*C);
        amx = 1./amy;
        else
        amy = [NaN NaN];
        amx = [NaN NaN];
        end
    end
    % HANDLE SPECIAL CASE WHEN C == 0
    amy(isnan(amy) & C==0) = -A/B;
    % HANDLE SPECIAL CASE WHEN A == 0
    amy(isnan(amy) & A==0) = -C/B;
    amx = 1./amy;
    % X-INTECEPTS & Y-INTERCEPTS
    axcpt = -amx.*y0 + x0; axcpt(isnan(axcpt)) = x0;
    aycpt = -amy.*x0 + y0; aycpt(isnan(aycpt)) = y0;
    killer = 1;
elseif strcmp(cncType,'parabola')
    % PARABOLA
    amy = [NaN NaN];
    amx = [NaN NaN];
    axcpt = [0 0];
    aycpt = [0 0];
end
   
% ORIENTATION OF CONIC ASYMPTOTES
oaDeg = atand(amy); % [ 1 x 2 ]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ASYMPTOTE FUNCTIONS & STRINGS IN STANDARD FORM: y = amy*x + aycpt %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTIONS: EASY TO READ, LESS CONVENIENT TO USE
% ayFnc1 = @(x) amy(1).*x + aycpt(1); 
% ayFnc2 = @(x) amy(2).*x + aycpt(2);
% FUNCTIONS: HARD TO READ, MORE CONVENIENT TO USE
ayFnc = @(x) bsxfun(@plus,bsxfun(@times,amy,x(:)),aycpt);
% FUNCTION STRINGS
ayStr{1} = ['Y=' num2str(amy(1),'%.3f') 'X+' num2str(aycpt(1),'%.3f')];
ayStr{2} = ['Y=' num2str(amy(2),'%.3f') 'X+' num2str(aycpt(2),'%.3f')];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ASYMPTOTE FUNCTIONS & STRINGS IN STANDARD FORM: x = amx*y + axcpt %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTIONS: EASY TO READ, LESS CONVENIENT TO USE
% axFnc1 = @(y) amx(1).*y + axcpt(1); 
% axFnc2 = @(y) amx(2).*y + axcpt(2);
% FUNCTIONS: HARD TO READ, MORE CONVENIENT TO USE
axFnc = @(y) bsxfun(@plus,bsxfun(@times,amx,y(:)),axcpt);
% FUNCTION STRINGS
axStr{1} = ['X=' num2str(amx(1),'%.3f') 'Y+' num2str(axcpt(1),'%.3f')];
axStr{2} = ['X=' num2str(amx(2),'%.3f') 'Y+' num2str(axcpt(2),'%.3f')];

% CONIC TYPE
cnctype = conictype(A,B,C,D,E,F);
if ~strcmp(cnctype,'hyperbola')
   disp(['conicasymptotes: WARNING! asymptotes do not actually exist b/c conicType=' cnctype]); 
end

if bPLOT == 1
   % PLOT CONIC & ASYMPTOTES
   conicplot(A,B,C,D,E,F,bPLOT);
  
end