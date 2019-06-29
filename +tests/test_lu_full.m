function test_lu_full
    lu_path = '/home/alexander/materials/sego/maple/lu_full_1';
    am_path = '/home/alexander/materials/sego/maple/am_full_1';
    opts_path = '/home/alexander/materials/sego/maple/opts_full_1';
    reduce_pos = 834;
    n_r = 12;
    tval = 0.5149;
    action_inds = [-4,-6,706,-5,707,708,709,710,711,712,-14,713,714,715,716,717];
    s = 16;
    read_lu_test(lu_path, am_path, opts_path, tval, s);
end