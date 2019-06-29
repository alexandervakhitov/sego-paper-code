function [K, Ps, Ls, Rs, ts, Xp, XL1, XL2] = setup_min_stereo_problem_2p1l_test2(npt, nl)  
    addpath('util/');
    resx = 640;
    resy = 480;
    f = 500;
    K = [f 0 resx/2;
        0 f resy/2;
        0 0 1];

    stereo_base = 0.07;
    t1g = [-stereo_base/2; 0; 0];
    t2g = [stereo_base/2; 0; 0];
    invis = 1;
    
    Ps = [];
    Ls = [];
    
    while (invis)
    
        Xp = [xrand(1,npt,[-2 2]); xrand(1,npt,[-2 2]); xrand(1,npt,[4 8])]; 
        XL1 = [xrand(1,nl,[-2 2]); xrand(1,nl,[-2 2]); xrand(1,nl,[4 8])]; 
        XL2 = [xrand(1,nl,[-2 2]); xrand(1,nl,[-2 2]); xrand(1,nl,[4 8])]; 

        Rs(:, :, 1) = eye(3);
        Rs(:, :, 2) = eye(3);
        Rs(:, :, 3) = rodrigues(randn(3, 1));
        Rs(:, :, 4) = Rs(:, :, 3);
        
        ts(:, 1) = t1g;
        ts(:, 2) = t2g;
        ts(:, 3) = [xrand(1,1,[-2 2]); xrand(1,1,[-2 2]); xrand(1,1,[-2 2])];
        ts(:, 4) = ts(:, 3) + [stereo_base; 0; 0];
        
        pt_vis = 0;
        ln_vis = 0;
        for cam_i = 1:4
            Pi = K*[Rs(:, :, cam_i) ts(:, cam_i)];            
            for pi = 1:npt
                pt_vis  = pt_vis + check_visibility(Pi, Xp(:, pi), resx, resy);
            end

            for pi = 1:nl
                ln_vis  = ln_vis + check_visibility(Pi, XL1(:, pi), resx, resy);
                ln_vis  = ln_vis + check_visibility(Pi, XL2(:, pi), resx, resy);
            end
        end
        if (ln_vis == 8*nl && pt_vis == 4*npt)
            invis = 0;
        end
    end
    
    K = eye(3);
%     p = randperm(npt+nl);
    p = [1 3 2];
    psi = 0;
    lsi = 0;
    pnum = 0;
    lnum = 0;
    for ei = 1:2
        oi = p(ei);
        if (oi <= npt)
            pi = pnum+1;           
            for ci = 1:2
                Ps = add_point_projection(K, Rs, ts, ci, Xp, pi, Ps);
            end
            c3i = 3;
            Ps = add_point_projection(K, Rs, ts, c3i, Xp, pi, Ps);
            pnum = pnum+1;
        end
        if (oi > npt)
            li = lnum + 1;
            lnum = lnum+1;
            for ci = 1:2
                Ls = add_line_projection(K, Rs, ts, ci, XL1, XL2, li, Ls);
            end
            c3i = 4;            
            Ls = add_line_projection(K, Rs, ts, c3i, XL1, XL2, li, Ls);
        end        
    end
    
    oi = p(3);
    cams_to_proj = [2 3 4];
    cams_to_proj = cams_to_proj (1:3);
    for i = 1:3
        ci = cams_to_proj(i);
        if (oi <= npt)    
            pi = pnum+1;
            Ps = add_point_projection(K, Rs, ts, ci, Xp, pi, Ps);    
        else
            li = lnum+1;
            Ls = add_line_projection(K, Rs, ts, ci, XL1, XL2, li, Ls);
        end        
    end    
    
end
function pt_vis = check_visibility(Pi, p3d, resx, resy)
    [ptproj, is_behind] = project_point(Pi, p3d);
    pt_vis = 0;
    if (ptproj(1) > 0 && ptproj(1) < resx && ptproj(2) > 0 && ptproj(2) < resy && is_behind == 0)
        pt_vis = 1;
    end
end
function [ptproj, is_behind] = project_point(Pi, p3d)
    ptproj = Pi*[p3d; 1];
    if (ptproj(3) < 0)
        is_behind = 1;
    else
        is_behind = 0;
    end
    ptproj = ptproj(1:2)/ptproj(3);    
end
function lc = project_line(p3d1, p3d2, Pi)
    projs = Pi*[p3d1, p3d2; 1 1];                
    lc = cross(projs(:, 1), projs(:, 2));
    lc = lc / norm(lc(1:2));
end

function Ps = add_point_projection(K, Rs, ts, ci, Xp, pi, Ps)
    psi = size(Ps, 1) + 1;    
    Ps(psi, 1) = pi;
    Pi = K*[Rs(:, :, ci) ts(:, ci)];                
    Ps(psi, 2:3) = project_point(Pi, Xp(:, pi));
    Ps(psi, 4) = ci;           
end
function Ls = add_line_projection(K, Rs, ts, ci, XL1, XL2, li, Ls)
    lsi = size(Ls, 1) + 1;
    Pi = K*[Rs(:, :, ci) ts(:, ci)];                
    Ls(lsi, 1) = li;
    Ls(lsi, 2:4) = project_line(XL1(:, li), XL2(:, li), Pi);
    Ls(lsi, 5) = ci;
end