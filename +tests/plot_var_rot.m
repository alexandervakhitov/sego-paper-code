function plot_var_rot
load('r_scale.mat');
marker= { '^', 'v', 'square', 'o', 'x', 'x', 'none', '+','none', '<','v','v','^'};
color= {'r','g','b','y','m','c','g','k','r','g','b','b','g'};
markerfacecolor=  color;%{'r','g','n','m','n','n','r','r','g'};
linestyle= {'-','-','-','-','-','-','--','-','--',':','-','-','-'};  

for i = 1:9
    method_list(i).name= num2str(i);    
    method_list(i).marker = marker{i};
    method_list(i).color= color{i};
    method_list(i).markerfacecolor= markerfacecolor{i};
    method_list(i).linestyle= linestyle{i};
end


close all;
h = sp_position();
set(gcf,'Units','normal');
set(gcf, 'PaperPositionMode', 'auto');

% subplot(1,5,1);
sp_format(1);
XLabel = 'Rotation angle, rad.';
Xarg = rlens;
ws = ones(length(method_list), 1);
yrange = [0 11];
[mnames, p] = util.xdraw_main(Xarg,yrange,method_list,'med_r','Median Rotation',XLabel,'Rotation Error (degrees)', ws);
util.correct_margin();

% subplot(1,5,2);
sp_format(2);
yrange = [0 40];
ws = ones(length(method_list), 1);
util.xdraw_main(Xarg,yrange,method_list,'mean_r','Median Translation',...
    XLabel,'Translation Error (percent)',ws);
util.correct_margin();



% subplot(1, 5, 5);
% sp_format(5);
% ws = ones(length(method_list), 1);
% yrange = [0 10];
% xdraw_main(Xarg,yrange,method_list,'mean_reproj_pts_lines','Mean Reprojection',...
%     XLabel,'Reprojection Error (pixels)',ws);
% correct_margin();

% hL = legend(mnames, 'Orientation','horizontal', 'Position', [0.2 0.9 0.6 0.1]);
hL = legend(mnames, 'Orientation','vertical', 'Position', [0.85 0.2 0.1 0.6]);

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'figs/rot.pdf','-dpdf','-r0')
end
function h = sp_position
    h = figure('position', [100 100 500 225]);
end
function sp_format(i)
    subplot('Position', [0.05+0.40*(i-1) 0.0 0.28 0.99]);
end