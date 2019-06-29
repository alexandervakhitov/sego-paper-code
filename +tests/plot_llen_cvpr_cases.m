function plot_noise_cvpr_cases
    addpath('/home/alexander/materials/sego/sego_git/matlab/main/columnlegend');
    close all;
    h0 = figure('position', [100 100 1200 650]);
    set(gcf,'Units','normal');
    lp = [0.1, 0.4, 0.7];
    lh = [0.14, 0.09, 0.09];
        
    load('llen.mat');
    
    ml = ml([1,2,4,5,6]);
    
    case_labels = {'S2P-1L', 'S1P1L-1P', 'S2P-1P', 'S1P-2L', 'S1P1L-1L', 'S3L', 'S3P', 'S2P1L', 'S1P2L'};
    %gen stats
%     stat_arr = {[6,7,8,9], [1,2,3,4,5], [3,7]};
%     for si = 3:length(stat_arr)
%         for mi= 4:length(ml)  
%             for nl = 1:length(nls)
%                 rs = [];
%                 ts = [];
%                 times = [];
%                 for sci = 1:length(stat_arr{si})
%                     ci = stat_arr{si}(sci);
%                     inds = find(ml(mi).r(:,nl,ci) ~= -1);
%                     rs = [rs; ml(mi).r(inds, nl, ci)];
%                     ts = [ts; ml(mi).t(inds, nl, ci)];
%                     times = [times; ml(mi).time(inds, nl, ci)];
%                 end
% 
%                 ml(mi).mean_time(nl,si)= (mean(times));
%                 ml(mi).med_r(nl,si)= (median(rs));
%                 ml(mi).med_t(nl,si)= (median(ts)); 
%             end
%         end
%     end

    

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
            ml(mi).name = 'Pradeep';%ml(mi).id;
            ml(mi).linestyle = '-';
        end        
        if (strcmp(ml(mi).id , 'Approx'))
            ml(mi).marker = '.';
            ml(mi).color = 'b';
            ml(mi).markerfacecolor = 'b';
            ml(mi).name = ml(mi).id;
            ml(mi).linestyle = '-';
        end          
        if (strcmp(ml(mi).id , 'BA'))
            ml(mi).marker = '.';
            ml(mi).color = 'k';
            ml(mi).markerfacecolor = 'k';
            ml(mi).name = ml(mi).id;
            ml(mi).linestyle = '-';
        end   
    end
    
    XLabel = 'Avg. line length';
    Xarg = lls;    
    
    for si = 1:9                

            ms = [];
            for mi = 1:length(ml)
                [vis_p, vis_l] = model.generate_visibility(si);
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
            
            row_ind = floor((si-0.1)/3)+1;
            col_ind = mod(si, 3);
            if (col_ind == 0)
                col_ind = 3;
            end
            
            XLabelc = '';
            if (row_ind == 3) 
                XLabelc = XLabel;
            end
            shift = si;
            subplot('Position', [0.18+0.33*(col_ind-1), 0.15+0.3*(3-row_ind),  0.11 0.2]);

            ws = ones(length(ms), 1);
            yrange = [0 40];            
            if (si == 1)
                [mnames1, p] = util.xdraw_main(Xarg,yrange,ms,'med_r',['Rotation'],XLabelc,'', ws,'right');            
            else
                [mnames1, p] = util.xdraw_main(Xarg,yrange,ms,'med_r',['Rotation'],XLabelc,'', ws,'right');                        %Median Rotation
%                 set(gca,'YTickLabel','')            
            end
            set(gca,'FontSize',10);
            subplot('Position', [0.05+0.33*(col_ind-1), 0.15+0.3*(3-row_ind),  0.11 0.2]);
            %, 'Position', [0.4, 1-0.3*(si) 0.2 0.2]
            ws = ones(length(ms), 1);
            yrange = [0 250];            
            if (si == 1)
                [mnames2, p] = util.xdraw_main(Xarg,yrange,ms,'med_t',[case_labels{si}, ' Translation'],XLabelc,'', ws);%Median Translation

            else
                [mnames2, p] = util.xdraw_main(Xarg,yrange,ms,'med_t',[case_labels{si}, ' Translation'],XLabelc,'', ws);
%                 set(gca,'YTickLabel','')
            end
            set(gca,'FontSize',10);
            
            if (si == 7)
                hL = legend(mnames1, 'Orientation','horizontal', 'Position', [0.25, 0.03, 0.5 0.05], 'box', 'on'); 
                hL.FontSize = 12;
%                 set(gca,'FontSize',12);
            end

    end

        
        h = h0;
        set(h,'Units','Inches');
        pos = get(h,'Position');
        set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
        print(h,['figs/llen' '.pdf'],'-dpdf','-r0')
%         pause;    
end