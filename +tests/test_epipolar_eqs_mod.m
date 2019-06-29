function test_epipolar_eqs_mod
    
    prime_num = 32999;
    projs1 = randi(100, 2, 3);
    R2 = eye(3);
    %generate_cam(prime_num);
    
    [R3,at,bt,ct,dt] = model.generate_cam(prime_num);  
    
%     t2 = randi(100, 3, 1);
    t2 = [1;0;0];
    t3 = randi(100, 3, 1);
    ts(:, 2) = t2;
    ts(:, 3) = t3;    
    R4 = mod(R2*R3, prime_num);
    t4 = mod(R2*t3+t2, prime_num);
    Rs(:, :, 2) = R2;
    Rs(:, :, 3) = R3;
    Rs(:, :, 1) = eye(3);
    Rs(:, :, 4) = R4;
    ts(:, 4) = t4;

    pt3d = mod(repmat(randi(100,1,3), 3, 1).*[projs1; 1 1 1], prime_num);
    for cam_i = 1:4
        pr_i = mod(Rs(:, :, cam_i)*pt3d + repmat(ts(:, cam_i), 1, 3), prime_num);
        for j = 1:3                       
            projs(:, j, cam_i) = mod(pr_i(1:2, j)*fp.inverse(pr_i(3, j),prime_num), prime_num);
        end
    end
    projsh = projs;
    projsh(3, :) = 1;
    
    
    lprojs1 = randi(100, 2, 4);
    lpt3d = repmat(randi(100,1,4), 3, 1).*[lprojs1; 1 1 1 1];
    for cam_i = 2:4
        pr_i = mod(Rs(:, :, cam_i)*lpt3d + repmat(ts(:, cam_i), 1, 4), prime_num);
        for j = 1:4
            lpprojs(:, j, cam_i) = mod(pr_i(1:2, j)*fp.inverse(pr_i(3, j), prime_num), prime_num);
        end
    end
    lpprojs(:, :, 1) = lprojs1;
    lpprojsh = lpprojs;
    lpprojsh(3, :) = 1;
    
    for cam_i = 1:4
        for li = 1:2
            for j = 1:2
                lprojs(:, li, cam_i) = mod(cross(lpprojsh(:, 2*li-1, cam_i), lpprojsh(:, 2*li, cam_i)), prime_num);
            end
        end
    end
    
    pt_shift = resolve_point_mod(eye(3), zeros(3,1), eye(3), [1;0;0], projs(:, 1,1), projs(:, 1, 2), prime_num);
    u = [projs(:, 1, 3); 1];
    %direct
    A_pt = model.generate_epipolar_eqs_mod(projs(:, 2,1), projs(:, 2, 2), projs(:, 2, 3), pt_shift, u, true, false, prime_num);
    r = R3(:);
    uscaled = mod(R3*pt3d(:, 1) + ts(:, 3), prime_num);        
    alpha_true = uscaled(3);
    tvec = mod([r; alpha_true*r], prime_num);
    
    A_ln = model.generate_line_pluecker_mod(lprojs(:, 1, 1), lprojs(:, 1, 2), lprojs(:, 1, 3), pt_shift, u, true, false, prime_num);
    fprintf('direct\n');
    mod(A_pt*tvec, prime_num)    
    mod(A_ln*tvec, prime_num)    
    %direct stereo
    A_pt = model.generate_epipolar_eqs_mod(projs(:, 2,1), projs(:, 2, 2), projs(:, 2, 4), pt_shift, u, true, true, prime_num);
    A_ln = model.generate_line_pluecker_mod(lprojs(:, 1, 1), lprojs(:, 1, 2), lprojs(:, 1, 4), pt_shift, u, true, true, prime_num);
    fprintf('direct stereo\n');
    mod(A_pt*tvec, prime_num)
    mod(A_ln*tvec, prime_num)    
    fprintf('indirect\n');
    A_pt = model.generate_epipolar_eqs_mod(projs(:, 2,3), projs(:, 2, 4), projs(:, 2, 1), pt_shift, u, false, false, prime_num);
    A_ln = model.generate_line_pluecker_mod(lprojs(:, 1, 3), lprojs(:, 1, 4), lprojs(:, 1, 1), pt_shift, u, false, false, prime_num);
    mod(A_pt*tvec, prime_num)
    mod(A_ln*tvec, prime_num)
    fprintf('indirect stereo\n');
    A_pt = model.generate_epipolar_eqs_mod(projs(:, 2,3), projs(:, 2, 4), projs(:, 2, 2), pt_shift, u, false, true, prime_num);
    A_ln = model.generate_line_pluecker_mod(lprojs(:, 1, 3), lprojs(:, 1, 4), lprojs(:, 1, 2), pt_shift, u, false, true, prime_num);
    mod(A_pt*tvec, prime_num)
    mod(A_ln*tvec, prime_num)
%     
%     ts(:, 3) 
%     mod(uscaled - R3 * pt_shift, prime_num)
end