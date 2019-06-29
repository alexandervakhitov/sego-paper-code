function plot_var_noise_planar_ijcv    
    addpath('/home/alexander/materials/sego/sego_git/matlab/main/columnlegend');
    close all;
    h0 = figure('position', [100 100 650 550]);
    set(gcf,'Units','normal');
    lp = [0.1, 0.4, 0.7];
    lh = [0.14, 0.09, 0.09];
    
    
    solver_sets{1} = [1,2]; %2p
    solver_sets{2} = [4,5,8,9]; %2l
    solver_sets{3} = [3,6,7,10]; %3p,3l
    SN = length(solver_sets);
    
    method_list_full = {};
    method_list_names = {'S2P/1L'; 'Q2P/1L*'; ...
                         'S1P1L/1P*'; 'Q1P1L/1P*'; ...
                         'S2P/1P'; 'Q2P/1P*'; ...
                         'S1P/2L'; 'Q1P/2L*'; ...
                         'S1P1L/1L'; 'Q1P1L/1L*';...
                         'S2L/1L'; 'Q2L/1L*'; ...
                         'S3P'; 'Q3P*'; ...
                         'S2P1L'; 'Q2P1L*'; ...
                         'S1P2L'; 'Q1P2L*';...
                         'S3L'; 'Q3L*'};
    for case_ind = 1:10
        load(['var_noise_planar_' int2str(case_ind) '.mat']);
        method_list_full{2*case_ind-1} = method_list(1);
        method_list_full{2*case_ind} = method_list(2);
        method_list_full{2*case_ind-1}.name = method_list_names{2*case_ind-1};
        method_list_full{2*case_ind}.name = method_list_names{2*case_ind};
    end
    
    colors{1} = {[0.8 0.3 0.3], [0.3 0.3 0.8]};
    colors{2} = {[0.8 0 0],[0 0.8 0],[0 0 0.8],[0.3 0.8 0.3]};
    colors{3} = {[0.5 0.5 0], [0 0.5 0.5 ], [0.5 0 0.5], [0.5 0.5 0.5]};
    for case_ind = 1:10
        method_list_full{2*case_ind-1}.linestyle = '-';
        method_list_full{2*case_ind}.linestyle = '--';
        for t = 1:2
            ssnum = -1;
            sspos = -1;
            for ssi = 1:SN
                for ssi2 = 1:length(solver_sets{ssi})
                    if (solver_sets{ssi}(ssi2) == case_ind)
                        ssnum = ssi;
                        sspos = ssi2;
                    end
                end
            end
            method_list_full{2*case_ind-2+t}.color = colors{ssnum}{sspos};
            method_list_full{2*case_ind-2+t}.marker = '.';        
            method_list_full{2*case_ind-2+t}.markerfacecolor = colors{ssnum}{sspos};
        end
    end
    
    XLabel = 'Noise std. dev., pix.';
    Xarg = nls*1000;
    method_list = method_list_full;
    
    for si = 1:SN
        3*si-2
%         subplot(2,SN,si);
        subplot('Position', [0.1+0.3*(si-1), 0.68,  0.23 0.28]);
        ss = [2*solver_sets{si}-1, 2*solver_sets{si}]; 
        method_list_subs = [];
        for t =1:length(ss)
            method_list_subs  = [method_list_subs; method_list{ss(t)}];
        end
        ws = ones(length(method_list_subs), 1);
        yrange = [0 30];
        if (si == 1)
            [mnames1, p] = util.xdraw_main(Xarg,yrange,method_list_subs,'med_r','','','Rotation Error (deg)', ws);            
        else
            [mnames1, p] = util.xdraw_main(Xarg,yrange,method_list_subs,'med_r','','','', ws);                        %Median Rotation
            set(gca,'YTickLabel','')            
        end
        set(gca,'FontSize',10);
%         set(gca,'FontWeight','bold');
        if (si == 2)
%             title('\fontsize{12} Rotation Error');
        end
        lm = length(mnames1);
        hL = legend(mnames1, 'Orientation','vertical', 'Position', [lp(si), lh(si), 0.23 0.1], 'box', 'on');        
        %hL = legend({mnames1{1:lm/2}}, 'Orientation','vertical', 'Position', [0.3*(si-1)+0.15, 0.20 0.05 0.05], 'box', 'off');        
        %hL = legend(p(1:lm/2), 'Orientation','vertical', 'Position', [0.3*(si-1)+0.15, 0.20 0.05 0.05], 'box', 'off');        
%         correct_margin();
        
        
        
%         hL = columnlegend(2, mnames1, 'Orientation','vertical', 'Position', [0.3*(si-1)+0.15, 0.4 0.1 0.1]);
        
%         subplot(SN,3,si+3);
        subplot('Position', [0.1+0.3*(si-1), 0.34,  0.23 0.28]);
        %, 'Position', [0.4, 1-0.3*(si) 0.2 0.2]
        ws = ones(length(method_list_subs), 1);
        yrange = [0 100];
        if (si == 1)
            [mnames2, p] = util.xdraw_main(Xarg,yrange,method_list_subs,'med_t','',XLabel,'Translation Error (%)', ws);%Median Translation
            
        else
            [mnames2, p] = util.xdraw_main(Xarg,yrange,method_list_subs,'med_t','',XLabel,'', ws);
            set(gca,'YTickLabel','')
        end
        set(gca,'FontSize',10);
        if (si == 2)
%             title('\fontsize{12} Translation Error');
        end
%         
%         lm = length(mnames2);
%         hL2 = legend({mnames1{lm/2+1:lm}}, 'Orientation','vertical', 'Position', [0.3*(si-1)+0.25, 0.20 0.05 0.05], 'box', 'off');
        %hL2 = legend(p(lm/2+1:lm), 'Orientation','vertical', 'Position', [0.3*(si-1)+0.25, 0.20 0.05 0.05], 'box', 'off');
%         correct_margin();
    
%         subplot(SN,3,si+6);                
%         ws = ones(length(method_list_subs), 1);
%         yrange = [0.8 1.05];
%         [mnames3, p] = util.xdraw_main(Xarg,yrange,method_list_subs,'succ_share','Success Share',XLabel,'Rotation Error (degrees)', ws);
%         correct_margin();
    end
    
    
    h = h0;
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(h,'figs/var_noise_planar.pdf','-dpdf','-r0')

end