function [R, t] = p3p_based(projs)
    U = zeros(3,3);
    u = zeros(3,3);
    for i = 1:size(projs, 2)
        
        A = resolve_point(eye(3), zeros(3,1), eye(3), [1;0;0], projs(:, i, 1), projs(:, i, 2));
        if (length(A) < 3)
            R = [];
            t = [];
            return;
        else
            U(:, i) = A;
        end
        u1 = projs(1:2, i, 3);
        u1 = [u1; 1];
        u1 = u1/norm(u1);
        u(:, i) = u1;
    end
    poses = p3p(U, u);
    poses = real(poses);
    R = zeros(3, 3, 4);
    t = zeros(3, 4);
    for si = 1:4
        Rc = poses(:, 4*si-2:4*si);
        Rc = Rc';
        tc = poses(:, 4*si-3);
        tc = -Rc*tc;
        R(:, :, si) = Rc;
        t(:, si) = tc;
    end
end