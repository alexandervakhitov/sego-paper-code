function [X1, X2, err_sum] = resolve_line(R1, t1, R2, t2, lproj1, lproj2)
    %a'*X1+b = 0
    %c'X1+d = 0
    %X1 = - l1 a - l2 c
    a = R1'*lproj1;
    b = t1'*lproj1;
    c = R2'*lproj2;
    d = t2'*lproj2;
    A = [a' 0 0;
        c' 0 0;
        eye(3) a c];
    if (rcond(A) < 1e-15)
        X1 = [];
        X2 = [];
        err_sum = -1;
        return;
    end    
    Xf = A\[-b;-d;zeros(3, 1)];

%     Aext = [A [-b;-d;zeros(3, 1)]];
%     Aext_red = rref(Aext);
%     X1 = Aext_red(1:3, 6);
    X1 = Xf(1:3);
    
%     mod(A*Arext_red(:, 6), prime_num)-mod([-b;-d;zeros(3, 1)], prime_num)    
    line_dir = cross(R1'*a,R2'*c);
    line_dir = line_dir / norm(line_dir);
    X2 = X1 + line_dir;    
    pr1 = R1*X1+t1;
    e1 = pr1'*lproj1;
    pr1 = R1*X2+t1;
    e2 = pr1'*lproj1;
    pr1 = R2*X1+t2;
    e3 = pr1'*lproj2;
    pr1 = R2*X2+t2;
    e4 = pr1'*lproj2;
    err_sum = sum(abs([e1 e2 e3 e4]));
    
%     if (norm(X1) == 0 || norm(X2) == 0)
%         X1=[];
%         X2=[];
%         err_sum = -1; 
%         return;
%     end
%     
end