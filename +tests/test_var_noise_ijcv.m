clear; 
clc;
close all;
warning off;

% prepare_paths();

% experimental parameters

%focal length in pixels
fpix = 500;



nls = [0.00:0.2:1.0];

%number of random trials per iteration
num = 100;

% is_planar = 1;
method_list = model.setup_methods(method_names, num, length(nls), is_planar);

for k = 1:2
    method_list(k).fails(1) = 0;
end   


    
all_case_num = 10;
%experiments
for k = 1:all_case_num
    for mi = 1:2
        method_list(mi).r= -1*ones(num, length(nls));    
        method_list(mi).t= -1*ones(num, length(nls));
    end

    for i= 1:length(nls)
        pix_noise = nls(i);
        cur_tlen = 9*rand+1;
        rotrad = rand*pi/4;   
        

        for j= 1:num

            % camera's parameters


            [Rs, ts, projs_full, lprojs_full] = model.setup_stereo_scene_full(cur_tlen, rotrad, pix_noise, fpix);                
        
            [projs, lprojs, vis_p, vis_l] = model.prepare_case(k, projs_full, lprojs_full);
            t0 = tic;
            [R_ans, t_ans] = solve_stereo_minimal_full(projs(1:2,:,:), lprojs, vis_p, vis_l);
            [R_ans, t_ans] = sego_solver(projs, lprojs, vis_p, vis_l);
            t1 = toc(t0);            
            
            [projs_ijcv, lprojs_ijcv] = model.clean_projs_ijcv12(projs_full, vis_p, lprojs_full, vis_l);
            t02 = tic;
            [R_comp, t_comp] = cvpr10.quat_assf(lprojs_ijcv, projs_ijcv);
            t12 = toc(t02);
            %choose the solution with smallest error 
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
        end       
        for mi= 1:2
            inds = find(method_list(mi).r(:,i) ~= -1);
            method_list(mi).mean_r(i)= (mean(method_list(mi).r(inds,i)));
            method_list(mi).mean_t(i)= (mean(method_list(mi).t(inds,i)));

            method_list(mi).med_r(i)= (median(method_list(mi).r(inds,i)));
            method_list(mi).med_t(i)= (median(method_list(mi).t(inds,i)));
            method_list(mi).succ_share(i) = length(inds)/length(method_list(mi).r(:,i));
        end
%        showpercent(j,num);
        j/num*100
    end        
    fprintf('\n');
    

    % save result
    
    
    save(['var_noise_' int2str(k) '.mat']);
end



fprintf('end');