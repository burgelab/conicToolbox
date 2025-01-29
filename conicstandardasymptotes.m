function [amy,aycpt,amx,axcpt,ayFnc,ayStr,axFnc,axStr] =  conicstandardasymptotes(a,b,x0,y0)

% function [amy,aycpt,axcpt,ayFnc,ayStr,axFnc,axStr] = conicstandardasymptotes(a,b,x0,y0)
%
%   example call: % HORIZONTAL HYPERBOLA
%                   conicstandardasymptotes(1/sqrt(3),1j,0,0)
%
% conic asymptotes from standard equation
%
%      GENERAL  FORM:  Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
%      STANDARD FORM: ( (x-x0)/a )^2 + ( (y-y0)/b )^2  = 1
%      ASYMPOTES:     y = (-,+)*abs(b/a).*(x-x0) + y0;
%                     x = (-,+)*abs(a/b).*(y-y0) + x0;
%
% a:      half length of conic in standard form along x-axis
%         imaginary ->  vertical  hyperbola
%         NaN       -> horizontal parabola
% b:      half length of conic in standard form along y-axis
%         imaginary -> horizontal hyperbola
%         NaN       ->  vertical  parabola
% x0:     x-center in standard form OR 
%         x-vertex if conic is a parabola
% y0:     y-center in standard form OR
%         y-vertex if conic is a parabola
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% amy:     asymptote slope -> rise over run...                    [ 1 x 2 ]
% aycpt:   y-intercepts of asymptote                              [ 1 x 2 ] 
% amx:     asymptote slope -> run over rise... amx   = 1./amy     [ 1 x 2 ]
% axcpt:   x-intercepts of asymptotes ->       axcpt = -aycpt/amy [ 1 x 2 ]
% ayFnc:   asymptote 1 & 2 function of form... y = amy*x + aycpt  
% ayStr:   asymptote cell of strings {1,2}
% axFnc:   asymptote 1 & 2 function of form... x = amx*y + axcpt;  
% axStr:   asymptote cell of strings {1,2}

if ~isnan(a) && ~isnan(b)
    % SLOPE OF HYPERBOLA / ELLIPSE ASYMPTOTES 
    amy    = [-1 1].*abs(b)/abs(a);
    amx    = 1./amy;
    % X-INTECEPTS & Y-INTERCEPTS
    axcpt = -amx.*y0 + x0; axcpt(isnan(axcpt)) = x0;
    aycpt = -amy.*x0 + y0; aycpt(isnan(aycpt)) = y0;
elseif isnan(a) || isnan(b) 
    % PARABOLA
    amy = [NaN NaN];
    amx = [NaN NaN];
    axcpt = [0 0];
    aycpt = [0 0];
end

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

% % ASYMPTOTE FUNCTIONS
% if sum(isinf(aycpt)) == 0 && sum(isnan(aycpt)) == 0
%     % FUNCTIONS: EASY TO READ
%     % aFnc1 = @(x) amy(1).*x + aycpt(1); aFnc2 = @(x) amy(2).*x + aycpt(2);
%     % FUNCTIONS: HARD TO READ
%     ayFnc = @(x) bsxfun(@plus,bsxfun(@times,amy,x(:)),aycpt);
%     % FUNCTION STRINGS
%     ayStr{1} = ['Y=' num2str(amy(1),'%.3f') 'X+' num2str(aycpt(1),'%.3f')];
%     ayStr{2} = ['Y=' num2str(amy(2),'%.3f') 'X+' num2str(aycpt(2),'%.3f')];
% elseif sum(isinf(axcpt)) == 0 && sum(isnan(axcpt)) == 0
%     % FUNCTIONS: EASY TO READ
%     % aFnc1 = @(y) (1/amy(1)).*y + axcpt(1); aFnc2 = @(y) (1/amy(2)).*y + axcpt(2);
%     % FUNCTIONS: HARD TO READ
%     aFnc = @(y) bsxfun(@plus,bsxfun(@times,1/amy,y(:)),axcpt);
%     % FUNCTION STRINGS
%     aStr{1} = ['X=' num2str(1/amy(1),'%.3f') 'Y+' num2str(axcpt(1),'%.3f')];
%     aStr{2} = ['X=' num2str(1/amy(2),'%.3f') 'Y+' num2str(axcpt(2),'%.3f')];
% end

