function test_p3l
    vis_l = zeros(3, 4);
    lprojs = zeros(3, 3, 4);
    b = [1;0;0];
%     t = randn(3,1);
    t = [1;2;3];
    R = rodrigues([1,2,3]);
    for li = 1:3
%         l1 = randn(3,1);
%         l2 = randn(3,1);
        l1 = [li; 2-li; 1];
        l2 = [3-li; 2*li; 1];
        [X1, X2] = resolve_line(eye(3), zeros(3,1), eye(3), b, l1, l2);
        X1c = R*X1 + t;
        X2c = R*X2 + t;
        l3 = cross(X1c, X2c);
        ls = [l1 l2 l3];
        for pi = 1:3
            lprojs(:, li, pi) = ls(:, pi)/norm(ls(1:2,pi));            
            vis_l(li, pi) = 1;
        end                
    end

    is_d_ch = 0;
    [Rs, ts] = polyslv.quadric_solver([], lprojs, [], vis_l, is_d_ch);
    R
    for si = 1:size(Rs, 3)
        Rs(:,:,si)
    end
end