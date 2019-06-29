function l3d = encode_line(X1, X2)
    line_dir = X2-X1;    
    line_dir = line_dir/norm(line_dir);
    X1 = X1 - (X1'*line_dir)*line_dir;    
    a = norm(X1);
    X1n = X1/a;
    r3 = cross(line_dir, X1n);
    R = [line_dir X1n r3];
    rvec = slv.rodrigues(R);    
    l3d = [rvec; a];
end