clear; 
clc;
close all;
warning off;

% prepare_paths();

% experimental parameters

%focal length in pixels
fpix = 500;



%number of random trials per iteration
num = 5;

% is_planar = 1;
% method_list = model.setup_methods(method_names, num, length(nls), is_planar);

% for k = 1:2
%     method_list(k).fails(1) = 0;
% end   

method_list(1).mean_r(4,9)= 0;
method_list(1).mean_t(4,9)= 0;
method_list(1).mean_time(4,9)= 0;

method_list(1).med_r(4,9)= 0;
method_list(1).med_t(4,9)= 0;
method_list(1).succ_share(4,9) = 0;

method_list(1).r = -1*ones(num,4,9);
method_list(1).t(num,4,9) = 0;
method_list(1).time(num,4,9) = 0;
    
all_case_num = 10;
%experiments
for k = 3:3 %all_case_num
%     for mi = 1:2
%         method_list(mi).r= -1*ones(num, length(nls));    
%         method_list(mi).t= -1*ones(num, length(nls));
%     end

    for i = 1:4
        pix_noise = 0.00;
        cur_tlen = 9*rand+1;
        rotrad = rand*pi/4;   
        

        for j= 1:num

            % camera's parameters


            [Rs, ts, projs_full, lprojs_full] = model.setup_stereo_scene_full(cur_tlen, rotrad, pix_noise, fpix);                
            q = util.rot2quat(Rs(:, :, 3));
            at = q(1);
            bt = q(2);
            ct = q(3);
            dt = q(4);
            ci1 = mod(i, 2)+1;
            ci2 = floor(i/2-0.25)+1;
%             ci1
%             ci2
            [projs, lprojs, vis_p, vis_l] = model.generate_case(k, projs_full, lprojs_full, ci1, ci2);
            [projs_ijcv, lprojs_ijcv] = model.clean_projs_ijcv12(projs_full, vis_p, lprojs_full, vis_l);
            t0 = tic;
            [R_ans, t_ans] = cvpr10.quat_assf(lprojs_ijcv, projs_ijcv);%, at, bt, ct, dt
            t1 = toc(t0);            
            [index_best, y, Rf, tf] = model.choose_best(Rs(:, :, 3), ts(:, 3), R_ans, t_ans);                         

            method_list(1).r(j,i,k)= -1;
%             method_list(2).r(j,i,k)= -1;
            if (length(y) == 2)
                method_list(1).r(j,i,k)= y(1);
                method_list(1).t(j,i,k)= y(2); 
                method_list(1).time(j,i,k)= t1; 

            end            
        end       
        
        mi = 1;
        
        inds = find(method_list(mi).r(:,i,k) ~= -1);
        method_list(mi).mean_r(i,k)= (mean(method_list(mi).r(inds,i,k)));
        method_list(mi).mean_t(i,k)= (mean(method_list(mi).t(inds,i,k)));
        method_list(mi).mean_time(i,k)= (mean(method_list(mi).time(inds,i,k)));

        method_list(mi).med_r(i,k)= (median(method_list(mi).r(inds,i,k)));
        method_list(mi).med_t(i,k)= (median(method_list(mi).t(inds,i,k)));
        method_list(mi).succ_share(i,k) = length(inds)/length(method_list(mi).r(:,i,k));

    end

    % save result
    
    
    
end

save('test_ijcv');


fprintf('end');