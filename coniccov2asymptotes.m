function [my,ycpt,mx,xcpt,ayFnc,ayStr,axFnc,axStr] = coniccov2asymptotes(MU1,COV1,MU2,COV2)

% function [my,ycpt,mx,xcpt,ayFnc,ayStr,axFnc,axStr] = coniccov2asymptotes(MU1,COV1,MU2,COV2);
%
% %   example call: [my,ycpt,mx,xcpt,ayFnc,ayStr,axFnc,axStr] = coniccov2asymptotes([0 0],[4 0; 0 1],[0 0],[1 0; 0 4])
%
% convert two covariance matrices into the asymptotes of hyperbola
% that represent the iso-value contours associated with their ratio
%
% MU1:    mean vector       of 1st gaussian                     [ 1 x 2 ]
% COV1:   covariance matrix of 1st gaussian                     [ 2 x 2 ]
% MU2:    mean vector       of 2nd gaussian                     [ 1 x 2 ]  
% COV2:   covariance matrix of 2nd gaussian                     [ 2 x 2 ]  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% my:     asymptote slope -> rise over run...                   [ 1 x 2 ]
% ycpt:   y-intercepts of asymptote                             [ 1 x 2 ] 
% mx:     asymptote slope -> run over rise... mx   = 1./my      [ 1 x 2 ]
% xcpt:   x-intercepts of asymptotes ->       xcpt = -ycpt/my   [ 1 x 2 ]
% ayFnc:  asymptote 1 & 2 function of form... y = my*x + ycpt  
% ayStr:  asymptote cell of strings {1,2}
% axFnc:  asymptote 1 & 2 function of form... x = mx*y + xcpt;  
% axStr:  asymptote cell of strings {1,2}


% CONIC PARAMETERS FROM COVARIANCE
[A,B,C,D,E,F]=cov2conicparams(MU1,COV1,MU2,COV2);
    
% ASYMPTOTES FROM CONIC PARAMETERS
% [ma,xcpta,ycpta,aFnc,aStr] = conicasymptotesOLD(A,B,C,D,E,F);
[my,ycpt,mx,xcpt,ayFnc,ayStr,axFnc,axStr] = conicasymptotes(A,B,C,D,E,F);

disp(['cov2conicaymptotes.m: WARNING! untested code!!!']);