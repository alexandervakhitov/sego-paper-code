function [Rs, ts] = quadric_solver(projs, lprojs, vis_p, vis_l, is_det_check)
    inds = [1 2 3;
            4 5 6;
            7 8 9];
    t2 = [1;0;0];
    
    is_3_lines = false;
    if (size(vis_p, 1) == 0)
        is_3_lines = true;
    end
    
%     global Rtt;
%     global ttt;
%     
    A = [];
    tis = [];
    for pi = 1:size(vis_p, 1)
        ci = 3;
        b = zeros(3, 1);
        if (vis_p(pi, ci) == 0)
            ci = 4;
            b = t2;
        end
        X = slv.resolve_point(eye(3), zeros(3,1), eye(3), [1;0;0], projs(:, pi, 1), projs(:, pi, 2));
        if (length(X) < 3)
            Rs = [];
            ts = [];
            return;
        end
        C = fill_r_mat(X, inds);
        T = eye(3);
        Cfull = [C T b];        
        C2 = [Cfull(1,:) - Cfull(3,:)*projs(1, pi, ci); Cfull(2,:) - Cfull(3,:)*projs(2, pi, ci)];
        A = [A; C2];
        tis = [tis; size(A, 1)-1; size(A, 1)];
    end
    for li = 1:size(vis_l, 1)
        if (is_3_lines)            
            inds_l = [];
            n_cp = zeros(3, 1);            
            ci = -1;
            if (sum(vis_l(li, 1:2)) == 2)
                inds_l = inds;
                n_cp = cross(lprojs(:, li, 1), lprojs(:, li, 2));                
                if (vis_l(li, 3) == 1)
                    ci = 3;
                else
                    ci = 4;
                end
            else
                inds_l = inds';
                n_cp = cross(lprojs(:, li, 3), lprojs(:, li, 4));                
                if (vis_l(li, 1) == 1)
                    ci = 1;
                else
                    ci = 2;
                end
            end            
            leq3 = lprojs(:, li, ci);
            C = fill_r_mat(n_cp, inds_l); 
            A = [A; leq3'*C, 0];
        else
            ci1 = 1;
            ci2 = 2;
            ci3 = 3;
            inds_l = inds;
            b = zeros(3,1);
            if (sum(vis_l(li, 3:4)) == 2)                
                ci1 = 3; 
                ci2 = 4;    
                ci3 = 1;
                inds_l = inds';
                if (vis_l(li, 2) == 1)
                    ci3 = 2;
                    b = t2;
                end
            else
                if (vis_l(li, 4) == 1)
                    ci3 = 4;
                    b = t2;
                end
            end
            [X1, X2] = slv.resolve_line(eye(3), zeros(3,1), eye(3), [1;0;0], lprojs(:, li, ci1), lprojs(:, li, ci2));
            if (length(X1) == 0)
                Rs = [];
                ts = [];
                return;
            end
            Cr1 = fill_r_mat(X1, inds_l);
            Cr2 = fill_r_mat(X2, inds_l);
            l3 = lprojs(:, li, ci3);
            A = [A; 
                l3'*Cr1, l3', l3'*b;
                l3'*Cr2, l3', l3'*b;];
            tis = [tis; size(A, 1)-1];
        end
    end

    T = [];
    if (size(A, 2) > 10)
        rem_inds = [1:9, 13];
        
%         ti = 1;
%         Asel = A(tis(ti), 10:12);
%         tis_seld = [1];
%         while (rank(Asel) < 3)
%             ti = ti+1;
%             if (ti > length(tis))
%                 ti = ti - length(tis);
%             end
%             Atry = [Asel; A(tis(ti), 10:12)];
%             if (rank(Atry) > rank(Asel))
%                 Asel = Atry;
%                 tis_seld  =[tis_seld, ti];
%             end
%         end
        
%         T = -A(tis(tis_seld), 10:12)\A(tis(1:3), rem_inds);
%         ntis = [];
%         for i = 1:6
%             is_fnd = false;
%             for j = 1:length(tis_seld)
%                 if (i == tis(tis_seld(j)))
%                     is_fnd = true;
%                 end
%             end
%             if (~is_fnd)
%                 ntis = [ntis; i];
%             end
%         end
% 
%         A = A(ntis, rem_inds) + A(ntis, 10:12)*T;
         At = A(:, [[10:12], [1:9], 13]);
         Atr = slv.frref(At);
         T = - Atr(1:3, 4:end);
         A = Atr(4:end, 4:end);
    end
    
    if (~is_3_lines)
%         global R_true;
%         global t_true;
% 
%         A*[R_true(:); 1]
%     %     
%         T*[R_true(:); 1]-t_true
    end
    R2Q = slv.build_R2Q();
    C2Q = zeros(1, 10);
    C2Q(1, [7 8 9 10]) = 1;
    Q = [R2Q;
        C2Q]; 
    M_red_q = A*Q;
    
%     global R_true;
%     q=rot2quat(R_true);
%     at=q(1);
%     bt = q(2);
%     ct = q(3);
%     dt = q(4);
    
    [bs, cs, ds] = slv.solve_3_quadric(M_red_q, is_det_check);%, bt/at, ct/at, dt/at);
    
%     [bsm, csm, dsm, ncntm] = solve_3_quad_mex(M_red_q, is_det_check);
    if (length(bs) == 0)
        Rs = [];
        ts = [];
        return;
    end
    
    Rs = zeros(3, 3, length(bs));
    ts = zeros(3, length(bs));
    t_ok = false(length(bs), 1);
    for i = 1:length(bs)
        q = [1;bs(i); cs(i); ds(i)];
        q = q/norm(q);
        R = slv.build_cam(q(1), q(2), q(3), q(4));
        Rs(:, :, i) = R;
        if (is_3_lines)            
%             if (norm(R-Rt)<1e-1)
%                 R;
%             end
            ta = slv.get_t_using_tt(projs, lprojs, vis_p, vis_l, R);                                    
            
            if (length(ta) > 0)
                ts(:, i) = ta;
                t_ok(i) = true;                             
            end
            %ts(:, i)
            %norm(ts(:, i) - tt)
            %tt;
        else
            a = q(1);
            b = q(2);
            c = q(3);
            d = q(4);            
            ts(:, i) = T*[R(:); 1];            
            t_ok(i) = true;
            
%             A*[R(:); 1]
%             T*[R(:); 1]-ts(:,i)
        end
    end
    Rs = Rs(:,:,t_ok);
    ts = ts(:, t_ok);
end

function C = fill_r_mat(X, inds)
    C = zeros(3, 9);
    C(1, inds(:, 1)) = X';
    C(2, inds(:, 2)) = X';
    C(3, inds(:, 3)) = X';
end