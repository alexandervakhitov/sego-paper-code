function plot_theory
load('theory1.mat');
marker= { '^', 'v', 'square', 'o', 'x', 'x', 'none', '+','none', '<','v','v','^'};
color= {'r','r','b','m','m','b','k','k','k','g','b','b','g'};
markerfacecolor=  color;%{'r','g','n','m','n','n','r','r','g'};
linestyle= {'-','--',':','-','-','-',':','-','-',':','-','-','-'};  
names = {'SEGO 85%', 'SEGO 100%','IJCV12 100%'};
for i = 1:3
    method_list(i).name= names{i};    
    method_list(i).marker = marker{i};
    method_list(i).color= color{i};
    method_list(i).markerfacecolor= markerfacecolor{i};
    method_list(i).linestyle= linestyle{i};
    method_list(i).X = X(i,:);
end


close all;
h = sp_position();
set(gcf,'Units','normal');
set(gcf, 'PaperPositionMode', 'auto');

% subplot(1,5,1);
sp_format(1);
XLabel = 'Wrong Match Prob.';
Xarg = wmps;
ws = ones(length(method_list), 1);
yrange = [0 500];
[mnames, p] = util.xdraw_main(Xarg,yrange,method_list,'X','RANSAC Iterations',XLabel,'No. of Iterations', ws);
util.correct_margin();

% subplot(1,5,2);
% sp_format(2);
% yrange = [0 60];
% ws = ones(length(method_list), 1);
% util.xdraw_main(Xarg,yrange,method_list,'mean_r','Median Translation',...
%     XLabel,'Translation Error (percent)',ws);
% util.correct_margin();
% 
% 

% subplot(1, 5, 5);
% sp_format(5);
% ws = ones(length(method_list), 1);
% yrange = [0 10];
% xdraw_main(Xarg,yrange,method_list,'mean_reproj_pts_lines','Mean Reprojection',...
%     XLabel,'Reprojection Error (pixels)',ws);
% correct_margin();

% hL = legend(mnames, 'Orientation','horizontal', 'Position', [0.2 0.9 0.6 0.1]);
hL = legend(mnames, 'Orientation','vertical', 'Position', [0.38 0.6 0.1 0.2]);

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'figs/theory.pdf','-dpdf','-r0')
end
function h = sp_position
    h = figure('position', [100 100 250 250]);
end
function sp_format(i)
    subplot('Position', [0.2+0.40*(i-1) 0.0 0.7 0.7]);
end