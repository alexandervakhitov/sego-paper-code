function [verts, lb, rb] = generate_initial_cam(box_side, box_dist)
    box_center = [0;0;box_dist];
    verts = zeros(3, 8);
    ind = 1;
    for i = 1:2
        for j = 1:2
            for k = 1:2
                p = [i,j,k] - ones(1,3)*1.5;
                p = p' * box_side + box_center;
                verts(:, ind) = p;
                ind = ind+1;
            end
        end
    end
    lb = ones(3,1);
    rb = ones(3,1);
    for i = 1:3
        lb(i) = min(verts(i, :));
        rb(i) = max(verts(i, :));
    end
end