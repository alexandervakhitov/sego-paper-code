function test_logged

    folder_pref ='/home/alexander/materials/sego/debug/';
    vis_p = dlmread([folder_pref 'vis_p']);
    vis_l = dlmread([folder_pref 'vis_l']);
    pprojsr = dlmread([folder_pref 'pprojs']);
    lprojsr = dlmread([folder_pref 'lprojs']);
    pprojs = ones(3, size(vis_p, 1), 4);
    ind = 1;
    for pi = 1:size(vis_p, 1)
        for ci = 1:4
            pprojs(1:2, pi, ci) = pprojsr(ind,:);
            ind = ind+1;
        end
    end
    lprojs = zeros(3, size(vis_l, 1), 4);
    ind = 1;
    for pi = 1:size(vis_l, 1)
        for ci = 1:4
            lprojs(:, pi, ci) = lprojsr(ind,:);
            ind = ind+1;
        end
    end
    [R, t] = slv.sego_solver(pprojs,lprojs,vis_p,vis_l,true,true);
end