function [Rs, ts, projsh, lprojs, lpprojsh] = setup_stereo_scene_planar(tlen, rotrad, pix_noise, N)
    

    if (nargin == 2)
        pix_noise = 0;
    end
    
    if (nargin < 4)
        N = 3;
    end

    box_close = 40;
    box_far = 80;
    box_side = box_far - box_close;
    
    
    Rwc = util.rodrigues(randn(3,1));
    t1wc = [rand-0.5;rand-0.5;rand*(box_far-box_close)+box_close];
    
    R2 = eye(3);
    t2 = [1;0;0];%rand(3, 1);
    
    rodvec = randn(3,1);
    rodvec = rodvec / norm(rodvec) * rotrad;
    R3 = util.rodrigues(rodvec);
    
    t3 = rand(3, 1);
    t3 = t3/norm(t3)*tlen;
    ts(:, 2) = t2;
    ts(:, 3) = t3;    
    R4 = R2*R3;
    t4 = R2*t3+t2;
    Rs(:, :, 2) = R2;
    Rs(:, :, 3) = R3;
    Rs(:, :, 1) = eye(3);
    Rs(:, :, 4) = R4;
    ts(:, 4) = t4;
    
        
    projsh = zeros(2, N, 4);
    for i = 1:N                
        [pt3d, projs] = generate_suitable_point(Rwc, t1wc, Rs, ts, box_side, pix_noise);
        pts3d(:, i) = pt3d;
        projsh(1, i, :) = projs(1,:);
        projsh(2, i, :) = projs(2,:);
        projsh(3, i, :) = 1;                                                   
    end
    
    for i = 1:2*N        
        [pt3d, projs] = generate_suitable_point(Rwc, t1wc, Rs, ts, box_side, pix_noise);
        lpts3d(:, i) = pt3d;
        lpprojsh(1, i, :) = projs(1,:);
        lpprojsh(2, i, :) = projs(2,:);
        lpprojsh(3, i, :) = 1;                                                           
    end    
    lprojs = zeros(3, N, 4);
    for cam_i = 1:4
        for li = 1:N
            lprojs(:, li, cam_i) = cross(lpprojsh(:, 2*li-1, cam_i), lpprojsh(:, 2*li, cam_i));
        end
    end
    
           
end

function [pt3d, projs] = generate_suitable_point(Rwc, t1wc, Rs, ts, box_side, pix_noise)
    gend = 0;
    while (~gend)
        gend = 1;
        Xw = util.xrand(3,1,[-box_side/2 box_side/2]);
        Xw(3) = 0;
        pt3d = Rwc*Xw + t1wc;     
        projs = zeros(2, 4);
        for cam_i = 1:4
            pr_i = Rs(:, :, cam_i)*pt3d + ts(:, cam_i);
            projs(:, cam_i) = pr_i(1:2)./pr_i(3);
            projs(:, cam_i) = projs(:, cam_i) + (randn(2,1))*pix_noise;
            if (abs(projs(1, cam_i))>1 || abs(projs(2, cam_i))>1)
                gend = 0;
            end
        end            
    end
end