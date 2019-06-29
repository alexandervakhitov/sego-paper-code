function [CT, CR, BT] = one_point_line_mod(x1, x2x, x3x, is_4, prime_num)
    CT = zeros(9,3);
    CR = zeros(9,9);
    BT = zeros(9, 1);

    for j = 1:3
        r_mat = zeros(3, 9);
        pinds = [1 2 3];
        r_mat(1, pinds) = x3x(:, j);
        r_mat(2, pinds+3) = x3x(:, j);
        r_mat(3, pinds+6) = x3x(:, j);
        r_mat = mod(r_mat, prime_num);
        r_mat1 = -x2x*[x1'*r_mat; zeros(2, 9)];
        r_mat1 = mod(r_mat1, prime_num);
        t_mat = x2x*x1*x3x(:,j)';      
        t_mat = mod(t_mat, prime_num);
        
        CT(3*j-2:3*j, :) = t_mat;
        CR(3*j-2:3*j, :) = r_mat1;
    end
    if (is_4 == 1)
        BM = x2x*[x1 zeros(3, 2)]*x3x;        
        BT = -BM(:);
        BT = mod(BT, prime_num);
    end
end