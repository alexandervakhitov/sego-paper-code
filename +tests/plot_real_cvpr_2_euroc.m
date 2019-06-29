function plot_real_cvpr_2_euroc(stats, pos, pos_gt, trnames)
    addpath('/home/alexander/materials/sego/sego_git/matlab/main/columnlegend');
    close all;
    h0 = figure('position', [100 100 600 250]);
    set(gcf,'Units','normal');
    lp = [0.1, 0.4, 0.7];
    lh = [0.14, 0.09, 0.09];
           
    ml = model.setup_methods_ransac;
    rbins = [0:0.05:0.5];    
    rbins = [rbins 100];
    
    tbins = [0:2.5:25];
    tbins = [tbins 200];
    ctbins = tbins(1:length(tbins)-1)+2.5/2;
    cbins = rbins(1:length(rbins)-1)+0.025;
    for mi = 1:length(ml)
        ml(mi).r  = stats(:, mi, 1);
        ml(mi).t  = stats(:, mi, 2);        
        
        ml(mi).r = histcounts(ml(mi).r, rbins)/length(ml(mi).r);
        ml(mi).t = histcounts(ml(mi).t, tbins)/length(ml(mi).t);
    end
    
    %gen stats    

    for mi = 1:length(ml)
%                 'marker',method_list(i).marker,...
%         'color',method_list(i).color,...
%         'markerfacecolor',method_list(i).markerfacecolor,...
%         'displayname',mname, ...
%         'LineStyle', method_list(i).linestyle, ...
        if (strcmp(ml(mi).id,'EpiSEgo'))
            ml(mi).marker = '.';
            ml(mi).color = 'r';
            ml(mi).markerfacecolor = 'r';
            ml(mi).name = ml(mi).id;
            ml(mi).linestyle = '-';
        end
        if (strcmp(ml(mi).id ,'PPSEgo'))
            ml(mi).marker = '.';
            ml(mi).color = 'r';
            ml(mi).markerfacecolor = 'r';
            ml(mi).name = ml(mi).id;
            ml(mi).linestyle = '--';
        end
        if (strcmp(ml(mi).id ,'GSEgo'))
            ml(mi).marker = '.';
            ml(mi).color = 'r';
            ml(mi).markerfacecolor = 'r';
            ml(mi).name = ml(mi).id;
            ml(mi).linestyle = '-.';
        end
        if (strcmp(ml(mi).id , 'AssF'))
            ml(mi).marker = '.';
            ml(mi).color = 'g';
            ml(mi).markerfacecolor = 'g';
            ml(mi).name = ml(mi).id;
            ml(mi).linestyle = '-';
        end        
        if (strcmp(ml(mi).id , 'Approx'))
            ml(mi).marker = '.';
            ml(mi).color = 'b';
            ml(mi).markerfacecolor = 'b';
            ml(mi).name = ml(mi).id;
            ml(mi).linestyle = '-';
        end          
        if (strcmp(ml(mi).id , 'P3P'))
            ml(mi).marker = '.';
            ml(mi).color = 'k';
            ml(mi).markerfacecolor = 'k';
            ml(mi).name = ml(mi).id;
            ml(mi).linestyle = '-';
        end   
    end
    
    XLabel = 'Frame id';
    Xarg = [1:5:5*(size(stats, 1)-1)+1];            
    
    for si = 1:1
        
        ms = ml;
        %for si = 1:
            
    %         subplot(2,SN,si);
            shift = si-1;
            subplot('Position', [0.1, 0.28,  0.23 0.6]);

            ws = ones(length(ms), 1);
            yrange = [0 0.5];                       
            
            if (si == 1)
                [mnames1, p] = util.xdraw_main(cbins,yrange,ms,'r','Rotation Error (deg)',XLabel,'', ws);            
            else
                [mnames1, p] = util.xdraw_main(cbins,yrange,ms,'r','',XLabel,'', ws);                        %Median Rotation
                set(gca,'YTickLabel','')            
            end
            set(gca,'FontSize',10);
    %         set(gca,'FontWeight','bold');
            if (si == 2)
    %             title('\fontsize{12} Rotation Error');
            end
            %lm = length(mnames1);
            %hL = legend(mnames1, 'Orientation','vertical', 'Position', [lp(si), lh(si), 0.23 0.1], 'box', 'on');        
            %hL = legend({mnames1{1:lm/2}}, 'Orientation','vertical', 'Position', [0.3*(si-1)+0.15, 0.20 0.05 0.05], 'box', 'off');        
            %hL = legend(p(1:lm/2), 'Orientation','vertical', 'Position', [0.3*(si-1)+0.15, 0.20 0.05 0.05], 'box', 'off');        
    %         correct_margin();



    %         hL = columnlegend(2, mnames1, 'Orientation','vertical', 'Position', [0.3*(si-1)+0.15, 0.4 0.1 0.1]);

    %         subplot(SN,3,si+3);
            subplot('Position', [0.4, 0.28,  0.23 0.6]);
            %, 'Position', [0.4, 1-0.3*(si) 0.2 0.2]
            ws = ones(length(ms), 1);
            yrange = [0 0.5];
            if (si == 1)
                [mnames2, p] = util.xdraw_main(ctbins,yrange,ms,'t','Translation Error (%)',XLabel,'', ws);%Median Translation

            else
                [mnames2, p] = util.xdraw_main(ctbins,yrange,ms,'t','',XLabel,'', ws);
                set(gca,'YTickLabel','')
            end
            set(gca,'FontSize',10);
            
            
            
            
            subplot('Position', [0.7, 0.28,  0.23 0.6]);
            
            cols = {'r','g','b','k'};            
            hold on;
            ylim([-200,200]);
            xlim([-200, 200]);
            
            for mi = 1:4
                p(mi) = plot(pos(1,:,mi), pos(3,:,mi), cols{mi}, 'LineWidth', 2, 'displayname', trnames{mi});    
            end

            plot(pos_gt(1,:), pos_gt(3,:), 'm', 'LineWidth', 4, 'LineStyle', ':', 'displayname', 'GT');
            hold off;
            title('Trajectory','FontSize',12, 'FontWeight', 'normal');
            
            mnames = trnames;
            mnames{5} = 'GT';
            
            hL = legend(mnames, 'Orientation','horizontal', 'Position', [0.25, 0.05, 0.5 0.05], 'box', 'on'); 
%             subplot('Position', [0.1+0.3*shift, 0.1,  0.23 0.25]);
%             %, 'Position', [0.4, 1-0.3*(si) 0.2 0.2]
%             %ws = ones(size(ms), 1);
%             yrange = [0 0.02];
%             [mnames3, p] = util.xdraw_main(Xarg,yrange,ms,'mean_time','',XLabel,'Time (s)', ws);%Median Translation


    end

        

        h = h0;
        set(h,'Units','Inches');
        pos = get(h,'Position');
        set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%         print(h,['figs/real_cvpr' '.pdf'],'-dpdf','-r0')
%         pause;    
end