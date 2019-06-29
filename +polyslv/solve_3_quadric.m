function [bs, cs, ds] = solve_3_quadric(M, is_det_check, bt, ct, dt)
% v = [ab, ac, ad, bc, bd, cd, a2, b2, c2, d2]
    %divide by a
% v = [b, c, d, bc, bd, cd, 1, b2, c2, d2]
    
    di = -1;
    if (is_det_check)
        det_b = cond(M(:, [9,10,6]));
        det_d = cond(M(:, [9,8,4]));
        det_c = cond(M(:, [8,10,5]));
        dets = [det_b, det_c, det_d];
        det_quality = abs(abs(dets)-1);
        [~,di] = min(det_quality);    
        if (di == 3)
            %cdb -> cbd
            M(:, [1 3 4 6 8 10]) = M(:, [3 1 6 4 10 8]);
        end
        if (di == 2)
            %cdb -> bdc
            M(:, [1 2 5 6 8 9]) = M(:, [2 1 6 5 9 8]);
        end
    end
    A = M(:, [9,10,6]);
    if (rank(A) < 3)
        bs = [];
        cs = [];
        ds = [];
        return;
    end
    C0 = -A\M(:, [2, 3, 7]);
    C1 = -A\M(:, [4, 5, 1]);
    C2 = -A\[zeros(3, 2), M(:, 8)];
%     lhs = [ct^2; dt^2; ct*dt];
%     rhs = (C0 + C1*bt + C2*bt^2)*[ct;dt;1];
%     lhs-rhs
%     b=polyslv.polycoeffs(C0,C1,C2(:,3));
    b = polyslv.polycoeffs2(C0,C1,C2(:,3));
    if (isnan(b))
        b;
    end
    bs_all = roots(b);
    bs = [];
    for i = 1:length(bs_all)
        if (imag(bs_all(i)) == 0)
            bs = [bs; bs_all(i)];
        end 
    end
    cs = zeros(length(bs), 1);
    ds = zeros(length(bs), 1);
    for i = 1:length(bs)
        C = C0 + C1*bs(i) + C2*bs(i)^2;
        [U,S,V] = svd(C);
        ev = V(:, 3);
        cs(i) = ev(1)/ev(3);
        ds(i) = ev(2)/ev(3);
    end
    
    if (is_det_check)
        if (di == 3)
            ds_init = ds;
            ds = bs;
            bs = ds_init;
        end
        if (di == 2)
            cs_init = cs;
            cs = bs;
            bs = cs_init;
        end
    end
end