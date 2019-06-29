function generate_solver_eqs(fname, var_pref, arr_name, dim1, dim2)
    fout = fopen(fname, 'w');
    for i = 1:dim1
        for j = 1:dim2
            fprintf(fout, '%s_%d_%d = %s(%d,%d);\n', var_pref, i, j, arr_name, i, j);
        end
    end
    fclose(fout);
end