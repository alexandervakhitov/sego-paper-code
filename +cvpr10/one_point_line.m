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
%         x2x
%         r_mat
%         x1
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