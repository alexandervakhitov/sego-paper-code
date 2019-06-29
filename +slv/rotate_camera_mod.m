function rc = rotate_camera_mod(X1, X2, prime_num)
    rc = -1;
    d = mod(X2-X1, prime_num);
    dnorm = d(1)^2 + d(2)^2 + d(3)^2;
    dnorm = fp.fp_sqrt(dnorm, prime_num);
    if (dnorm < 0)
        return;
    end
    rc = 1;
    d = d * fp.inverse(dnorm, prime_num);
    
end