function A = generate_line_pluecker_real(l1, l2, third_proj, pt_shift, u, is_direct, is_stereoshift)
    t2 = [1;0;0];
    inds = [1 2 3; 4 5 6; 7 8 9];
    if (~is_direct)
        inds = inds';
    end
    [X1, X2] = slv.resolve_line(eye(3), zeros(3, 1), eye(3), t2, l1, l2);
    if (length(X1) == 0)
        A = [];
        return;
    end
    Xcp = cross(X1, X2);
    dX = (X2-X1);
    r_eqs = get_rx_mat(Xcp, third_proj, inds);    
    if (is_direct)        
        ar_eqs = get_urx_row(dX, inds, util.cpmat(third_proj)', u);        
        Xm = (-cross(pt_shift, dX));
        r_eqs_add = get_rx_mat(Xm, third_proj, inds);   
    else
        nDx = (-cross(u, dX));
        ar_eqs = get_rx_mat(nDx, third_proj, inds);        
        r_eqs_add = get_urx_row(dX, inds, util.cpmat(third_proj)', pt_shift);
    end
    if (is_stereoshift)
        r_eqs_stereo_add = get_urx_row(dX, inds, util.cpmat(third_proj)', t2);        
        r_eqs = r_eqs + r_eqs_stereo_add;
    end
    A = [r_eqs + r_eqs_add, ar_eqs];
    A = A(1:2, :);
end
function c1_row = get_urx_row(p1, inds, third_proj, u)
    C1 = zeros(3, 9);
    C1(1, inds(:,1)) = [p1'];
    C1(2, inds(:,2)) = [p1'];
    C1(3, inds(:,3)) = [p1'];
    c1_row = (third_proj'*util.cpmat(u)*C1);
end

function cr1_row = get_rx_mat(Xm, third_proj, inds)
    Cr = zeros(3, 9);
    Cr(1, inds(:, 1)) = Xm;
    Cr(2, inds(:, 2)) = Xm;
    Cr(3, inds(:, 3)) = Xm;
    cr1_row = (util.cpmat(third_proj)*Cr);
end
