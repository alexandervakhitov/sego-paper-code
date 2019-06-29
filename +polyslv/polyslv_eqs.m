function polyslv_eqs
    B = sym('B', [3, 7, 2]);
    syms d0 d1;
    m = sym('m', [1, 7, 2]);
    n = sym('n', [1, 7, 2]);
    syms a b c e;
    A = [a 0 0;
        0 a 0;
        0 0 a;
        1 0 0;
        0 1 0;
        0 0 a^2;
        0 0 1];
    v = [b; c; 1];
    eq1 = ((m(:, :, 1)+m(:, :, 2)*e)*(d0 + d1*e) + (n(:,:,1) + n(:,:,2)*e))*A;
    w = -(B(:,:,1)+B(:,:,2)*e)*A*v;
    eq2 = w(1)*b - w(2)*c;
    eq3 = w(1)*c - w(3)*b;
    eq4 = w(1)*w(1)-w(2)*w(3);
    [C,T]=coeffs(eq2,[b,c]);
    eq2 = eq2 - b^2*C(1)+C(1)*w(2) - b*c*C(2) + C(2)*w(1) -c^2*C(4) + w(3)*C(4);    
    [Cf2,Tf]=coeffs(eq2,[b,c]);
    Tf
    [C,T]=coeffs(eq3,[b,c]);
    eq3 = eq3 - b^2*C(1)+C(1)*w(2) - b*c*C(2) + C(2)*w(1) -c^2*C(4) + w(3)*C(4);    
    [Cf3,Tf]=coeffs(eq3,[b,c]);
    Tf
    [C,T]=coeffs(eq4,[b,c]);
    eq4 = eq4 - b^2*C(1)+C(1)*w(2) - b*c*C(2) + C(2)*w(1) -c^2*C(4) + w(3)*C(4);    
    [Cf4,Tf]=coeffs(eq4,[b,c]);
    Tf
%     eq3 = eq3 - b^2*C(1)+C(1)*w(2) - b*c*C(2) + C(2)*w(1) -c^2*C(4) + w(3)*C(4);    
    [Cf1,Tf]=coeffs(eq1*v,[b,c]);
    Tf    
    Cm = [Cf1; Cf2; Cf3; Cf4];
    [c1a, t1a] = coeffs(sum(Cf1), [a e]);
    [c1e, t1e] = coeffs(sum(Cf1), e);
    [c2a, t2a] = coeffs(sum(Cf2), a);
    [c2e, t2e] = coeffs(sum(Cf2), e);
    [c4a, t4a] = coeffs(sum(Cf4), a);
    [c4e, t4e] = coeffs(sum(Cf4), e);
    eq1f = det(Cm(1:3, 1:3));
    eq2f = det(Cm([1 2 4], 1:3));
    [Ceq1e,Teq1e] = coeffs(eq1f, [a e]);
    [Ceq2e,Teq2e] = coeffs(eq2f, e);
end