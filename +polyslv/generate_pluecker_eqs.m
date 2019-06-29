function generate_pluecker_eqs_mod(projs, lprojs, vis_p, vis_l, prime_num)
    u = [projs(:, 1, 3); 1];
    pt_shift = resolve_point_mod(eye(3), zeros(3, 1), eye(3), [1;0;0], projs(:, 1, 1), projs(:, 1, 2), prime_num);
    for pi = 2:size(vis_p, 1)
        direct = true;
        stereoshift = false;
        third_proj = projs(:, pi, 3);
        if (sum(vis_p(pi, 3:4))==2)            
            direct = false;                    
            third_proj = projs(:, pi, 1);
        end        
        if (direct && vis_p(pi, 2) == 1 || ~direct && vis_p(pi, 4) == 1)
            stereoshift = true;          
            if (direct)
                third_proj = projs(:, pi, 4);
            else
                third_proj = projs(:, pi, 2);
            end
        end        
        A_pt = generate_epipolar_eqs_mod(projs(:, pi, 1), projs(:, pi, 2), third_proj, pt_shift, u, direct, stereoshift, prime_num);
    end

end