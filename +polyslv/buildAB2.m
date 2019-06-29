function [A,B, case_num] = buildAB2(projs,t3e_dir, shift_3d, lprojs, vis_p, vis_l, R2, t2, t2s)

    [feat_type, ip_num, feat_ind, ind1, ind2] = polyslv.find_feature_classes(vis_p, vis_l);    
    
    if (feat_type(ind1) == 1)
        A = build_mat_for_pt(ip_num(ind1), vis_p(feat_ind(ind1), :), R2, t2, t2s, shift_3d, projs(:, feat_ind(ind1), :), t3e_dir);
    else
        A = build_mat_for_ln(ip_num(ind1), vis_l(feat_ind(ind1), :), R2, t2, t2s, shift_3d, lprojs(:, feat_ind(ind1), :), t3e_dir);
    end
    
    if (length(A) == 0)
        A = [];
        B = [];
        case_num = -1;
        return;
    end
        
    
    if (feat_type(ind2) == 1)
        B = build_mat_for_pt(ip_num(ind2), vis_p(feat_ind(ind2), :), R2, t2, t2s, shift_3d, projs(:, feat_ind(ind2), :), t3e_dir);
    else
        B = build_mat_for_ln(ip_num(ind2), vis_l(feat_ind(ind2), :), R2, t2, t2s, shift_3d, lprojs(:, feat_ind(ind2), :), t3e_dir);
    end
    
    if (length(B) == 0)
        A = [];
        B = [];
        case_num = -1;
        return;
    end

    if (feat_type(1) == 1 && feat_type(2) == 2)
        if (ip_num(1) == 1 && ip_num(2) == 2)
            case_num = 1;
        else
            case_num = 2;
        end
    end
    if (feat_type(1) == 1 && feat_type(2) == 1)
        case_num = 3;
    end
    if (feat_type(1) == 2 && feat_type(2) == 2)
        if (ip_num(1) == 2 && ip_num(2) == 2)
            case_num = 4;
        else
            case_num = 5;
        end
    end
    if (length(ip_num) == 2 && ip_num(1) == 1 && ip_num(2) == 1)
        if( feat_type(1) == 1 && feat_type(2) == 1)
            case_num = 7;
        end
        if( feat_type(1) == 1 && feat_type(2) == 2)
            case_num = 8;
        end
        if (feat_type(1) == 2 && feat_type(2) == 2)
            case_num = 9;
        end
    end
end
function A = build_mat_for_pt(ip_num, vis_p_row, R2, t2, t2s, shift_3d, projs, t3e_dir)
    if (ip_num == 1)
        p3d1_c1 = util.resolve_point(eye(3), zeros(3, 1), R2, t2, [projs(:, 1, 1); 1], [projs(:, 1, 2); 1]);
        p3d1_c1 = p3d1_c1 + shift_3d;
        ci3 = 3;
        if (vis_p_row(4) == 1)
            ci3 = 4;
        end
    else
        p3d1_c1 = util.resolve_point(eye(3), zeros(3, 1), R2, t2s, [projs(:, 1, 3); 1], [projs(:, 1, 4); 1]);
        ci3 = 1;
        if (vis_p_row(2) == 1)
            ci3 = 2;
        end        
    end
        
    if (ip_num == 1)
        A(1, [1 4 7]) = p3d1_c1;
        A(1, [3 6 9]) = -projs(1, 1, ci3)*p3d1_c1;
        A(1, 10) = t3e_dir(1)-projs(1, 1, ci3) ;
        A(1, 11) = 0;%
        A(2, [2 5 8]) = p3d1_c1;
        A(2, [3 6 9]) = -projs(2, 1, ci3)*p3d1_c1;
        A(2, 10) = t3e_dir(2)-projs(2, 1, ci3) ;
        A(2, 11) = 0;%
    else
        A(1, 1:3) = p3d1_c1;
        A(1, 7:9) = -projs(1, 1, ci3)*p3d1_c1;
        A(1, 10:12) = -t3e_dir;
        A(1, 16:18) = projs(1, 1, ci3)*t3e_dir;
        A(1, 19) = -shift_3d(1)+projs(1, 1, ci3)*shift_3d(3);    
        A(2, 4:6) = p3d1_c1;
        A(2, 7:9) = -projs(2, 1, ci3)*p3d1_c1;
        A(2, 13:15) = -t3e_dir;
        A(2, 16:18) = projs(2, 1, ci3)*t3e_dir;     
        A(2, 19) = -shift_3d(2)+projs(2, 1, ci3)*shift_3d(3);

    end
    
    if (ip_num == 1 && ci3 == 4)
        A(1, 11) = t2s(1) - projs(1, 1, ci3)*t2s(3);
        A(2, 11) = t2s(2) - projs(2, 1, ci3)*t2s(3);
    end
    if (ip_num == 2 && ci3 == 2)
        A(1, 19) = A(1, 19) + t2(1) - projs(1, 1, ci3)*t2(3);
        A(2, 19) = A(2, 19) + t2(2) - projs(2, 1, ci3)*t2(3);
    end
end

function B = build_mat_for_ln(ip_num, vis_l_row, R2, t2, t2s, shift_3d, lprojs, t3e_dir, R3, t3)
    t2p = t2;
    if (ip_num == 2)
        lproj1 = lprojs(:, 1, 3);
        lproj2 = lprojs(:, 1, 4);
        t2p = t2s;
        if (vis_l_row(1, 1) == 1)
            ci = 1;
        else
            ci = 2;
        end
    else
        lproj1 = lprojs(:, 1, 1);
        lproj2 = lprojs(:, 1, 2);
        if (vis_l_row(1, 3) == 1)
            ci = 3;
        else
            ci = 4;
        end                
    end
    [X1, X2] = util.resolve_line(eye(3), zeros(3, 1), R2, t2p, lproj1, lproj2);
    if (length(X1) < 3)
        B = [];
        return;
    end
    if (ip_num == 2)
        for i = 1:3
            for j = 1:3
                B(1, 3*(i-1)+j) = lprojs(i, 1, ci)*X1(j);
                B(2, 3*(i-1)+j) = lprojs(i, 1, ci)*X2(j);  
                B(1, 9+3*(i-1)+j) = lprojs(i, 1, ci)*(-t3e_dir(j));
                B(2, 9+3*(i-1)+j) = lprojs(i, 1, ci)*(-t3e_dir(j));
            end
        end
        B(1, 19) = -lprojs(:, 1, ci)'*shift_3d;
        B(2, 19) = B(1, 19);

        if (ci == 2)
            B(1,19) = B(1, 19) + lprojs(:, 1, ci)'*t2;
            B(2,19) = B(2, 19) + lprojs(:, 1, ci)'*t2;
        end
    else
        X1 = X1 + shift_3d;
        X2 = X2 + shift_3d;
        for i = 1:3
            for j = 1:3
                B(1, 3*(j-1)+i) = lprojs(i, 1, ci)*X1(j);
                B(2, 3*(j-1)+i) = lprojs(i, 1, ci)*X2(j);  
            end
        end        
        B(1, 10) = lprojs(:, 1, ci)'*t3e_dir;
        B(2, 10) = lprojs(:, 1, ci)'*t3e_dir;                             
        
        if (ci == 4)
            B(1, 11) = lprojs(:, 1, ci)'*t2s;
            B(2, 11) = B(1, 11);
        else
            B(1, 11) = 0;
            B(2, 11) = 0;
        end
 
    end
    
end


