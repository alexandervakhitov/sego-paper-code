clear; 
clc;
close all;
warning off;

% prepare_paths();

% experimental parameters

%focal length in pixels
fpix = 500;

all_case_num = 9;

nls = [0.0:0.0004:0.002];

%number of random trials per iteration
num = 10;

% is_planar = 1;
% method_list = model.setup_methods(method_names, num, length(nls), is_planar);

ks = [1;8;32];
    
%experiments
for i= 1:length(nls)
    pix_noise = nls(i);
    cur_tlen = 9*rand+1;
    rotrad = rand*pi/4;    
    
    for j= 1:num
        
        % camera's parameters
        
        
        [Rs, ts, projs, lprojs] = model.setup_stereo_scene(cur_tlen, rotrad, pix_noise);
        
        npt = randi(3);
        nl = 3-npt;
        projs = projs(:, 1:npt, :);
        lprojs = lprojs(:, 1:nl, :);
        
        for k = 1:length(ks)+1
            if (k == 1)
                [R_ans, t_ans] = cvpr10.quat_assf(lprojs, projs);
            else
                [R_ans, t_ans] = solve_stereo_minimal_quad(projs(1:2,:,:), lprojs, ks(k-1));
            end
            %choose the solution with smallest error 
            [index_best, y, Rf, tf] = model.choose_best(Rs(:, :, 3), ts(:, 3), R_ans, t_ans);                                    

            method_list(k).r(j,i)= -1;
            if (length(y) < 2)
                continue;
            end
            method_list(k).r(j,i)= y(1);
            method_list(k).t(j,i)= y(2); 
        end

%        showpercent(j,num);
        j/num*100
    end        
    fprintf('\n');
    

    % save result
    for k= 1:length(ks)+1
        inds = find(method_list(k).r(:,i) ~= -1);
        method_list(k).mean_r(i)= (mean(method_list(k).r(inds,i)));
        method_list(k).mean_t(i)= (mean(method_list(k).t(inds,i)));
        
        method_list(k).med_r(i)= (median(method_list(k).r(inds,i)));
        method_list(k).med_t(i)= (median(method_list(k).t(inds,i)));
        method_list(k).succ_share(i) = length(inds)/length(method_list(k).r(:,i));
    end
end

save('var_noise_4.mat');

fprintf('end');