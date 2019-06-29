function [eqs, true_roots] = generate_notensor3_real(cfg, eq, known, unknown) 
    fprintf('start\n');    

    case_num = 4;
    is_4_std = false;
    
%     projs1 = rand(2, 3);
%     R2 = eye(3);
%     %generate_cam(prime_num);
%     
%     [R3,at,bt,ct,dt] = model.generate_cam();  
%     
% %     t2 = randi(100, 3, 1);
%     t2 = [1;0;0];
%     t3 = rand(3, 1);
%     ts(:, 2) = t2;
%     ts(:, 3) = t3;    
%     R4 = R2*R3;
%     t4 = R2*t3+t2;
%     Rs(:, :, 2) = R2;
%     Rs(:, :, 3) = R3;
%     Rs(:, :, 1) = eye(3);
%     Rs(:, :, 4) = R4;
%     ts(:, 4) = t4;
% 
%     pt3d = repmat(rand(1,3), 3, 1).*[projs1; 1 1 1];
%     for cam_i = 1:4
%         pr_i = Rs(:, :, cam_i)*pt3d + repmat(ts(:, cam_i), 1, 3);
%         for j = 1:3                       
%             projs(:, j, cam_i) = pr_i(1:2, j)/pr_i(3, j);
%         end
%     end
%     projsh = projs;
%     projsh(3, :) = 1;
%     
%     
%     lprojs1 = rand(2, 4);
%     lpt3d = repmat(rand(1,4), 3, 1).*[lprojs1; 1 1 1 1];
%     for cam_i = 2:4
%         pr_i = Rs(:, :, cam_i)*lpt3d + repmat(ts(:, cam_i), 1, 4);
%         for j = 1:4
%             lpprojs(:, j, cam_i) = pr_i(1:2, j)/pr_i(3, j);
%         end
%     end
%     lpprojs(:, :, 1) = lprojs1;
%     lpprojsh = lpprojs;
%     lpprojsh(3, :) = 1;
%     
%     for cam_i = 1:4
%         for li = 1:2
%             for j = 1:2
%                 lprojs(:, li, cam_i) = cross(lpprojsh(:, 2*li-1, cam_i), lpprojsh(:, 2*li, cam_i));
%             end
%         end
%     end
    
    fpix = 500;
    pix_noise = 0.00;
    rotrad = 0.18;
    cur_tlen = 6.3;
    [Rs, ts, projs, lprojs, lpprojsh, pts3d, lpt3d] = model.setup_stereo_scene_full(cur_tlen, rotrad, pix_noise, fpix);
    q = util.rot2quat(Rs(:, :, 3));
    at = q(1);
    bt = q(2);
    ct = q(3);
    dt = q(4);
    
%     t3_new = ts(:, 3) - Rs(:,:,3)*pts3d;    
%     alpha_true = t3_new(3);
    if (case_num == 1)
        vis_p = zeros(2, 4);
        vis_p(1, 1:3) = 1;
        vis_p(2, 1:2) = 1;
        vis_p(2, 2+2) = 1;

        vis_l = zeros(1, 4);
        vis_l(1, 3:4) = 1;
        vis_l(1, 2) = 1;
    end
    if (case_num == 2)
        vis_p = zeros(2, 4);
        vis_p(1, 1:3) = 1;
        vis_p(2, 3:4) = 1;
        vis_p(2, 2) = 1;

        vis_l = zeros(1, 4);
        vis_l(1, 1:2) = 1;
        vis_l(1, 4) = 1;
    end
    if (case_num == 3)
        vis_p = zeros(3, 4);
        vis_p(1, 1:3) = 1;
        vis_p(2, [1 2 4]) = 1;        
        vis_p(3, [2 3 4]) = 1;

        vis_l = zeros(0, 4);
    end

    if (case_num == 4)
        vis_p = [1 1 1 0];
        
        vis_l = zeros(2, 4);
        vis_l(1:2, 2:4) = 1;        
    end
    
    if (case_num == 5)
        vis_p = [1 1 1 0];
        
        vis_l = zeros(2, 4);
        vis_l(1, [1 2 4]) = 1;                
        vis_l(2, [2 3 4]) = 1;
    end
    
    if (case_num == 7)
        vis_l = zeros(0, 4);               
        vis_p = [1 1 1 0; 1 1 0 1; 1 1 0 1];                
    end
    
    if (case_num == 8)
        vis_l = [1 1 0 1];               
        vis_p = [1 1 1 0; 1 1 0 1];                
    end    
    
    if (case_num == 9)
        vis_l = zeros(2, 4);               
        vis_p = zeros(1, 4);
        vis_p(1, 1:3) = 1;                              

        vis_l(1:2, 1:2) = 1;
        vis_l(1, 4) = 1;
        vis_l(2, 3) = 1;
    end          
    
    [projs, lprojs] = clean_projs(projs, vis_p, lprojs, vis_l);
    R2 = eye(3);
    t2 = [1;0;0];
    alpha_true = get_alpha_true(Rs, ts, projs);
%     R3 = Rs(:,:,3);
%     t3 = ts(:, 3);
%     pt3d1 = resolve_point(eye(3), zeros(3, 1), R2, t2, [projs(1:2, 1, 1); 1], [projs(1:2, 1, 2); 1]);
%     shift_3d = -pt3d1;        
%     t3e_dir = [projs(1:2, 1, 3); 1];
%     t3_new = t3 - R3*shift_3d;
%     alpha_true = t3_new(3);
    
    [A,B, case_num, ip_num, ind1, ind2] = buildAB2(projs,t3e_dir,R3, t3, shift_3d, lpt3d, lprojs, vis_p, vis_l, R2, t2);
    
    

    pvec2 = [R3(:); alpha_true*R3(:); 1];
        
    pvec = [R3(:); alpha_true; 1];
    if (ip_num(ind1) == 1)
        A*pvec
    else
        A*pvec2
    end
    if (ip_num(ind2) == 1)
        B*pvec
    else
        B*pvec2
    end
    
    if (case_num == 4 && is_4_std)
        a_free = A(1,:)-A(2,:);
        b_free = B(1,:)-B(2,:);
        A1 = [a_free; b_free];
        B1 = [A(1,:)+A(2,:); B(1,:)+B(2,:)];
        A = A1(:, 1:11);
        B = B1;
        ip_num(ind1) = 1;
    end
        
    syms e a b c d  real;
    
    R3sym = [a^2+b^2-c^2-d^2, 2*b*c-2*a*d, 2*b*d+2*a*c;
        2*b*c+2*a*d, a^2-b^2+c^2-d^2, 2*c*d-2*a*b;
        2*b*d-2*a*c, 2*c*d+2*a*b, a^2-b^2-c^2+d^2];
    quat_scale = a^2+b^2+c^2+d^2;
    r3 = R3sym(:);
        
    if (ip_num(ind1) == 1)
        eqs(1:2) = A*[r3; e; 1];
        if (norm(A(:, end)) > 0)
            fprintf('1:2: r3 e 1\n');
        else
            fprintf('1:2: r3 e\n');
        end
    else
        eqs(1:2) = A*[r3; e*r3; 1];
        fprintf('1:2: r3 e*r3 1\n');
    end
    if (ip_num(ind2) == 1)
        eqs(3:4) = B*[r3; e; 1];
        fprintf('3:4: r3 e 1\n');
    else
        eqs(3:4) = B*[r3; e*r3; 1];
        fprintf('3:4: r3 e*r3 1\n');
    end
    eqs(5) = quat_scale - 1;
    
    true_roots = [bt; ct; dt; at; alpha_true];
end

% function [R,a,b,c,d] = generate_cam(prime_num)
%     a = randi(100);
%     b = randi(100);
%     c = randi(100);
%     d = randi(100);
%     R = mod([a^2+b^2-c^2-d^2, 2*b*c-2*a*d, 2*b*d+2*a*c;
%         2*b*c+2*a*d, a^2-b^2+c^2-d^2, 2*c*d-2*a*b;
%         2*b*d-2*a*c, 2*c*d+2*a*b, a^2-b^2-c^2+d^2], prime_num);
%     R = mod(R*fp.inverse(a^2+b^2+c^2+d^2, prime_num), prime_num);
% end


function [A,B, case_num, ip_num, ind1, ind2] = buildAB2_mod(projs,t3e_dir,R3, t3, shift_3d, lpt3d, lprojs, vis_p, vis_l, R2, t2, prime_num)

    [feat_type, ip_num, feat_ind] = find_feature_classes(vis_p, vis_l);
    
    ind1 = 1;
    ind2 = 2;
    if (ip_num(ind1) == 2)
        ind1 = 2;
        ind2 = 1;
    end
    
    t3_new = t3 - R3*shift_3d;    
    
    if (feat_type(ind1) == 1)
        A = build_mat_for_pt_mod(ip_num(ind1), vis_p(feat_ind(ind1), :), R2, t2, shift_3d, projs(:, feat_ind(ind1), :), t3e_dir, prime_num);
    else
        A = build_mat_for_ln_mod(ip_num(ind1), vis_l(feat_ind(ind1), :), R2, t2, shift_3d, lprojs(:, feat_ind(ind1), :), t3e_dir, R3, t3, prime_num, t3_new);
    end
    
    
    alpha_true = t3_new(3);
    
    pvec = [R3(:); alpha_true; 1];
    
    pvec2 = [R3(:); alpha_true*R3(:); 1];
%     A*pvec2
    
    lpt3d_new = lpt3d + repmat(shift_3d, 1, 4);
    lp3d_c3 = R3*lpt3d_new + repmat(t3_new, 1, 4);
    
    if (feat_type(ind2) == 1)
        B = build_mat_for_pt_mod(ip_num(ind2), vis_p(feat_ind(ind2), :), R2, t2, shift_3d, projs(:, feat_ind(ind2), :), t3e_dir, prime_num);
    else
        B = build_mat_for_ln_mod(ip_num(ind2), vis_l(feat_ind(ind2), :), R2, t2, shift_3d, lprojs(:, feat_ind(ind2), :), t3e_dir, R3, t3, prime_num);
    end
                
    
       
    if (feat_type(1) == 1 && feat_type(2) == 2)
        if (ip_num(1) == 1 && ip_num(2) == 2)
            case_num = 1;
        else
            case_num = 2;
        end
    end
    if (feat_type(1) == 1 && feat_type(2) == 1)
        case_num = 3;
    end
    if (feat_type(1) == 2 && feat_type(2) == 2)
        if (ip_num(1) == 2 && ip_num(2) == 2)
            case_num = 4;
        else
            case_num = 5;
        end
    end
end

function A = build_mat_for_pt_mod(ip_num, vis_p_row, R2, t2, shift_3d, projs, t3e_dir, prime_num)
    if (ip_num == 1)
        p3d1_c1 = resolve_point_mod(eye(3), zeros(3, 1), R2, t2, [projs(:, 1, 1); 1], [projs(:, 1, 2); 1], prime_num);
        p3d1_c1 = mod(p3d1_c1 + shift_3d, prime_num);
        ci3 = 3;
        if (vis_p_row(4) == 1)
            ci3 = 4;
        end
    else
        p3d1_c1 = resolve_point_mod(eye(3), zeros(3, 1), R2, t2, [projs(:, 1, 3); 1], [projs(:, 1, 4); 1], prime_num);
        ci3 = 1;
        if (vis_p_row(2) == 1)
            ci3 = 2;
        end        
    end
        
    if (ip_num == 1)
        A(1, [1 4 7]) = p3d1_c1;
        A(1, [3 6 9]) = -projs(1, 1, ci3)*p3d1_c1;
        A(1, 10) = t3e_dir(1)-projs(1, 1, ci3) ;
        A(1, 11) = 0;%
        A(2, [2 5 8]) = p3d1_c1;
        A(2, [3 6 9]) = -projs(2, 1, ci3)*p3d1_c1;
        A(2, 10) = t3e_dir(2)-projs(2, 1, ci3) ;
        A(2, 11) = 0;%
    else
        A(1, 1:3) = p3d1_c1;
        A(1, 7:9) = -projs(1, 1, ci3)*p3d1_c1;
        A(1, 10:12) = -t3e_dir;
        A(1, 16:18) = projs(1, 1, ci3)*t3e_dir;
        A(1, 19) = -shift_3d(1)+projs(1, 1, ci3)*shift_3d(3);    
        A(2, 4:6) = p3d1_c1;
        A(2, 7:9) = -projs(2, 1, ci3)*p3d1_c1;
        A(2, 13:15) = -t3e_dir;
        A(2, 16:18) = projs(2, 1, ci3)*t3e_dir;     
        A(2, 19) = -shift_3d(2)+projs(2, 1, ci3)*shift_3d(3);

    end
    
    if (ip_num == 1 && ci3 == 4)
        A(1, 11) = t2(1) - projs(1, 1, ci3)*t2(3);
        A(2, 11) = t2(2) - projs(2, 1, ci3)*t2(3);
    end
    if (ip_num == 2 && ci3 == 2)
        A(1, 19) = A(1, 19) + t2(1) - projs(1, 1, ci3)*t2(3);
        A(2, 19) = A(2, 19) + t2(2) - projs(2, 1, ci3)*t2(3);
    end
    
    A = mod(A, prime_num);
end


function B = build_mat_for_ln_mod(ip_num, vis_l_row, R2, t2, shift_3d, lprojs, t3e_dir, R3, t3, prime_num, t3_new)
    if (ip_num == 2)
        lproj1 = lprojs(:, 1, 3);
        lproj2 = lprojs(:, 1, 4);
        if (vis_l_row(1, 1) == 1)
            ci = 1;
        else
            ci = 2;
        end
    end
    if (ip_num == 1)
        lproj1 = lprojs(:, 1, 1);
        lproj2 = lprojs(:, 1, 2);
        if (vis_l_row(1, 3) == 1)
            ci = 3;
        else
            ci = 4;
        end
        
    end
    [X1, X2] = resolve_line_mod(eye(3), zeros(3, 1), R2, t2, lproj1, lproj2, prime_num);
    

    if (ip_num == 2)
        for i = 1:3
            for j = 1:3
                B(1, 3*(i-1)+j) = lprojs(i, 1, ci)*X1(j);
                B(2, 3*(i-1)+j) = lprojs(i, 1, ci)*X2(j);  
                B(1, 9+3*(i-1)+j) = lprojs(i, 1, ci)*(-t3e_dir(j));
                B(2, 9+3*(i-1)+j) = lprojs(i, 1, ci)*(-t3e_dir(j));
            end
        end
        B(1, 19) = -lprojs(:, 1, ci)'*shift_3d;
        B(2, 19) = B(1, 19);

        if (ci == 2)
            B(1,19) = B(1, 19) + lprojs(:, 1, ci)'*t2;
            B(2,19) = B(2, 19) + lprojs(:, 1, ci)'*t2;
        end
    else
        
        X1 = mod(X1 + shift_3d, prime_num);
        X2 = mod(X2 + shift_3d, prime_num);
        for i = 1:3
            for j = 1:3
                B(1, 3*(j-1)+i) = lprojs(i, 1, ci)*X1(j);
                B(2, 3*(j-1)+i) = lprojs(i, 1, ci)*X2(j);  
            end
        end        
        B(1, 10) = lprojs(:, 1, ci)'*t3e_dir;
        B(2, 10) = lprojs(:, 1, ci)'*t3e_dir;                             
        
        if (ci == 4)
            B(1, 11) = lprojs(:, 1, ci)'*t2;
            B(2, 11) = B(1, 11);
        else
            B(:, 11) = 0;
        end
    end
    
%     mod(B(1, 1:9)*R3(:), prime_num)
%     mod(lprojs(:, 1, 4)'*R3*X1, prime_num)
%     mod(lprojs(:, 1, 3)'*(R3*X1+t3_new), prime_num)
    B = mod(B, prime_num);
end

function [A,B, case_num, ip_num, ind1, ind2] = buildAB2(projs,t3e_dir,R3, t3, shift_3d, lpt3d, lprojs, vis_p, vis_l, R2, t2)

    [feat_type, ip_num, feat_ind, ind1, ind2] = find_feature_classes(vis_p, vis_l);
    
    
    if (feat_type(ind1) == 1)
        A = build_mat_for_pt(ip_num(ind1), vis_p(feat_ind(ind1), :), R2, t2, shift_3d, projs(:, feat_ind(ind1), :), t3e_dir);
    else
        A = build_mat_for_ln(ip_num(ind1), vis_l(feat_ind(ind1), :), R2, t2, shift_3d, lprojs(:, feat_ind(ind1), :), t3e_dir, R3, t3);
    end
    
    t3_new = t3 - R3*shift_3d;    
    alpha_true = t3_new(3);
    
    pvec = [R3(:); alpha_true; 1];    
    
    pvec2 = [R3(:); alpha_true*R3(:); 1];
%     
%     if (ip_num(ind1) == 1)
%         A*pvec
%     else
%         A*pvec2
%     end
%     A*pvec2
    
%     lpt3d_new = lpt3d + repmat(shift_3d, 1, 4);
%     lp3d_c3 = R3*lpt3d_new + repmat(t3_new, 1, 4);
    
    if (feat_type(ind2) == 1)
        B = build_mat_for_pt(ip_num(ind2), vis_p(feat_ind(ind2), :), R2, t2, shift_3d, projs(:, feat_ind(ind2), :), t3e_dir);
    else
        B = build_mat_for_ln(ip_num(ind2), vis_l(feat_ind(ind2), :), R2, t2, shift_3d, lprojs(:, feat_ind(ind2), :), t3e_dir, R3, t3);
    end
                
%     if (ip_num(2) == 2)
%         B*pvec2
%     else
%         B*pvec
%     end
       
    if (feat_type(1) == 1 && feat_type(2) == 2)
        if (ip_num(1) == 1 && ip_num(2) == 2)
            case_num = 1;
        else
            case_num = 2;
        end
    end
    if (feat_type(1) == 1 && feat_type(2) == 1)
        case_num = 3;
    end
    if (feat_type(1) == 2 && feat_type(2) == 2)
        if (ip_num(1) == 2 && ip_num(2) == 2)
            case_num = 4;
        else
            case_num = 5;
        end
    end
    if (length(ip_num) == 2 && ip_num(1) == 1 && ip_num(2) == 1)
        if( feat_type(1) == 1 && feat_type(2) == 1)
            case_num = 7;
        end
        if( feat_type(1) == 1 && feat_type(2) == 2)
            case_num = 8;
        end
        if (feat_type(1) == 2 && feat_type(2) == 2)
            case_num = 9;
        end
    end
end



function A = build_mat_for_pt(ip_num, vis_p_row, R2, t2, shift_3d, projs, t3e_dir)
    if (ip_num == 1)
        p3d1_c1 = resolve_point(eye(3), zeros(3, 1), R2, t2, [projs(:, 1, 1); 1], [projs(:, 1, 2); 1]);
        p3d1_c1 = p3d1_c1 + shift_3d;
        ci3 = 3;
        if (vis_p_row(4) == 1)
            ci3 = 4;
        end
    else
        p3d1_c1 = resolve_point(eye(3), zeros(3, 1), R2, t2, [projs(:, 1, 3); 1], [projs(:, 1, 4); 1]);
        ci3 = 1;
        if (vis_p_row(2) == 1)
            ci3 = 2;
        end        
    end
        
    if (ip_num == 1)
        A(1, [1 4 7]) = p3d1_c1;
        A(1, [3 6 9]) = -projs(1, 1, ci3)*p3d1_c1;
        A(1, 10) = t3e_dir(1)-projs(1, 1, ci3) ;
        A(1, 11) = 0;%
        A(2, [2 5 8]) = p3d1_c1;
        A(2, [3 6 9]) = -projs(2, 1, ci3)*p3d1_c1;
        A(2, 10) = t3e_dir(2)-projs(2, 1, ci3) ;
        A(2, 11) = 0;%
    else
        A(1, 1:3) = p3d1_c1;
        A(1, 7:9) = -projs(1, 1, ci3)*p3d1_c1;
        A(1, 10:12) = -t3e_dir;
        A(1, 16:18) = projs(1, 1, ci3)*t3e_dir;
        A(1, 19) = -shift_3d(1)+projs(1, 1, ci3)*shift_3d(3);    
        A(2, 4:6) = p3d1_c1;
        A(2, 7:9) = -projs(2, 1, ci3)*p3d1_c1;
        A(2, 13:15) = -t3e_dir;
        A(2, 16:18) = projs(2, 1, ci3)*t3e_dir;     
        A(2, 19) = -shift_3d(2)+projs(2, 1, ci3)*shift_3d(3);

    end
    
    if (ip_num == 1 && ci3 == 4)
        A(1, 11) = t2(1) - projs(1, 1, ci3)*t2(3);
        A(2, 11) = t2(2) - projs(2, 1, ci3)*t2(3);
    end
    if (ip_num == 2 && ci3 == 2)
        A(1, 19) = A(1, 19) + t2(1) - projs(1, 1, ci3)*t2(3);
        A(2, 19) = A(2, 19) + t2(2) - projs(2, 1, ci3)*t2(3);
    end
end

function B = build_mat_for_ln(ip_num, vis_l_row, R2, t2, shift_3d, lprojs, t3e_dir, R3, t3)
    if (ip_num == 2)
        lproj1 = lprojs(:, 1, 3);
        lproj2 = lprojs(:, 1, 4);
        if (vis_l_row(1, 1) == 1)
            ci = 1;
        else
            ci = 2;
        end
    else
        lproj1 = lprojs(:, 1, 1);
        lproj2 = lprojs(:, 1, 2);
        if (vis_l_row(1, 3) == 1)
            ci = 3;
        else
            ci = 4;
        end                
    end
    [X1, X2] = resolve_line(eye(3), zeros(3, 1), R2, t2, lproj1, lproj2);
    
    if (ip_num == 2)
        for i = 1:3
            for j = 1:3
                B(1, 3*(i-1)+j) = lprojs(i, 1, ci)*X1(j);
                B(2, 3*(i-1)+j) = lprojs(i, 1, ci)*X2(j);  
                B(1, 9+3*(i-1)+j) = lprojs(i, 1, ci)*(-t3e_dir(j));
                B(2, 9+3*(i-1)+j) = lprojs(i, 1, ci)*(-t3e_dir(j));
            end
        end
        B(1, 19) = -lprojs(:, 1, ci)'*shift_3d;
        B(2, 19) = B(1, 19);

        if (ci == 2)
            B(1,19) = B(1, 19) + lprojs(:, 1, ci)'*t2;
            B(2,19) = B(2, 19) + lprojs(:, 1, ci)'*t2;
        end
    else
        X1 = X1 + shift_3d;
        X2 = X2 + shift_3d;
        for i = 1:3
            for j = 1:3
                B(1, 3*(j-1)+i) = lprojs(i, 1, ci)*X1(j);
                B(2, 3*(j-1)+i) = lprojs(i, 1, ci)*X2(j);  
            end
        end        
        B(1, 10) = lprojs(:, 1, ci)'*t3e_dir;
        B(2, 10) = lprojs(:, 1, ci)'*t3e_dir;                             
        
        if (ci == 4)
            B(1, 11) = lprojs(:, 1, ci)'*t2;
            B(2, 11) = B(1, 11);
        else
            B(1, 11) = 0;
            B(2, 11) = 0;
        end
 
    end
    
    X1_2 = R3'*X1 -R3'*t3 + t2;
%     X1_2'*lprojs(:, 1, 2)
end