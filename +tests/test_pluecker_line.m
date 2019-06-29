function test_pluecker_line
    R1 = rodrogies(randn(3,1));
    t1 = randn(3,1);
    l1 = randn(3,1);
    l2 = randn(3,1);
    
    [X1, X2, err_sum] = resolve_line(eye(3), zeros(3,1), R1, t1, l1, l2);
    X1h = [X1; 1];
    X2h = [X2; 1];
    L = X1h*X2h'-X2h*X1h';
    lpluecker = [L(1,2); L(1,3); L(1,4); L(2,3); L(4,2); L(3,4)];
    
end