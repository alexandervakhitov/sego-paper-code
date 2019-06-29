function generate_sego_pluecker_solver
    clear all;
    close all;
    addpath('/home/alexander/materials/solvgen/Automatic-Generator-release');
    setpaths;
    M1 = gbs_Matrix('M1_%d_%d', 4, 10, 'real');    
    M2 = gbs_Matrix('M2_%d_%d', 4, 10, 'real');    
    %second two rows are zero    
    syms b c d;
    a = 1;    
    v = [a*b; a*c; a*d; b*c; b*d; c*d; a^2; b^2; c^2; d^2];
    
    cm1 = M1*v;
    cm2 = M2*v;
    Cm = [cm1, cm2];
    U = [];
    for i = 1:4
        for j = i+1:4
            U = [U, det(Cm([i j], 1:2))];
        end
    end
    
%     	Mn0_mult := MultiplyBy(Mn0, vmult_list, p):
% 	Mn1:=[op(Mn0), op(Mn0_mult)]:
% 	Mn1_mult :=  MultiplyBy(Mn0_mult, [b,c,d], p):	
% 	Mn2 := [op(Mn1), op(Mn1_mult)];
% 	Mn2_mult :=  MultiplyBy(Mn1_mult, [b], p):
% 	Mn := [op(Mn2), op(Mn2_mult)];

    vmult_list = [b,c,d];
    Mn0 = U;
	Mn0_mult = MultiplyBy(Mn0, vmult_list);
	Mn1 = [Mn0, Mn0_mult];
	Mn1_mult = MultiplyBy(Mn0_mult, [b,c,d]);
	Mn2 = [Mn1, Mn1_mult];
	Mn2_mult =  MultiplyBy(Mn1_mult, [b,c,d]);
	Mn = [Mn2, Mn2_mult];

    
    
    length(Mn)
%     return;
   
    mon_lst = [ b^7,b^6*c^1,b^5*c^2,b^4*c^3,b^3*c^4,b^2*c^5,b^1*c^6,c^7,b^6*d^1,b^5*c^1*d^1,b^4*c^2*d^1,b^3*c^3*d^1,b^2*c^4*d^1,b^1*c^5*d^1,c^6*d^1,b^5*d^2,b^4*c^1*d^2,b^3*c^2*d^2,b^2*c^3*d^2,b^1*c^4*d^2,c^5*d^2,b^4*d^3,b^3*c^1*d^3,b^2*c^2*d^3,b^1*c^3*d^3,c^4*d^3,b^3*d^4,b^2*c^1*d^4,b^1*c^2*d^4,c^3*d^4,b^2*d^5,b^1*c^1*d^5,c^2*d^5,b^1*d^6,c^1*d^6,d^7,b^6,b^5*c^1,b^4*c^2,b^3*c^3,b^2*c^4,b^1*c^5,c^6,b^5*d^1,b^4*c^1*d^1,b^3*c^2*d^1,b^2*c^3*d^1,b^1*c^4*d^1,c^5*d^1,b^4*d^2,b^3*c^1*d^2,b^2*c^2*d^2,b^1*c^3*d^2,c^4*d^2,b^3*d^3,b^2*c^1*d^3,b^1*c^2*d^3,c^3*d^3,b^2*d^4,b^1*d^5,d^6,b^5,b^4*c^1,b^3*c^2,b^2*c^3,b^1*c^4,c^5,b^4*d^1,b^3*c^1*d^1,b^3*d^2,b^2*d^3,b^4,b^3*d^1,b^3*c^1,c^4,b^1*c^3,b^2*c^2,c^1*d^5,b^1*c^1*d^3,b^1*c^1*d^4,b^2*c^1*d^2,c^2*d^3,c^2*d^4,c^3*d^2,c^4*d^1,b^1*c^2*d^2,b^1*c^3*d^1,b^2*c^2*d^1,1,b^1,b^2,b^3,c^1,c^2,c^3,b^1*c^1,b^1*c^2,b^2*c^1,d^1,d^2,d^3,d^4,d^5,b^1*d^1,b^1*d^2,b^1*d^3,b^1*d^4,b^2*d^1,b^2*d^2,c^1*d^1,c^1*d^2,c^1*d^3,c^1*d^4,c^2*d^1,c^2*d^2,c^3*d^1,b^1*c^1*d^1,b^1*c^1*d^2,b^1*c^2*d^1,b^2*c^1*d^1];
    length(mon_lst)
    fout = fopen('/home/alexander/materials/sego/my_gen/gend_pluecker_4_c.txt','w');
    for i = 1:length(Mn)
        [cf,tf] = coeffs(expand(Mn(i)),[b,c,d]);
        for ti = 1:length(tf)
            for j = 1:length(mon_lst)
                if (tf(ti) == mon_lst(j))
                    fprintf(fout ,'Mc[%d,%d]=%s;\n',i-1, j-1, cf(ti));
                end;
            end
        end
        i/length(Mn)*100
    end
    fclose(fout);
end

function M3 = MultiplyBy(M1, M2)
    M3 = [];
    for i = 1:length(M2)
        for j = 1:length(M1)
            M3 = [M3, M1(j)*M2(i)];
        end
    end
end