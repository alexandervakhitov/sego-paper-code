function [Cr, Ct, b] = generate_rteqs_line_mod(X, proj, is_stereoshift, inds, prime_num)    
    Cr = zeros(3, 9);
    for i = 1:3
        Cr(i, inds(:, i)) = X';
    end
    Cr = proj'*Cr;
    Cr = mod(Cr, prime_num);
    Ct = proj'*eye(3);
    Ct = mod(Ct, prime_num);
    b = 0;
    if (is_stereoshift)
        b = mod(-proj'*([1;0;0]), prime_num);
    end
end