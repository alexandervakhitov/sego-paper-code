function [R_ans, t_ans] = quat_assf(lprojs, pprojs, at, bt, ct, dt) % , t3true, R3true, at, bt, ct, dt
    
%log (temp)
%     pts_out = fopen('/home/alexander/materials/sego/debug_pra/p_projs', 'w');
%     for i = 1:size(pprojs, 2)
%         for j = 1:size(pprojs, 3)
%             fprintf(pts_out, '%f %f\n', pprojs(1,i,j), pprojs(2,i,j));
%         end
%     end
%     fclose(pts_out);
%     
%     lns_out = fopen('/home/alexander/materials/sego/debug_pra/l_projs', 'w');
%     for i = 1:size(lprojs, 2)
%         for j = 1:size(lprojs, 3)
%             fprintf(lns_out , '%f %f %f\n', lprojs(1,i,j), lprojs(2,i,j), lprojs(3,i,j));
%         end
%     end
%     fclose(lns_out );    

%     CT = [];
%     CR = [];
%     CB = [];
    n_obs = 6*size(lprojs, 2) + 18*size(pprojs, 2);
    CT = zeros(n_obs, 3);
    CR = zeros(n_obs, 9);
    CB = zeros(n_obs, 1);

    for i = 1:size(lprojs, 2)
        l1 = lprojs(:, i, 1);
        l2 = lprojs(:, i, 2);
        l3 = lprojs(:, i, 3);
        l4 = lprojs(:, i, 4);
        
        t_mat = util.cpmat(l1)*(l2*l3');
        r_mat = zeros(3, 9);
        r_mat(1, 1:3) = -l2(1)*l3';
        r_mat(2, 4:6) = -l2(1)*l3';
        r_mat(3, 7:9) = -l2(1)*l3';
        r_mat = util.cpmat(l1)*r_mat;
        %CT = [CT; t_mat];
        %CR = [CR; r_mat];
        %CB = [CB; zeros(3,1)];
        
        CT(6*i-5:6*i-3, :) = t_mat;
        CR(6*i-5:6*i-3, :) = r_mat;
        
        t_mat = util.cpmat(l1)*(l2*l4');
        r_mat = zeros(3, 9);
        r_mat(1, 1:3) = -l2(1)*l4';
        r_mat(2, 4:6) = -l2(1)*l4';
        r_mat(3, 7:9) = -l2(1)*l4';
        r_mat = util.cpmat(l1)*r_mat;
        b_vec = -util.cpmat(l1)*l2*l4(1);
        
%         CT = [CT; t_mat];
%         CR = [CR; r_mat];
%         CB = [CB; b_vec];        
        CT(6*i-2:6*i, :) = t_mat;
        CR(6*i-2:6*i, :) = r_mat;
        CB(6*i-2:6*i, :) = b_vec;
    end
%     r = R3true(:);
%     CR*r+CT*t3true - CB
    n_line = 6*size(lprojs, 2);
    for i = 1:size(pprojs, 2)
        x1 = [pprojs(:,i,1)];
        x2 = [pprojs(:,i,2)];
        x3 = [pprojs(:,i,3)];
        
        x2x = util.cpmat([x2; 1]);
        x3x = util.cpmat([x3; 1]);
        x4x = util.cpmat([pprojs(:,i,4); 1]);
        [CT0, CR0, BT0] = cvpr10.one_point_line(x1, x2x, x3x, 0);
        [CT1, CR1, BT1] = cvpr10.one_point_line(x1, x2x, x4x, 1);
        chinds = [1:9];
        CT0 = CT0(chinds, :);
        CT1 = CT1(chinds, :);
        CR0 = CR0(chinds, :);
        CR1 = CR1(chinds, :);
        BT0 = BT0(chinds);
        BT1 = BT1(chinds);
%         CT = [CT; CT0; CT1];
%         CB = [CB; BT0; BT1];
%         CR = [CR; CR0; CR1];
        CT(n_line + 18*i-17:n_line + 18*i-9, :) = CT0;
        CT(n_line + 18*i-8:n_line + 18*i, :) = CT1;
        CB(n_line + 18*i-17:n_line + 18*i-9, :) = BT0;
        CB(n_line + 18*i-8:n_line + 18*i, :) = BT1;
        CR(n_line + 18*i-17:n_line + 18*i-9, :) = CR0;
        CR(n_line + 18*i-8:n_line + 18*i, :) = CR1;
    end
    
%     r = R3true(:);
%     norm(CR*r+CT*t3true - CB)
    
    A1 = [CT CR -CB];
    [Ar, jb] = slv.frref(A1);    
    
    TM = -Ar(1:3, 4:end);
    
%     ind = 4;
%     while (norm(Ar(ind, :))>0)
%         ind = ind+1;
%     end
%     At = Ar(4:ind-1, 4:end);
    At = A1(:, 1:3)*TM + A1(:, 4:end);
    
    At1 = cvpr10.form_a_t_1(At);
    At1 = [At1; 
          1 1 1 0 0 0 1 0 0 0 -1];
    
    
%     parvec = [ bt^2, ct^2, dt^2, bt*ct, bt*dt, ct*dt, at^2, at*bt, at*ct, at*dt, 1];
%     At1*parvec'
    
    P1 = At1(:, 1:6);
    %At2 = -inv(P1'*P1)*P1'*At1(:, 7:end);
    if (rank(P1) < 6)
        R_ans = [];
        t_ans = [];
        return;
    end
    At2 = -P1\At1(:, 7:end);

%     At2*parvec(7:11)'
    %At2f = At1(:, 1:6)*At2 + At1(:, 7:end);
%     At2f*parvec(7:11)'
%     At1exp = -At1r(1:6, 7:11);
    Cf = cvpr10.build_C_mat(At2);

    [P] = cvpr10.build_polys(Cf);   
%     att = at^2;
%     P*[att^5; att^4; att^3; att^2; att; 1]
    
    rs_all = [];
    pind = 1;
    
    as = [];
    bs = [];
    cs = [];
    ds = [];
    
    
    for i = 1:1
        for j = i+1:i+1
            seln = ones(6,1);
            seln(i) = 0;
            seln(j) = 0;
            inds = find(seln);
            if (sum(isnan(P(pind, :))) > 0)
                P;
            end
            rs = roots(P(pind, :));
            rs = rs(find(imag(rs) ==0));
            rs_p = rs(find(rs>0));                        
            
            rs_i_all = [sqrt(rs_p); -sqrt(rs_p)];
            for k = 1:length(rs_i_all)
                atg = rs_i_all(k);
                Mt = build_mat_for_a(Cf, atg);
                
                [U,S,V] = svd(Mt);
                bcd = V(1:3, 4)/V(4,4);
                
%                 [evec, evals] = eig(Mt(inds, :), 'vector');
%                 eval_inds = find (abs(evals)<1e-9);
%                 if (length(eval_inds) == 1)
%                     my_vec = evec(:, eval_inds);
%                     if (norm(imag(my_vec))) < 1e-9
%                         my_vec = my_vec / my_vec(4);
                        as = [as; atg];
                        bs = [bs; bcd(1)];
                        cs = [cs; bcd(2)];
                        ds = [ds; bcd(3)];
%                     end
%                 end
            end           
            pind = pind+1;
        end
    end
    R_ans = [];
    t_ans = [];
    for i = 1:length(as)
        R3 = util.quat2mat(as(i), bs(i), cs(i), ds(i));
%         t3 = TM*[R3(:); 1];
        %t3 = inv(CT'*CT)*CT'*(-CR*R3(:)+CB);
        t3 = CT\(-CR*R3(:)+CB);
        t_ans = [t_ans t3];
        R_ans = [R_ans; R3];
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