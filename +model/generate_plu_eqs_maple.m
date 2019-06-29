function generate_plu_eqs_maple(projs, lprojs, vis_p, vis_l, at, bt, ct, dt, et)
    A = model.eq_generator_plu_real(projs(1:2,:,:), lprojs, vis_p, vis_l);
    R2Q = zeros(9, 10);
    R2Q(1, [7 8 9 10]) = [1 1 -1 -1];
    R2Q(2, [4 3]) = 2;
    R2Q(3, [5, 2]) = [2, -2];
    R2Q(4, [4 3]) = [2, -2];
    R2Q(5, [7 8 9 10]) = [1, -1, 1, -1];
    R2Q(6, [6, 1]) = 2;
    R2Q(7, [5 2]) = 2;
    R2Q(8, [6 1]) = [2, -2];
    R2Q(9, [7 8 9 10]) = [1, -1, -1, 1];
    M1 = A(:, 1:9)*R2Q;
    M2 = A(:, 10:18)*R2Q;
    
    
%     M = polyslv.build_homo_system(A, B, at, bt, ct, dt, et, prime_num);
%     M = mod(M, prime_num);
%     M1=M(:, 1:10);
%     M2=M(:, 11:20);    
    print_to_maple(M1);
    print_to_maple(M2);    
    v_test = [at*bt, at*ct, at*dt, bt*ct, bt*dt, ct*dt, at*at, bt*bt, ct*ct, dt*dt]';
    binv=bt/at;
    cinv=ct/at;
    dinv=dt/at;
    M1*v_test + M2*v_test*et
    [binv,cinv,dinv]
    
    polyslv.solver_pluecker(M1, M2, binv, cinv,dinv);
end