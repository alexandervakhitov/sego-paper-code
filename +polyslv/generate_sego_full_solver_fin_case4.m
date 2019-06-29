function generate_sego_full_solver_fin_case4
    clear all;
    close all;
    M1 = gbs_Matrix('M1_%d_%d', 4, 10, 'real');    
    M2 = gbs_Matrix('M2_%d_%d', 4, 10, 'real');    
    %second two rows are zero
    M2(1,:) = 0;
    
    syms a b c d;
    v = [a*b; a*c; a*d; b*c; b*d; c*d; a*a; b*b; c*c; d*d];
    
    cm1 = M1*v;
    cm2 = M2*v;
    Cm = [cm1, cm2];
    U = [];
    for i = 1:4
        for j = i+1:4
            U = [U, det(Cm([i j], 1:2))];
        end
    end
    
    %special for case 4    
    U(1) = M1(2,:)*v;
    
    U = [M1(1,:)*v, U(1:6), a^2+b^2+c^2+d^2-1];
    
    M = U;    
    vlist = [a,b,c,d];
    
    Mn1 = M;	
	M_lo = [M(1)];	
	Mn_lo = MultiplyBy(M_lo, [a]);
	Mn2_lo = MultiplyBy(Mn_lo, [a]);
	
	M_lo_c = [M(8)];
	Mn_lo_c = MultiplyBy(M_lo_c,[b,c]);
	Mn2_lo_c = MultiplyBy(Mn_lo_c,[a,b,c]);
    
    Mn_lof = [Mn2_lo,M(2:7), Mn2_lo_c, M(1), M(8)];
	Mn_5 = MultiplyBy(Mn_lof,vlist);
	Mn_6 = MultiplyBy(Mn_5,[a,b,c]);

	Mn_full_6 = [Mn_6,Mn_5,Mn_lof];
	Mn_7 = MultiplyBy(Mn_6,[a,b]);
	Mn_8 = MultiplyBy(Mn_7,[a]);	
%     
    Mn = [Mn_full_6, Mn_7, Mn_8];
    
    length(Mn)
%     return;
   
    mon_lst = [  a^8,a^7*b^1,a^6*b^2,a^5*b^3,a^4*b^4,a^3*b^5,a^2*b^6,a^1*b^7,a^7*c^1,a^6*b^1*c^1,a^5*b^2*c^1,a^4*b^3*c^1,a^3*b^4*c^1,a^2*b^5*c^1,a^1*b^6*c^1,a^6*c^2,a^5*b^1*c^2,a^4*b^2*c^2,a^3*b^3*c^2,a^2*b^4*c^2,a^1*b^5*c^2,a^5*c^3,a^4*b^1*c^3,a^3*b^2*c^3,a^2*b^3*c^3,a^1*b^4*c^3,a^4*c^4,a^3*b^1*c^4,a^2*b^2*c^4,a^1*b^3*c^4,a^3*c^5,a^2*b^1*c^5,a^1*b^2*c^5,a^2*c^6,a^1*b^1*c^6,a^7*d^1,a^6*b^1*d^1,a^5*b^2*d^1,a^4*b^3*d^1,a^3*b^4*d^1,a^2*b^5*d^1,a^1*b^6*d^1,a^6*c^1*d^1,a^5*b^1*c^1*d^1,a^4*b^2*c^1*d^1,a^3*b^3*c^1*d^1,a^2*b^4*c^1*d^1,a^1*b^5*c^1*d^1,a^5*c^2*d^1,a^4*b^1*c^2*d^1,a^3*b^2*c^2*d^1,a^2*b^3*c^2*d^1,a^1*b^4*c^2*d^1,a^4*c^3*d^1,a^3*b^1*c^3*d^1,a^2*b^2*c^3*d^1,a^1*b^3*c^3*d^1,a^3*c^4*d^1,a^2*b^1*c^4*d^1,a^1*b^2*c^4*d^1,a^2*c^5*d^1,a^1*b^1*c^5*d^1,a^6*d^2,a^5*b^1*d^2,a^4*b^2*d^2,a^3*b^3*d^2,a^2*b^4*d^2,a^1*b^5*d^2,a^5*c^1*d^2,a^4*b^1*c^1*d^2,a^3*b^2*c^1*d^2,a^2*b^3*c^1*d^2,a^1*b^4*c^1*d^2,a^4*c^2*d^2,a^3*b^1*c^2*d^2,a^2*b^2*c^2*d^2,a^1*b^3*c^2*d^2,a^3*c^3*d^2,a^2*b^1*c^3*d^2,a^1*b^2*c^3*d^2,a^2*c^4*d^2,a^1*b^1*c^4*d^2,a^5*d^3,a^4*b^1*d^3,a^3*b^2*d^3,a^2*b^3*d^3,a^1*b^4*d^3,a^4*c^1*d^3,a^3*b^1*c^1*d^3,a^2*b^2*c^1*d^3,a^1*b^3*c^1*d^3,a^3*c^2*d^3,a^2*b^1*c^2*d^3,a^1*b^2*c^2*d^3,a^2*c^3*d^3,a^1*b^1*c^3*d^3,a^4*d^4,a^3*b^1*d^4,a^2*b^2*d^4,a^1*b^3*d^4,a^3*c^1*d^4,a^2*b^1*c^1*d^4,a^1*b^2*c^1*d^4,a^2*c^2*d^4,a^1*b^1*c^2*d^4,a^3*d^5,a^2*b^1*d^5,a^1*b^2*d^5,a^2*c^1*d^5,a^1*b^1*c^1*d^5,a^7,a^6*b^1,a^5*b^2,a^4*b^3,a^3*b^4,a^2*b^5,a^1*b^6,b^7,a^6*c^1,a^5*b^1*c^1,a^4*b^2*c^1,a^3*b^3*c^1,a^2*b^4*c^1,a^1*b^5*c^1,b^6*c^1,a^5*c^2,a^4*b^1*c^2,a^3*b^2*c^2,a^2*b^3*c^2,a^1*b^4*c^2,b^5*c^2,a^4*c^3,a^3*b^1*c^3,a^2*b^2*c^3,a^1*b^3*c^3,b^4*c^3,a^3*c^4,a^2*b^1*c^4,a^1*b^2*c^4,b^3*c^4,a^2*c^5,a^1*b^1*c^5,b^2*c^5,a^1*c^6,b^1*c^6,a^6*d^1,a^5*b^1*d^1,a^4*b^2*d^1,a^3*b^3*d^1,a^2*b^4*d^1,a^1*b^5*d^1,b^6*d^1,a^5*c^1*d^1,a^4*b^1*c^1*d^1,a^3*b^2*c^1*d^1,a^2*b^3*c^1*d^1,a^1*b^4*c^1*d^1,b^5*c^1*d^1,a^4*c^2*d^1,a^3*b^1*c^2*d^1,a^2*b^2*c^2*d^1,a^1*b^3*c^2*d^1,b^4*c^2*d^1,a^3*c^3*d^1,a^2*b^1*c^3*d^1,a^1*b^2*c^3*d^1,b^3*c^3*d^1,a^2*c^4*d^1,a^1*b^1*c^4*d^1,b^2*c^4*d^1,a^1*c^5*d^1,b^1*c^5*d^1,a^5*d^2,a^4*b^1*d^2,a^3*b^2*d^2,a^2*b^3*d^2,a^1*b^4*d^2,b^5*d^2,a^4*c^1*d^2,a^3*b^1*c^1*d^2,a^2*b^2*c^1*d^2,a^1*b^3*c^1*d^2,b^4*c^1*d^2,a^3*c^2*d^2,a^2*b^1*c^2*d^2,a^1*b^2*c^2*d^2,b^3*c^2*d^2,a^2*c^3*d^2,a^1*b^1*c^3*d^2,b^2*c^3*d^2,a^1*c^4*d^2,b^1*c^4*d^2,a^4*d^3,a^3*b^1*d^3,a^2*b^2*d^3,a^1*b^3*d^3,b^4*d^3,a^3*c^1*d^3,a^2*b^1*c^1*d^3,a^1*b^2*c^1*d^3,b^3*c^1*d^3,a^2*c^2*d^3,a^1*b^1*c^2*d^3,b^2*c^2*d^3,a^1*c^3*d^3,b^1*c^3*d^3,a^3*d^4,a^2*b^1*d^4,a^1*b^2*d^4,b^3*d^4,a^2*c^1*d^4,a^1*b^1*c^1*d^4,b^2*c^1*d^4,a^1*c^2*d^4,b^1*c^2*d^4,a^2*d^5,a^1*b^1*d^5,b^2*d^5,a^1*c^1*d^5,b^1*c^1*d^5,a^6,a^5*b^1,a^4*b^2,a^3*b^3,a^2*b^4,a^1*b^5,b^6,a^5*c^1,a^4*b^1*c^1,a^3*b^2*c^1,a^2*b^3*c^1,a^1*b^4*c^1,b^5*c^1,a^4*c^2,a^3*b^1*c^2,a^2*b^2*c^2,a^1*b^3*c^2,b^4*c^2,a^3*c^3,a^2*b^1*c^3,a^1*b^2*c^3,b^3*c^3,a^2*c^4,a^1*b^1*c^4,b^2*c^4,a^1*c^5,b^1*c^5,c^6,a^5*d^1,a^4*b^1*d^1,a^3*b^2*d^1,a^2*b^3*d^1,a^1*b^4*d^1,b^5*d^1,a^4*c^1*d^1,a^3*b^1*c^1*d^1,a^2*b^2*c^1*d^1,a^1*b^3*c^1*d^1,b^4*c^1*d^1,a^3*c^2*d^1,a^2*b^1*c^2*d^1,a^1*b^2*c^2*d^1,b^3*c^2*d^1,a^2*c^3*d^1,a^1*b^1*c^3*d^1,b^2*c^3*d^1,a^1*c^4*d^1,b^1*c^4*d^1,c^5*d^1,a^4*d^2,a^3*b^1*d^2,a^2*b^2*d^2,a^1*b^3*d^2,b^4*d^2,a^3*c^1*d^2,a^2*b^1*c^1*d^2,a^1*b^2*c^1*d^2,b^3*c^1*d^2,a^2*c^2*d^2,a^1*b^1*c^2*d^2,b^2*c^2*d^2,a^1*c^3*d^2,b^1*c^3*d^2,c^4*d^2,a^3*d^3,a^2*b^1*d^3,a^1*b^2*d^3,b^3*d^3,a^2*c^1*d^3,a^1*b^1*c^1*d^3,b^2*c^1*d^3,a^1*c^2*d^3,b^1*c^2*d^3,c^3*d^3,a^2*d^4,a^1*b^1*d^4,b^2*d^4,a^1*c^1*d^4,b^1*c^1*d^4,c^2*d^4,a^1*d^5,b^1*d^5,c^1*d^5,a^4*b^1,a^3*b^2,a^2*b^3,a^1*b^4,b^5,a^4*c^1,a^3*b^1*c^1,a^2*b^2*c^1,a^1*b^3*c^1,b^4*c^1,a^3*c^2,a^2*b^1*c^2,a^1*b^2*c^2,b^3*c^2,a^2*c^3,a^1*b^1*c^3,b^2*c^3,a^1*c^4,b^1*c^4,c^5,a^4*d^1,a^3*b^1*d^1,a^2*b^2*d^1,a^1*b^3*d^1,b^4*d^1,a^3*c^1*d^1,a^2*b^1*c^1*d^1,a^1*b^2*c^1*d^1,b^3*c^1*d^1,a^2*c^2*d^1,a^1*b^1*c^2*d^1,b^2*c^2*d^1,a^1*c^3*d^1,b^1*c^3*d^1,c^4*d^1,a^3*d^2,a^2*b^1*d^2,a^1*b^2*d^2,b^3*d^2,a^2*c^1*d^2,a^1*b^1*c^1*d^2,b^2*c^1*d^2,a^1*c^2*d^2,b^1*c^2*d^2,c^3*d^2,a^2*d^3,a^1*b^1*d^3,b^2*d^3,a^1*c^1*d^3,b^1*c^1*d^3,c^2*d^3,a^1*d^4,b^1*d^4,c^1*d^4,d^5,a^2*b^2,a^1*b^3,b^4,a^2*b^1*c^1,a^1*b^2*c^1,b^3*c^1,a^2*c^2,a^1*b^1*c^2,b^2*c^2,a^1*c^3,b^1*c^3,c^4,a^2*b^1*d^1,a^1*b^2*d^1,b^3*d^1,a^2*c^1*d^1,a^1*b^1*c^1*d^1,b^2*c^1*d^1,a^1*c^2*d^1,b^1*c^2*d^1,c^3*d^1,a^2*d^2,a^1*b^1*d^2,b^2*d^2,a^1*c^1*d^2,b^1*c^1*d^2,c^2*d^2,a^1*d^3,b^1*d^3,c^1*d^3,d^4,b^3,b^2*c^1,a^1*c^2,b^1*c^2,c^3,a^1*b^1*d^1,b^2*d^1,a^1*c^1*d^1,b^1*c^1*d^1,c^2*d^1,a^1*d^2,b^1*d^2,c^1*d^2,d^3,c^2,b^1*d^1,c^1*d^1,d^2,a^5,a^1*b^2,a^3*b^1,a^3*c^1,a^1*b^1*c^1,a^3*d^1,1,a^1,a^2,a^3,a^4,b^1,b^2,a^1*b^1,a^2*b^1,c^1,a^1*c^1,a^2*c^1,b^1*c^1,d^1,a^1*d^1,a^2*d^1];
    fout = fopen('/home/alexander/materials/sego/my_gen/gend_full_case4.txt','w');
    fout_c = fopen('/home/alexander/materials/sego/my_gen/gend_full_case4_c.txt','w');
    for i = 1:length(Mn)
        [cf,tf] = coeffs(expand(Mn(i)),[a,b,c,d]);
        for ti = 1:length(tf)
            for j = 1:length(mon_lst)
                if (tf(ti) == mon_lst(j))
                    fprintf(fout ,'Mc(%d,%d)=%s;\n',i, j, cf(ti));
                    fprintf(fout_c ,'Mc[%d,%d]=%s;\n',i-1, j-1, cf(ti));
                end;
            end
        end
        i/length(Mn)*100
    end
    fclose(fout);
    fclose(fout_c);
end

function M3 = MultiplyBy(M1, M2)
    M3 = [];
    for i = 1:length(M2)
        for j = 1:length(M1)
            M3 = [M3, M1(j)*M2(i)];
        end
    end
end
