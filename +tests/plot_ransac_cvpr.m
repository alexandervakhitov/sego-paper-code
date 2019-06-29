function plot_noise_cvpr
    addpath('/home/alexander/materials/sego/sego_git/matlab/main/columnlegend');
    close all;
    h0 = figure('position', [100 100 600 450]);
    set(gcf,'Units','normal');
    lp = [0.1, 0.4, 0.7];
    lh = [0.14, 0.09, 0.09];
        
    load('ransac_cvpr.mat');
        
    %gen stats
    out_rats = [0 0.25 0.5];
    for i = 1:length(out_rats)
        for mi = 1:length(ml)
            inds = find(ml(mi).r(:,i) ~= -1);
            ml(mi).med_r(i) = median(ml(mi).r(inds,i));
            ml(mi).med_t(i) = median(ml(mi).t(inds,i));
        end
    end
    

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
    
    XLabel = 'Noise std. dev., pix.';
    Xarg = out_rats;    
    
    for si = 1:length(out_rats)
        
        
        %for si = 1:

%             [vis_p, vis_l] = model.generate_visibility(si);
%             
%             if (size(vis_p, 1)+size(vis_l, 1) == 0)
%                 continue;
%             end

            ms = ml;

    %         subplot(2,SN,si);
            shift = si-1;
            subplot('Position', [0.1+0.3*shift, 0.6,  0.23 0.3]);

            ws = ones(length(ms), 1);
            yrange = [0 65];
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
            subplot('Position', [0.1+0.3*shift, 0.23,  0.23 0.3]);
            %, 'Position', [0.4, 1-0.3*(si) 0.2 0.2]
            ws = ones(length(ms), 1);
            yrange = [0 120];
            if (si == 1)
                [mnames2, p] = util.xdraw_main(Xarg,yrange,ms,'med_t','',XLabel,'Translation Error (%)', ws);%Median Translation

            else
                [mnames2, p] = util.xdraw_main(Xarg,yrange,ms,'med_t','',XLabel,'', ws);
                set(gca,'YTickLabel','')
            end
            set(gca,'FontSize',10);

%             subplot('Position', [0.1+0.3*shift, 0.1,  0.23 0.25]);
%             %, 'Position', [0.4, 1-0.3*(si) 0.2 0.2]
%             %ws = ones(size(ms), 1);
%             yrange = [0 0.02];
%             [mnames3, p] = util.xdraw_main(Xarg,yrange,ms,'mean_time','',XLabel,'Time (s)', ws);%Median Translation


    end

        hL = legend(mnames1, 'Orientation','horizontal', 'Position', [0.25, 0.05, 0.5 0.05], 'box', 'on'); 

        h = h0;
        set(h,'Units','Inches');
        pos = get(h,'Position');
        set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
        print(h,['figs/var_noise_cvpr_f2' '.pdf'],'-dpdf','-r0')
%         pause;    
end