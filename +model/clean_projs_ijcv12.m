function [projs, lprojs] = clean_projs_ijcv12(projs, vis_p, lprojs, vis_l)
    npt = size(vis_p, 1);
    
    if (npt < size(projs, 2))
        projs = projs(:, 1:npt, :);
    end
    
    nl = size(vis_l, 1);
    
    if (nl < size(lprojs, 2))
        lprojs = lprojs(:, 1:nl, :);
    end
   
end

