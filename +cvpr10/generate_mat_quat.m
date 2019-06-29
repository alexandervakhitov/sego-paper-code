function generate_mat_quat
    syms a b c d;
    
    R = [a^2+b^2-c^2-d^2, 2*b*c-2*a*d, 2*b*d+2*a*c;
    2*b*c+2*a*d, a^2-b^2+c^2-d^2, 2*c*d-2*a*b;
    2*b*d-2*a*c, 2*c*d+2*a*b, a^2-b^2-c^2+d^2];

    r = R(:);
    A = gbs_Matrix('A_%do%d__', 18, 10, 'real');
    p = A*[r; 1];
    a_coeffs = [];
    other_coeffs = [];
    for i = 1:length(p)
        [cf,tf] = coeffs(p(i), [a,b,c,d]);
        a_coeffs  = [a_coeffs; cf([1:4 11])];
        other_coeffs = [other_coeffs; cf([5,8,10,6,7,9])];
    end
    
    Mg = [other_coeffs a_coeffs];

end