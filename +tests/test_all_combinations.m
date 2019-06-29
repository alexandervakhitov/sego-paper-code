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

for k = 1:2
    method_list(k).fails(1) = 0;
end   

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
ys = [];
ys2 = [];
times = [];
times2 = [];
for k = 1:5 %2:all_case_num
%     for mi = 1:2
%         method_list(mi).r= -1*ones(num, length(nls));    
%         method_list(mi).t= -1*ones(num, length(nls));
%     end
    fprintf('case num %d', k);
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
            et = get_alpha_true(Rs, ts, projs_full);
                    
            ci1 = (rand>0.5)+1;
            ci2 = (rand>0.5)+1;
            ci1
            ci2
            [projs, lprojs, vis_p, vis_l] = model.generate_case(k, projs_full, lprojs_full, ci1, ci2);
            
            t0 = tic;
%             [R_ans, t_ans] = solve_stereo_minimal_full(projs(1:2,:,:), lprojs, vis_p, vis_l, at, bt, ct, dt, et);
            t1 = toc(t0);            
            
            if (k >= 6)                

                is_det_check = true;
                [R_ans, t_ans] = polyslv.quadric_solver(projs, lprojs, vis_p, vis_l, is_det_check);
                
                [index_best, y, Rf, tf] = model.choose_best(Rs(:, :, 3), ts(:, 3), R_ans, t_ans);                         
                ys = [ys; y];
                
                
                is_det_check = false;
                [R_ans, t_ans] = polyslv.quadric_solver(projs, lprojs, vis_p, vis_l, is_det_check);
                
                [index_best, y2, Rf, tf] = model.choose_best(Rs(:, :, 3), ts(:, 3), R_ans, t_ans);                         
                ys2 = [ys2; y2];
            else
                is_pluecker = true;
                if (is_pluecker)
                    [A, pt_shift] = model.eq_generator_plu_real(projs(1:2,:,:), lprojs, vis_p, vis_l);
                    R2Q = zeros(9, 10);
                    R2Q(1, [7 8 9 10]) = [1 1 -1 -1];
                    R2Q(2, [4 3]) = 2;
                    R2Q(3, [5, 2]) = [2, -2];
                    R2Q(4, [4 3]) = [2, -2];
                    R2Q(5, [7 8 9 10]) = [1, -1, 1, -1];
                    R2Q(6, [6, 1]) = 2;
                    R2Q(7, [5 2]) = 2;
                    R2Q(8, [6 1]) = [2, -2];
                    R2Q(9, [7 8 9 10]) = [1, -1, -1, 1];
                    M1 = A(:, 1:9)*R2Q;
                    M2 = A(:, 10:18)*R2Q;            
                    t0 = tic;
                    sols = polyslv.solver_pluecker(M1, M2, bt/at,ct/at,dt/at);
                    tof = toc(t0);
                    times = [times; tof];
                    %[R_ans, t_ans] = t_from_bcd(sols(1,:), sols(2,:), sols(3,:), projs(1:2,:,:), lprojs, vis_p, vis_l);
                    R_ans = zeros(3, 3, size(sols, 2));
                    t_ans = zeros(3, size(sols, 2));
                    for si = 1:size(sols, 2)
                        q = [1; sols(:, si)];
                        q = q/norm(q);
                        a = q(1);
                        b = q(2);
                        c = q(3);
                        d = q(4);
                        Rf = build_cam(a,b,c,d);
                        v = [a*b, a*c, a*d, b*c, b*d, c*d, a^2, b^2, c^2, d^2];
                        e = -(M2*v')\(M1*v');
                        tf = projs(:, 1, 3)*e;
                        R_ans(:,:,si) = Rf;
                        t_ans(:, si) = tf-Rf*pt_shift;
                    end
                    
                    [index_best, y, Rf, tf] = model.choose_best(Rs(:, :, 3), ts(:, 3), R_ans, t_ans);                         
                    ys = [ys; y];                    
                end
                is_pluecker = false;
                if (~is_pluecker)
                    t2 = [1;0;0];
                    R2 = eye(3);
                    [projs1, lprojs1, t_2s, R1] = polyslv.shift_u(projs, [1;0;0], lprojs, vis_p, vis_l);
                    pt3d1 = resolve_point(eye(3), zeros(3, 1), R2, t2, [projs1(:, 1, 1)], [projs1(:, 1, 2)]);
                    shift_3d = -pt3d1;        
                    t3e_dir = [projs1(:, 1, 3)];

                    [A,B, case_num] = buildAB2(projs1(1:2,:,:),t3e_dir, shift_3d, lprojs1, vis_p, vis_l, R2, t2, t_2s);
                    M = polyslv.build_homo_system(A, B, case_num);                    
                     Mf = M;
                    if (case_num == 1)
                        Mf(3,:) = M(3,:) -M(4,:);
                        Mf([1,3],:) = Mf([3,1],:);
                    end
                    if (case_num == 5 || case_num == 2)
                        Mf(1,:) = M(1,:) -M(2,:);            
                    end
                    if (case_num == 4)
                        Mf(1,:) = M(1,:) -M(2,:);            
                        Mf(3,:) = M(3,:) -M(4,:);            
                        Mf([2,3], :) = Mf([3,2], :);
                    end


                    M1f = Mf(:, 1:10);
                    M2f = Mf(:, 11:20);   
                    t0 = tic;
                    [as, bs, cs, ds] = polyslv.solver_full(M1f, M2f, case_num);
                    tof = toc(t0);
                    times2 = [times2; tof];
                    
                    R_ans = zeros(3, 3, length(as));
                    t_ans = zeros(3, length(as));
                    
                    R_test = R1*Rs(:, :, 3);
                    q = util.rot2quat(R_test);
                    for si = 1:length(as)
                        a = as(si);
                        b = bs(si);
                        c = cs(si);
                        d = ds(si);
                        Rf = build_cam(a,b,c,d);
                        v = [a*b, a*c, a*d, b*c, b*d, c*d, a^2, b^2, c^2, d^2];
                        e = -(M2f*v')\(M1f*v');
                        t3_f = t3e_dir*e;
                        R_ans(:, :, si) = R1'*Rf;                        
                        t_ans(:, si) = R1'*t3_f-R1'*Rf*pt3d1;
                    end
                    
                    [index_best, y, Rf, tf] = model.choose_best(Rs(:, :, 3), ts(:, 3), R_ans, t_ans);                         
                    
                    ys2 = [ys2; y];
                end
                
            end
            
            %[index_best, y, Rf, tf] = model.choose_best(Rs(:, :, 3), ts(:, 3), R_ans, t_ans);                         

            method_list(1).r(j,i,k)= -1;
            method_list(2).r(j,i,k)= -1;
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

save('test_all');


fprintf('end');