%expect A 2 x 11, r e 1
%B 2 x 19, r e*r 1
function divide_unknowns(A, B, at, bt, ct, dt, et)
    %a) reparametrize into % v = [ab, ac, ad, bc, bd, cd, a2, b2, c2, d2,1] = [v0 1]
    M = polyslv.build_homo_system(A, B, at, bt, ct, dt, et);
    %b) reparametrize into X [ b,c,1]^T + Y[ bc, b^2, c^2] by dividing by d
    am_inds = [1 2 4 5 6 7 10];
    X0 = M(:, [am_inds am_inds+10]);
    rem_inds = [3 8 9];
    Y = M(:, [rem_inds rem_inds+10]);
    
    %works only for case 4
    Y(1, :) = Y(1, :) - Y(2, :);
    Y(3, :) = Y(3, :) - Y(4, :);
    Y = Y([1 3 2 4], :);
    X0(1, :) = X0(1, :) - X0(2, :);
    X0(3, :) = X0(3, :) - X0(4, :);
    X0 = X0([1 3 2 4], :);
        
    Y0 = Y(1:3,:);
    [dety, IY0] = polyslv.invert_Y(Y0);
    IYtrue = 1/(dety(1)+et*dety(2))*(IY0(:,:,1)+et*IY0(:,:,2));
    Ytrue = Y0(:, 1:3)+Y0(:, 4:6)*et;
    IYtrue*Ytrue
    
    C = zeros(3, 7, 3);
    C(:,:,1) = IY0(:,:,1)*X0(1:3, 1:7);
    C(:,:,2) = IY0(:,:,2)*X0(1:3, 1:7)+IY0(:,:,1)*X0(1:3, 8:14);
    C(:,:,3) = IY0(:,:,2)*X0(1:3, 8:14);
    %C(:,:,3) = zero
    
    C = C(:, :, 1:2);
    
    a=at;
    
    A = [a 0 0;
    0 a 0;
    0 0 a;
    1 0 0;
    0 1 0;
    0 0 a^2;
    0 0 1];
    C(:, :, 1)*A
    C(:, :, 2)*A
end