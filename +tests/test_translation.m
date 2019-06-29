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

pix_noise = 0.002;

%number of random trials per iteration
num = 1000;

% is_planar = 1;
% method_list = model.setup_methods(method_names, num, length(nls), is_planar);


%experiments
for i= 1:length(tlens)
    cur_tlen = tlens(i);
    fprintf('tlen = %d: ', cur_tlen);

    index_fail = [];
    
    for k = 1:6
        method_list(k).fails(i) = 0;
    end   
    
    for j= 1:num
        
        % camera's parameters
        
        rotrad = 0.01;
        [Rs, ts, projs_full, lprojs_full] = model.setup_stereo_scene(cur_tlen, rotrad, pix_noise);
        
        

        for k = 1:all_case_num
            [projs, lprojs, vis_p, vis_l] = model.prepare_case(k, projs_full, lprojs_full);
            t0 = tic;
            [R_ans, t_ans] = solve_stereo_minimal_full(projs(1:2,:,:), lprojs, vis_p, vis_l);
            t1 = toc(t0);            
            %choose the solution with smallest error 
            [index_best, y, Rf, tf] = model.choose_best(Rs(:, :, 3), ts(:, 3), R_ans, t_ans);                                    
            
            method_list(k).r(j,i)= -1;
            if (length(y) < 2)
                continue;
            end
            method_list(k).r(j,i)= y(1);
            method_list(k).t(j,i)= y(2); 
            method_list(k).time(j,i)= t1; 
        end                    
%        showpercent(j,num);
        j/num*100
    end        
    fprintf('\n');
    

    % save result
    for k= 1:length(method_list)
        inds = find(method_list(k).r(:,i) ~= -1);
        method_list(k).mean_r(i)= (mean(method_list(k).r(inds,i)));
        method_list(k).mean_t(i)= (mean(method_list(k).t(inds,i)));
        
        method_list(k).med_r(i)= (median(method_list(k).r(inds,i)));
        method_list(k).med_t(i)= (median(method_list(k).t(inds,i)));
        method_list(k).succ_share(i) = length(inds)/length(method_list(k).r(:,i));
    end
end

save('t_scale_noise.mat');

fprintf('end');