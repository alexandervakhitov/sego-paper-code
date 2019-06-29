function [X1, X2] = decode_line(l3d)
    rvec = l3d(1:3);
    R = slv.rodrigues(rvec);
    X1 = R(:, 2) * l3d(4);
    line_dir = R(:, 1);
    X2 = X1 + line_dir;
end