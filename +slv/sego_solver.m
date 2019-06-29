function [R_ans, t_ans] = sego_solver(projs, lprojs, vis_p, vis_l, is_pluecker, is_det_check)

    projs_init = projs;
    lprojs_init = lprojs;
    vis_p_init = vis_p;
    vis_l_init = vis_l;
    
    [changed_cams, changed_views, projs, lprojs, vis_p, vis_l] = slv.check_change_cams(projs, lprojs, vis_p, vis_l);

    k = slv.find_case(vis_p, vis_l);
    if (k >= 6)                        
        [R_ans, t_ans] = polyslv.quadric_solver(projs, lprojs, vis_p, vis_l, is_det_check);
%         projs_mex = zeros(2, 3, 4);
%         np = size(projs, 2);
%         projs_mex(:, 1:np, :) = projs(1:2,:,:);        
%         l_projs_mex = zeros(3, 3, 4);
%         nl = size(lprojs, 2);
%         l_projs_mex(:, 1:nl, :) = lprojs;
%         vis_p_mex = (zeros(3,4));
%         nvp = size(vis_p, 1);
%         vis_p_mex(1:nvp, :) = (vis_p);
%         vis_l_mex = (zeros(3,4));
%         nvl = size(vis_l, 1);
%         vis_l_mex(1:nvl, :) = (vis_l);        
%         [a,b,c] = quadric_solver_mex(projs_mex, l_projs_mex, vis_p_mex, vis_l_mex, is_det_check);
%         n_sol = size(a, 2)/3;
%         R_ans_m = reshape(a, 3, 3, n_sol);
%         t_ans_m = b;
%         a;
    else                
        if (is_pluecker)
            [A, pt_shift] = model.eq_generator_plu_real(projs(1:2,:,:), lprojs, vis_p, vis_l);
            if (length(A) == 0)
                R_ans = [];
                t_ans = [];
                return;
            end
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
%             t0 = tic;
            sols = polyslv.solver_pluecker(M1, M2);%, bt/at,ct/at,dt/at);
%             tof = toc(t0);
%             times = [times; tof];
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
                Rf = slv.build_cam(a,b,c,d);
                v = [a*b, a*c, a*d, b*c, b*d, c*d, a^2, b^2, c^2, d^2];
                e = -(M2*v')\(M1*v');
                tf = projs(:, 1, 3)*e;
                R_ans(:,:,si) = Rf;
                t_ans(:, si) = tf-Rf*pt_shift;
            end                        

            
        end
        if (~is_pluecker)
            %shift is not woring if third projection is identical for some
            %two points
            for pi1 = 1:size(projs, 2)
                for pi2 = pi1+1:size(projs, 2)
                    if (norm(projs(:, pi1, 3) - projs(:, pi2, 3)) == 0)
                        R_ans = [];
                        t_ans = [];
                        return;
                    end
                end
            end
            
            
            t2 = [1;0;0];
            R2 = eye(3);
            [projs1, lprojs1, t_2s, R1] = polyslv.shift_u(projs, [1;0;0], lprojs, vis_p, vis_l);
            pt3d1 = slv.resolve_point(eye(3), zeros(3, 1), R2, t2, [projs1(:, 1, 1)], [projs1(:, 1, 2)]);
            if (length(pt3d1) == 0)
                R_ans = [];
                t_ans = [];
                return;
            end
            shift_3d = -pt3d1;        
            t3e_dir = [projs1(:, 1, 3)];

            [A,B, case_num] = slv.buildAB2(projs1(1:2,:,:),t3e_dir, shift_3d, lprojs1, vis_p, vis_l, R2, t2, t_2s);
            if (case_num<0)
                R_ans = [];
                t_ans = [];
                return;
            end
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
            
            if (sum(isnan(M1f(:)))>0 || sum(isnan(M2f(:)))>0)
                M1f;
            end
            for pi=3:4
                if (norm(M1f(pi,:)) == 0 || norm(M2f(pi,:)) == 0)
                    M1f;
                end
            end
%             t0 = tic;
            [as, bs, cs, ds] = polyslv.solver_full(M1f, M2f, case_num);
%             tof = toc(t0);
%             times2 = [times2; tof];

            R_ans = zeros(3, 3, length(as));
            t_ans = zeros(3, length(as));

            for si = 1:length(as)
                a = as(si);
                b = bs(si);
                c = cs(si);
                d = ds(si);
                Rf = slv.build_cam(a,b,c,d);
                v = [a*b, a*c, a*d, b*c, b*d, c*d, a^2, b^2, c^2, d^2];
                e = -(M2f*v')\(M1f*v');
                t3_f = t3e_dir*e;
                R_ans(:, :, si) = R1'*Rf;                        
                t_ans(:, si) = R1'*t3_f-R1'*Rf*pt3d1;
            end

        end
    end
    
    [R_ans, t_ans] = slv.correct_changed_cams(changed_views , changed_cams, R_ans, t_ans);
    
   
%         projs_mex = zeros(2, 3, 4);
%         np = size(projs, 2);
%         projs_mex(:, 1:np, :) = projs_init(1:2,:,:);        
%         l_projs_mex = zeros(3, 3, 4);
%         nl = size(lprojs, 2);
%         l_projs_mex(:, 1:nl, :) = lprojs_init;
%         vis_p_mex = (zeros(3,4));
%         nvp = size(vis_p, 1);
%         vis_p_mex(1:nvp, :) = (vis_p_init);
%         vis_l_mex = (zeros(3,4));
%         nvl = size(vis_l, 1);
%         vis_l_mex(1:nvl, :) = (vis_l_init);        
%         [a,b,c] = sego_pluecker_mex(projs_mex, l_projs_mex, vis_p_mex, vis_l_mex, is_det_check);
%         n_sol = size(a, 2)/3;
%         R_ans_m = reshape(a, 3, 3, n_sol);
%         t_ans_m = b;    
    
end