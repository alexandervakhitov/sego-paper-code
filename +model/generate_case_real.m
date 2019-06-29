function [projs, lprojs, vis_p, vis_l, at,bt,ct,dt,et ,pts3d, lpts3d, Rs, ts, projs_full] = generate_case_real(case_num)
    cur_tlen = 9*rand+4;
    rotrad = pi/180*2;%*rand;
    pix_noise = 0.0;
    fpix = 500;
    [Rs, ts, projs_full, lprojs_full, lpprojsh, pts3d, lpts3d] = model.setup_stereo_scene_full(cur_tlen, rotrad, pix_noise, fpix);  
    
    if (case_num > 0)
        [vis_p, vis_l] = model.generate_visibility(case_num);

        [projs, lprojs] = clean_projs(projs_full, vis_p, lprojs_full, vis_l);
    else
        projs = projs_full;
        lprojs = lprojs_full;
        vis_p = [];
        vis_l = [];
    end
    q = util.rot2quat(Rs(:, :, 3));
    at = q(1);
    bt = q(2);
    ct = q(3);
    dt = q(4);
    et = get_alpha_true(Rs, ts, projs_full);
end