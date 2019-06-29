function [Rs, ts] = approx_pose(projs, vis_p)
    b = -[1;0;0];
    wvec = zeros(36*6, 1);
    us = zeros(6, 6);
    vs = zeros(6, 6);
    for pi = 1:3        
        %vs cam 1        
        u = [projs(:, pi, 1); zeros(3,1)];         
        v = [projs(:, pi, 4); cross(b, projs(:, pi, 4))];
        w = (u*v')';        
        us(:, 2*pi-1) = u;
        vs(:, 2*pi-1) = v;
        wvec((2*pi-2)*36+1:(2*pi-1)*36) = w(:);
        u = [projs(:, pi, 2); cross(b, projs(:, pi, 2))];        
        v = [projs(:, pi, 3); zeros(3, 1)];
        w = (u*v')';      
        us(:, 2*pi) = u;
        vs(:, 2*pi) = v;
        wvec((2*pi-1)*36+1:(2*pi)*36) = w(:);        
    end      
    [r, s] = polyslv.approx_pose_mex(wvec);        
    Rs = zeros(3, 3, s);
    ts = zeros(3, s);
    
    % -[t]_x R u = (R u)_x t
    C = zeros(6, 4);
    for i = 1:s
        R = util.cpmat(r(:, i))+eye(3);
        for j = 1:6            
            C(j, :) = fill_C_row(us(:, j), vs(:, j), R);            
        end
        [U,S,V] = svd(C'*C);
        ev = V(:, 4);
        t = ev(1:3)/ev(4);
        ts(:, i) = -t;%somehow
        Rs(:, :, i) = R;
    end
end

function c_row = fill_C_row(u, v, R)
    ct = v(1:3)'*util.cpmat(R*u(1:3));
    c = v(1:3)'*R*u(4:6)+v(4:6)'*R*u(1:3);
    c_row = [ct, c];
end