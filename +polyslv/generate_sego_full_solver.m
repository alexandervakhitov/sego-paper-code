function generate_sego_full_solver
    clear all;
    close all;
    M1 = gbs_Matrix('M1_%d_%d', 4, 10, 'real');    
    M2 = gbs_Matrix('M2_%d_%d', 4, 10, 'real');    
    %second two rows are zero
    M2(1,:) = 0;
    syms a b c d e;
    v = [];
    v = [a*b, a*c, a*d, b*c, b*d, c*d, a^2, b^2, c^2, d^2]';
    
    scaleeq = a^2+b^2+c^2+d^2-1;
    
    V = (M1+M2*e)*v;
    U = [V; scaleeq];
    
    vlist = [a,b,c,d];
    
    
    
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