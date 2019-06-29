function A = eq_generator_plu_mod(projs, lprojs, vis_p, vis_l, prime_num)
    pt_shift = resolve_point_mod(eye(3), zeros(3,1), eye(3), [1;0;0], projs(:, 1,1), projs(:, 1, 2), prime_num);
    u = [projs(:, 1, 3); 1];
    A = [];
    for pi = 2:size(vis_p, 1)
        [is_direct, is_stereoshift, p1, p2, third_proj] = analyze_case(vis_p, pi, projs);
        A_pt_curr = model.generate_epipolar_eqs_mod(p1, p2, third_proj, pt_shift, u, is_direct, is_stereoshift, prime_num);
        A = [A; A_pt_curr];
    end
    for li = 1:size(vis_l, 1)
        [is_direct, is_stereoshift, lp1, lp2, lp_third] = analyze_case(vis_l, li, lprojs);
        A_ln = model.generate_line_pluecker_mod(lp1, lp2, lp_third, pt_shift, u, is_direct, is_stereoshift, prime_num);
        A = [A; A_ln];
    end
end

function [is_direct, is_stereoshift, p1, p2, third_proj] = analyze_case(vis_p, pi, projs)
    is_direct = false;
    if (sum(vis_p(pi, 1:2)) == 2)
        is_direct = true;
    end
    is_stereoshift = false;
    if (is_direct && vis_p(pi, 4) == 1 || ~is_direct && vis_p(pi, 2) == 1)
        is_stereoshift = true;
    end
    if(is_direct)
        p1 = projs(:, pi, 1);
        p2 = projs(:, pi, 2);
        if (is_stereoshift)
            third_proj = projs(:, pi, 4);
        else
            third_proj = projs(:, pi, 3);
        end
    else
        p1 = projs(:, pi, 3);
        p2 = projs(:, pi, 4);
        if (is_stereoshift)
            third_proj = projs(:, pi, 2);
        else
            third_proj = projs(:, pi, 1);
        end
    end
end