function R3 = build_cam(a,b,c,d)
    R3 = [a^2+b^2-c^2-d^2, 2*b*c-2*a*d, 2*b*d+2*a*c;
        2*b*c+2*a*d, a^2-b^2+c^2-d^2, 2*c*d-2*a*b;
        2*b*d-2*a*c, 2*c*d+2*a*b, a^2-b^2-c^2+d^2];
    R3 = R3 / det(R3);
end