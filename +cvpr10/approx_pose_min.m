function [Rs, ts] = approx_pose_min(projs, vis_p)
    b = -[1;0;0];
    wvec = zeros(36*6, 1);
    us = zeros(6, 6);
    vs = zeros(6, 6);
    ind = 1;
    ind_w = 1;
    for pi = 1:3        
        %vs cam 1
        for mi = 1:2
            for oi = 3:4
                if (vis_p(pi, mi)==1 && vis_p(pi, oi) == 1)
                    n = zeros(3,1);
                    if (mi == 2)
                        n = cross(b, projs(:, pi, mi));
                    end   
                    u = [projs(:, pi, mi); n];         
                    n2 = zeros(3,1);
                    if (oi == 4)
                        n2 = cross(b, projs(:, pi, oi));
                    end   
                    v = [projs(:, pi, oi); n2];
                    w = (u*v')';        
                    us(:, ind) = u;
                    vs(:, ind) = v;
                    wvec(ind_w:ind_w+36-1) = w(:);
                    ind_w = ind_w+36;
                    ind = ind+1;
                end
            end
        end      
    end      
    if (sum(isnan(wvec(:))) || sum(isinf(wvec(:))))
        wvec;
    end
%     fout = fopen('/home/alexander/debug_ap', 'w');
%     fprintf(fout, '%.30f,', wvec);
%     fclose(fout);
    [r, s] = polyslv.approx_pose_mex(wvec);        
    Rs = zeros(3, 3, s);
    ts = zeros(3, s);
    s = min([s, 20]);
    % -[t]_x R u = (R u)_x t
    C = zeros(6, 4);
    for i = 1:s
        if (sum(isnan(r(:,i)))>0)
            continue;
        end
        R = util.cpmat(r(:, i))+eye(3);
        for j = 1:6            
            C(j, :) = fill_C_row(us(:, j), vs(:, j), R);            
        end
        if (sum(isnan(C(:))) > 0)
            us
            vs
            R
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