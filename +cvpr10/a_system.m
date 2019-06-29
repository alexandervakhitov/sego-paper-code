function a_system()
    addpath('/home/alexander/materials/solvgen/Automatic-Generator-release/generator/helpers');
    clear all;
    A = cvpr10.gbs_Matrix_c('A_%do%d__', 6, 5, 'real');
    syms a b c d;
    As = A*[a^2; a*b; a*c; a*d; 1];
    M = [];
    for i = 1:length(As)
        [cf,tf] = coeffs(As(i), [b,c,d]);
        M = [M; cf];
    end
    
    MultMap1 = [4 1 2; 5 1 3; 6 2 3];
    MultMap2 = [4 5 1 6; 4 6 2 5; 5 6 3 4];
    
    Bs = [];
    for i = 1:3
        Bs = [Bs; As(MultMap1(i,1))^2-As(MultMap1(i,2))*As(MultMap1(i,3))];
    end
    for i = 1:3
        Bs = [Bs; As(MultMap2(i,1))*As(MultMap2(i,2))-As(MultMap2(i,3))*As(MultMap2(i,4))];
    end
    
    %[ b^2, b*c, b*d, b, c^2, c*d, c, d^2, d, 1]
    eq_map = [1 4 5 0 2 6 0 3 0 0];
    Cs = [];
    for i = 1:length(Bs)
        [cf,tf] = coeffs(Bs(i),[b c d]);
        subst_vec = [];
        for j = 1:length(eq_map)
            if (eq_map(j) == 0)
                subst_vec = [subst_vec; tf(j)];
            else
                subst_vec = [subst_vec; As(eq_map(j))];
            end
        end
        p = cf*subst_vec;
        [cf1, tf1] = coeffs(p, [b c d]);
        Cs = [Cs; cf1];
    end    
    a_out = fopen('a_c.txt', 'w');
    for i = 1:6        
        tfs = [];
        cfs = [];
        for j = 1:4
            [cf, tf] = coeffs(Cs(i,j), [a]);
%             tl = [tl; tf];            
            tfs = [tfs tf];
            cfs = [cfs cf];
        end
        cfs
        for j = 1:length(cfs)
            fprintf(a_out, 'C(%d,%d) = %s;\n', i-1,j-1,cfs(j));
        end
    end
    fclose(a_out);
    B = cvpr10.gbs_Matrix_c('B_%do%d__', 6, 9, 'real');
    
    Cs2 = [];
    for i = 1:6        
        cr = [];
        for j = 1:3
            cr = [cr, B(i, 2*j-1)*a^3 + B(i, 2*j)*a];
        end
        cr = [cr, B(i, 7)*a^4 + B(i, 8)*a^2 + B(i, 9)];
        Cs2 = [Cs2; cr];
    end
    
    b_out = fopen('b_c.txt', 'w');
    dets = [];
    ind = 0;
    for i = 1:6
        for j = i+1:6
            seln = ones(6, 1);
            seln(i) = 0;
            seln(j) = 0;
            inds = find(seln);
            [cf,tf] = coeffs(det(Cs2(inds, :)), [a]);
            for k = 1:length(cf)
                fprintf(b_out, 'P(%d,%d) = %s;\n', ind,k-1,cf(k));
            end
            ind = ind+1;
        end
    end
    fclose(b_out);
end