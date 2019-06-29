function test_ransac_cvpr
    addpath('/home/alexander/materials/pnp3d/pnp3d/p3p');
    do_nl = false;

    ml = model.setup_methods();
    
    t2 = [1;0;0];

    fpix = 500;
    pix_noise = 0.5;%5;
    N = 100;
    num = 10;

    out_rats = [0 0.15 0.3 0.45];
    for out_rat_it = 1:length(out_rats)
        out_rat = out_rats(out_rat_it);%0.25*(out_rat_it-1);
        fprintf('outlier ratio %f\n', out_rat);
        for i = 1:num

            cur_tlen = 9*rand+1;
            rotrad = rand*pi/4;  

            [Rs, ts, projs_full, lprojs_full, lpprojsh, pts3dt, lpts3dt] = model.setup_stereo_scene_full(cur_tlen, rotrad, pix_noise, fpix, N);    
            projs_full_true = projs_full;
            lprojs_full_true = lprojs_full;
            [projs_full, outlier_pt_ids] = generate_outliers(N, out_rat, projs_full);
            [lprojs_full, outlier_ln_ids] = generate_outliers(N, out_rat, lprojs_full);                                    
            
            pt_ok = false(size(projs_full, 2), 1);
            pt_rev_ok = false(size(projs_full, 2), 1);
            for pii = 1:size(projs_full, 2)
                if (abs(projs_full(2, pii, 1)-projs_full(2, pii, 2)) < 2/fpix)
                    pt_ok (pii) = true;
                end
                if (abs(projs_full(2, pii, 3)-projs_full(2, pii, 4)) < 2/fpix)
                    pt_rev_ok (pii) = true;
                end            
            end
            
            projs_full_3 = projs_full(1:2, pt_ok, 3);        
            projs_full_4 = projs_full(1:2, pt_ok, 4);        
            projs_full_1 = projs_full(1:2, pt_rev_ok, 1);        
            projs_full_2 = projs_full(1:2, pt_rev_ok, 2);  
            
            %triangulate all features, for testing
            pts3d = zeros(3, N);
            pts3d_reversed = zeros(3, N);
            lpts3d = zeros(6, N);
            lpts3d_reversed = zeros(6, N);
            for pii = 1:N            
                %pts3d(:, pii) = resolve_point(eye(3), zeros(3,1), eye(3), t2, projs_full_true(:, pii, 1), projs_full_true(:, pii, 2));
                pts3d(:, pii) = resolve_point(eye(3), zeros(3,1), eye(3), t2, projs_full(:, pii, 1), projs_full(:, pii, 2));
                pts3d_reversed(:, pii) = resolve_point(eye(3), zeros(3,1), eye(3), t2, projs_full(:, pii, 3), projs_full(:, pii, 4));
                %[X1, X2] = resolve_line(eye(3), zeros(3,1), eye(3), t2, lprojs_full_true(:, pii, 1), lprojs_full_true(:, pii, 2));
                [X1, X2] = resolve_line(eye(3), zeros(3,1), eye(3), t2, lprojs_full(:, pii, 1), lprojs_full(:, pii, 2));
                if (length(X1) == 3)
                    lpts3d(1:3, pii) = X1;
                    lpts3d(4:6, pii) = X2;
                    ln_ok(pii) = true;
                end
                [X1, X2] = resolve_line(eye(3), zeros(3,1), eye(3), t2, lprojs_full(:, pii, 3), lprojs_full(:, pii, 4));
                if (length(X1) == 3)
                    lpts3d_reversed(1:3, pii) = X1;
                    lpts3d_reversed(4:6, pii) = X2;            
                    ln_rev_ok(pii) = true;
                end
            end
            
            pts3d = pts3d(:, pt_ok);
            pts3d_reversed = pts3d_reversed(:, pt_rev_ok);


            %probability of an outlier match
            O = 0.5;            
            %target probability of success
            p = 0.999;
            %minimal feature set
            s = 12;
            %threshold
            pt_thr = 10*5.99*(pix_noise/fpix)^2;
            ln_thr = 10*5.99*(pix_noise/fpix)^2;
            for mi = 1:length(ml)
                fprintf('method %d \n', mi);
                t_start = tic;
                if (ml(mi).is_min)
                    s = 9;
                else
                    s = 12;
                end
                TN = log(1-p) / log (1 - (1-O)^s);
                ti = 0;
                consensus_best = 0;
                R_f = eye(3);
                t_f = zeros(3,1);
                pt_inliers_1 = [];
                pt_inliers_2 = [];
                pt_inliers_3 = [];
                pt_inliers_4 = [];                
                ln_inliers_1 = [];
                ln_inliers_2 = [];
                ln_inliers_3 = [];
                ln_inliers_4 = [];
                
                while (ti < TN)
                    ftypes = zeros(3, 1);
                    for fi = 1:3
                        if (~ml(mi).is_pt_only && rand > 0.5)
                        %line 
                            ftypes(fi) = 2;
                        else
                        %point
                            ftypes(fi) = 1;
                        end
                    end
                    n_lines = length(find(ftypes==2));
                    lprojs = zeros(3, n_lines, 4);
                    vis_l = zeros(n_lines, 4);
                    n_pts = length(find(ftypes==1));
                    projs = zeros(3, n_pts, 4);
                    vis_p = zeros(n_pts, 4);                   
%                     N
%                     n_pts
                    pt_inds = select_rand_features(N, n_pts);
                    [projs, vis_p, io_pt] = select_projs_by_inds(projs_full, pt_inds, projs, vis_p, ml(mi).is_min, outlier_pt_ids);
                    ln_inds = select_rand_features(N, n_lines);
                    [lprojs, vis_l, io_ln] = select_projs_by_inds(lprojs_full, ln_inds, lprojs, vis_l, ml(mi).is_min, outlier_ln_ids);
                    
                    is_pt_rect = check_points_rectify(projs, vis_p, 1.5/fpix);
                    if (~is_pt_rect)                        
                        continue;
                    end

                    if (ml(mi).is_pt_only)
                        if (ml(mi).is_min)
                            [R_ans, t_ans] = ml(mi).run(projs, vis_p);
                        else
                            [R_ans, t_ans] = ml(mi).run(projs);
                        end;
                    else
                        if (ml(mi).is_min)
                            [R_ans, t_ans] = ml(mi).run(projs, lprojs, vis_p, vis_l);
                        else
                            [R_ans, t_ans] = ml(mi).run(lprojs, projs);
                        end
                    end                        
%                    [index_best, y, Rf, tf] = model.choose_best(Rs(:, :, 3), ts(:, 3), R_ans, t_ans);           
%                    pt_good_3 = check_reproj_err_pt(Rf, tf, pts3d, projs_full(1:2, :, 3), pt_thr, N);
%                    ln_good_3 = check_reproj_err_ln(Rf, tf, lpts3d, lprojs_full(:, :, 3), ln_thr, N);
                    n_sol = 0;
                    if (length(size(R_ans)) > 2)
                        n_sol = size(R_ans, 3);
                    else
                        n_sol = size(R_ans, 1)/3;
                    end
                    for si = 1:n_sol
                        R = eye(3);
                        if (length(size(R_ans)) > 2)
                            R = R_ans(:, :, si);
                        else
                            R = R_ans(3*si-2:3*si, :);
                        end
                        t = t_ans(:, si);
                        
                        pt_good_3 = check_reproj_err_pt(R, t, pts3d, projs_full_3, pt_thr, sum(pt_ok));
                        pt_good_4 = check_reproj_err_pt(R, t+t2, pts3d, projs_full_4, pt_thr, sum(pt_ok));
                        pt_good_1 = check_reproj_err_pt(R', -R'*t, pts3d_reversed, projs_full_1, pt_thr, sum(pt_rev_ok));
                        pt_good_2 = check_reproj_err_pt(R', -R'*t+t2, pts3d_reversed, projs_full_2, pt_thr, sum(pt_rev_ok));

                        ln_good_3 = check_reproj_err_ln(R, t, lpts3d, lprojs_full(:, :, 3), ln_thr, N);
                        ln_good_4 = check_reproj_err_ln(R, t+t2, lpts3d, lprojs_full(:, :, 4), ln_thr, N);
                        ln_good_1 = check_reproj_err_ln(R', -R'*t, lpts3d_reversed, lprojs_full(:, :, 3), ln_thr, N);
                        ln_good_2 = check_reproj_err_ln(R', -R'*t+t2, lpts3d_reversed, lprojs_full(:, :, 3), ln_thr, N);
                        
                        n_consensus_1 = sum(pt_good_3) + sum(pt_good_4) + sum(ln_good_3) + sum(ln_good_4);
                        n_consensus_2 = sum(pt_good_1) + sum(pt_good_2) + sum(ln_good_1) + sum(ln_good_2);
                        n_consensus = n_consensus_1 + n_consensus_2;
                        n_test_features = sum(pt_ok)+sum(pt_rev_ok) + 2*N;
                        if (n_consensus / (n_test_features) > 1-O)
                            
                            O = 1-n_consensus / (n_test_features);
                            TN = log(1-p) / log (1 - (1-O)^s);
                        end
                        if (n_consensus > consensus_best)
                            consensus_best = n_consensus;
                            R_f = R;
                            t_f = t;
                            pt_inliers_3 = pt_good_3;
                            pt_inliers_4 = pt_good_4;
                            pt_inliers_1 = pt_good_1;
                            pt_inliers_2 = pt_good_2;
                            ln_inliers_3 = ln_good_3;
                            ln_inliers_4 = ln_good_4;
                            ln_inliers_1 = ln_good_1;
                            ln_inliers_2 = ln_good_2;
                        end                                               
                    end
                    if (mod(ti,100) == 0)
                        fprintf('   it  %d / %d \n', ti, TN);
                    end
                    ti = ti+1;
                end
                   
                t_fin = toc(t_start);
                y_fin = [-1 -1];
                if (do_nl)
                    fprintf('nl \n');
                    pt_inliers{1} = pt_inliers_1;
                    pt_inliers{2} = pt_inliers_2;
                    pt_inliers{3} = pt_inliers_3;
                    pt_inliers{4} = pt_inliers_4;
                    ln_inliers{1} = ln_inliers_1;
                    ln_inliers{2} = ln_inliers_2;
                    ln_inliers{3} = ln_inliers_3;
                    ln_inliers{4} = ln_inliers_4;
                    lpts_full = zeros(size(lpprojsh, 2)/2, 16);
                    for ci = 1:4
                        for li = 1:size(lpprojsh, 2)/2
                            lpts_full(li, 4*ci-3:4*ci-2) = lpprojsh(1:2, 2*li-1, ci)';
                            lpts_full(li, 4*ci-1:4*ci) = lpprojsh(1:2, 2*li, ci)';
                        end
                    end
                    %Tfin = run_nl_after_ransac(R_f, t_f, pt_inliers, pt_ok, pt_rev_ok, ln_inliers, projs_full, lpts_full);                    
                    Tfin = run_nl_after_ransac(R_f, t_f, pt_inliers, pt_ok, pt_rev_ok, ln_inliers, projs_full, lpts_full);
%                     Tfin = inv(Tfin);
                    [index_best, y_fin, Rff, tff] = model.choose_best(Rs(:, :, 3), ts(:, 3), Tfin(1:3,1:3), Tfin(1:3, 4));     
                end                                                
                
                [index_best, y, Rf, tf] = model.choose_best(Rs(:, :, 3), ts(:, 3), R_f, t_f);           
                if (length(y) > 0 && (y(1)) == 0 )
                    y
                end
                ml(mi).r(i, out_rat_it) = y(1);
                ml(mi).t(i, out_rat_it) = y(2);
                ml(mi).it(i, out_rat_it) = TN;
                ml(mi).time(i, out_rat_it) = t_fin;
                ml(mi).rf(i, out_rat_it) = y_fin(1);
                ml(mi).tf(i, out_rat_it) = y_fin(2);
                
            end
        end
        save('ransac_cvpr.mat');
    end
    
    

end

function [projs_full, outlier_pt_ids] = generate_outliers(N, out_rat, projs_full)
    outlier_pt_ids = zeros(N, 4);
    while (sum(outlier_pt_ids(:)) < out_rat * 4 * N)
        outlier_pt_ids(randi(N),randi(4)) = 1;
    end        
    out_pt_inds = find(outlier_pt_ids);
    for oi = 1:length(out_pt_inds)        
        [pti, ci] = ind2sub(size(outlier_pt_ids), out_pt_inds(oi));
        projs_full(:, pti, ci) = rand(3, 1);        
    end
end

function pt_inds = select_rand_features(N, n_pts)
    pt_ids = zeros(N, 1);                    
    while (sum(pt_ids) < n_pts)
        pt_ids(randi(N)) = 1;
    end
    pt_inds = find(pt_ids);
end

function [projs, vis_p, io] = select_projs_by_inds(projs_full, pt_inds, projs, vis_p, is_min, outlier_ids)
    io = zeros(size(vis_p, 1), 1);
    for pi = 1:size(vis_p, 1)
        if (is_min)
            c_no = randi(4);
            for ci = 1:4
                if (c_no == ci)
                    continue;
                end
                projs(:, pi, ci) =  projs_full(:, pt_inds(pi), ci);
                vis_p(pi, ci) = 1;
                if (outlier_ids(pt_inds(pi), ci) == 1)
                    io(pi) = 1;
                end
            end
        else
            for ci = 1:4
                projs(:, pi, ci) =  projs_full(:, pt_inds(pi), ci);
                if (outlier_ids(pt_inds(pi), ci) == 1)
                    io(pi) = 1;
                end
            end
        end
    end
end

function pt_good = check_reproj_err_pt(R, t, pts3d, projs, pt_thr, N)
    pts3d_3 = R*pts3d + repmat(t, 1, N);
    pts3d_3p = pts3d_3 (1:2, :) ./ repmat(pts3d_3(3, :), 2, 1);
    dp3 = pts3d_3p - projs;
    dp3 = sqrt(dp3(1,:).^2 + dp3(2,:).^2);
    pt_good = (dp3 < sqrt(pt_thr));
end

function ln_good = check_reproj_err_ln(R, t, lpts3d, lprojs, ln_thr, N)
    lpts3d_1 = R*lpts3d(1:3,:) + repmat(t, 1, N);
    lpts3d_2 = R*lpts3d(4:6,:) + repmat(t, 1, N);
    lpts3d_1p = lpts3d_1 (1:3, :) ./ repmat(lpts3d_1(3, :), 3, 1);
    lpts3d_2p = lpts3d_2 (1:3, :) ./ repmat(lpts3d_2(3, :), 3, 1);
    errs = zeros(size(lpts3d, 2), 1);
    for li = 1:size(lpts3d, 2)
        errs(li) = sqrt( (lprojs(:, li)'*lpts3d_1p(:, li))^2 +(lprojs(:, li)'*lpts3d_2p(:, li))^2 );
    end    
    ln_good = (errs < sqrt(ln_thr));
end

function ret_fin = check_points_rectify(projsh, vis_p, thr)
    ret_fin = true;
    for i = 1:size(vis_p, 1)
        d = 0;
        if (sum(vis_p(i, 1:2))==2)
            d = abs(projsh(2, i, 1)-projsh(2, i, 2));
        else
            d = abs(projsh(2, i, 3)-projsh(2, i, 4));
        end
        if (d > thr)
            ret_fin = false;
        end
    end    
end
