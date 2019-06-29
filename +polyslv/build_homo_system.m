%a) reparametrize into % v = [ab, ac, ad, bc, bd, cd, a2, b2, c2, d2,1] = [v0 1]
function M = build_homo_system(A, B, case_num, at, bt, ct, dt, et, prime_num)
    
    %in cols:
    %    R3sym = [a^2+b^2-c^2-d^2, 2*b*c-2*a*d, 2*b*d+2*a*c;
%         2*b*c+2*a*d, a^2-b^2+c^2-d^2, 2*c*d-2*a*b;
%         2*b*d-2*a*c, 2*c*d+2*a*b, a^2-b^2-c^2+d^2];

    R2Q = slv.build_R2Q();
    %A -> A2:2 x 12 (quat + e)
    C2Q = zeros(1, 10);
    C2Q(1, [7 8 9 10]) = 1;
    ET = zeros(1, 11);
    ET(11) = 1;
    Ta = [R2Q zeros(9, 10);
          zeros(1, 10) C2Q;
          C2Q zeros(1,10)];
    %v0 e*v0
    if (size(A, 2) == 11)
        AQ = A*Ta;
    else
        B = [A; B];
    end    
    Tb = [R2Q zeros(9, 10);
          zeros(9, 10) R2Q;
          C2Q zeros(1,10)];
    BQ = B*Tb;
    if (size(A, 2) == 11)
        M = [AQ; BQ];    
    else
        M = BQ;
    end
    
    if (case_num == 3)
        if (nargin > 8)
            M(1,:) = M(1,:)-M(2,:)*M(1,20)*fp.inverse(M(2,20), prime_num);
        else
            M(1,:) = M(1,:)-M(2,:)*M(1,20)/M(2,20);
        end
    end
    if (nargin > 8)
        M = mod(M, prime_num);        
    end    
    if (nargin > 3)
        v_test = [at*bt, at*ct, at*dt, bt*ct, bt*dt, ct*dt, at*at, bt*bt, ct*ct, dt*dt];
        v_full = [v_test et*v_test]';
        if (nargin > 8)
            v_test = mod(v_test, prime_num);
            v_full = mod([v_test et*v_test]', prime_num);
            mod(M*v_full, prime_num)
        else
            M*v_full
        end        
    end
        

%     md1 = M(1,:)-M(2,:);
%     md2 = M(3,:)-M(4,:);
%     M(2,:) = M(3,:);
%     M(3, :) = md1;
%     M(4, :) = md2;
end