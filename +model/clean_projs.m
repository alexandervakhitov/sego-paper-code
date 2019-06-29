function [projs, lprojs] = clean_projs(projs, vis_p, lprojs, vis_l)
    npt = size(vis_p, 1);
    
    if (npt < size(projs, 2))
        projs = projs(:, 1:npt, :);
    end
    for i = 1:npt
        for ci = 1:4
            if (vis_p(i, ci) == 0)
                projs(:, i, ci) = [0;0;0];
            end
        end
    end
    
    nl = size(vis_l, 1);
    
    if (nl < size(lprojs, 2))
        lprojs = lprojs(:, 1:nl, :);
    end
    for i = 1:nl
        for ci = 1:4
            if (vis_l(i, ci) == 0)
                lprojs(:, i, ci) = [0;0;0];
            end
        end
    end

end

