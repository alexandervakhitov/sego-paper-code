function [R,a,b,c,d] = generate_cam(prime_num)
    if (nargin == 0)
        a = rand;
        b = rand;
        c = rand;
        d = rand;
        denom = sqrt(a^2 + b^2 + c^2 + d^2);
        a = a/denom;
        b = b/denom;
        c = c/denom;
        d = d/denom;
        R = [a^2+b^2-c^2-d^2, 2*b*c-2*a*d, 2*b*d+2*a*c;
            2*b*c+2*a*d, a^2-b^2+c^2-d^2, 2*c*d-2*a*b;
            2*b*d-2*a*c, 2*c*d+2*a*b, a^2-b^2-c^2+d^2];
        return;
    end
    
    denom = -1;
    while (denom < 0)
        a = randi(100);
        b = randi(100);
        c = randi(100);
        d = randi(100);
        denom = fp.fp_sqrt(mod(a^2 + b^2 + c^2 + d^2, prime_num), prime_num);
    end
    a = mod(a*fp.inverse(denom, prime_num), prime_num);
    b = mod(b*fp.inverse(denom, prime_num), prime_num);
    c = mod(c*fp.inverse(denom, prime_num), prime_num);
    d = mod(d*fp.inverse(denom, prime_num), prime_num);
    R = mod([a^2+b^2-c^2-d^2, 2*b*c-2*a*d, 2*b*d+2*a*c;
        2*b*c+2*a*d, a^2-b^2+c^2-d^2, 2*c*d-2*a*b;
        2*b*d-2*a*c, 2*c*d+2*a*b, a^2-b^2-c^2+d^2], prime_num);
    %R = mod(R*fp.inverse(a^2+b^2+c^2+d^2, prime_num), prime_num);
end