function build_tens_mat
    CT = [];
    CR = [];
    CB = [];
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
        CT = [CT; t_mat];
        CR = [CR; r_mat];
        CB = [CB; zeros(3,1)];
        
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
%     r = R3true(:);
%     CR*r+CT*t3true - CB
    
    for i = 1:size(pprojs, 2)
        x1 = [pprojs(:,i,1); 1];
        x2 = [pprojs(:,i,2); 1];
        x3 = [pprojs(:,i,3); 1];
        
        x2x = util.cpmat([x2; 1]);
        x3x = util.cpmat([x3; 1]);
        x4x = util.cpmat([pprojs(:,i,4); 1]);
        [CT0, CR0, BT0] = one_point_line(x1, x2x, x3x, 0);
        [CT1, CR1, BT1] = one_point_line(x1, x2x, x4x, 1);
        chinds = [1 3 5];
        CT0 = CT0(chinds, :);
        CT1 = CT1(chinds, :);
        CR0 = CR0(chinds, :);
        CR1 = CR1(chinds, :);
        BT0 = BT0(chinds);
        BT1 = BT1(chinds);
        CT = [CT; CT0; CT1];
        CB = [CB; BT0; BT1];
        CR = [CR; CR0; CR1];
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
   
    
    
end