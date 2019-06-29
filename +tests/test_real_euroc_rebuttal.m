function test_real_euroc_rebuttal
    fprintf('r_acc/t_acc/time\n');
    stats = [];
    pos = [];
    
    Prect1 = reshape([7.188560000000e+02 0.000000000000e+00 6.071928000000e+02 0.000000000000e+00 0.000000000000e+00 7.188560000000e+02 1.852157000000e+02 0.000000000000e+00 0.000000000000e+00 0.000000000000e+00 1.000000000000e+00 0.000000000000e+00], 4, 3)';
    Prect2 = reshape([7.188560000000e+02 0.000000000000e+00 6.071928000000e+02 -3.861448000000e+02 0.000000000000e+00 7.188560000000e+02 1.852157000000e+02 0.000000000000e+00 0.000000000000e+00 0.000000000000e+00 1.000000000000e+00 0.000000000000e+00], 4, 3)';
    
    K = Prect1(1:3,1:3);
    P2n = K\Prect2;
    b = P2n(:, 4);
    
    
    [gt_Rs, gt_ts] = read_poses('/home/alexander/materials/sego/kitti_odometry/dataset (3)/poses/01.txt');
    pos_gt = [];
    it = 1;
    
    T_gt_agg = eye(4);
    step = 1;
    for frame_ind = 23:1:224
        
        R1_gt = gt_Rs(:,:,frame_ind+step);
        R2_gt = gt_Rs(:,:,frame_ind);
        t1_gt = gt_ts(:,frame_ind+step);
        t2_gt = gt_ts(:,frame_ind);
        
        T1 = [R1_gt t1_gt+b; zeros(1,3) 1];
        T2 = [R2_gt t2_gt+b; zeros(1,3) 1];
        T12 = T2\T1;
        
        R_gt = T12(1:3,1:3);
        t_gt = T12(1:3, 4);
        
        Tgt = inv([R_gt t_gt; 0 0 0 1]);
        if (frame_ind == 23)
            T_gt_agg = Tgt;
        else
            T_gt_agg = Tgt * T_gt_agg;
        end
        
        Rg = T_gt_agg(1:3,1:3);
        tg = T_gt_agg(1:3, 4);
        cg = -Rg'*tg;
        
        pos_gt(:, it) = cg;
        
        %load(['ransac_real_02_' num2str(frame_ind) '_ln2_t2_f.mat']);        
        %load(['final1/' num2str(frame_ind) '.mat']);  
        load(['final_euroc_1/' num2str(frame_ind) '.mat']);  
        for mi = 1:4
            trnames{mi} = ml(mi).id;
            %stats_row = [stats_row, ml(mi).r(frame_ind), ml(mi).t(frame_ind), ml(mi).time(frame_ind)];
            stats(it, mi, 1:8) = [ml(mi).r(frame_ind), ml(mi).t(frame_ind), ml(mi).rf(frame_ind), ml(mi).tf(frame_ind), ml(mi).time(frame_ind), ml(mi).it(frame_ind), length(ml(mi).pt_inds{frame_ind}), length(ml(mi).ln_inds{frame_ind})];
            if (frame_ind == 23)
                Ts{mi} = inv(ml(mi).t_ans{frame_ind});
            else
                Ts{mi} = inv(ml(mi).t_ans{frame_ind})*Ts{mi};                
            end
            
            R = Ts{mi}(1:3,1:3);
            t = Ts{mi}(1:3, 4);
            c = -R'*t;
            pos(:, it, mi) = c;
            
        end                
        
        it = it+1;
    end
    median(stats(:,:,1))
    median(stats(:,:,2))    
    close all;
%     cols = {'r','g','b','k'};
%     figure(1);
%     hold on;
%     ylim([-20,180]);
%     xlim([-30, 100]);
%     plot(pos_gt(1,:), pos_gt(3,:), 'm', 'LineWidth', 4);
%     for mi = 1:4
%         plot(pos(1,:,mi), pos(3,:,mi), cols{mi}, 'LineWidth', 2);    
%     end
%     
%     hold off;
    tests.plot_real_cvpr_2_euroc(stats, pos, pos_gt, trnames);
    
end