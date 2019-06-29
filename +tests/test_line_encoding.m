function test_line_encoding
    X1 = randn(3,1);
    X2 = randn(3,1);
    line_dir = X2-X1;
    line_dir = line_dir/norm(line_dir);
    X1 = X1 - (line_dir'*X1)*line_dir;
    X2 = X1 + line_dir;
    l3d = util.encode_line(X1, X2);
    [X1e, X2e] = util.decode_line(l3d);
    norm(X1e-X1)
    norm(X2e-X2)
end