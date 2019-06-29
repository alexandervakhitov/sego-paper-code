function A_pt = generate_epipolar_eqs_real(p1, p2, third_proj, pt_shift, u, is_direct, is_stereoshift)
    %t=alpha*u - R * pt_shift
    %t_x R p = alpha* u_x R p - R * (pt_shift_x p)
    
    %eqs
    %
    inds = [1 2 3; 4 5 6; 7 8 9];
    t2 = [1;0;0];
    if (~is_direct)
        inds = inds';
    end
    if (length(third_proj) == 2)
        third_proj = [third_proj; 1];
    end
    
    third_proj = third_proj / norm(third_proj);
    
    %(alpha R) coeffs    
    if (is_direct)
        car1_row = get_urx_row(p1, inds, third_proj, u);
        car2_row = get_urx_row(p2, inds, third_proj, u);
        cr1_row = get_rps_row(p1, pt_shift, inds, third_proj);
        cr2_row = get_rps_row(p2, pt_shift+t2, inds, third_proj);
    else
        car1_row = get_rps_row(p1, u, inds, third_proj);
        car2_row = get_rps_row(p2, u, inds, third_proj);
        cr1_row = get_urx_row(p1, inds, third_proj, pt_shift);
        cr2_row = get_urx_row(p2, inds, third_proj, pt_shift);                
        cr2_add_row = get_rps_row(p2, t2, inds, third_proj);
        cr2_row = cr2_row + cr2_add_row;
    end    
    if (is_stereoshift)
        css1_row = get_stereoshift_row(p1, inds, t2, third_proj);
        css2_row = get_stereoshift_row(p2, inds, t2, third_proj);
        cr1_row = (cr1_row + css1_row);
        cr2_row = (cr2_row + css2_row);
    end
    A_pt = [cr1_row, car1_row;
            cr2_row, car2_row];
end
function c_row = get_stereoshift_row(p1, inds, t2, third_proj)
    C1 = zeros(3, 9);
    C1(1, inds(:,1)) = [p1', 1];
    C1(2, inds(:,2)) = [p1', 1];
    C1(3, inds(:,3)) = [p1', 1];
    c_row = third_proj'*util.cpmat(t2)*C1;
end
function c1_row = get_urx_row(p1, inds, third_proj, u)
    C1 = zeros(3, 9);
    C1(1, inds(:,1)) = [p1', 1];
    C1(2, inds(:,2)) = [p1', 1];
    C1(3, inds(:,3)) = [p1', 1];
    c1_row = third_proj'*util.cpmat(u)*C1;
end
function c1_row = get_rps_row(p1, pt_shift, inds, third_proj)
    p_cross_1 = -util.cpmat(pt_shift)*[p1;1];
    Cr1 = zeros(3, 9);
    Cr1(1, inds(:,1)) = [p_cross_1'];
    Cr1(2, inds(:,2)) = [p_cross_1'];
    Cr1(3, inds(:,3)) = [p_cross_1'];
    c1_row = third_proj'*Cr1;
end