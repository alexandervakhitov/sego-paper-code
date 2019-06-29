function [Cr, Ct, b] = generate_rteqs_point_mod(X, proj, is_stereoshift, inds, prime_num)    
    Cr = zeros(2, 9);
    for i = 1:2
        Cr(i, inds(:, i)) = X';
        Cr(i, inds(:, 3)) = -proj(i)*X';
    end
    Cr = mod(Cr, prime_num);
    Ct = eye(3);
    for i = 1:2
        Ct(i, 3) = -proj(i);
    end
    Ct = mod(Ct(1:2, :), prime_num);
    b = zeros(2, 1);
    if (is_stereoshift)
        b = mod(-[1;0], prime_num);
    end
    
end