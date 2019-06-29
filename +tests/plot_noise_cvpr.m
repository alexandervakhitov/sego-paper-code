function plot_noise_cvpr
    addpath('/home/alexander/materials/sego/sego_git/matlab/main/columnlegend');
    close all;
    h0 = figure('position', [100 100 650 550]);
    set(gcf,'Units','normal');
    lp = [0.1, 0.4, 0.7];
    lh = [0.14, 0.09, 0.09];
        
    load('noise_cvpr_.mat');        

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
        if (strcmp(ml(mi).id , 'OPnPL'))
            ml(mi).marker = '.';
            ml(mi).color = 'k';
            ml(mi).markerfacecolor = 'k';
            ml(mi).name = ml(mi).id;
            ml(mi).linestyle = '-';
        end   
    end
    
    XLabel = 'Noise std. dev., pix.';
    Xarg = nls*1000;    
    
    for gi = 1:5
        
        h0 = figure('position', [100 100 650 550]);
        set(gcf,'Units','normal');
        
        for si = 2*gi-1:2*gi

            [vis_p, vis_l] = model.generate_visibility(si);
            
            if (size(vis_p, 1)+size(vis_l, 1) == 0)
                continue;
            end

            ms = [];
            for mi = 1:length(ml)
                if (ml(mi).is_pt_only && size(vis_p, 1) < 3)
                    continue;
                end
                if (ml(mi).is_pt_only)
                    ml(mi);
                end
                m = ml(mi);
                m.med_r = m.med_r(:, si);
                m.med_t = m.med_t(:, si);
                m.mean_time = m.mean_time(:, si);
                ms = [ms; m];
            end

    %         subplot(2,SN,si);
            shift = mod(si+1, 2);
            subplot('Position', [0.1+0.45*shift, 0.75,  0.23 0.28]);

            ws = ones(length(ms), 1);
            yrange = [0 30];
            if (si == 1)
                [mnames1, p] = util.xdraw_main(Xarg,yrange,ms,'med_r','','','Rotation Error (deg)', ws);            
            else
                [mnames1, p] = util.xdraw_main(Xarg,yrange,ms,'med_r','','','', ws);                        %Median Rotation
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
            subplot('Position', [0.1+0.3*shift, 0.45,  0.23 0.28]);
            %, 'Position', [0.4, 1-0.3*(si) 0.2 0.2]
            ws = ones(length(ms), 1);
            yrange = [0 100];
            if (si == 1)
                [mnames2, p] = util.xdraw_main(Xarg,yrange,ms,'med_t','',XLabel,'Translation Error (%)', ws);%Median Translation

            else
                [mnames2, p] = util.xdraw_main(Xarg,yrange,ms,'med_t','',XLabel,'', ws);
                set(gca,'YTickLabel','')
            end
            set(gca,'FontSize',10);
            if (si == 2)
    %             title('\fontsize{12} Translation Error');
            end

            
            subplot('Position', [0.1+0.3*shift, 0.1,  0.23 0.28]);
            %, 'Position', [0.4, 1-0.3*(si) 0.2 0.2]
            ws = ones(length(ms), 1);
            yrange = [0 0.02];            
            [mnames2, p] = util.xdraw_main(Xarg,yrange,ms,'mean_time','',XLabel,'Time', ws);%Median Translation
        end


        h = h0;
        set(h,'Units','Inches');
        pos = get(h,'Position');
        set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
        print(h,['figs/var_noise_cvpr_' num2str(gi) '.pdf'],'-dpdf','-r0')
        pause;
    end
end