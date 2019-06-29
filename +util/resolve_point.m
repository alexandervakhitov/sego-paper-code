function [X0, err_sum] = resolve_point(R1, t1, R2, t2, proj1, proj2)
    %A = mod([eye(3), -projsh(:, 1, 1), zeros(3, 1); R2, zeros(3,1), -projsh(:, 1, 2)], prime_num);
    if (size(proj1, 1) == 2)
        proj1 = [proj1; 1];
        proj2 = [proj2; 1];
    end
    A = [R1, -proj1, zeros(3, 1); R2, zeros(3,1), -proj2];
    b = [-t1; -t2];
    if (rank(A) < 5)
        X0 = [];
        return;
    end
    X0 = A\b;
    X0 = X0(1:3);
    pr1 = R1*X0+t1;
    e1 = pr1(1:2)/pr1(3)-proj1(1:2);
    pr2 = R2*X0+t2;
    e2 = pr2(1:2)/pr2(3)-proj2(1:2);
    err_sum = norm(e1)+norm(e2);
end