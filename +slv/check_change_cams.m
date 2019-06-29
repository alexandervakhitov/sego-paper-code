function [changed_cams, changed_views, projs, lprojs, vis_p, vis_l] = check_change_cams(projs, lprojs, vis_p, vis_l)
    
    changed_cams = 0;
    changed_views = 0;
    
    if(size(vis_p, 1) < 1)
        return;
    end
    
    if (sum(vis_p(1, 1:2)) < 2)
        projs1 = projs;
        projs(:, :, 1:2) = projs1(:, :, 3:4);
        projs(:, :, 3:4) = projs1(:, :, 1:2);
        lprojs1 = lprojs;
        lprojs(:, :, 1:2) = lprojs1(:, :, 3:4);
        lprojs(:, :, 3:4) = lprojs1(:, :, 1:2);        
        vis_p_1 = vis_p;
        vis_p(:, 1:2) = vis_p_1(:, 3:4);
        vis_p(:, 3:4) = vis_p_1(:, 1:2);
        vis_l_1 = vis_l;
        vis_l(:, 1:2) = vis_l_1(:, 3:4);
        vis_l(:, 3:4) = vis_l_1(:, 1:2);
        changed_cams = 1;
    end
    
    
    if (vis_p(1, 3) == 0)
        projs1 = projs;
        projs1(1:2,:,:) = -projs(1:2,:,:);
        projs(:, :, [1 3]) = projs1(:, :, [2 4]);
        projs(:, :, [2 4]) = projs1(:, :, [1 3]);
        lprojs1 = lprojs;
        lprojs1(1:2,:,:) = -lprojs(1:2,:,:);        
        lprojs(:, :, [1 3]) = lprojs1(:, :, [2 4]);
        lprojs(:, :, [2 4]) = lprojs1(:, :, [1 3]);
        vis_p_1 = vis_p;
        vis_p(:, [1 3]) = vis_p_1(:, [2 4]);
        vis_p(:, [2 4]) = vis_p_1(:, [1 3]);
        vis_l_1 = vis_l;
        vis_l(:, [1 3]) = vis_l_1(:, [2 4]);
        vis_l(:, [2 4]) = vis_l_1(:, [1 3]);
        changed_views = 1;
    end
end