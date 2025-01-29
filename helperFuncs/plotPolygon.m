function plotPolygon(x,y,linstyle,colors,linwidth,fighandle)

% function plotPolygon(x,y,linstyle,colors,linwidth,fighandle)
%
%   example call: plotPolygon([-.5 .5],[-.5 .5],'-','y',2)
%     
% plot closed polygon from set of vertices
%  
% x:          x vertices
% y:          y vertices
% linstyle:   color and style and marker type of line
% linewidth:  width of line
% fighandle:  figure handle (default: gcf)

if ~exist('linwidth','var') || isempty(linwidth)
    linwidth = 1;
end
if exist('fighandle','var') & ~isempty(fighandle)
   figure(fighandle);
end
if length(x) == 2 && length(y) == 2
    x = [x(1) x x(2)]';
    y = [y fliplr(y)]';
end

x = [x; x(1,:)];
y = [y; y(1,:)];

plot(x,y,linstyle,'linewidth',linwidth,'color',colors);