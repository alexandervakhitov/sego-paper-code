clear; 
clc;
close all;
warning off;

addpath('/home/alexander/soft/TOOLBOX_calib');

% prepare_paths();

% experimental parameters

%focal length in pixels
fpix = 500;

nls = [0.000:0.2:1.0];

%number of random trials per iteration
num = 1000;

% is_planar = 1;
ml = model.setup_methods_and_ba();

% for k = 1:6
%     ml(k).fails(1) = 0;
% end   
    
all_case_num = 9;

% load('noise_cvpr_l.mat');
addpath('/home/alexander/materials/sego/pnpd_pyshnova/pnpd/SM/SM');

%experiments
for i= 1:length(nls)
    for k = 6:9 %all_case_num
    
        pix_noise = nls(i);
        cur_tlen = 9*rand+1;
        rotrad = rand*pi/4;           

        for j= 1:num
            
            for mi = 1:length(ml)
                ml(mi).r(j,i,k) = -1;
                ml(mi).t(j,i,k) = -1;
            end

            % camera's parameters


            [Rs, ts, projs_full, lprojs_full] = model.setup_stereo_scene_full(cur_tlen, rotrad, pix_noise, fpix);                                                
            
%             global Rtt;
%             Rtt = Rs(:,:,3);
%             global ttt;
%             ttt = ts(:,3);
            
            [projs, lprojs, vis_p, vis_l] = model.prepare_case(k, projs_full, lprojs_full);
            [projs_ijcv, lprojs_ijcv] = model.clean_projs_ijcv12(projs_full, vis_p, lprojs_full, vis_l);
            for mi = 1:length(ml)                
                t0 = tic;
                if (strcmp(ml(mi).id,'BA'))
                    [R_ans, t_ans] = ml(mi).run(projs, lprojs, vis_p, vis_l, Rs(:, :, 3), ts(:, 3));
                else
                    if (ml(mi).is_pt_only)
                        if (size(vis_p, 1) == 3)
                            if (ml(mi).is_min)
                                [R_ans, t_ans] = ml(mi).run(projs, vis_p);
                            else
                                [R_ans, t_ans] = ml(mi).run(projs_full);
                            end
                        else
                            R_ans = [];
                            t_ans = [];
                        end
                    else
                        if (ml(mi).is_min)
                            [R_ans, t_ans] = ml(mi).run(projs, lprojs, vis_p, vis_l);
                        else
                            [R_ans, t_ans] = ml(mi).run(lprojs_ijcv, projs_ijcv);
                        end
                    end
                end
                t1 = toc(t0);
                [index_best, y, Rf, tf] = model.choose_best(Rs(:, :, 3), ts(:, 3), R_ans, t_ans);             
                                
                if (length(y) == 2)
                    ml(mi).r(j,i,k)= y(1);                    
                    ml(mi).t(j,i,k)= y(2);                    
                    ml(mi).time(j,i,k)= t1; 
                else
                    ml(mi).r(j,i,k) = -1;
                    ml(mi).t(j,i,k) = -1;
                    ml(mi).time(j,i,k)= -1; 
                end
                                
            end
%             j/num*100
            if (mod(j, 10)==0)
                j/num*100
            end
        end       
        for mi= 1:length(ml)            
            nneg = (ml(mi).r(:,i,k) ~= -1) & (~isnan(ml(mi).r(:,i,k)));
            inds = find(nneg);
            ml(mi).mean_r(i,k)= (mean(ml(mi).r(inds,i,k)));
            ml(mi).mean_t(i,k)= (mean(ml(mi).t(inds,i,k)));
            
            ml(mi).mean_time(i,k)= (mean(ml(mi).time(inds,i,k)));

            ml(mi).med_r(i,k)= (median(ml(mi).r(inds,i,k)));
            ml(mi).med_t(i,k)= (median(ml(mi).t(inds,i,k)));
            ml(mi).succ_share(i,k) = length(inds)/length(ml(mi).r(:,i,k));
        end
        
    end        
    fprintf('\n');
                   
end

save('noise_cvpr_1e5.mat');
