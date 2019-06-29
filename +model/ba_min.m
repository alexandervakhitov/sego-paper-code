function [R3e, t3e] = ba_min(projs, lprojs, vis_p, vis_l, R3, t3)
    n_p = size(vis_p, 1);
    n_l = size(vis_l, 1);    
    p3d = zeros(3, n_p);
    l3d = zeros(4, n_l);
    t2 = [1;0;0];
    for pi = 1:size(vis_p, 1)
        if (sum(vis_p(pi, 1:2)) == 2)                        
            [X0, err_sum] = slv.resolve_point(eye(3), zeros(3,1), eye(3), t2, projs(:, pi, 1), projs(:, pi, 2));
            p3d(:, pi) = X0;
        else
            [X0, err_sum] = slv.resolve_point(eye(3), zeros(3,1), eye(3), t2, projs(:, pi, 3), projs(:, pi, 4));
            X0 = R3'*(X0-t3);
            p3d(:, pi) = X0;
        end
    end
    for li = 1:size(vis_l, 1)
        if (sum(vis_l(li, 1:2)) == 2)                        
            [X1, X2, es] = slv.resolve_line(eye(3), zeros(3,1), eye(3), t2, lprojs(:, li, 1), lprojs(:, li, 2));
            l_par = util.encode_line(X1, X2);
            l3d(:, li) = l_par;
        else
            [X1, X2, es] = slv.resolve_line(eye(3), zeros(3,1), eye(3), t2, lprojs(:, li, 3), lprojs(:, li, 4));
            X1 = R3'*(X1-t3);
            X2 = R3'*(X2-t3);
            l_par = util.encode_line(X1, X2);
            l3d(:, li) = l_par;
        end
    end
    x = [slv.rodrigues(R3); t3; p3d(:); l3d(:)];
    xf = lsqnonlin(@(xp)res_ba(xp, projs, lprojs, vis_p, vis_l), x);
    R3e = slv.rodrigues(xf(1:3));
    t3e = xf(4:6);
end

function res_vec = res_ba(x, projs, lprojs, vis_p, vis_l)
    R3 = slv.rodrigues(x(1:3));
    t3 = x(4:6);    
    n_p = size(vis_p, 1);
    n_l = size(vis_l, 1);    
    p3d = reshape(x(7:7+3*n_p-1), 3, n_p);
    l3d = reshape(x(7+3*n_p:end), 4, n_l);
    res_vec = zeros(3*2*(n_p+n_l), 1);
    ind = 1;
    Rs = zeros(3, 3, 4);    
    for ci = 1:4
        if (ci <= 2)
            Rs(:, :, ci) = eye(3); 
        else
            Rs(:, :, ci) = R3; 
        end        
    end
    t2 = [1;0;0];
    ts = [zeros(3,1), t2, t3, t3+t2];
    for pi = 1:n_p
        for ci = 1:4
            if (vis_p(pi, ci) == 1)
                pp = Rs(:,:,ci)*p3d(:, pi)+ts(:, ci);
                pp = pp/pp(3);
                r = pp(1:2)-projs(1:2, pi, ci);
                res_vec(ind:ind+1) = r;
                ind = ind+2;
            end
        end
    end
    for li = 1:n_l
        [X1, X2] = util.decode_line(l3d(:, li));        
        for ci = 1:4
            if (vis_l(li, ci) == 1)
                pp1 = Rs(:,:,ci)*X1+ts(:, ci);
                pp2 = Rs(:,:,ci)*X2+ts(:, ci);                
                pp1 = pp1/pp1(3);
                pp2 = pp2/pp2(3);
                r = [lprojs(:, li, ci)'*pp1; lprojs(:, li, ci)'*pp2];
                res_vec(ind:ind+1) = r;
                ind = ind+2;
            end
        end
    end    
end