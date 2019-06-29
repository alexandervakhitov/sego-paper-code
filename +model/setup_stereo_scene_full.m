function [Rs, ts, projsh, lprojs, lpprojsh, pts3d, lpts3d] = setup_stereo_scene_full(tlen, rotrad, pix_noise, fpix, N, llen_var)

    if (nargin < 6)
        llen_var = 1.0;
    end
    

%     if (nargin == 2)
%         pix_noise = 0;
%     end
%     
%     if (nargin < 4)
    if (nargin < 5)
        N = 3;
    end
%     end
    
    box_side = 4;
    box_dist = 12;
    
    [verts, lb, rb] = model.generate_initial_cam(box_side, box_dist);
    
    box_center = [0;0;box_dist];
    Rwc = eye(3);
    t1wc = box_center;
    
    R1 = eye(3);
    t1 = zeros(3,1);
    R2 = eye(3);
    t2 = [1;0;0];
    verts = verts + repmat([0.5;0;0], 1, size(verts, 2)); %now verts in 1st cam coords    
    f = 500; %pixels
    
    nc1 = model.count_visible(R1, t1, verts, f);
    nc2 = model.count_visible(R2, t2, verts, f);
    
    if (nc1 < 7 || nc2 < 7)
        error;
    end
    
    box_invisible = true;
    it = 0;
    while (box_invisible)
        rodvec = randn(3,1);
        rodvec = rodvec / norm(rodvec) * rotrad;
        R3 = util.rodrigues(rodvec);
        t3 = rand(3, 1);
        t3 = t3/norm(t3)*tlen;
        R4 = R3;
        t4 = t3 + [1;0;0];
        nc3 = model.count_visible(R3, t3, verts, f);
        nc4 = model.count_visible(R4, t4, verts, f);
        if (nc4 >=7 && nc3 >=7)
            box_invisible = false;
        end
        it = it+1;
        if (mod(it, 1000) == 0)
            [verts, lb, rb] = model.generate_initial_cam(box_side, box_dist);
            verts = verts + repmat([0.5;0;0], 1, size(verts, 2)); %now verts in 1st cam coords    
            nc1 = model.count_visible(R1, t1, verts, f);
            nc2 = model.count_visible(R2, t2, verts, f);            
        end
        if (mod(it, 10000) == 0)
            fprintf('error!');
            tlen
            rotrad
            pix_noise
            exit;
        end
    end
    R_flat= [R1(:); R2(:); R3(:); R4(:)];
    Rs = reshape(R_flat, 3, 3, 4);
    ts = [t1 t2 t3 t4];    
        
    projsh = zeros(2, N, 4);
    for i = 1:N                
        [pt3d, projs] = generate_suitable_point(Rwc, t1wc, Rs, ts, box_side, pix_noise/fpix);
        pts3d(:, i) = pt3d;
        projsh(1, i, :) = projs(1,:);
        projsh(2, i, :) = projs(2,:);
        projsh(3, i, :) = 1;                                                   
    end
    
%     for i = 1:2*N        
%         [pt3d, projs] = generate_suitable_point(Rwc, t1wc, Rs, ts, box_side, pix_noise/fpix);
%         lpts3d(:, i) = pt3d;
%         lpprojsh(1, i, :) = projs(1,:);
%         lpprojsh(2, i, :) = projs(2,:);
%         lpprojsh(3, i, :) = 1;                                                           
%     end    
    
    lpprojsh = zeros(3,N,4);
    for i = 1:N        
        [lpt3d, lprojs] = generate_suitable_line(Rwc, t1wc, Rs, ts, box_side, pix_noise/fpix, llen_var);
        lpts3d(:, i) = lpt3d;
        lpprojsh(1, 2*i-1, :) = lprojs(1,:);
        lpprojsh(2, 2*i-1, :) = lprojs(2,:);
        lpprojsh(3, 2*i-1, :) = 1;                                                           
        lpprojsh(1, 2*i, :) = lprojs(3,:);
        lpprojsh(2, 2*i, :) = lprojs(4,:);
        lpprojsh(3, 2*i, :) = 1;                                                                   
    end    
    
        
%     lpts3d_r = reshape(lpts3d, 6, N);
%     lpt3ddir = lpts3d_r(1:3,:)-lpts3d_r(4:6,:);
%     lpt3ddir = lpt3ddir ./ repmat(sum(lpt3ddir.^2), 3, 1);
%     lpt3dc = 0.5*(lpts3d_r(1:3,:)+lpts3d_r(4:6,:));
%     llens = (rand(N, 1)+0.5)*llen_var;    
%     
%     lpt3d_1 = lpt3dc - 0.5*lpt3ddir.*repmat(llens', 3, 1);
%     lpt3d_2 = lpt3dc + 0.5*lpt3ddir.*repmat(llens', 3, 1);
    
    
    
    lprojs = zeros(3, N, 4);
    for cam_i = 1:4
        for li = 1:N
            leq = cross(lpprojsh(:, 2*li-1, cam_i), lpprojsh(:, 2*li, cam_i));
            leq = leq / norm(leq(1:2));
            lprojs(:, li, cam_i) = leq;
        end
    end
    
           
end

function [lpt3d, projs] = generate_suitable_line(Rwc, t1wc, Rs, ts, box_side, pix_noise, llen_var)
    gend = 0;
    it = 1;
    while (~gend)
        gend = 1;
        Xw = util.xrand(3,1,[-box_side/2 box_side/2]);
        pt3d_c = Rwc*Xw + t1wc;     
        
        ldir = randn(3,1);
        ldir = ldir/norm(ldir);
        pt2 = pt3d_c + llen_var*(rand+0.5)*ldir;
        
        lpt3d = [pt3d_c; pt2];
        
        projs = zeros(4, 4);
        for cam_i = 1:4
            pr_i_1 = Rs(:, :, cam_i)*pt3d_c + ts(:, cam_i);
            pr_i_2 = Rs(:, :, cam_i)*pt2 + ts(:, cam_i);
            projs(1:2, cam_i) = pr_i_1(1:2)./pr_i_1(3);
            projs(3:4, cam_i) = pr_i_2(1:2)./pr_i_2(3);
            projs(:, cam_i) = projs(:, cam_i) + (randn(4,1))*pix_noise;
            if (abs(projs(1, cam_i))>1 || abs(projs(2, cam_i))>1 || abs(projs(3, cam_i))>1 || abs(projs(4, cam_i))>1)
                gend = 0;
            end
            it = it+1;
            if (mod(it, 1000) == 0)
                fprintf('error pt gen');
                norm(ts(:, 3))
                exit;
            end
        end            
    end
end

function [pt3d, projs] = generate_suitable_point(Rwc, t1wc, Rs, ts, box_side, pix_noise)
    gend = 0;
    it = 1;
    while (~gend)
        gend = 1;
        Xw = util.xrand(3,1,[-box_side/2 box_side/2]);
        pt3d = Rwc*Xw + t1wc;     
        projs = zeros(2, 4);
        for cam_i = 1:4
            pr_i = Rs(:, :, cam_i)*pt3d + ts(:, cam_i);
            projs(:, cam_i) = pr_i(1:2)./pr_i(3);
            projs(:, cam_i) = projs(:, cam_i) + (randn(2,1))*pix_noise;
            if (abs(projs(1, cam_i))>1 || abs(projs(2, cam_i))>1)
                gend = 0;
            end
            it = it+1;
            if (mod(it, 1000) == 0)
                fprintf('error pt gen');
                norm(ts(:, 3))
                exit;
            end
        end            
    end
end