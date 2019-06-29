function test_approx_pose
%mex approx_pose_mex.cpp -I/usr/include/eigen3 -L/home/alexander/materials/sego/ventura/multi-camera-motion/cmake-build-debug -lmulti-camera-motion
    %addpath('/home/alexander/materials/sego/ventura/multi-camera-motion/src');
    [projs, lprojs, vis_p, vis_l, at, bt, ct, dt, et,pts3d, lpts3d, Rs, ts ] = model.generate_case_real(0);
    b = -[1;0;0];
    wvec = zeros(36*6, 1);
    for pi = 1:3        
        %vs cam 1
        u = [projs(:, pi, 1); zeros(3,1)];        
        v = [projs(:, pi, 4); cross(b, projs(:, pi, 4))];
        w = (u*v')';        
        wvec((2*pi-2)*36+1:(2*pi-1)*36) = w(:);
        u = [projs(:, pi, 2); cross(b, projs(:, pi, 2))];        
        v = [projs(:, pi, 3); zeros(3, 1)];
        w = (u*v')';        
        wvec((2*pi-1)*36+1:(2*pi)*36) = w(:);        
    end      
    [r, s] = polyslv.approx_pose_mex(wvec);
    R_true = Rs(:,:,3);
    ns = [];
    Rps = [];
    for i = 1:s
        R_pred = eye(3) + util.cpmat(r(:, i));
        ns = [ns; norm(R_pred*R_true'-eye(3))];
        Rps(:, :, i) = R_pred;
    end
    [v,ind] = min(ns)
    Rps(:,:,ind)
    R_true
    
    [R_a, t_a] = cvpr10.approx_pose(projs);
    ts(:, 3)
    t_a(:, ind)    
end