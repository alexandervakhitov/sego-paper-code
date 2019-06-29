function [projs, lprojs, t_2s, R] = shift_u(projs, t2, lprojs, vis_p, vis_l)
    u_0 = projs(:, 1, 3);
    if (length(u_0) == 2)
        u_0 = [u_0; 1];
    end
    r_z = u_0 / norm(u_0);
    r_x = cross([1;0;0], r_z);
    r_x = r_x/norm(r_x);
    r_y = cross(r_z, r_x);
    R = [r_x'; r_y'; r_z'];
    %check
    R*u_0;
    %R = eye(3);
    for pi = 1:size(vis_p, 1)
        for ci = 3:4
            if (vis_p(pi, ci)==1)
                p_0 = projs(:, pi, ci);
                if (length(p_0) == 2)
                    p_0 = [p_0; 1];
                end
                p_n = R*p_0;
                p_n = p_n/p_n(3);
                if (size(projs, 1) == 2)
                    projs(:, pi, ci) = p_n(1:2);
                else
                    projs(:, pi, ci) = p_n;
                end
            end
        end        
    end
    for li = 1:size(vis_l, 1)
        for ci = 3:4
            if (vis_l(li, ci)==1)
                lp_0 = lprojs(:, li, ci);
                p_n = R*lp_0;
                p_n = p_n/p_n(3);
                lprojs(:, li, ci) = p_n;
            end
        end        
    end
    t_2s = R*t2;
end