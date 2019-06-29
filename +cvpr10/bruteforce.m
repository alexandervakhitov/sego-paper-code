function [R, t] = bruteforce(lprojs, projs)
    Xs = zeros(3, size(lprojs, 2));
    Xe = zeros(3, size(lprojs, 2));
    xs = zeros(2, size(lprojs, 2));
    xe = zeros(2, size(lprojs, 2));        
    for i = 1:size(lprojs, 2)
        [X1, X2] = resolve_line(eye(3), zeros(3,1), eye(3), [1;0;0], lprojs(:, i, 1), lprojs(:, i, 2));
        if (length(X1) < 3)
            R = [];
            t = [];
            return;
        end
        Xs(:,i) = X1;
        Xe(:,i) = X2;
        leq = lprojs(:, i, 3);
        %x=0
        if (abs(leq(2)) > 1e-6)
            xs(2, i) = -leq(3)/leq(2);
        else
            xs(1, i) = -leq(3)/leq(1);
            xs(2, i) = 1;
        end
        %y=0
        if (abs(leq(1)) > 1e-6)
            xe(1, i) = -leq(3)/leq(1);
        else
            xe(2, i) = -leq(3)/leq(2);
            xe(1, i) = 1.0;
        end
    end
    U = zeros(3, size(projs, 2));
    u = zeros(2, size(projs, 2));
    for i = 1:size(projs, 2)
        U(:, i) = resolve_point(eye(3), zeros(3,1), eye(3), [1;0;0], projs(:, i, 1), projs(:, i, 2));
        u(:, i) = projs(1:2, i, 3);
    end
    [R, t, fail_flag, s] = OPnPL(U,u,xs, xe, Xs, Xe);
end