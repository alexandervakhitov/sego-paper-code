addpath('/home/alexander/materials/sego/sego_git/matlab/+slv/codegen/mex/solver_p3v3_dif_notensor3_1p_2l_f');

clear; 
clc;
close all;
warning off;

% prepare_paths();

% experimental parameters

%translation_length
tlens = [1:8:40];

%focal length in pixels
fpix = 500;

all_case_num = 9;

pix_noise = 0.5;

%number of random trials per iteration
num = 100;

% is_planar = 1;
% method_list = model.setup_methods(method_names, num, length(nls), is_planar);

for case_ind = 1:10

    %experiments
    for i= 1:length(tlens)
        cur_tlen = tlens(i);
        fprintf('tlen = %d: ', cur_tlen);

        index_fail = [];

        for k = 1:2
            method_list(k).fails(i) = 0;
            method_list(k).r = [];
            method_list(k).t = [];
            method_list(k).time = [];
            method_list(k).fail_cnt = 0;
        end   

        for j= 1:num

            % camera's parameters

            rotrad = 0.01;
            [Rs, ts, projs_full, lprojs_full] = model.setup_stereo_scene_full(cur_tlen, rotrad, pix_noise, fpix);

            [projs, lprojs, vis_p, vis_l] = model.prepare_case(case_ind, projs_full, lprojs_full);
            t0 = tic;
            [R_ans, t_ans] = solve_stereo_minimal_full(projs(1:2,:,:), lprojs, vis_p, vis_l);
            t1 = toc(t0);            
            
            [projs_ijcv, lprojs_ijcv] = model.clean_projs_ijcv12(projs_full, vis_p, lprojs_full, vis_l);
            t02 = tic;
            [R_comp, t_comp] = cvpr10.quat_assf(lprojs_ijcv, projs_ijcv);
            t12 = toc(t02);

            %choose the solution with smallest error 
            [index_best, y, Rf, tf] = model.choose_best(Rs(:, :, 3), ts(:, 3), R_ans, t_ans);             
            [index_best2, y2, Rf2, tf2] = model.choose_best(Rs(:, :, 3), ts(:, 3), R_comp, t_comp); 

            method_list(1).r(j,i)= -1;
            method_list(2).r(j,i)= -1;
            if (length(y) == 2)
                method_list(1).r(j,i)= y(1);
                method_list(1).t(j,i)= y(2); 
                method_list(1).time(j,i)= t1; 

            end
            if (length(y2) == 2)           
                method_list(2).r(j,i)= y2(1);
                method_list(2).t(j,i)= y2(2); 
                method_list(2).time(j,i)= t12; 
            end

    %        showpercent(j,num);

            j/num*100
        end        
        fprintf('\n');


        % save result
        for k= 1:2
            inds = find(method_list(k).r(:,i) ~= -1);    
            case_ind
            method_list(k).mean_r(i)= (mean(method_list(k).r(inds,i)));
            method_list(k).mean_t(i)= (mean(method_list(k).t(inds,i)));
            method_list(k).mean_time(i)= (mean(method_list(k).time(inds,i)));

            method_list(k).med_r(i)= (median(method_list(k).r(inds,i)));
            method_list(k).med_t(i)= (median(method_list(k).t(inds,i)));
            method_list(k).med_time(i)= (mean(method_list(k).time(inds,i)));
            method_list(k).succ_share(i) = length(inds)/length(method_list(k).r);        
        end
    end

    save(['t_scale_noise_ijcv_' int2str(case_ind) '.mat']);
end

fprintf('end');