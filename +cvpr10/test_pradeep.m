function test_pradeep
%     p_projs_raw = dlmread('/home/alexander/materials/sego/debug_pra/p_projs');
%     l_projs_raw = dlmread('/home/alexander/materials/sego/debug_pra/l_projs');

    p_projs_raw = dlmread('/home/alexander/materials/sego/debug/pprojs');
    l_projs_raw = dlmread('//home/alexander/materials/sego/debug/lprojs');

    np = size(p_projs_raw, 1)/4;
    nl = size(l_projs_raw, 1)/4;
    p_projs=ones(3,np,4);
    l_projs=zeros(3,nl,4);
    for i = 1:np
        for ci = 1:4
            p_projs(1:2, i, ci) = p_projs_raw(4*(i-1)+ci, :);
        end
    end
    for i = 1:nl
        for ci = 1:4
            l_projs(:, i, ci) = l_projs_raw(4*(i-1)+ci, :);
        end
    end
    [Rs, ts] = cvpr10.quat_assf(l_projs, p_projs);
    
    R = Rs(1:3,1:3);
    t = ts(:, 1);
    for i = 1:size(p_projs, 2)
        X = resolve_point(eye(3), zeros(3,1), eye(3), [1;0;0], p_projs(:, i, 1), p_projs(:, i, 2));
        xp = R*X+t;
        xp = xp/xp(3);
        norm(p_projs(1:2,i,3)-xp(1:2))
    end
end