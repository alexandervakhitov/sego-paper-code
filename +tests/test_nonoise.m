clear; 
clc;
close all;
warning off;

% prepare_paths();

% experimental parameters

%focal length in pixels
fpix = 500;

all_case_num = 5;

pix_noise = 0.0;

%number of random trials per iteration
num = 100;

% is_planar = 1;
% method_list = model.setup_methods(method_names, num, length(nls), is_planar);

for k = 1:6
    method_list(k).fails(1) = 0;
end   
    
%experiments
for i= 1:1
    cur_tlen = 9*rand+1;
    rotrad = rand*pi/4;    
    
    for j= 1:num
        
        % camera's parameters
        
        
        [Rs, ts, projs_full, lprojs_full] = model.setup_stereo_scene(cur_tlen, rotrad, pix_noise);
        
        

        for k = 5:all_case_num
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
    for k= 1:all_case_num
        inds = find(method_list(k).r(:,i) ~= -1);
        method_list(k).mean_r(i)= (mean(method_list(k).r(inds,i)));
        method_list(k).mean_t(i)= (mean(method_list(k).t(inds,i)));
        
        method_list(k).med_r(i)= (median(method_list(k).r(inds,i)));
        method_list(k).med_t(i)= (median(method_list(k).t(inds,i)));
        method_list(k).succ_share(i) = length(inds)/length(method_list(k).r(:,i));
    end
end

save('no_noise.mat');

fprintf('end');