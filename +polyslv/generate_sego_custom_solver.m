function generate_sego_custom_solver
    clear all;
    close all;
    M1 = gbs_Matrix('M1_%d_%d', 4, 10, 'real');    
    M2 = gbs_Matrix('M2_%d_%d', 4, 10, 'real');    
    %second two rows are zero
    M2(3:4,:) = 0;
    syms a b c;
    v = [a*b; a*c; a; b*c; b; c; a*a; b*b; c*c; 1];
    
    cm1 = M1*v;
    cm2 = M2*v;
    Cm = [cm1, cm2];
    U = [];
    for i = 1:4
        for j = i+1:4
            U = [U, det(Cm([i j], 1:2))];
        end
    end
    U = [U(1:4), M1(3,:)*v, M1(4,:)*v];
    M = U;
    vlist = [a,b,c];
    M_add = [];
    for i = 1 :3 
        for j = 5 : 6 
            mnew = vlist(i)*U(j); 
            M_add = [M_add, mnew];
        end
    end
    
    Mcross = [];
    for i = 5:6
        for j = 5:6
            Mcross = [Mcross, M(i) * M(j)];
        end
    end
    
    Mn0 = [M, M_add, Mcross];
    
    
    Mn = Mn0;
    for i = 1:3
        for j = 1:length(Mn0)
            mnew = Mn0(j) * vlist(i);
            Mn = [Mn, mnew];
        end
    end
    
    Mn1 = Mn;
    Mn = Mn1;
    for i = 1:3
        for j = length(Mn0):length(Mn1)
            mnew = Mn1(j) * vlist(i);
            Mn = [Mn, mnew];            
        end;
    end;
    
    length(Mn)
%     return;
   
    mon_lst = [a^6,a^4*b^2,a^3*b^3,a^2*b^4,a^1*b^5,b^6,a^5*c^1,a^4*b^1*c^1,...
        a^3*b^2*c^1,a^2*b^3*c^1,a^1*b^4*c^1,b^5*c^1,a^4*c^2,a^3*b^1*c^2,...
        a^2*b^2*c^2,a^1*b^3*c^2,b^4*c^2,a^3*c^3,a^2*b^1*c^3,a^1*b^2*c^3,...
        b^3*c^3,a^2*c^4,a^1*b^1*c^4,b^2*c^4,a^1*c^5,b^1*c^5,c^6,a^2*b^3,a^1*b^4,...
        b^5,a^4*c^1,a^2*b^2*c^1,a^1*b^3*c^1,b^4*c^1,a^3*c^2,a^2*b^1*c^2,...
        a^1*b^2*c^2,b^3*c^2,a^2*c^3,a^1*b^1*c^3,b^2*c^3,a^1*c^4,b^1*c^4,c^5,b^4,...
        a^1*b^2*c^1,b^3*c^1,a^2*c^2,a^1*b^1*c^2,b^2*c^2,a^1*c^3,b^1*c^3,c^4,...
        b^2*c^1,a^1*c^2,b^1*c^2,c^3,c^2,a^4*b^1,a^5*b^1,b^3,a^1*b^3,a^2*b^2,...
        a^3*b^2,b^1*c^1,a^1*b^1*c^1,a^2*b^1*c^1,a^3*b^1*c^1,1,a^1,a^2,a^3,...
        a^4,a^5,b^1,b^2,a^1*b^1,a^1*b^2,a^2*b^1,a^3*b^1,c^1,a^1*c^1,a^2*c^1,a^3*c^1];
    fout = fopen('/home/alexander/materials/sego/my_gen/gend2.txt','w');
    for i = 1:length(Mn)
        [cf,tf] = coeffs(expand(Mn(i)),[a,b,c]);
        for ti = 1:length(tf)
            for j = 1:length(mon_lst)
                if (tf(ti) == mon_lst(j))
                    fprintf(fout ,'Mc(%d,%d)=%s;\n',i, j, cf(ti));
                end;
            end
        end
        i/length(Mn)*100
    end
    fclose(fout);
end