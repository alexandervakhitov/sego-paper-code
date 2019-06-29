function cvpr10ext(lprojs, pprojs, vis_p, vis_l, t3true, R3true, at, bt, ct, dt)
    
    CT = [];
    CR = [];
    CB = [];
    for i = 1:size(lprojs, 2)
        l1 = lprojs(:, i, 1);
        l2 = lprojs(:, i, 2);
        l3 = lprojs(:, i, 3);
        l4 = lprojs(:, i, 4);
        
        if (vis_l(i, 3) == 1)
            t_mat = util.cpmat(l1)*(l2*l3');
            r_mat = zeros(3, 9);
            r_mat(1, 1:3) = -l2(1)*l3';
            r_mat(2, 4:6) = -l2(1)*l3';
            r_mat(3, 7:9) = -l2(1)*l3';
            r_mat = util.cpmat(l1)*r_mat;
            CT = [CT; t_mat];
            CR = [CR; r_mat];
            CB = [CB; zeros(3,1)];
        end
        
        if (vis_l(i, 4) == 1)
            t_mat = util.cpmat(l1)*(l2*l4');
            r_mat = zeros(3, 9);
            r_mat(1, 1:3) = -l2(1)*l4';
            r_mat(2, 4:6) = -l2(1)*l4';
            r_mat(3, 7:9) = -l2(1)*l4';
            r_mat = util.cpmat(l1)*r_mat;
            b_vec = -util.cpmat(l1)*l2*l4(1);

            CT = [CT; t_mat];
            CR = [CR; r_mat];
            CB = [CB; b_vec];        
        end
    end
%     r = R3true(:);
%     CR*r+CT*t3true - CB
    
    for i = 1:size(pprojs, 2)
        x1 = [pprojs(:,i,1); 1];
        x2 = [pprojs(:,i,2); 1];
        x3 = [pprojs(:,i,3); 1];
        
        x2x = util.cpmat([x2; 1]);
        x3x = util.cpmat([x3; 1]);
        x4x = util.cpmat([pprojs(:,i,4); 1]);
        
        chinds = [1 3 5];
        
        if (vis_p(i, 3) == 1)
            [CT0, CR0, BT0] = one_point_line(x1, x2x, x3x, 0);
            CT0 = CT0(chinds, :);
            BT0 = BT0(chinds);
            CR0 = CR0(chinds, :);
            CT = [CT; CT0];
            CB = [CB; BT0];
            CR = [CR; CR0];
        end

        if (vis_p(i, 4) == 1)                                    
            [CT1, CR1, BT1] = one_point_line(x1, x2x, x4x, 1);
            CT1 = CT1(chinds, :);        
            CR1 = CR1(chinds, :);        
            BT1 = BT1(chinds);
            CT = [CT; CT1];
            CB = [CB; BT1];
            CR = [CR; CR1];
        end
    end
    
    r = R3true(:);
    norm(CR*r+CT*t3true - CB)
    
    A1 = [CT CR -CB];
    [Ar, jb] = rref(A1);
    
    TM = -Ar(1:3, 4:end);
    
%     ind = 4;
%     while (norm(Ar(ind, :))>0)
%         ind = ind+1;
%     end
%     At = Ar(4:ind-1, 4:end);
    At = A1(:, 1:3)*TM + A1(:, 4:end);
    
    At1 = cvpr10.form_a_t_1(At);
    
    parvec = [ bt^2, ct^2, dt^2, bt*ct, bt*dt, ct*dt, at^2, at*bt, at*ct, at*dt, 1];
    At1*parvec'
    
    P1 = At1(:, 1:6);
    At2 = -pinv(P1'*P1)*P1'*At1(:, 7:end);
    
%     At2*parvec(7:11)'
    At2f = At1(:, 1:6)*At2 + At1(:, 7:end);
    At2f*parvec(7:11)'
%     At1exp = -At1r(1:6, 7:11);
    Cf = cvpr10.build_C_mat(At2);
    
    Mt = zeros(6, 4);
    for i = 1:6
        for j = 1:3
            Mt(i, j) = Cf(i, 2*j-1)*at^3+Cf(i, 2*j)*at;
        end
        Mt(i, 4) = Cf(i, 7)*at^4+Cf(i, 8)*at^2+Cf(i, 9);
    end
    [P] = cvpr10.build_polys(Cf);   
    att = at^2;
    P*[att^5; att^4; att^3; att^2; att; 1]
    
    rs_all = [];
    pind = 1;
    
    as = []
    bs = []
    cs = []
    ds = [];
    for i = 1:1
        for j = i+1:i+1
            seln = ones(6,1);
            seln(i) = 0;
            seln(j) = 0;
            inds = find(seln);
            
            rs = roots(P(pind, :));
            rs = rs(find(imag(rs) ==0));
            rs_p = rs(find(rs>0));                        
            
            rs_i_all = [sqrt(rs_p); -sqrt(rs_p)];
            for k = 1:length(rs_i_all)
                atg = rs_i_all(k);
                Mt = build_mat_for_a(Cf, atg);
                [evec, evals] = eig(Mt(inds, :), 'vector');
                eval_inds = find (abs(evals)<1e-9);
                if (length(eval_inds) == 1)
                    my_vec = evec(:, eval_inds);
                    if (norm(imag(my_vec))) < 1e-9
                        my_vec = my_vec / my_vec(4);
                        as = [as; atg];
                        bs = [bs; my_vec(1)];
                        bs = [cs; my_vec(2)];
                        bs = [ds; my_vec(3)];
                    end
                end
            end
            
            pind = pind+1;
        end
    end
    rs_u = uniquetol(rs_all, 1e-9);
    rs_f = [sqrt(rs_u); -sqrt(rs_u)];
end

function [CT, CR, BT] = one_point_line(x1, x2x, x3x, is_4)
    CT = zeros(9,3);
    CR = zeros(9,9);
    BT = zeros(9, 1);

    for j = 1:3
        r_mat = zeros(3, 9);
        pinds = [1 2 3];
        r_mat(1, pinds) = x3x(:, j);
        r_mat(2, pinds+3) = x3x(:, j);
        r_mat(3, pinds+6) = x3x(:, j);
        r_mat1 = -x2x*[x1'*r_mat; zeros(2, 9)];
        t_mat = x2x*x1*x3x(:,j)';        
        
        CT(3*j-2:3*j, :) = t_mat;
        CR(3*j-2:3*j, :) = r_mat1;
    end
    if (is_4 == 1)
        BM = x2x*[x1 zeros(3, 2)]*x3x;
        BT = -BM(:);
    end
end

function Mt = build_mat_for_a(Cf, at)
    Mt = zeros(6, 4);
    for i = 1:6
        for j = 1:3
            Mt(i, j) = Cf(i, 2*j-1)*at^3+Cf(i, 2*j)*at;
        end
        Mt(i, 4) = Cf(i, 7)*at^4+Cf(i, 8)*at^2+Cf(i, 9);
    end
end