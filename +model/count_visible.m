function nc = count_visible(R, t, verts, f)
    vp = R*verts + repmat(t, 1, size(verts, 2));
    vp = vp ./ repmat(vp(3, :), 3, 1);
    vp = vp*f + repmat([f/2; f/2; 0], 1, size(verts, 2));
    good_inds = (vp(1, :) > 0) & (vp(1, :) < f) & (vp(2, :) > 0) & (vp(2, :) < f);
    nc = length(find(good_inds));
end